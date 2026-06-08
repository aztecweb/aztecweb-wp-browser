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
        if (!isset($this->slugCache[$pageIdOption])) {
            $pageId = $this->wpDb->grabOptionFromDatabase($pageIdOption);
            $pageId = is_numeric($pageId) ? (int) $pageId : 0;
            $slug = $this->wpDb->grabPostFieldFromDatabase($pageId, 'post_name');
            $slug = is_string($slug) ? $slug : '';
            $this->slugCache[$pageIdOption] = '/' . $slug;
        }

        return $this->slugCache[$pageIdOption];
    }
}
