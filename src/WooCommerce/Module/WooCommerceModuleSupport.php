<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use lucatume\WPBrowser\Module\WPDb;

trait WooCommerceModuleSupport
{
    protected function wpDb(): WPDb
    {
        $module = $this->getModule('WPDb');
        assert($module instanceof WPDb);

        return $module;
    }

    protected function wooCommerceConfig(): WooCommerceConfig
    {
        return new WooCommerceConfig(
            $this->pageSlugConfig('cartPageSlug'),
            $this->pageSlugConfig('checkoutPageSlug'),
            $this->pageSlugConfig('myAccountPageSlug'),
        );
    }

    private function pageSlugConfig(string $key): string
    {
        $value = $this->_getConfig($key);

        return is_string($value) ? $value : '';
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
