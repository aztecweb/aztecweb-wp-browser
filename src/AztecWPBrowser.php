<?php

declare(strict_types=1);

namespace Aztec\WPBrowser;

use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use Aztec\WPBrowser\WooCommerce\Method\CartMethods;
use Aztec\WPBrowser\WooCommerce\Method\CheckoutMethods;
use Aztec\WPBrowser\WooCommerce\Method\CouponMethods;
use Aztec\WPBrowser\WooCommerce\Method\CustomerMethods;
use Aztec\WPBrowser\WooCommerce\Method\OrderMethods;
use Aztec\WPBrowser\WooCommerce\Method\ProductMethods;
use Aztec\WPBrowser\WooCommerce\Method\SubscriptionMethods;
use Aztec\WPBrowser\WooCommerce\OrderStorage\HPOSOrderStorage;
use Aztec\WPBrowser\WooCommerce\OrderStorage\LegacyOrderStorage;
use Aztec\WPBrowser\WooCommerce\OrderStorage\OrderStorageInterface;
use Aztec\WPBrowser\WooCommerce\PageObject\PageObjectProvider;
use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\HPOSSubscriptionStorage;
use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\LegacySubscriptionStorage;
use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\SubscriptionStorageInterface;
use Codeception\Module;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

class AztecWPBrowser extends Module
{
    use CartMethods;
    use CheckoutMethods;
    use CouponMethods;
    use CustomerMethods;
    use OrderMethods;
    use ProductMethods;
    use SubscriptionMethods;

    private ?WooCommerceConfig $wooCommerceConfig = null;
    private ?PageObjectProvider $pageObjectProvider = null;

    protected array $config = [
        'pageObjects' => []
    ];

    protected function wpWebDriver(): WPWebDriver
    {
        /** @var WPWebDriver $wpWebDriver */
        $wpWebDriver = $this->getModule('WPWebDriver');

        return $wpWebDriver;
    }

    protected function wpDb(): WPDb
    {
        /** @var WPDb $wpDb */
        $wpDb = $this->getModule('WPDb');

        return $wpDb;
    }

    protected function wooCommerceConfig(): WooCommerceConfig
    {
        if ($this->wooCommerceConfig === null) {
            $this->wooCommerceConfig = new WooCommerceConfig($this->wpDb());
        }

        return $this->wooCommerceConfig;
    }

    protected function pageObjectProvider(): PageObjectProvider
    {
        if ($this->pageObjectProvider === null) {
            $this->pageObjectProvider = new PageObjectProvider($this->_getConfig('pageObjects'));
        }

        return $this->pageObjectProvider;
    }

    protected function orderStorage(): OrderStorageInterface
    {
        return $this->isHPOSEnabled()
            ? new HPOSOrderStorage($this->wpDb())
            : new LegacyOrderStorage($this->wpDb());
    }

    protected function subscriptionStorage(): SubscriptionStorageInterface
    {
        return $this->isHPOSEnabled()
            ? new HPOSSubscriptionStorage($this->wpDb())
            : new LegacySubscriptionStorage($this->wpDb());
    }

    private function isHPOSEnabled(): bool
    {
        $value = $this->wpDb()->grabOptionFromDatabase('woocommerce_custom_orders_table_enabled');
        return $value === 'yes' || $value === true;
    }
}
