<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\WooCommerce\Module;

use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use Aztec\WPBrowser\WooCommerce\Module\WooCommerceWebDriver;
use Codeception\Test\Unit;
use PHPUnit\Framework\MockObject\MockObject;
use ReflectionMethod;
use ReflectionProperty;

class WooCommerceWebDriverPageSlugTest extends Unit
{
    public function testDefaultsToWooCommerceConventionSlugs(): void
    {
        $config = $this->wooCommerceConfigOf($this->module());

        $this->assertSame('/cart', $config->cartPageSlug());
        $this->assertSame('/checkout', $config->checkoutPageSlug());
        $this->assertSame('/my-account', $config->myAccountPageSlug());
    }

    public function testEachSlugIsIndependentlyOverridable(): void
    {
        $module = $this->module([
            'checkoutPageSlug' => '/finalizar-compra',
        ]);

        $config = $this->wooCommerceConfigOf($module);

        $this->assertSame('/cart', $config->cartPageSlug(), 'untouched slug keeps its default');
        $this->assertSame('/finalizar-compra', $config->checkoutPageSlug(), 'overridden slug wins');
        $this->assertSame('/my-account', $config->myAccountPageSlug(), 'untouched slug keeps its default');
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

    private function wooCommerceConfigOf(WooCommerceWebDriver $module): WooCommerceConfig
    {
        $method = new ReflectionMethod($module, 'wooCommerceConfig');
        $method->setAccessible(true);

        $config = $method->invoke($module);
        assert($config instanceof WooCommerceConfig);

        return $config;
    }
}
