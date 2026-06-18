<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Config;

/**
 * Holds the WooCommerce page slugs the browser layer navigates to.
 *
 * Slugs are declared in the WooCommerceWebDriver module config (with
 * WooCommerce-convention defaults) rather than resolved from the database, so
 * navigation never queries the system under test. See
 * docs/adr/0008-webdriver-store-shape-via-config.md.
 */
class WooCommerceConfig
{
    public function __construct(
        private string $cartPageSlug,
        private string $checkoutPageSlug,
        private string $myAccountPageSlug,
    ) {
    }

    public function cartPageSlug(): string
    {
        return $this->cartPageSlug;
    }

    public function checkoutPageSlug(): string
    {
        return $this->checkoutPageSlug;
    }

    public function myAccountPageSlug(): string
    {
        return $this->myAccountPageSlug;
    }
}
