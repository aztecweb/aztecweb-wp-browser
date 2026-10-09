<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Support\Helper;

use Codeception\Exception\ModuleException;
use Codeception\Module;
use Codeception\Step\Action;
use Codeception\TestInterface;
use Facebook\WebDriver\Chrome\ChromeDevToolsDriver;
use lucatume\WPBrowser\ManagedProcess\PhpBuiltInServer;
use lucatume\WPBrowser\Module\WPWebDriver;
use lucatume\WPBrowser\Utils\Ports;

/**
 * Acceptance Helper for additional custom methods.
 */
class Acceptance extends Module
{
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
            (new ChromeDevToolsDriver($webDriver->webDriver))->execute('Network.clearBrowserCookies');
        }

        $this->quiesceBrowser($webDriver);
        $this->waitForServerToFinishRequests($webDriver);
    }

    /**
     * Run the WooCommerceWebDriver hook that follows a `loginAsAdmin` step, without running the step.
     *
     * Lets a test put the browser in the state a log-in step can leave behind
     * and check how the hook settles it.
     */
    public function settleLoginStep(): void
    {
        $this->getModule('WooCommerceWebDriver')->_afterStep(new Action('loginAsAdmin', []));
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
     * Wait for WooCommerce to be fully loaded.
     */
    public function waitForWooCommerce(): void
    {
        /** @var WPWebDriver $webDriver */
        $webDriver = $this->getModule('WPWebDriver');
        $webDriver->waitForElement('.woocommerce', 10);
    }

    /**
     * Restart the PHP built-in server, dropping any in-flight request.
     */
    public function restartBuiltInServer(): void
    {
        /** @var WPWebDriver $webDriver */
        $webDriver = $this->getModule('WPWebDriver');

        // Quiesce the browser first so the live page cannot re-fire AJAX
        // requests against the restarted server, then let the server finish
        // the requests it already received: killing it mid-write leaves a
        // SQLite journal that is rolled back onto the next test's database.
        if ($webDriver->webDriver !== null) {
            $this->quiesceBrowser($webDriver);
            $this->waitForServerToFinishRequests($webDriver);
        }

        $pidFile = PhpBuiltInServer::getPidFile();
        $port    = (int) (getenv('WP_SERVER_PORT') ?: 8080);
        $docRoot = getenv('WP_DOCROOT') ?: 'public';
        $workers = (int) (getenv('WP_SERVER_WORKERS') ?: 1);

        // Kill the running server
        if (is_file($pidFile)) {
            $pid = (int) file_get_contents($pidFile);
            if ($pid > 0) {
                exec('kill ' . $pid . ' 2>/dev/null');
            }
            // Remove the PID file so PhpBuiltInServer::start() does not early-return.
            @unlink($pidFile);
        }

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
     */
    private function waitForServerToFinishRequests(WPWebDriver $webDriver): void
    {
        $url = rtrim((string) $webDriver->_getConfig('url'), '/') . '/wp/wp-includes/images/blank.gif';
        $context = stream_context_create(['http' => ['timeout' => 60]]);

        if (@file_get_contents($url, false, $context) === false) {
            throw new ModuleException($this, "The built-in server did not answer {$url}.");
        }
    }
}
