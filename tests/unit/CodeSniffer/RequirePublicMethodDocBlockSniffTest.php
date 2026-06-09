<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\CodeSniffer;

use Codeception\Test\Unit;

/**
 * @covers \Aztec\WPBrowser\CodeSniffer\Sniffs\RequirePublicMethodDocBlockSniff
 */
class RequirePublicMethodDocBlockSniffTest extends Unit
{
    private static bool $phpcsLoaded = false;

    protected function setUp(): void
    {
        parent::setUp();

        if (self::$phpcsLoaded) {
            return;
        }

        require_once dirname(__DIR__, 3) . '/vendor/squizlabs/php_codesniffer/autoload.php';
        // Runner normally defines this; define it here for standalone test usage.
        if (!defined('PHP_CODESNIFFER_VERBOSITY')) {
            define('PHP_CODESNIFFER_VERBOSITY', 0);
        }
        self::$phpcsLoaded = true;
    }

    public function testValidModuleWithProperDocblock(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/ValidModuleWithProperDocblock.php');
        $this->assertEmpty(
            $violations,
            sprintf(
                'Expected no violations, got: %s',
                implode(', ', array_column($violations, 'message')),
            ),
        );
    }

    public function testInvalidModuleWithoutDocblock(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/InvalidModuleWithoutDocblock.php');
        $this->assertCount(1, $violations);
        $this->assertSame(9, $violations[0]['line']);
        $this->assertStringContainsString('havePercentageCouponInDatabase', $violations[0]['message']);
        $this->assertStringContainsString('@example', $violations[0]['message']);
    }

    public function testInvalidModuleDocblockWithoutExample(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/InvalidModuleDocblockWithoutExample.php');
        $this->assertCount(1, $violations);
        // The violation is reported at the `function` keyword token, which is on line 17
        // (the docblock without @example starts at line 9 but the function is at line 17).
        $this->assertSame(17, $violations[0]['line']);
        $this->assertStringContainsString('havePercentageCouponInDatabase', $violations[0]['message']);
        $this->assertStringContainsString('@example', $violations[0]['message']);
    }

    public function testValidMethodTraitWithProperDocblock(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/ValidMethodTraitWithProperDocblock.php');
        $this->assertEmpty($violations);
    }

    public function testValidProtectedMethodWithoutDocblock(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/ValidProtectedMethodWithoutDocblock.php');
        $this->assertEmpty($violations);
    }

    public function testValidNonModuleClass(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/ValidNonModuleClass.php');
        $this->assertEmpty($violations);
    }

    /**
     * Run the RequirePublicMethodDocBlockSniff on a fixture file and return violations.
     *
     * @return array<int, array{line: int, message: string}>
     */
    private function runSniff(string $fixtureFile): array
    {
        $sniffPath = dirname(__DIR__, 3) . '/src/CodeSniffer/Sniffs/RequirePublicMethodDocBlockSniff.php';

        $config = new \PHP_CodeSniffer\Config(['--no-cache', '-q', '--report=full']);
        $config->cache = false;

        $ruleset = new \PHP_CodeSniffer\Ruleset($config);
        $ruleset->registerSniffs([$sniffPath], [], []);
        $ruleset->populateTokenListeners();

        $file = new \PHP_CodeSniffer\Files\LocalFile($fixtureFile, $ruleset, $config);
        $file->process();

        $violations = [];
        /** @var array<int, array<int, array<int, array{message: string}>>> $errors */
        $errors = $file->getErrors();
        foreach ($errors as $line => $lineErrors) {
            foreach ($lineErrors as $colErrors) {
                foreach ($colErrors as $error) {
                    $violations[] = [
                        'line'    => $line,
                        'message' => $error['message'],
                    ];
                }
            }
        }

        return $violations;
    }
}
