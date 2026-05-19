<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

use Aztec\WPBrowser\ActionScheduler\Method\ActionMethods;
use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use Aztec\WPBrowser\WooCommerce\Method\CouponMethods;
use Aztec\WPBrowser\WooCommerce\Method\CustomerMethods;
use Aztec\WPBrowser\WooCommerce\Method\OrderMethods;
use Aztec\WPBrowser\WooCommerce\Method\ProductMethods;
use Aztec\WPBrowser\WooCommerce\Method\SubscriptionMethods;
use Aztec\WPBrowser\WooCommerce\OrderStorage\HPOSOrderStorage;
use Aztec\WPBrowser\WooCommerce\OrderStorage\LegacyOrderStorage;
use Aztec\WPBrowser\WooCommerce\OrderStorage\OrderStorageInterface;
use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\HPOSSubscriptionStorage;
use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\LegacySubscriptionStorage;
use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\SubscriptionStorageInterface;
use Codeception\Exception\ModuleException;
use Codeception\Module;
use lucatume\WPBrowser\Module\WPDb;

class WooCommerceDb extends Module
{
    use ActionMethods;
    use CouponMethods;
    use CustomerMethods;
    use OrderMethods;
    use ProductMethods;
    use SubscriptionMethods;

    private ?WooCommerceConfig $wooCommerceConfig = null;

    public function _initialize(): void
    {
        if (! $this->hasModule('WPDb')) {
            throw new ModuleException(
                $this,
                'WooCommerceDb requires the WPDb module to be enabled in the same suite.',
            );
        }
    }

    protected function isHposEnabled(): bool
    {
        $value = $this->wpDb()->grabOptionFromDatabase('woocommerce_custom_orders_table_enabled');

        return $value === 'yes';
    }

    protected function wpDb(): WPDb
    {
        $module = $this->getModule('WPDb');
        assert($module instanceof WPDb);

        return $module;
    }

    protected function wooCommerceConfig(): WooCommerceConfig
    {
        if ($this->wooCommerceConfig === null) {
            $this->wooCommerceConfig = new WooCommerceConfig($this->wpDb());
        }

        return $this->wooCommerceConfig;
    }

    protected function orderStorage(): OrderStorageInterface
    {
        return $this->isHposEnabled()
            ? new HPOSOrderStorage($this->wpDb())
            : new LegacyOrderStorage($this->wpDb());
    }

    protected function subscriptionStorage(): SubscriptionStorageInterface
    {
        return $this->isHposEnabled()
            ? new HPOSSubscriptionStorage($this->wpDb())
            : new LegacySubscriptionStorage($this->wpDb());
    }
}
