<?php

declare(strict_types=1);

namespace AztecWPBrowser\Sniffs\Docblock;

use PHP_CodeSniffer\Files\File;
use PHP_CodeSniffer\Sniffs\Sniff;

/**
 * phpcs returns weakly-typed token stacks (File::getTokens() is annotated only
 * as `array`). Describe the token keys this sniff reads so PHPStan can analyse
 * it at the strictest level without per-access casts.
 *
 * @phpstan-type PhpcsToken array{code: int|string, content: string, bracket_closer: int, comment_opener: int}
 */
class RequirePublicMethodDocBlockSniff implements Sniff
{
    /**
     * Returns the token types that this sniff is interested in.
     *
     * @return array<int, int|string>
     */
    public function register(): array
    {
        return [T_CLASS, T_TRAIT];
    }

    /**
     * Processes the tokens that this sniff is interested in.
     *
     * @param \PHP_CodeSniffer\Files\File $phpcsFile The file being scanned.
     * @param int                         $stackPtr  The position of the current token in the stack.
     *
     * @return void
     */
    public function process(File $phpcsFile, $stackPtr): void
    {
        /** @var array<int, PhpcsToken> $tokens */
        $tokens = $phpcsFile->getTokens();

        $namespace = $this->getNamespace($phpcsFile, $stackPtr);
        $classOrTraitName = $phpcsFile->getDeclarationName($stackPtr);

        if (!$classOrTraitName) {
            return;
        }

        if (!$this->shouldEnforce($namespace)) {
            return;
        }

        $classOpenBrace = $phpcsFile->findNext(T_OPEN_CURLY_BRACKET, $stackPtr);
        if ($classOpenBrace === false) {
            return;
        }
        $classCloseBrace = $tokens[$classOpenBrace]['bracket_closer'];

        for ($i = $classOpenBrace; $i < $classCloseBrace; $i++) {
            if ($tokens[$i]['code'] !== T_FUNCTION) {
                continue;
            }

            $visibility = $this->getMethodVisibility($phpcsFile, $i);
            if ($visibility !== 'public') {
                continue;
            }

            $methodName = $phpcsFile->getDeclarationName($i);
            if (!$methodName) {
                continue;
            }

            // Skip Codeception lifecycle hooks (_initialize, _before, _after, etc.)
            if (str_starts_with($methodName, '_')) {
                continue;
            }

            $docComment = $this->getDocComment($phpcsFile, $i);
            if (!$docComment || !$this->hasExampleTag($docComment)) {
                $phpcsFile->addError(
                    sprintf(
                        'Public method %s() in %s class must have a non-empty docblock with @example tag',
                        $methodName,
                        $namespace,
                    ),
                    $i,
                    'MissingDocBlock',
                );
                continue;
            }

            if ($this->hasCorrectAnnotationOrder($docComment)) {
                continue;
            }

            $phpcsFile->addError(
                sprintf(
                    'Public method %s() docblock must order annotations as: @example, @param, @return, @throws',
                    $methodName,
                ),
                $i,
                'WrongAnnotationOrder',
            );
        }
    }

    /**
     * Get the fully qualified namespace.
     *
     * @param \PHP_CodeSniffer\Files\File $phpcsFile The file being scanned.
     * @param int                         $stackPtr  The position of the token.
     *
     * @return string The fully qualified namespace.
     */
    private function getNamespace(File $phpcsFile, int $stackPtr): string
    {
        /** @var array<int, PhpcsToken> $tokens */
        $tokens = $phpcsFile->getTokens();
        $namespace = '';

        for ($i = $stackPtr - 1; $i >= 0; $i--) {
            if ($tokens[$i]['code'] === T_NAMESPACE) {
                $i++;
                while ($i < $stackPtr) {
                    if ($tokens[$i]['code'] === T_NS_SEPARATOR || $tokens[$i]['code'] === T_STRING) {
                        $namespace .= $tokens[$i]['content'];
                    } elseif ($tokens[$i]['code'] === T_SEMICOLON) {
                        break;
                    }
                    $i++;
                }
                break;
            }
        }

        return $namespace;
    }

