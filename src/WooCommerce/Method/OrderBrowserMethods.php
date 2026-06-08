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
