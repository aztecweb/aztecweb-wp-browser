<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\PageObject;

class PageObjectProvider
{
    /** @var array<string, CartPageObject|CheckoutPageObject> */
    private array $pageInstances = [];
    /** @var array<string, string|object> */
    private array $pageObjectsConfig;

    /**
     * Initialize with page objects configuration.
     *
     * @param array<string, string|object> $pageObjectsConfig Configuration for page objects.
     */
    public function __construct(array $pageObjectsConfig)
    {
        $this->pageObjectsConfig = $pageObjectsConfig;
    }

    public function cartPage(): CartPageObject
    {
        if ( ! isset($this->pageInstances['cart'])) {
            $class = $this->pageObjectsConfig['cart'] ?? CartPageObject::class;
            /** @var CartPageObject $pageObj */
            $pageObj = new $class();
            $this->pageInstances['cart'] = $pageObj;
        }

        /** @var CartPageObject $instance */
        $instance = $this->pageInstances['cart'];
        return $instance;
    }

    public function checkoutPage(): CheckoutPageObject
    {
        if ( ! isset($this->pageInstances['checkout'])) {
            $class = $this->pageObjectsConfig['checkout'] ?? CheckoutPageObject::class;
            /** @var CheckoutPageObject $pageObj */
            $pageObj = new $class();
            $this->pageInstances['checkout'] = $pageObj;
        }

        /** @var CheckoutPageObject $instance */
        $instance = $this->pageInstances['checkout'];
        return $instance;
    }

}
