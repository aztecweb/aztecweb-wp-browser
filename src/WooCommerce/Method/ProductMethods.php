<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use lucatume\WPBrowser\Module\WPDb;

trait ProductMethods
{
    abstract protected function wpDb(): WPDb;

    /**
     * Creates a product category in the database.
     *
     * @example
     * ```php
     * $categoryId = $I->haveProductCategoryInDatabase('electronics', [
     *     'name' => 'Electronics',
     *     'description' => 'Electronic products',
     * ]);
     * ```
     *
     * @param string               $slug      The category slug.
     * @param array<string, mixed> $overrides Override term data (name, description, parent, count).
     *
     * @return int The created category term ID.
     */
    public function haveProductCategoryInDatabase(string $slug, array $overrides = []): int
    {
        $nameValue = $overrides['name'] ?? $slug;
        $name = is_string($nameValue) ? $nameValue : $slug;

        $termData = array_merge([
            'slug' => $slug,
            'name' => $name,
        ], $overrides);

        $termIds = $this->wpDb()->haveTermInDatabase($name, 'product_cat', [
            'slug' => $slug,
            'description' => $overrides['description'] ?? '',
            'parent' => $overrides['parent'] ?? 0,
            'count' => $overrides['count'] ?? 0,
        ]);

        return $termIds[0];
    }

    /**
     * Adds a product to a category.
     *
     * @example
     * ```php
     * $I->haveProductCategoryRelationshipInDatabase($productId, $categoryId);
     * ```
     *
     * @param int $productId  The product post ID.
     * @param int $categoryId The category term ID.
     *
     * @return void
     */
    public function haveProductCategoryRelationshipInDatabase(int $productId, int $categoryId): void
    {
        $this->wpDb()->haveTermRelationshipInDatabase($productId, $categoryId);
    }

    /**
     * Creates a product in the database with default meta values.
     *
     * @example
     * ```php
     * $productId = $I->haveProductInDatabase([
     *     'post_title' => 'Test Product',
     *     'meta' => [
     *         '_price' => '25.00',
     *         '_sku' => 'TEST-SKU-001',
     *     ],
     * ]);
     * ```
     *
     * @param array<string, mixed> $overrides Post and meta data overrides. Meta is passed under the 'meta' key.
     *
     * @return int The created product post ID.
     */
    public function haveProductInDatabase(array $overrides = []): int
    {
        $meta = is_array($overrides['meta'] ?? null) ? $overrides['meta'] : [];
        unset($overrides['meta']);

        $productData = array_merge([
            'post_type' => 'product',
            'post_status' => 'publish',
            'post_title' => 'Test Product',
        ], $overrides);

        $productId = $this->wpDb()->havePostInDatabase($productData);

        $defaultMeta = [
            '_price' => '10.00',
            '_regular_price' => '10.00',
            '_stock_status' => 'instock',
            '_tax_status' => 'taxable',
            '_tax_class' => '',
            '_manage_stock' => 'no',
            '_backorders' => 'no',
            '_sold_individually' => 'no',
            '_virtual' => 'no',
            '_downloadable' => 'no',
        ];

        $finalMeta = array_merge($defaultMeta, $meta);
        foreach ($finalMeta as $key => $value) {
            $this->haveProductMetaInDatabase($productId, $key, $value);
        }

        return $productId;
    }

    /**
     * Adds meta data to a product.
     *
     * @example
     * ```php
     * $metaId = $I->haveProductMetaInDatabase($productId, '_price', '99.99');
     * ```
     *
     * @param int   $productId The product post ID.
     * @param string $key     The meta key.
     * @param mixed  $value    The meta value.
     *
     * @return int The created post meta ID.
     */
    public function haveProductMetaInDatabase(int $productId, string $key, mixed $value): int
    {
        return $this->wpDb()->havePostMetaInDatabase($productId, $key, $value);
    }

    /**
     * Adds a product to multiple categories.
     *
     * @example
     * ```php
     * $I->haveProductInCategoriesInDatabase($productId, [$categoryId1, $categoryId2]);
     * ```
     *
     * @param int              $productId   The product post ID.
     * @param array<int, int>  $categoryIds Array of category term IDs.
     *
     * @return void
     */
    public function haveProductInCategoriesInDatabase(int $productId, array $categoryIds): void
    {
        foreach ($categoryIds as $categoryId) {
            $this->haveProductCategoryRelationshipInDatabase($productId, $categoryId);
        }
    }

