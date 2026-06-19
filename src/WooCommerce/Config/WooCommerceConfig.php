<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Config;

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
