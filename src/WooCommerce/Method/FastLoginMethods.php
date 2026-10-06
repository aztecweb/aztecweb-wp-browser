<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Codeception\Exception\ModuleException;
use GuzzleHttp\Client;
use GuzzleHttp\Cookie\CookieJar;
use GuzzleHttp\Exception\GuzzleException;
use lucatume\WPBrowser\Module\WPWebDriver;

/**
 * Signs users in over the HTTP layer instead of driving the wp-login.php form
 * in the browser.
 *
 * `fastLoginAs()` GETs `wp-login.php` (to obtain the `wordpress_test_cookie`),
 * POSTs the credentials with redirect following disabled, and copies the auth
 * cookies from the 302 response into the browser. WordPress itself authenticates
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
     * followed, so the slow post-login wp-admin load never happens. Both auth
     * cookies from the response are then attached to the browser, which must be
     * on the target domain for the cookies to stick.
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
        $loginUrl = $this->fastLoginUrl();

        $client = new Client([
            'cookies' => new CookieJar(),
            'allow_redirects' => false,
            'http_errors' => false,
            'timeout' => self::$fastLoginTimeout,
        ]);

        try {
            $client->get($loginUrl);
            $response = $client->post($loginUrl, [
                'form_params' => [
                    'log' => $username,
                    'pwd' => $password,
                    'testcookie' => '1',
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

        // Cookies are only accepted while the browser is on the target domain;
        // `/` is that domain's home page.
        $webDriver->amOnPage('/');

        foreach ($cookies as $name => $value) {
            $webDriver->setCookie($name, $value, ['path' => '/', 'httpOnly' => true]);
        }
    }

    private function fastLoginUrl(): string
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

        return rtrim($url, '/') . str_replace('wp-admin', 'wp-login.php', $adminPath);
    }

    /**
     * Extract the `name=value` pairs of the WordPress auth cookies from the
     * response's `Set-Cookie` headers.
     *
     * The cookie hash is not computed: it is read from whatever WordPress
     * emitted, which keeps the method correct regardless of the site URL and
     * scheme. Only the two auth cookies are matched, so unrelated cookies (the
     * test cookie, plugins' cookies) are ignored.
     *
     * @param string[] $setCookieHeaders One entry per `Set-Cookie` header.
     *
     * @return array<string, string> Cookie name => value.
     */
    private static function extractAuthCookies(array $setCookieHeaders): array
    {
        $cookies = [];

        foreach ($setCookieHeaders as $header) {
            if (preg_match('/^(wordpress(?:_logged_in)?_[a-f0-9]{32})=([^;]*)/', trim($header), $matches) !== 1) {
                continue;
            }

            $cookies[$matches[1]] = $matches[2];
        }

        return $cookies;
    }
}