    /**
     * Check if the namespace should be enforced.
     *
     * @param string $namespace The fully qualified namespace.
     *
     * @return bool
     */
    private function shouldEnforce(string $namespace): bool
    {
        return (
            (strpos($namespace, 'Aztec\\WPBrowser\\') === 0 && strpos($namespace, '\\Module\\') !== false) ||
            (strpos($namespace, 'Aztec\\WPBrowser\\') === 0 && strpos($namespace, '\\Method\\') !== false) ||
            (strpos($namespace, 'Aztec\\WPBrowser\\') === 0 && str_ends_with($namespace, '\\Module')) ||
            (strpos($namespace, 'Aztec\\WPBrowser\\') === 0 && str_ends_with($namespace, '\\Method'))
        );
    }

    /**
     * Get the visibility of a method (public, protected, private).
     *
     * @param \PHP_CodeSniffer\Files\File $phpcsFile The file being scanned.
     * @param int                         $stackPtr  The position of the function token.
     *
     * @return string 'public', 'protected', or 'private'.
     */
    private function getMethodVisibility(File $phpcsFile, int $stackPtr): string
    {
        /** @var array<int, PhpcsToken> $tokens */
        $tokens = $phpcsFile->getTokens();

        for ($i = $stackPtr - 1; $i >= 0; $i--) {
            if ($tokens[$i]['code'] === T_PUBLIC) {
                return 'public';
            }

            if ($tokens[$i]['code'] === T_PROTECTED) {
                return 'protected';
            }

            if ($tokens[$i]['code'] === T_PRIVATE) {
                return 'private';
            }

            if ($tokens[$i]['code'] === T_OPEN_CURLY_BRACKET) {
                return 'public';
            }
        }

        return 'public';
    }

    /**
     * Get the docblock comment for a method.
     *
     * @param \PHP_CodeSniffer\Files\File $phpcsFile The file being scanned.
     * @param int                         $stackPtr  The position of the function token.
     *
     * @return string|null The docblock content, or null if not found.
     */
    private function getDocComment(File $phpcsFile, int $stackPtr): ?string
    {
        /** @var array<int, PhpcsToken> $tokens */
        $tokens = $phpcsFile->getTokens();

        // phpcs tokenizes doc comments into individual tokens, not a single T_DOC_COMMENT.
        // Search backward for T_DOC_COMMENT_CLOSE_TAG, skipping modifiers and whitespace.
        for ($i = $stackPtr - 1; $i >= 0; $i--) {
            if ($tokens[$i]['code'] === T_DOC_COMMENT_CLOSE_TAG) {
                $openPtr = $tokens[$i]['comment_opener'];
                $content = '';
                for ($j = $openPtr; $j <= $i; $j++) {
                    $content .= $tokens[$j]['content'];
                }
                return $content;
            }

            if (
                $tokens[$i]['code'] !== T_WHITESPACE &&
                $tokens[$i]['code'] !== T_PUBLIC &&
                $tokens[$i]['code'] !== T_PROTECTED &&
                $tokens[$i]['code'] !== T_PRIVATE &&
                $tokens[$i]['code'] !== T_STATIC &&
                $tokens[$i]['code'] !== T_ABSTRACT
            ) {
                return null;
            }
        }

        return null;
    }

    /**
     * Check if a docblock contains an @example tag.
     *
     * @param string $docBlock The docblock content.
     *
     * @return bool
     */
    private function hasExampleTag(string $docBlock): bool
    {
        return (bool)preg_match('/@example\s/i', $docBlock);
    }

    /**
     * Check that annotations appear in the required order: @example, @param, @return, @throws.
     *
     * @param string $docBlock The docblock content.
     *
     * @return bool
     */
    private function hasCorrectAnnotationOrder(string $docBlock): bool
    {
        $order = ['@example', '@param', '@return', '@throws'];
        $positions = [];

        foreach ($order as $tag) {
            $pos = strpos($docBlock, $tag);
            if ($pos === false) {
                continue;
            }

            $positions[$tag] = $pos;
        }

        $found = array_values($positions);

        for ($i = 0; $i < count($found) - 1; $i++) {
            if ($found[$i] > $found[$i + 1]) {
                return false;
            }
        }

        return true;
    }
}
