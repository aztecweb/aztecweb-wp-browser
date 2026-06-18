<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Support\Helper;

use Codeception\Module;
use lucatume\WPBrowser\ManagedProcess\PhpBuiltInServer;
use lucatume\WPBrowser\Module\WPWebDriver;
use lucatume\WPBrowser\Utils\Ports;

/**
 * Acceptance Helper for additional custom methods.
 */
class Acceptance extends Module
{
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
     * Override WooCommerceWebDriver page-slug config for the current test.
     *
     * Mirrors a per-slug override in suite.yml so acceptance tests can exercise
     * a renamed page without a second suite. Pair with
     * resetWooCommerceWebDriverConfig() to restore the declared defaults.
     *
     * @param array<string, string> $config
     */
    public function overrideWooCommerceWebDriverConfig(array $config): void
    {
        $this->getModule('WooCommerceWebDriver')->_reconfigure($config);
    }

    /**
     * Restore WooCommerceWebDriver config to its declared defaults.
     */
    public function resetWooCommerceWebDriverConfig(): void
    {
        $this->getModule('WooCommerceWebDriver')->_resetConfig();
    }

    /**
     * Restart the PHP built-in server, dropping any in-flight request.
     */
    public function restartBuiltInServer(): void
    {
        /** @var WPWebDriver $webDriver */
        $webDriver = $this->getModule('WPWebDriver');

        // Quiesce the browser first so the live page cannot re-fire AJAX
        // requests against the restarted server. window.stop() halts in-flight
        // requests; replacing the document with a blank one tears down the React
        // app and its timers. (amOnUrl('about:blank') is unreliable here, so we
        // drive it from page JS directly.)
        if ($webDriver->webDriver !== null) {
            try {
                $webDriver->executeJS('window.stop(); window.location.replace("about:blank");');
            } catch (\Throwable $e) {
                // No live document; the server restart below still quiesces it.
            }
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
}
