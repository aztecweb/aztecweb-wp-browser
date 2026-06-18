<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\WooCommerce\Config;

use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use Codeception\Test\Unit;

class WooCommerceConfigTest extends Unit
{
    public function testExposesTheConfiguredPageSlugs(): void
    {
        $config = new WooCommerceConfig('/cart', '/checkout', '/my-account');

        $this->assertSame('/cart', $config->cartPageSlug());
        $this->assertSame('/checkout', $config->checkoutPageSlug());
        $this->assertSame('/my-account', $config->myAccountPageSlug());
    }

    public function testReturnsPerSlugOverridesVerbatim(): void
    {
        $config = new WooCommerceConfig('/basket', '/pay', '/account');

        $this->assertSame('/basket', $config->cartPageSlug());
        $this->assertSame('/pay', $config->checkoutPageSlug());
        $this->assertSame('/account', $config->myAccountPageSlug());
    }
}
