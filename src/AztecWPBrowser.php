<?php

declare(strict_types=1);

namespace Aztec\WPBrowser;

use Aztec\WPBrowser\Config\WooCommerceConfig;
use Aztec\WPBrowser\Method\CartMethods;
use Aztec\WPBrowser\Page\PageObjectProvider;
use Codeception\Module;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

class AztecWPBrowser extends Module
{
    use CartMethods;

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
}
