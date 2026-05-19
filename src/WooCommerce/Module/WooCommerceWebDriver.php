<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use Aztec\WPBrowser\WooCommerce\Method\CartMethods;
use Aztec\WPBrowser\WooCommerce\Method\CheckoutMethods;
use Aztec\WPBrowser\WooCommerce\Method\CustomerBrowserMethods;
use Aztec\WPBrowser\WooCommerce\Method\OrderBrowserMethods;
use Aztec\WPBrowser\WooCommerce\PageObject\PageObjectProvider;
use Codeception\Exception\ModuleException;
use Codeception\Module;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

class WooCommerceWebDriver extends Module
{
    use CartMethods;
    use CheckoutMethods;
    use CustomerBrowserMethods;
    use OrderBrowserMethods;

    /** @var array<string, mixed> */
    protected array $config = [
        'pageObjects' => [],
    ];

    private ?WooCommerceConfig $wooCommerceConfig = null;
    private ?PageObjectProvider $pageObjectProvider = null;

    public function _initialize(): void
    {
        if (! $this->hasModule('WPWebDriver')) {
            throw new ModuleException(
                $this,
                'WooCommerceWebDriver requires the WPWebDriver module to be enabled in the same suite.',
            );
        }

        if (! $this->hasModule('WPDb')) {
            throw new ModuleException(
                $this,
                'WooCommerceWebDriver requires the WPDb module to be enabled in the same suite '
                . '(it reads WooCommerce configuration directly from the database).',
            );
        }
    }

    protected function wpDb(): WPDb
    {
        $module = $this->getModule('WPDb');
        assert($module instanceof WPDb);

        return $module;
    }

    protected function wpWebDriver(): WPWebDriver
    {
        $module = $this->getModule('WPWebDriver');
        assert($module instanceof WPWebDriver);

        return $module;
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
            /** @var array<string, class-string> $config */
            $config = $this->_getConfig('pageObjects') ?? [];
            $this->pageObjectProvider = new PageObjectProvider($config);
        }

        return $this->pageObjectProvider;
    }
}
