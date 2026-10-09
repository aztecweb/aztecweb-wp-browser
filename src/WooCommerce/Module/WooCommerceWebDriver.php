<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

use Aztec\WPBrowser\WooCommerce\Method\CartMethods;
use Aztec\WPBrowser\WooCommerce\Method\CheckoutMethods;
use Aztec\WPBrowser\WooCommerce\Method\CustomerBrowserMethods;
use Aztec\WPBrowser\WooCommerce\Method\FastLoginMethods;
use Aztec\WPBrowser\WooCommerce\Method\OrderBrowserMethods;
use Aztec\WPBrowser\WooCommerce\PageObject\PageObjectProvider;
use Codeception\Exception\ModuleException;
use Codeception\Module;
use Codeception\Step;
use Facebook\WebDriver\Exception\WebDriverException;
use lucatume\WPBrowser\Module\WPWebDriver;

class WooCommerceWebDriver extends Module
{
    use CartMethods;
    use CheckoutMethods;
    use CustomerBrowserMethods;
    use FastLoginMethods;
    use OrderBrowserMethods;

    /**
     * The log-in actor steps whose post-login redirect the module waits to settle.
     *
     * @var list<string>
     */
    private const LOGIN_ACTIONS = ['loginAs', 'loginAsAdmin'];

    /**
     * Max seconds to wait for the post-login redirect to settle.
     */
    private const LOGIN_SETTLE_TIMEOUT = 10;

    /**
     * Poll interval, in microseconds, while waiting for the post-login redirect to settle.
     */
    private const LOGIN_SETTLE_POLL_INTERVAL = 100_000;

    /** @var array<string, mixed> */
    protected array $config = [
        'pageObjects' => [],
        'cartPageSlug' => '/cart',
        'checkoutPageSlug' => '/checkout',
        'myAccountPageSlug' => '/my-account',
        // Store-wide order-storage mode. `false` (HPOS) is the WooCommerce
        // default; set `true` in suite.yml for sites still on legacy
        // (wp_posts) order storage. Drives admin order URLs via
        // AdminOrderUrlResolver — see ADR-0008.
        'legacyOrderStorage' => false,
    ];

    private ?PageObjectProvider $pageObjectProvider = null;

    public function _initialize(): void
    {
        if (! $this->hasModule('WPWebDriver')) {
            throw new ModuleException(
                $this,
                'WooCommerceWebDriver requires the WPWebDriver module to be enabled in the same suite.',
            );
        }
    }

    /**
     * Waits for the redirect triggered by a log-in step before the test continues.
     *
     * wp-browser's `loginAs`/`loginAsAdmin` return once the auth cookies are
     * readable, which can be before the browser commits the post-login redirect:
     * the next navigation then races the pending one and can be overwritten. A
     * Plugin Module cannot override those methods (ADR-0002), so the module
     * intercepts the step and settles the navigation here. See ADR-0010.
     */
    public function _afterStep(Step $step): void
    {
        if ($step->hasFailed() || !in_array($step->getAction(), self::LOGIN_ACTIONS, true)) {
            return;
        }

        $webDriver = $this->wpWebDriver()->webDriver;

        if ($webDriver === null) {
            return;
        }

        $this->waitForLoginToSettle();
    }

    private function waitForLoginToSettle(): void
    {
        $deadline = microtime(true) + self::LOGIN_SETTLE_TIMEOUT;
        $script = 'return document.readyState === "complete" '
            . '&& document.getElementById("loginform") === null;';

        while (microtime(true) < $deadline) {
            try {
                if ($this->wpWebDriver()->executeJS($script) === true) {
                    return;
                }
            } catch (WebDriverException) {
                // The pending redirect is replacing the execution context; poll again.
            }

            usleep(self::LOGIN_SETTLE_POLL_INTERVAL);
        }

        throw new ModuleException(
            $this,
            sprintf(
                'The login page did not settle within %d seconds. %s',
                self::LOGIN_SETTLE_TIMEOUT,
                $this->describeUnsettledLogin(),
            ),
        );
    }

    /**
     * Describe where the browser stopped, so a login that never settled can be told apart from a rejected one.
     */
    private function describeUnsettledLogin(): string
    {
        try {
            $state = $this->wpWebDriver()->executeJS(
                'var error = document.getElementById("login_error");'
                . 'return {url: location.href, error: error ? error.innerText.trim() : ""};',
            );
        } catch (WebDriverException) {
            return 'The browser state could not be read.';
        }

        if (!is_array($state)) {
            return 'The browser state could not be read.';
        }

        $url = is_string($state['url'] ?? null) ? $state['url'] : '';
        $error = is_string($state['error'] ?? null) ? $state['error'] : '';

        return sprintf('Browser at "%s"; login error: "%s".', $url, $error === '' ? 'none' : $error);
    }

    protected function wpWebDriver(): WPWebDriver
    {
        $module = $this->getModule('WPWebDriver');
        assert($module instanceof WPWebDriver);

        return $module;
    }

    protected function pageObjectProvider(): PageObjectProvider
    {
        if ($this->pageObjectProvider === null) {
            /** @var array<string, class-string> $config */
            $config = $this->_getConfig('pageObjects') ?? [];
            $this->pageObjectProvider = new PageObjectProvider($config);
        }

        return $this->pageObjectProvider;
    }

    protected function cartPageSlug(): string
    {
        return $this->pageSlugConfig('cartPageSlug');
    }

    protected function checkoutPageSlug(): string
    {
        return $this->pageSlugConfig('checkoutPageSlug');
    }

    protected function myAccountPageSlug(): string
    {
        return $this->pageSlugConfig('myAccountPageSlug');
    }

    private function pageSlugConfig(string $key): string
    {
        $value = $this->_getConfig($key);

        if (!is_string($value)) {
            throw new ModuleException($this, "Config key \"{$key}\" must be a string slug (e.g. \"/cart\").");
        }

        return $value;
    }

    /**
     * Narrow a page-object selector constant to a string.
     *
     * Page objects expose their selectors as untyped class constants because
     * the package targets PHP 8.0+, where typed class constants are not
     * available. Reading such a constant through a (non-final, overridable)
     * page-object instance therefore widens to mixed under static analysis.
     * Selectors are always strings, so this safely narrows the value.
     */
    protected function selector(mixed $value): string
    {
        return is_string($value) ? $value : '';
    }
}
