<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\CodeSniffer\Sniffs;

use PHP_CodeSniffer\Files\File;
use PHP_CodeSniffer\Sniffs\Sniff;

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
        $tokens = $phpcsFile->getTokens();
        $token = $tokens[$stackPtr];

        // Get the fully qualified namespace and class/trait name
        $namespace = $this->getNamespace($phpcsFile, $stackPtr);
        $classOrTraitName = $phpcsFile->getDeclarationName($stackPtr);

        if (!$classOrTraitName) {
            return;
        }

        // Check if this class/trait should be enforced
        if (!$this->shouldEnforce($namespace)) {
            return;
        }

        // Find all methods in this class/trait
        $classOpenBrace = $phpcsFile->findNext(T_OPEN_CURLY_BRACKET, $stackPtr);
        $classCloseBrace = $tokens[$classOpenBrace]['bracket_closer'];

        // Search for all function declarations within this class/trait
        for ($i = $classOpenBrace; $i < $classCloseBrace; $i++) {
            if ($tokens[$i]['code'] !== T_FUNCTION) {
                continue;
            }

            // Check if this is a public method
            $visibility = $this->getMethodVisibility($phpcsFile, $i);
            if ($visibility !== 'public') {
                continue;
            }

            // Get the method name
            $methodName = $phpcsFile->getDeclarationName($i);
            if (!$methodName) {
                continue;
            }

            // Check if the method has a docblock with @example
            $docComment = $this->getDocComment($phpcsFile, $i);
            if ($docComment && $this->hasExampleTag($docComment)) {
                continue;
            }

            $line = $tokens[$i]['line'];
            $column = $tokens[$i]['column'];

            $phpcsFile->addError(
                sprintf(
                    'Public method %s() in %s class must have a non-empty docblock with @example tag',
                    $methodName,
                    $namespace,
                ),
                $i,
                'MissingDocBlock',
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
        $tokens = $phpcsFile->getTokens();
        $namespace = '';

        // Search backward for a namespace declaration
        for ($i = $stackPtr - 1; $i >= 0; $i--) {
            if ($tokens[$i]['code'] === T_NAMESPACE) {
                // Get the namespace content
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
        // Check if namespace matches Aztec\WPBrowser\*\Module\ or Aztec\WPBrowser\*\Method\
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
        $tokens = $phpcsFile->getTokens();

        // Search backward for visibility modifier
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
                // We've hit the start of the class/trait, stop looking
                return 'public'; // Default to public if no visibility found (PHP default)
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
        $tokens = $phpcsFile->getTokens();

        // phpcs tokenizes doc comments into individual tokens, not a single T_DOC_COMMENT.
        // Search backward for T_DOC_COMMENT_CLOSE_TAG, skipping modifiers and whitespace.
        for ($i = $stackPtr - 1; $i >= 0; $i--) {
            if ($tokens[$i]['code'] === T_DOC_COMMENT_CLOSE_TAG) {
                // Reconstruct the full docblock content from open to close tag.
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
                // We've hit something that's not a whitespace or modifier
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
}
