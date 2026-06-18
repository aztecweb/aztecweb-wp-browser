<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Aztec\WPBrowser\WooCommerce\Browser\AdminOrderUrlResolver;
use lucatume\WPBrowser\Module\WPWebDriver;

trait OrderBrowserMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;

    abstract public function _getConfig(?string $key = null): mixed;

    /**
     * Navigate to the admin order edit page for a given order.
     *
     * The order-storage mode is read from the `legacyOrderStorage` config flag
     * (default `false`, i.e. HPOS) — the browser layer never inspects the
     * database to build this URL. See ADR-0008.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase(['status' => 'processing']);
     * $I->amOnAdminOrderPage($orderId);
     * $I->seeInCurrentUrl('action=edit');
     * ```
     *
     * @param int $orderId  Order ID to view in the admin
     *
     * @return void
     */
    public function amOnAdminOrderPage(int $orderId): void
    {
        $legacyOrderStorage = (bool) $this->_getConfig('legacyOrderStorage');
        $url = (new AdminOrderUrlResolver())->resolve($orderId, $legacyOrderStorage);

        $this->wpWebDriver()->amOnAdminPage($url);
    }
}
