<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\CodeSniffer;

use Codeception\Test\Unit;

/**
 * @covers \AztecWPBrowser\Sniffs\Docblock\RequirePublicMethodDocBlockSniff
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
        // Tokens.php defines phpcs token constants (T_DOC_COMMENT_CLOSE_TAG, etc.)
        // not loaded by the autoloader alone.
        require_once dirname(__DIR__, 3) . '/vendor/squizlabs/php_codesniffer/src/Util/Tokens.php';
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

    public function testInvalidModuleDocblockParamBeforeExample(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/InvalidModuleDocblockParamBeforeExample.php');
        $this->assertCount(1, $violations);
        $this->assertStringContainsString('@example', $violations[0]['message']);
        $this->assertStringContainsString('@param', $violations[0]['message']);
    }

    public function testInvalidModuleDocblockReturnBeforeExample(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/InvalidModuleDocblockReturnBeforeExample.php');
        $this->assertCount(1, $violations);
        $this->assertStringContainsString('@example', $violations[0]['message']);
        $this->assertStringContainsString('@return', $violations[0]['message']);
    }

    public function testValidModuleWithLifecycleMethod(): void
    {
        $violations = $this->runSniff(__DIR__ . '/Fixtures/ValidModuleWithLifecycleMethod.php');
        $this->assertEmpty($violations);
    }

    /**
     * Run the RequirePublicMethodDocBlockSniff on a fixture file and return violations.
     *
     * @return array<int, array{line: int, message: string}>
     */
    private function runSniff(string $fixtureFile): array
    {
        $sniffPath = dirname(__DIR__, 3)
            . '/src/CodeSniffer/AztecWPBrowser/Sniffs/Docblock/RequirePublicMethodDocBlockSniff.php';

        // Specify a standard to prevent phpcs.xml.dist from being auto-loaded,
        // which would apply its exclude-patterns to the test fixture files.
        $config = new \PHP_CodeSniffer\Config(['--no-cache', '-q', '--report=full', '--standard=PSR12']);
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
