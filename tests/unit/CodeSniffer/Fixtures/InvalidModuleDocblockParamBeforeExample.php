<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

class InvalidModuleDocblockParamBeforeExample
{
    /**
     * Creates a coupon in the database.
     *
     * @param string $code       The coupon code.
     * @param float  $percentage The discount percentage.
     *
     * @example
     * ```php
     * $couponId = $I->havePercentageCouponInDatabase('PCT20', 20.0);
     * ```
     *
     * @return int The created coupon ID.
     */
    public function havePercentageCouponInDatabase(string $code, float $percentage): int
    {
        return 123;
    }
}
