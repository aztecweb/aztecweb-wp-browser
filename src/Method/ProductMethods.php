<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Method;

use lucatume\WPBrowser\Module\WPDb;

trait ProductMethods
{
    abstract protected function wpDb(): WPDb;

    public function haveProductCategoryInDatabase(string $slug, array $overrides = []): int
    {
        $name = $overrides['name'] ?? $slug;

        $termData = array_merge([
            'slug' => $slug,
            'name' => $name,
        ], $overrides);

        $termIds = $this->wpDb()->haveTermInDatabase($termData['name'], 'product_cat', [
            'slug' => $termData['slug'],
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

    public function haveProductInDatabase(array $data = []): int
    {
        $meta = $data['meta'] ?? [];
        unset($data['meta']);

        $productData = array_merge([
            'post_type' => 'product',
            'post_status' => 'publish',
            'post_title' => 'Test Product',
        ], $data);

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

    public function grabProductCategoriesFromDatabase(int $productId): array
    {
        return $this->wpDb()->grabColumnFromDatabase(
            $this->wpDb()->grabTermRelationshipsTableName(),
            'term_taxonomy_id',
            ['object_id' => $productId]
        );
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

        return (int)$id;
    }

    public function grabProductFieldFromDatabase(int $id, string $field): mixed
    {
        return $this->wpDb()->grabPostFieldFromDatabase($id, $field);
    }

    public function seeProductInDatabase(array $criteria): void
    {
        $criteria['post_type'] = 'product';
        $this->wpDb()->seePostInDatabase($criteria);
    }

    public function seeProductMetaInDatabase(array $criteria): void
    {
        if (isset($criteria['product_id'])) {
            $criteria['post_id'] = $criteria['product_id'];
            unset($criteria['product_id']);
        }

        $this->wpDb()->seePostMetaInDatabase($criteria);
    }

    public function dontSeeProductInDatabase(array $criteria): void
    {
        $criteria['post_type'] = 'product';
        $this->wpDb()->dontSeePostInDatabase($criteria);
    }

    public function grabProductsTableName(): string
    {
        return $this->wpDb()->grabPostsTableName();
    }

    public function dontSeeProductMetaInDatabase(array $criteria): void
    {
        if (isset($criteria['product_id'])) {
            $criteria['post_id'] = $criteria['product_id'];
            unset($criteria['product_id']);
        }

        $this->wpDb()->dontSeePostMetaInDatabase($criteria);
    }

    public function haveManyProductsInDatabase(int $count, array $overrides = []): array
    {
        $createdIds = [];
        $baseTitle = $overrides['post_title'] ?? 'Product';

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

    public function grabProductCategoryIdsFromDatabase(int $productId): array
    {
        return $this->wpDb()->grabColumnFromDatabase(
            $this->wpDb()->grabTermRelationshipsTableName(),
            'term_taxonomy_id',
            ['object_id' => $productId]
        );
    }
}
