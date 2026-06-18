<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\WooCommerce\Browser;

use Aztec\WPBrowser\WooCommerce\Browser\AdminOrderUrlResolver;
use Codeception\Test\Unit;

class AdminOrderUrlResolverTest extends Unit
{
    public function testResolvesHposUrlWhenStorageIsNotLegacy(): void
    {
        $resolver = new AdminOrderUrlResolver();

        $this->assertSame(
            'admin.php?page=wc-orders&action=edit&id=42',
            $resolver->resolve(42, false),
        );
    }

    public function testResolvesLegacyUrlWhenStorageIsLegacy(): void
    {
        $resolver = new AdminOrderUrlResolver();

        $this->assertSame(
            'post.php?post=42&action=edit',
            $resolver->resolve(42, true),
        );
    }
}
