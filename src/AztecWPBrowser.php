<?php

declare(strict_types=1);

namespace Aztec\WPBrowser;

use Aztec\WPBrowser\Config\WooCommerceConfig;
use Aztec\WPBrowser\Method\CartMethods;
use Aztec\WPBrowser\Method\CheckoutMethods;
use Aztec\WPBrowser\Method\CouponMethods;
use Aztec\WPBrowser\Method\OrderMethods;
use Aztec\WPBrowser\Method\ProductMethods;
use Aztec\WPBrowser\OrderStorage\HPOSOrderStorage;
use Aztec\WPBrowser\OrderStorage\LegacyOrderStorage;
use Aztec\WPBrowser\OrderStorage\OrderStorageInterface;
use Aztec\WPBrowser\Page\PageObjectProvider;
use Codeception\Module;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

class AztecWPBrowser extends Module
{
    use CartMethods;
    use CheckoutMethods;
    use CouponMethods;
    use OrderMethods;
    use ProductMethods;

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

    private function isHPOSEnabled(): bool
    {
        $value = $this->wpDb()->grabOptionFromDatabase('woocommerce_custom_orders_table_enabled');
        return $value === 'yes' || $value === true;
    }
}
