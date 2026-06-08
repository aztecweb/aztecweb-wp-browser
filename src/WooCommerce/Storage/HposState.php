<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

use lucatume\WPBrowser\Module\WPDb;

final class HposState
{
    public const OPTION_NAME = 'woocommerce_custom_orders_table_enabled';

    public static function isEnabled(WPDb $wpDb): bool
    {
        return $wpDb->grabOptionFromDatabase(self::OPTION_NAME) === 'yes';
    }
}
