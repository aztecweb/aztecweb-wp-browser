<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\WooCommerce\Module;

use Aztec\WPBrowser\WooCommerce\Module\WooCommerceWebDriver;
use Codeception\Test\Unit;
use PHPUnit\Framework\MockObject\MockObject;
use ReflectionMethod;
use ReflectionProperty;

class WooCommerceWebDriverPageSlugTest extends Unit
{
    public function testDefaultsToWooCommerceConventionSlugs(): void
    {
        $module = $this->module();

        $this->assertSame('/cart', $this->invoke($module, 'cartPageSlug'));
        $this->assertSame('/checkout', $this->invoke($module, 'checkoutPageSlug'));
        $this->assertSame('/my-account', $this->invoke($module, 'myAccountPageSlug'));
    }

    public function testEachSlugIsIndependentlyOverridable(): void
    {
        $module = $this->module([
            'checkoutPageSlug' => '/finalizar-compra',
        ]);

        $this->assertSame('/cart', $this->invoke($module, 'cartPageSlug'), 'untouched slug keeps its default');
        $this->assertSame(
            '/finalizar-compra',
            $this->invoke($module, 'checkoutPageSlug'),
            'overridden slug wins',
        );
        $this->assertSame(
            '/my-account',
            $this->invoke($module, 'myAccountPageSlug'),
            'untouched slug keeps its default',
        );
    }

    private function invoke(WooCommerceWebDriver $module, string $method): string
    {
        $reflection = new ReflectionMethod($module, $method);
        $reflection->setAccessible(true);

        $value = $reflection->invoke($module);
        assert(is_string($value));

        return $value;
    }

    /**
     * @param array<string, mixed> $overrides
     */
    private function module(array $overrides = []): WooCommerceWebDriver
    {
        /** @var WooCommerceWebDriver&MockObject $module */
        $module = $this->getMockBuilder(WooCommerceWebDriver::class)
            ->disableOriginalConstructor()
            ->onlyMethods([])
            ->getMock();

        if ($overrides !== []) {
            $property = new ReflectionProperty($module, 'config');
            $property->setAccessible(true);
            /** @var array<string, mixed> $current */
            $current = $property->getValue($module);
            $property->setValue($module, array_merge($current, $overrides));
        }

        return $module;
    }
}
