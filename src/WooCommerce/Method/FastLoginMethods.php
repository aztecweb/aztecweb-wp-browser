<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Codeception\Exception\ModuleException;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;
use lucatume\WPBrowser\Module\WPWebDriver;

/**
 * Signs users in over the HTTP layer instead of driving the wp-login.php form
 * in the browser.
 *
 * `fastLoginAs()` POSTs the credentials to `wp-login.php` with redirect
 * following disabled and copies the auth cookies from the 302 response into the
 * browser. WordPress itself authenticates
 * the credentials and registers the session, so the browser layer needs no
 * database access (ADR-0008) and the module needs no wp-config salts. See
 * ADR-0011.
 *
 * Composed into `WooCommerceWebDriver`; never overrides `loginAs`/`loginAsAdmin`
 * (ADR-0002, ADR-0010).
 */
trait FastLoginMethods
{
    /**
     * Seconds to wait for each wp-login.php request.
     *
     * Generous on purpose: when the site has not blocked external HTTP, the
     * post-login wp-admin load can stall for tens of seconds on update checks.
     */
    private static int $fastLoginTimeout = 120;

    abstract protected function wpWebDriver(): WPWebDriver;

    /**
     * Sign in as the WordPress administrator configured on `WPWebDriver`.
     *
     * Reads `adminUsername`/`adminPassword` from the `WPWebDriver` module and
     * delegates to `fastLoginAs()`.
     *
     * @example
     * ```php
     * $I->fastLoginAsAdmin();
     * $I->amOnAdminPage('/');
     * $I->see('Dashboard');
     * ```
     *
     * @return void
     *
     * @throws ModuleException If the admin credentials are not configured.
     */
    public function fastLoginAsAdmin(): void
    {
        $webDriver = $this->wpWebDriver();
        $username = $webDriver->_getConfig('adminUsername');
        $password = $webDriver->_getConfig('adminPassword');

        if (!is_string($username) || $username === '' || !is_string($password)) {
            throw new ModuleException(
                $this,
                'fastLoginAsAdmin requires the WPWebDriver "adminUsername" and "adminPassword" config to be set.',
            );
        }

        $this->fastLoginAs($username, $password);
    }

    /**
     * Sign in as the user identified by WordPress login name and password,
     * bypassing the wp-login.php form submission in the browser.
     *
     * The credentials are POSTed directly to `wp-login.php`; the redirect is not
     * followed, so the slow post-login wp-admin load never happens. The
     * `testcookie` field is omitted, so WordPress skips its cookie-support check
     * and no preliminary GET is needed. The auth cookies from the response are
     * then attached to the browser, which must be on the target domain for the
     * cookies to stick.
     *
     * @example
     * ```php
     * $I->fastLoginAs('shop_manager', 'secret');
     * $I->amOnAdminPage('/edit.php?post_type=shop_order');
     * ```
     *
     * @param string $username The WordPress user_login to authenticate as.
     * @param string $password The user's plain-text password.
     *
     * @return void
     *
     * @throws ModuleException If the request fails, the credentials are
     *                          rejected, or the auth cookies cannot be
     *                          transferred to the browser.
     */
    public function fastLoginAs(string $username, string $password): void
    {
        $webDriver = $this->wpWebDriver();
        $loginUrl = $this->fastLoginSiteUrl('wp-login.php');

        $client = new Client([
            'allow_redirects' => false,
            'http_errors' => false,
            'timeout' => self::$fastLoginTimeout,
        ]);

        try {
            $response = $client->post($loginUrl, [
                'form_params' => [
                    'log' => $username,
                    'pwd' => $password,
                    'redirect_to' => '',
                ],
            ]);
        } catch (GuzzleException $exception) {
            throw new ModuleException(
                $this,
                sprintf('fastLoginAs: the request to %s failed: %s', $loginUrl, $exception->getMessage()),
            );
        }

        $cookies = self::extractAuthCookies($response->getHeader('Set-Cookie'));

        if ($cookies === []) {
            throw new ModuleException(
                $this,
                sprintf(
                    'fastLoginAs: no WordPress auth cookies were returned by %s; '
                    . 'the credentials are probably wrong.',
                    $loginUrl,
                ),
            );
        }

        // Cookies are only accepted while the browser is on the target domain.
        // A static core image puts it there without bootstrapping WordPress.
        $webDriver->amOnUrl($this->fastLoginSiteUrl('wp-includes/images/blank.gif'));

        // Each cookie keeps the path WordPress gave it (the auth cookie is scoped
        // to `wp-admin`). A cookie of the same name and path replaces the one a
        // previous session left in the browser, which a path of `/` would not.
        foreach ($cookies as $cookie) {
            $webDriver->setCookie($cookie['name'], $cookie['value'], [
                'path' => $cookie['path'],
                'httpOnly' => true,
                'secure' => $cookie['secure'],
            ]);
        }
    }

    /**
     * Build the absolute URL of a path that sits next to `wp-admin`.
     *
     * Derived from the `WPWebDriver` `adminPath`, so it follows WordPress
     * installed in a subdirectory (e.g. Bedrock's `/wp/wp-admin`).
     *
     * @param string $path Path relative to the WordPress core directory.
     *
     * @return string
     *
     * @throws ModuleException If `url` or `adminPath` is not configured.
     */
    private function fastLoginSiteUrl(string $path): string
    {
        $webDriver = $this->wpWebDriver();
        $url = $webDriver->_getConfig('url');
        $adminPath = $webDriver->_getConfig('adminPath');

        if (!is_string($url) || $url === '' || !is_string($adminPath) || $adminPath === '') {
            throw new ModuleException(
                $this,
                'fastLoginAs: WPWebDriver must define a non-empty "url" and "adminPath".',
            );
        }

        return rtrim($url, '/') . str_replace('wp-admin', $path, $adminPath);
    }

    /**
     * Extract the `name=value` pairs of the WordPress auth cookies from the
     * response's `Set-Cookie` headers.
     *
     * The cookie hash is not computed: it is read from whatever WordPress
     * emitted, which keeps the method correct regardless of the site URL and
     * scheme. Only the auth cookies are matched — `wordpress_{hash}` over HTTP,
     * `wordpress_sec_{hash}` over HTTPS, and `wordpress_logged_in_{hash}` — so
     * unrelated cookies (plugins' cookies) are ignored. The `Secure` attribute
     * is kept so HTTPS cookies stay HTTPS-only in the browser.
     *
     * @param string[] $setCookieHeaders One entry per `Set-Cookie` header.
     *
     * @return list<array{name: string, value: string, path: string, secure: bool}> Name, value, path and Secure flag.
     */
    private static function extractAuthCookies(array $setCookieHeaders): array
    {
        $cookies = [];

        foreach ($setCookieHeaders as $header) {
            $header = trim($header);

            if (preg_match('/^(wordpress(?:_sec|_logged_in)?_[a-f0-9]{32})=([^;]*)/', $header, $matches) !== 1) {
                continue;
            }

            $cookies[] = [
                'name' => $matches[1],
                'value' => $matches[2],
                'path' => preg_match('/;\s*path=([^;]*)/i', $header, $path) === 1 ? $path[1] : '/',
                'secure' => preg_match('/;\s*secure\s*(?:;|$)/i', $header) === 1,
            ];
        }

        return $cookies;
    }
}
