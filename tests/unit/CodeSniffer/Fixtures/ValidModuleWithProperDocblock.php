<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

class ValidModuleWithProperDocblock
{
    /**
     * Creates a coupon in the database.
     *
     * @example
     * ```php
     * $couponId = $I->havePercentageCouponInDatabase('PCT20', 20.0);
     * ```
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
