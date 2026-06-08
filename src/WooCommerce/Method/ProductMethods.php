<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use lucatume\WPBrowser\Module\WPDb;

trait ProductMethods
{
    abstract protected function wpDb(): WPDb;

    /**
     * @param array<string, mixed> $overrides
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

    public function haveProductCategoryRelationshipInDatabase(int $productId, int $categoryId): void
    {
        $this->wpDb()->haveTermRelationshipInDatabase($productId, $categoryId);
    }

    /**
     * @param array<string, mixed> $overrides
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

    public function haveProductMetaInDatabase(int $productId, string $key, mixed $value): int
    {
        return $this->wpDb()->havePostMetaInDatabase($productId, $key, $value);
    }

    /**
     * @param array<int, int> $categoryIds
     */
    public function haveProductInCategoriesInDatabase(int $productId, array $categoryIds): void
    {
        foreach ($categoryIds as $categoryId) {
            $this->haveProductCategoryRelationshipInDatabase($productId, $categoryId);
        }
    }

    public function grabProductMetaFromDatabase(int $productId, string $key, bool $single = false): mixed
    {
        return $this->wpDb()->grabPostMetaFromDatabase($productId, $key, $single);
    }

    /**
     * @return array<int, int>
     */
    public function grabProductCategoriesFromDatabase(int $productId): array
    {
        // Cast to int: on PHP < 8.1 PDO SQLite returns integer columns as
        // strings, on 8.1+ as native ints. Normalising to int keeps the return
        // type stable across PHP versions so strict comparisons behave the same.
        $ids = $this->wpDb()->grabColumnFromDatabase(
            $this->wpDb()->grabTermRelationshipsTableName(),
            'term_taxonomy_id',
            ['object_id' => $productId]
        );
        /** @var array<int, int> $result */
        $result = array_map(static fn (mixed $v): int => is_numeric($v) ? (int) $v : 0, $ids);
        return $result;
    }

    public function seeProductInCategoryInDatabase(int $productId, int $categoryId): void
    {
        $this->wpDb()->seeInDatabase(
            $this->wpDb()->grabTermRelationshipsTableName(),
            [
                'object_id' => $productId,
                'term_taxonomy_id' => $categoryId,
            ]
        );
    }

    /**
     * @param array<string, mixed> $criteria
     */
    public function grabProductIdFromDatabase(array $criteria): int|false
    {
        $criteria['post_type'] = 'product';
        $id = $this->wpDb()->grabFromDatabase(
            $this->wpDb()->grabPostsTableName(),
            'ID',
            $criteria
        );

        if ($id === false) {
            return false;
        }

        return is_numeric($id) ? (int)$id : false;
    }

    public function grabProductFieldFromDatabase(int $id, string $field): mixed
    {
        return $this->wpDb()->grabPostFieldFromDatabase($id, $field);
    }

    /**
     * @param array<string, mixed> $criteria
     */
    public function seeProductInDatabase(array $criteria): void
    {
        $criteria['post_type'] = 'product';
        $this->wpDb()->seePostInDatabase($criteria);
    }

    /**
     * @param array<string, mixed> $criteria
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
     * @param array<string, mixed> $criteria
     */
    public function dontSeeProductInDatabase(array $criteria): void
    {
        $criteria['post_type'] = 'product';
        $this->wpDb()->dontSeePostInDatabase($criteria);
    }

    public function grabProductsTableName(): string
    {
        return $this->wpDb()->grabPostsTableName();
    }

    /**
     * @param array<string, mixed> $criteria
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
     * @param array<string, mixed> $overrides
     * @return array<int, int>
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
     * @return array<int, int>
     */
    public function grabProductCategoryIdsFromDatabase(int $productId): array
    {
        // Cast to int for a stable return type across PHP versions (PDO SQLite
        // returns integer columns as strings on PHP < 8.1, ints on 8.1+).
        $ids = $this->wpDb()->grabColumnFromDatabase(
            $this->wpDb()->grabTermRelationshipsTableName(),
            'term_taxonomy_id',
            ['object_id' => $productId]
        );
        /** @var array<int, int> $result */
        $result = array_map(static fn (mixed $v): int => is_numeric($v) ? (int) $v : 0, $ids);
        return $result;
    }
}
