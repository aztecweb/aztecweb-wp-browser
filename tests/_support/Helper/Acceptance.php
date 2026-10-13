<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Support\Helper;

use Codeception\Exception\ModuleException;
use Codeception\Module;
use Codeception\TestInterface;
use Facebook\WebDriver\Chrome\ChromeDevToolsDriver;
use Facebook\WebDriver\Remote\RemoteWebDriver;
use lucatume\WPBrowser\ManagedProcess\PhpBuiltInServer;
use lucatume\WPBrowser\Module\WPWebDriver;
use lucatume\WPBrowser\Utils\Ports;

/**
 * Acceptance Helper for additional custom methods.
 */
class Acceptance extends Module
{
    private bool $browserCpuThrottled = false;

    /**
     * Stop the browser from talking to WordPress before the next test reloads the database.
     *
     * WPDb reloads the SQLite file in place before each test, while the page
     * left by a browser test can keep firing requests, such as WooCommerce's
     * cart fragments. A request that touches the file mid-reload leaves the
     * next test without tables ("no such table: wp_options"). This module is
     * listed last, so its `_after` runs before the other modules' hooks and
     * before the next test's database reload.
     *
     * Replacing the page only stops the browser: a request the server already
     * received keeps running. The single-worker built-in server answers one
     * request at a time, so a request for a static file returns only once the
     * requests ahead of it are done.
     *
     * Cookies are cleared through the DevTools protocol: WPWebDriver clears
     * them in its own `_after`, on the blank page, where the site's cookies are
     * out of reach, and WebDriver only deletes the cookies the current page can
     * see, so a log-in cookie scoped to the `/wp/` path reached the next test.
     */
    public function _after(TestInterface $test): void
    {
        /** @var WPWebDriver $webDriver */
        $webDriver = $this->getModule('WPWebDriver');

        if ($webDriver->webDriver === null) {
            return;
        }

        if ($webDriver->_getConfig('clear_cookies')) {
            $this->clearBrowserCookies($webDriver->webDriver);
        }

        if ($this->browserCpuThrottled) {
            $this->setBrowserCpuThrottlingRate($webDriver->webDriver, 1);
            $this->browserCpuThrottled = false;
        }

        $this->quiesceBrowser($webDriver);

        if (!$this->waitForServerToFinishRequests($webDriver)) {
            throw new ModuleException(
                $this,
                "The built-in server did not answer {$this->serverIdleProbeUrl($webDriver)}.",
            );
        }
    }

    /**
     * Declare the store-wide order-storage mode for the browser layer.
     *
     * Reconfigures the WooCommerceWebDriver `legacyOrderStorage` flag at
     * runtime so a single suite can exercise admin order URLs under both
     * storage modes. Mirrors what a suite.yml override would do.
     *
     * @param bool $legacy `true` for legacy (wp_posts), `false` for HPOS.
     */
    public function setLegacyOrderStorage(bool $legacy): void
    {
        $this->getModule('WooCommerceWebDriver')->_reconfigure(['legacyOrderStorage' => $legacy]);
    }

    /**
     * Slow the browser's CPU down by the given factor until the end of the test.
     *
     * Makes the work the browser does after a page loads, such as rendering a
     * block, last long enough for a test to tell whether a step waits for it.
     *
     * @param float $rate Slowdown factor; `1` runs at full speed.
     */
    public function throttleBrowserCpu(float $rate): void
    {
        /** @var WPWebDriver $webDriver */
        $webDriver = $this->getModule('WPWebDriver');

        if ($webDriver->webDriver === null) {
            throw new ModuleException($this, 'There is no browser session to throttle.');
        }

        $this->setBrowserCpuThrottlingRate($webDriver->webDriver, $rate);
        $this->browserCpuThrottled = true;
    }

    /**
     * Wait for WooCommerce to be fully loaded.
     */
    public function waitForWooCommerce(): void
    {
        /** @var WPWebDriver $webDriver */
        $webDriver = $this->getModule('WPWebDriver');
        $webDriver->waitForElement('.woocommerce', 10);
    }

