<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Module;

class ValidProtectedMethodWithoutDocblock
{
    protected function helperMethod(): string
    {
        return 'helper';
    }
}