    /**
     * Retrieves product meta data by key.
     *
     * @example
     * ```php
     * $price = $I->grabProductMetaFromDatabase($productId, '_price', true);
     * ```
     *
     * @param int    $productId The product post ID.
     * @param string $key      The meta key to retrieve.
     * @param bool   $single   Whether to return a single value or array of values.
     *
     * @return mixed The meta value(s).
     */
    public function grabProductMetaFromDatabase(int $productId, string $key, bool $single = false): mixed
    {
        return $this->wpDb()->grabPostMetaFromDatabase($productId, $key, $single);
    }

    /**
     * Retrieves all category IDs assigned to a product.
     *
     * @example
     * ```php
     * $categoryIds = $I->grabProductCategoriesFromDatabase($productId);
     * ```
     *
     * @param int $productId The product post ID.
     *
     * @return array<int, int> Array of category term IDs.
     */
    public function grabProductCategoriesFromDatabase(int $productId): array
    {
        // Cast to int: on PHP < 8.1 PDO SQLite returns integer columns as
        // strings, on 8.1+ as native ints. Normalising to int keeps the return
        // type stable across PHP versions so strict comparisons behave the same.
        $ids = $this->wpDb()->grabColumnFromDatabase(
            $this->wpDb()->grabTermRelationshipsTableName(),
            'term_taxonomy_id',
            ['object_id' => $productId],
        );
        /** @var array<int, int> $result */
        $result = array_map(static fn (mixed $v): int => is_numeric($v) ? (int) $v : 0, $ids);
        return $result;
    }

    /**
     * Asserts a product is in a category.
     *
     * @example
     * ```php
     * $I->seeProductInCategoryInDatabase($productId, $categoryId);
     * ```
     *
     * @param int $productId  The product post ID.
     * @param int $categoryId The category term ID.
     *
     * @return void
     */
    public function seeProductInCategoryInDatabase(int $productId, int $categoryId): void
    {
        $this->wpDb()->seeInDatabase(
            $this->wpDb()->grabTermRelationshipsTableName(),
            [
                'object_id' => $productId,
                'term_taxonomy_id' => $categoryId,
            ],
        );
    }

    /**
     * Retrieves a product ID by criteria.
     *
     * @example
     * ```php
     * $productId = $I->grabProductIdFromDatabase(['post_title' => 'Test Product']);
     * ```
     *
     * @param array<string, mixed> $criteria Query criteria (post_status, post_title, etc.).
     *
     * @return int|false The product ID, or false if not found.
     */
    public function grabProductIdFromDatabase(array $criteria): int|false
    {
        $criteria['post_type'] = 'product';
        $id = $this->wpDb()->grabFromDatabase(
            $this->wpDb()->grabPostsTableName(),
            'ID',
            $criteria,
        );

        if ($id === false) {
            return false;
        }

        return is_numeric($id) ? (int)$id : false;
    }

    /**
     * Retrieves a product post field value.
     *
     * @example
     * ```php
     * $status = $I->grabProductFieldFromDatabase($productId, 'post_status');
     * ```
     *
     * @param int    $id    The product post ID.
     * @param string $field The post field name (post_title, post_status, etc.).
     *
     * @return mixed The field value.
     */
    public function grabProductFieldFromDatabase(int $id, string $field): mixed
    {
        return $this->wpDb()->grabPostFieldFromDatabase($id, $field);
    }

    /**
     * Asserts a product exists in the database.
     *
     * @example
     * ```php
     * $I->seeProductInDatabase([
     *     'ID' => $productId,
     *     'post_status' => 'publish',
     *     'post_title' => 'Test Product',
     * ]);
     * ```
     *
     * @param array<string, mixed> $criteria Query criteria (ID, post_status, post_title, etc.).
     *
     * @return void
     */
    public function seeProductInDatabase(array $criteria): void
    {
        $criteria['post_type'] = 'product';
        $this->wpDb()->seePostInDatabase($criteria);
    }

