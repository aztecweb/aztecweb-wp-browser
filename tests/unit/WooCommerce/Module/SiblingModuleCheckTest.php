<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\WooCommerce\Module;

use Aztec\WPBrowser\WooCommerce\Module\WooCommerceDb;
use Aztec\WPBrowser\WooCommerce\Module\WooCommerceWebDriver;
use Codeception\Exception\ModuleException;
use Codeception\Test\Unit;
use PHPUnit\Framework\MockObject\MockObject;

class SiblingModuleCheckTest extends Unit
{
    public function testWooCommerceDbThrowsWhenWpDbIsMissing(): void
    {
        $module = $this->moduleWithSiblings(WooCommerceDb::class, ['WPDb' => false]);

        $this->expectException(ModuleException::class);
        $this->expectExceptionMessage('WPDb');

        $module->_initialize();
    }

    public function testWooCommerceDbInitializesWhenWpDbIsPresent(): void
    {
        $module = $this->moduleWithSiblings(WooCommerceDb::class, ['WPDb' => true]);

        $this->expectNotToPerformAssertions();

        $module->_initialize();
    }

    public function testWooCommerceWebDriverThrowsWhenWpWebDriverIsMissing(): void
    {
        $module = $this->moduleWithSiblings(WooCommerceWebDriver::class, [
            'WPWebDriver' => false,
            'WPDb' => true,
        ]);

        $this->expectException(ModuleException::class);
        $this->expectExceptionMessage('WPWebDriver');

        $module->_initialize();
    }

    public function testWooCommerceWebDriverInitializesWhenWpWebDriverIsPresent(): void
    {
        $module = $this->moduleWithSiblings(WooCommerceWebDriver::class, [
            'WPWebDriver' => true,
        ]);

        $this->expectNotToPerformAssertions();

        $module->_initialize();
    }

    /**
     * @template T of \Codeception\Module
     * @param class-string<T> $class
     * @param array<string, bool> $siblings
     * @return T&MockObject
     */
    private function moduleWithSiblings(string $class, array $siblings)
    {
        /** @var T&MockObject $module */
        $module = $this->getMockBuilder($class)
            ->disableOriginalConstructor()
            ->onlyMethods(['hasModule'])
            ->getMock();

        $module->method('hasModule')->willReturnCallback(
            static fn (string $name): bool => $siblings[$name] ?? false,
        );

        return $module;
    }
}
