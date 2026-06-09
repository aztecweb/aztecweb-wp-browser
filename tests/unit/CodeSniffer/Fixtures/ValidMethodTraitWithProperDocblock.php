<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

trait ValidMethodTraitWithProperDocblock
{
    /**
     * Creates a product in the database.
     *
     * @example
     * ```php
     * $productId = $I->haveProductInDatabase(['post_title' => 'Test Product']);
     * ```
     *
     * @param array $overrides Product data overrides.
     *
     * @return int The created product ID.
     */
    public function haveProductInDatabase(array $overrides = []): int
    {
        return 123;
    }
}
