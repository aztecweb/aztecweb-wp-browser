<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

class InvalidModuleWithoutDocblock
{
    public function havePercentageCouponInDatabase(string $code, float $percentage): int
    {
        return 123;
    }
}
