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

    /**
     * Narrow a page-object selector constant to a string.
     *
     * Page objects expose their selectors as untyped class constants because
     * the package targets PHP 8.0+, where typed class constants are not
     * available. Reading such a constant through a (non-final, overridable)
     * page-object instance therefore widens to mixed under static analysis.
     * Selectors are always strings, so this safely narrows the value.
     */
    protected function selector(mixed $value): string
    {
        return is_string($value) ? $value : '';
    }
}
