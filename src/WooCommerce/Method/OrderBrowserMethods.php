<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Aztec\WPBrowser\WooCommerce\OrderStorage\HPOSOrderStorage;
use Aztec\WPBrowser\WooCommerce\OrderStorage\LegacyOrderStorage;
use Aztec\WPBrowser\WooCommerce\OrderStorage\OrderStorageInterface;
use Aztec\WPBrowser\WooCommerce\Storage\HposState;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

trait OrderBrowserMethods
{
    abstract protected function wpDb(): WPDb;

    abstract protected function wpWebDriver(): WPWebDriver;

    /**
     * Navigate to the admin order edit page for a given order.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase(['status' => 'processing']);
     * $I->amOnAdminOrderPage($orderId);
     * $I->seeInCurrentUrl('order/' . $orderId);
     * ```
     *
     * @param int $orderId  Order ID to view in the admin
     *
     * @return void
     */
    public function amOnAdminOrderPage(int $orderId): void
    {
        $this->wpWebDriver()->amOnAdminPage($this->resolveOrderStorage()->getAdminOrderEditUrl($orderId));
    }

    private function resolveOrderStorage(): OrderStorageInterface
    {
        $wpDb = $this->wpDb();

        return HposState::isEnabled($wpDb)
            ? new HPOSOrderStorage($wpDb)
            : new LegacyOrderStorage($wpDb);
    }
}
