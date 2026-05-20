<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use lucatume\WPBrowser\Module\WPDb;

trait WooCommerceModuleSupport
{
    private ?WooCommerceConfig $wooCommerceConfig = null;

    protected function wpDb(): WPDb
    {
        $module = $this->getModule('WPDb');
        assert($module instanceof WPDb);

        return $module;
    }

    protected function wooCommerceConfig(): WooCommerceConfig
    {
        return $this->wooCommerceConfig ??= new WooCommerceConfig($this->wpDb());
    }
}
