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
        $productData = array_merge([
            'post_type' => 'product',
            'post_status' => 'publish',
        ], $data);

        return $this->wpDb()->havePostInDatabase($productData);
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
}
