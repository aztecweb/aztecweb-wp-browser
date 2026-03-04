<?php

declare(strict_types=1);

namespace Aztec\WPBrowser;

use Aztec\WPBrowser\Config\WooCommerceConfig;
use Aztec\WPBrowser\Method\CartMethods;
use Aztec\WPBrowser\Method\OrderMethods;
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
    use OrderMethods;

    private ?WooCommerceConfig $wooCommerceConfig = null;
    private ?PageObjectProvider $pageObjectProvider = null;
    private ?OrderStorageInterface $orderStorage = null;

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
        if ($this->orderStorage === null) {
            $this->orderStorage = $this->isHPOSEnabled()
                ? new HPOSOrderStorage($this->wpDb())
                : new LegacyOrderStorage($this->wpDb());
        }

        return $this->orderStorage;
    }

    private function isHPOSEnabled(): bool
    {
        $value = $this->wpDb()->grabOptionFromDatabase('woocommerce_custom_orders_table_enabled');
        return $value === 'yes' || $value === true;
    }
}
