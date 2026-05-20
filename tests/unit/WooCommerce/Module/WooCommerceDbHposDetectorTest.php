<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\WooCommerce\Module;

use Aztec\WPBrowser\WooCommerce\Module\WooCommerceDb;
use Codeception\Test\Unit;
use lucatume\WPBrowser\Module\WPDb;
use PHPUnit\Framework\MockObject\MockObject;
use ReflectionMethod;

class WooCommerceDbHposDetectorTest extends Unit
{
    public function testReturnsTrueWhenOptionIsYes(): void
    {
        $module = $this->moduleWithWpDb($this->wpDbReturning('yes'));

        $this->assertTrue($this->invokeIsHposEnabled($module));
    }

    public function testReturnsFalseWhenOptionIsNo(): void
    {
        $module = $this->moduleWithWpDb($this->wpDbReturning('no'));

        $this->assertFalse($this->invokeIsHposEnabled($module));
    }

    public function testReturnsFalseWhenOptionIsMissing(): void
    {
        $module = $this->moduleWithWpDb($this->wpDbReturning(false));

        $this->assertFalse($this->invokeIsHposEnabled($module));
    }

    public function testReReadsTheOptionOnEveryCall(): void
    {
        $optionValue = 'no';
        $wpDb = $this->createMock(WPDb::class);
        $wpDb->method('grabOptionFromDatabase')
            ->with('woocommerce_custom_orders_table_enabled')
            ->willReturnCallback(static function () use (&$optionValue) {
                return $optionValue;
            });

        $module = $this->moduleWithWpDb($wpDb);

        $this->assertFalse($this->invokeIsHposEnabled($module));

        $optionValue = 'yes';

        $this->assertTrue(
            $this->invokeIsHposEnabled($module),
            'isHposEnabled() must not cache — it should reflect the new option value',
        );
    }

    private function moduleWithWpDb(WPDb $wpDb): WooCommerceDb
    {
        /** @var WooCommerceDb&MockObject $module */
        $module = $this->getMockBuilder(WooCommerceDb::class)
            ->disableOriginalConstructor()
            ->onlyMethods(['wpDb'])
            ->getMock();

        $module->method('wpDb')->willReturn($wpDb);

        return $module;
    }

    private function wpDbReturning(string|false $value): WPDb&MockObject
    {
        $wpDb = $this->createMock(WPDb::class);
        $wpDb->method('grabOptionFromDatabase')
            ->with('woocommerce_custom_orders_table_enabled')
            ->willReturn($value);

        return $wpDb;
    }

    private function invokeIsHposEnabled(WooCommerceDb $module): bool
    {
        $method = new ReflectionMethod($module, 'isHposEnabled');
        $method->setAccessible(true);

        return (bool) $method->invoke($module);
    }
}
