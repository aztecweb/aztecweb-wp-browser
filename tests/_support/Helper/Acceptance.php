<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Support\Helper;

use Codeception\Module;

/**
 * Acceptance Helper for additional custom methods.
 */
class Acceptance extends Module
{
    /**
     * Wait for WooCommerce to be fully loaded.
     */
    public function waitForWooCommerce(): void
    {
        $this->getModule('WPWebDriver')->waitForElement('.woocommerce', 10);
    }
}