    /**
     * Asserts product meta exists in the database.
     *
     * @example
     * ```php
     * $I->seeProductMetaInDatabase([
     *     'product_id' => $productId,
     *     'meta_key' => '_price',
     *     'meta_value' => '25.00',
     * ]);
     * ```
     *
     * @param array<string, mixed> $criteria Query criteria (product_id, meta_key, meta_value, etc.).
     *
     * @return void
     */
    public function seeProductMetaInDatabase(array $criteria): void
    {
        if (isset($criteria['product_id'])) {
            $criteria['post_id'] = $criteria['product_id'];
            unset($criteria['product_id']);
        }

        $this->wpDb()->seePostMetaInDatabase($criteria);
    }

    /**
     * Asserts a product does not exist in the database.
     *
     * @example
     * ```php
     * $I->dontSeeProductInDatabase(['ID' => $productId]);
     * ```
     *
     * @param array<string, mixed> $criteria Query criteria (ID, post_status, post_title, etc.).
     *
     * @return void
     */
    public function dontSeeProductInDatabase(array $criteria): void
    {
        $criteria['post_type'] = 'product';
        $this->wpDb()->dontSeePostInDatabase($criteria);
    }

    /**
     * Retrieves the posts table name.
     *
     * @example
     * ```php
     * $tableName = $I->grabProductsTableName();
     * ```
     *
     * @return string The posts table name.
     */
    public function grabProductsTableName(): string
    {
        return $this->wpDb()->grabPostsTableName();
    }

    /**
     * Asserts product meta does not exist in the database.
     *
     * @example
     * ```php
     * $I->dontSeeProductMetaInDatabase([
     *     'product_id' => $productId,
     *     'meta_key' => '_price',
     * ]);
     * ```
     *
     * @param array<string, mixed> $criteria Query criteria (product_id, meta_key, meta_value, etc.).
     *
     * @return void
     */
    public function dontSeeProductMetaInDatabase(array $criteria): void
    {
        if (isset($criteria['product_id'])) {
            $criteria['post_id'] = $criteria['product_id'];
            unset($criteria['product_id']);
        }

        $this->wpDb()->dontSeePostMetaInDatabase($criteria);
    }

    /**
     * Creates multiple products in the database.
     *
     * @example
     * ```php
     * $productIds = $I->haveManyProductsInDatabase(5, [
     *     'post_title' => 'Product',
     * ]);
     * ```
     *
     * @param int                  $count     The number of products to create.
     * @param array<string, mixed> $overrides Post and meta data overrides.
     *
     * @return array<int, int> Array of created product post IDs.
     */
    public function haveManyProductsInDatabase(int $count, array $overrides = []): array
    {
        $createdIds = [];
        $baseTitleValue = $overrides['post_title'] ?? 'Product';
        $baseTitle = is_string($baseTitleValue) ? $baseTitleValue : 'Product';

        for ($i = 1; $i <= $count; $i++) {
            $productData = array_merge($overrides, [
                'post_title' => $baseTitle . ' ' . $i,
                'post_name' => strtolower(str_replace(' ', '-', $baseTitle . ' ' . $i)),
            ]);

            $productId = $this->haveProductInDatabase($productData);
            $createdIds[] = $productId;
        }

        return $createdIds;
    }

    /**
     * Retrieves all category IDs assigned to a product.
     *
     * @example
     * ```php
     * $categoryIds = $I->grabProductCategoryIdsFromDatabase($productId);
     * ```
     *
     * @param int $productId The product post ID.
     *
     * @return array<int, int> Array of category term IDs.
     */
    public function grabProductCategoryIdsFromDatabase(int $productId): array
    {
        // Cast to int for a stable return type across PHP versions (PDO SQLite
        // returns integer columns as strings on PHP < 8.1, ints on 8.1+).
        $ids = $this->wpDb()->grabColumnFromDatabase(
            $this->wpDb()->grabTermRelationshipsTableName(),
            'term_taxonomy_id',
            ['object_id' => $productId],
        );
        /** @var array<int, int> $result */
        $result = array_map(static fn (mixed $v): int => is_numeric($v) ? (int) $v : 0, $ids);
        return $result;
    }
}
