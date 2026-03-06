<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Page;

use Aztec\WPBrowser\Page\CartPageObject;
use Aztec\WPBrowser\Page\CheckoutPageObject;

class PageObjectProvider
{
    private array $pageInstances = [];
    private array $pageObjectsConfig;

    public function __construct(array $pageObjectsConfig)
    {
        $this->pageObjectsConfig = $pageObjectsConfig;
    }

    public function cartPage(): CartPageObject
    {
        if ( ! isset($this->pageInstances['cart'])) {
            $class                       = $this->pageObjectsConfig['cart'] ?? CartPageObject::class;
            $this->pageInstances['cart'] = new $class();
        }

        return $this->pageInstances['cart'];
    }

    public function checkoutPage(): CheckoutPageObject
    {
        if ( ! isset($this->pageInstances['checkout'])) {
            $class                         = $this->pageObjectsConfig['checkout'] ?? CheckoutPageObject::class;
            $this->pageInstances['checkout'] = new $class();
        }

        return $this->pageInstances['checkout'];
    }

}
