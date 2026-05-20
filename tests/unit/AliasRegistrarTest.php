<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit;

use Aztec\WPBrowser\WooCommerce\Module\WooCommerceDb;
use Aztec\WPBrowser\WooCommerce\Module\WooCommerceWebDriver;
use Codeception\Test\Unit;

use function Aztec\WPBrowser\registerAliases;

class AliasRegistrarTest extends Unit
{
    public function testCleanAutoloadRegistersBothShortNames(): void
    {
        $this->assertTrue(
            class_exists('Codeception\\Module\\WooCommerceDb', false),
            'WooCommerceDb short-name alias must exist after autoload',
        );
        $this->assertTrue(
            class_exists('Codeception\\Module\\WooCommerceWebDriver', false),
            'WooCommerceWebDriver short-name alias must exist after autoload',
        );
    }

    public function testShortNameAliasResolvesToFullyQualifiedClass(): void
    {
        $this->assertTrue(
            is_a('Codeception\\Module\\WooCommerceDb', WooCommerceDb::class, true),
            'short-name alias must resolve to the FQN class',
        );
        $this->assertTrue(
            is_a('Codeception\\Module\\WooCommerceWebDriver', WooCommerceWebDriver::class, true),
            'short-name alias must resolve to the FQN class',
        );
    }

    public function testConflictingAliasIsSkippedAndEmitsWarning(): void
    {
        $alias = 'Codeception\\Module\\AztecAliasConflictProbe';

        if (! class_exists($alias, false)) {
            eval('namespace Codeception\\Module { class AztecAliasConflictProbe {} }');
        }

        $warnings = [];
        set_error_handler(static function (int $errno, string $errstr) use (&$warnings): bool {
            $warnings[] = ['errno' => $errno, 'errstr' => $errstr];
            return true;
        }, E_USER_WARNING);

        try {
            registerAliases([$alias => WooCommerceDb::class]);
        } finally {
            restore_error_handler();
        }

        $this->assertCount(1, $warnings);
        $this->assertSame(E_USER_WARNING, $warnings[0]['errno']);
        $this->assertStringContainsString($alias, $warnings[0]['errstr']);
        $this->assertStringContainsString('fully-qualified', $warnings[0]['errstr']);

        $this->assertFalse(
            is_a($alias, WooCommerceDb::class, true),
            'A pre-existing alias must not be re-pointed at our FQN',
        );
    }

    public function testRegisterAliasesIsIdempotentForCleanRegistrations(): void
    {
        $alias = 'Codeception\\Module\\AztecAliasIdempotentProbe';

        registerAliases([$alias => WooCommerceDb::class]);

        $warnings = [];
        set_error_handler(static function (int $errno, string $errstr) use (&$warnings): bool {
            $warnings[] = ['errno' => $errno, 'errstr' => $errstr];
            return true;
        }, E_USER_WARNING);

        try {
            registerAliases([$alias => WooCommerceDb::class]);
        } finally {
            restore_error_handler();
        }

        $this->assertCount(
            1,
            $warnings,
            'A second registration of the same alias should be skipped with a single warning',
        );
        $this->assertTrue(is_a($alias, WooCommerceDb::class, true));
    }
}
