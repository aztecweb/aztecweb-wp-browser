<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

class InvalidModuleDocblockReturnBeforeExample
{
    /**
     * Creates a coupon in the database.
     *
     * @return int The created coupon ID.
     *
     * @example
     * ```php
     * $couponId = $I->havePercentageCouponInDatabase('PCT20', 20.0);
     * ```
     *
     * @param string $code       The coupon code.
     * @param float  $percentage The discount percentage.
     */
    public function havePercentageCouponInDatabase(string $code, float $percentage): int
    {
        return 123;
    }
}
