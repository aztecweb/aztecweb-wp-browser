<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\CodeSniffer;

use PHP_CodeSniffer\Tests\AbstractSniffUnitTest;

/**
 * @covers \Aztec\WPBrowser\CodeSniffer\Sniffs\RequirePublicMethodDocBlockSniff
 */
class RequirePublicMethodDocBlockSniffTest extends AbstractSniffUnitTest
{
    public function getSniffName(): string
    {
        return 'Aztec\WPBrowser\CodeSniffer\Sniffs\RequirePublicMethodDocBlockSniff';
    }

    public function testValidModuleWithProperDocblock(): void
    {
        $fixtureFile = __DIR__ . '/Fixtures/ValidModuleWithProperDocblock.php';
        $this->assertNoViolationsInFile($fixtureFile);
    }

    public function testInvalidModuleWithoutDocblock(): void
    {
        $fixtureFile = __DIR__ . '/Fixtures/InvalidModuleWithoutDocblock.php';
        $this->assertViolationsInFile($fixtureFile, [
            [
                'line' => 9,
                'column' => 5,
                'message' => 'Public method havePercentageCouponInDatabase() in Aztec\WPBrowser\WooCommerce\Module class must have a non-empty docblock with @example tag',
            ],
        ]);
    }

    public function testInvalidModuleDocblockWithoutExample(): void
    {
        $fixtureFile = __DIR__ . '/Fixtures/InvalidModuleDocblockWithoutExample.php';
        $this->assertViolationsInFile($fixtureFile, [
            [
                'line' => 9,
                'column' => 5,
                'message' => 'Public method havePercentageCouponInDatabase() in Aztec\WPBrowser\WooCommerce\Module class must have a non-empty docblock with @example tag',
            ],
        ]);
    }

    public function testValidMethodTraitWithProperDocblock(): void
    {
        $fixtureFile = __DIR__ . '/Fixtures/ValidMethodTraitWithProperDocblock.php';
        $this->assertNoViolationsInFile($fixtureFile);
    }

    public function testValidProtectedMethodWithoutDocblock(): void
    {
        $fixtureFile = __DIR__ . '/Fixtures/ValidProtectedMethodWithoutDocblock.php';
        $this->assertNoViolationsInFile($fixtureFile);
    }

    public function testValidNonModuleClass(): void
    {
        $fixtureFile = __DIR__ . '/Fixtures/ValidNonModuleClass.php';
        $this->assertNoViolationsInFile($fixtureFile);
    }

    /**
     * Helper to assert no violations in a file.
     */
    protected function assertNoViolationsInFile(string $fixtureFile): void
    {
        $violations = $this->getSniffViolations($fixtureFile);
        $this->assertEmpty($violations, sprintf(
            'Expected no violations in %s, but found %d: %s',
            basename($fixtureFile),
            count($violations),
            implode(', ', array_map(static fn($v) => $v['message'], $violations)),
        ));
    }

    /**
     * Helper to assert expected violations in a file.
     *
     * @param string $fixtureFile The fixture file path.
     * @param array<int, array> $expectedViolations Array of expected violations with 'line', 'column', 'message' keys.
     */
    protected function assertViolationsInFile(string $fixtureFile, array $expectedViolations): void
    {
        $violations = $this->getSniffViolations($fixtureFile);

        $this->assertCount(
            count($expectedViolations),
            $violations,
            sprintf(
                'Expected %d violations in %s, but found %d',
                count($expectedViolations),
                basename($fixtureFile),
                count($violations),
            ),
        );

        foreach ($expectedViolations as $index => $expected) {
            $this->assertArrayHasKey($index, $violations);
            $violation = $violations[$index];

            $this->assertSame(
                $expected['line'],
                $violation['line'],
                sprintf('Violation %d: expected line %d, got %d', $index, $expected['line'], $violation['line']),
            );
            $this->assertSame(
                $expected['column'],
                $violation['column'],
                sprintf('Violation %d: expected column %d, got %d', $index, $expected['column'], $violation['column']),
            );
            $this->assertSame(
                $expected['message'],
                $violation['message'],
                sprintf('Violation %d: expected message "%s", got "%s"', $index, $expected['message'], $violation['message']),
            );
        }
    }

    /**
     * Get violations for a fixture file.
     *
     * @return array<int, array<string, mixed>>
     */
    protected function getSniffViolations(string $fixtureFile): array
    {
        // Run the sniff on the fixture file
        $phpcsFile = $this->getSniffFile($fixtureFile);
        $violations = [];

        foreach ($phpcsFile->getErrors() as $line => $errors) {
            foreach ($errors as $column => $cols) {
                foreach ($cols as $error) {
                    $violations[] = [
                        'line' => $line,
                        'column' => $column,
                        'message' => $error['message'],
                    ];
                }
            }
        }

        return $violations;
    }

    /**
     * Get the processed file for a fixture.
     *
     * @param string $fixtureFile The fixture file path.
     *
     * @return \PHP_CodeSniffer\Files\File
     */
    protected function getSniffFile(string $fixtureFile)
    {
        return $this->getCodeSniffer()->processFile($fixtureFile);
    }

    /**
     * Get the CodeSniffer instance for testing.
     *
     * @return \PHP_CodeSniffer\Runner
     */
    protected function getCodeSniffer()
    {
        // This will be set up by the parent AbstractSniffUnitTest
        // We need to ensure the sniff is registered
        if (!isset($GLOBALS['PHP_CODESNIFFER_SNIFF_CODES'])) {
            $GLOBALS['PHP_CODESNIFFER_SNIFF_CODES'] = [];
        }

        return new \PHP_CodeSniffer\Runner();
    }
}