    /**
     * Restart the PHP built-in server once it has finished the requests it already received.
     *
     * The browser is quiesced first so the live page cannot re-fire AJAX
     * requests against the restarted server. Killing the server mid-write
     * leaves a SQLite journal that is rolled back onto the next test's
     * database, so the restart waits for the pending requests. A server that
     * does not answer has no request left to finish and is replaced anyway.
     */
    public function restartBuiltInServer(): void
    {
        /** @var WPWebDriver $webDriver */
        $webDriver = $this->getModule('WPWebDriver');

        if ($webDriver->webDriver !== null) {
            $this->quiesceBrowser($webDriver);
            $this->waitForServerToFinishRequests($webDriver);
        }

        $pidFile = PhpBuiltInServer::getPidFile();
        $port    = (int) (getenv('WP_SERVER_PORT') ?: 8080);
        $docRoot = getenv('WP_DOCROOT') ?: 'public';
        $workers = (int) (getenv('WP_SERVER_WORKERS') ?: 1);

        $pid = is_file($pidFile) ? (int) file_get_contents($pidFile) : 0;

        if ($pid < 1) {
            throw new ModuleException(
                $this,
                "The built-in server's PID file {$pidFile} is missing or empty, so the server cannot be stopped. "
                    . 'Was another bin/test command run on this checkout during the suite?',
            );
        }

        exec('kill ' . $pid . ' 2>/dev/null');
        // Remove the PID file so PhpBuiltInServer::start() does not early-return.
        @unlink($pidFile);

        // Wait for the listening port to be released (kill is asynchronous).
        $deadline = microtime(true) + 5.0;
        while (Ports::isPortOccupied($port) && microtime(true) < $deadline) {
            usleep(50_000);
        }

        // Start a fresh, idle server with the configured worker count. The
        // process is detached (createNewConsole) so it survives this scope, and
        // start() rewrites the PID file so suite teardown still finds it. A
        // failure surfaces deliberately — a dead server must fail loudly.
        (new PhpBuiltInServer($docRoot, $port, ['PHP_CLI_SERVER_WORKERS' => $workers]))->start();
    }

    /**
     * Replace the live page with a blank one, stopping its requests and timers.
     *
     * window.stop() halts in-flight requests; replacing the document tears down
     * the React app and its timers. (amOnUrl('about:blank') is unreliable here,
     * so we drive it from page JS directly.)
     */
    private function quiesceBrowser(WPWebDriver $webDriver): void
    {
        try {
            $webDriver->executeJS('window.stop(); window.location.replace("about:blank");');
        } catch (\Throwable $e) {
            // No live document; nothing to quiesce.
        }
    }

    /**
     * Return once the built-in server has answered every request sent before this one.
     *
     * @return bool `false` when the server did not answer.
     */
    private function waitForServerToFinishRequests(WPWebDriver $webDriver): bool
    {
        $context = stream_context_create(['http' => ['timeout' => 60]]);

        return @file_get_contents($this->serverIdleProbeUrl($webDriver), false, $context) !== false;
    }

    /**
     * Static file the single-worker built-in server serves only after its earlier requests.
     *
     * Derived from the `WPWebDriver` `adminPath`, so it follows WordPress
     * wherever the site installs it.
     */
    private function serverIdleProbeUrl(WPWebDriver $webDriver): string
    {
        $url = (string) $webDriver->_getConfig('url');
        $adminPath = (string) $webDriver->_getConfig('adminPath');

        return rtrim($url, '/') . str_replace('wp-admin', 'wp-includes/images/blank.gif', $adminPath);
    }

    /**
     * Delete every cookie in the browser, whatever its domain or path.
     *
     * A browser session that already died has no cookies left to delete, so
     * the error is logged instead of failing the test, as WebDriver's own
     * `_after` does.
     */
    private function clearBrowserCookies(RemoteWebDriver $browser): void
    {
        try {
            (new ChromeDevToolsDriver($browser))->execute('Network.clearBrowserCookies');
        } catch (\Throwable $e) {
            $this->debug("Error, can't clear the browser cookies after a test: " . $e->getMessage());
        }
    }

    /**
     * Set how many times slower than normal the browser's CPU runs.
     */
    private function setBrowserCpuThrottlingRate(RemoteWebDriver $browser, float $rate): void
    {
        (new ChromeDevToolsDriver($browser))->execute('Emulation.setCPUThrottlingRate', ['rate' => $rate]);
    }
}
