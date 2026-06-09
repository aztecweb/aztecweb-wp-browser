<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

class InvalidModuleDocblockWithoutExample
{
    /**
     * Creates a coupon in the database.
     *
     * @param string $code       The coupon code.
     * @param float  $percentage The discount percentage.
     *
     * @return int The created coupon ID.
     */
    public function havePercentageCouponInDatabase(string $code, float $percentage): int
    {
        return 123;
    }
}
