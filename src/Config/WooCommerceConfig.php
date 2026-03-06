<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Config;

use lucatume\WPBrowser\Module\WPDb;

class WooCommerceConfig
{
    private WPDb $wpDb;
    private ?string $cartPageSlug = null;
    private ?string $checkoutPageSlug = null;

    public function __construct(WPDb $wpDb)
    {
        $this->wpDb = $wpDb;
    }

    public function cartPageSlug(): string
    {
        if ($this->cartPageSlug !== null) {
            return $this->cartPageSlug;
        }

        $pageId = intval($this->wpDb->grabOptionFromDatabase('woocommerce_cart_page_id'));

        $this->cartPageSlug = '/' . $this->wpDb->grabPostFieldFromDatabase($pageId, 'post_name');

        return $this->cartPageSlug;
    }

    public function checkoutPageSlug(): string
    {
        if ($this->checkoutPageSlug !== null) {
            return $this->checkoutPageSlug;
        }

        $pageId = intval($this->wpDb->grabOptionFromDatabase('woocommerce_checkout_page_id'));

        $this->checkoutPageSlug = '/' . $this->wpDb->grabPostFieldFromDatabase($pageId, 'post_name');

        return $this->checkoutPageSlug;
    }
}
