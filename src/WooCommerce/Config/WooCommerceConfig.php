<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Config;

use lucatume\WPBrowser\Module\WPDb;

class WooCommerceConfig
{
    /** @var array<string, string> */
    private array $slugCache = [];

    public function __construct(private WPDb $wpDb)
    {
    }

    public function cartPageSlug(): string
    {
        return $this->pageSlug('woocommerce_cart_page_id');
    }

    public function checkoutPageSlug(): string
    {
        return $this->pageSlug('woocommerce_checkout_page_id');
    }

    public function myAccountPageSlug(): string
    {
        return $this->pageSlug('woocommerce_myaccount_page_id');
    }

    private function pageSlug(string $pageIdOption): string
    {
        return $this->slugCache[$pageIdOption] ??= '/' . $this->wpDb->grabPostFieldFromDatabase(
            (int) $this->wpDb->grabOptionFromDatabase($pageIdOption),
            'post_name',
        );
    }
}
