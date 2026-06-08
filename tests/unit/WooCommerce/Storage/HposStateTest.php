<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\WooCommerce\Storage;

use Aztec\WPBrowser\WooCommerce\Storage\HposState;
use Codeception\Test\Unit;
use lucatume\WPBrowser\Module\WPDb;

class HposStateTest extends Unit
{
    public function testReturnsTrueWhenOptionIsYes(): void
    {
        $this->assertTrue(HposState::isEnabled($this->wpDbReturning('yes')));
    }

    public function testReturnsFalseWhenOptionIsNo(): void
    {
        $this->assertFalse(HposState::isEnabled($this->wpDbReturning('no')));
    }

    public function testReturnsFalseWhenOptionIsMissing(): void
    {
        $this->assertFalse(HposState::isEnabled($this->wpDbReturning(false)));
    }

    public function testReadsTheCanonicalOptionName(): void
    {
        $wpDb = $this->createMock(WPDb::class);
        $wpDb->expects($this->once())
            ->method('grabOptionFromDatabase')
            ->with(HposState::OPTION_NAME)
            ->willReturn('yes');

        HposState::isEnabled($wpDb);
    }

    private function wpDbReturning(string|false $value): WPDb
    {
        $wpDb = $this->createMock(WPDb::class);
        $wpDb->method('grabOptionFromDatabase')
            ->with(HposState::OPTION_NAME)
            ->willReturn($value);

        return $wpDb;
    }
}
