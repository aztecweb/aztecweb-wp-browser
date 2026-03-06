<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class ProductCest
{
    public function testHaveProductInDatabase(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        assert(is_int($productId) && $productId > 0, 'Product ID should be a positive integer');

        $I->seePostInDatabase([
            'ID' => $productId,
            'post_type' => 'product',
            'post_status' => 'publish',
            'post_title' => 'Test Product',
        ]);
    }

    public function testHaveProductInDatabaseWithDefaults(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();

        $I->seePostInDatabase([
            'ID' => $productId,
            'post_type' => 'product',
            'post_status' => 'publish',
        ]);
    }

    public function testHaveProductInDatabaseWithCustomStatus(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_status' => 'draft',
            'post_title' => 'Draft Product',
        ]);

        $I->seePostInDatabase([
            'ID' => $productId,
            'post_type' => 'product',
            'post_status' => 'draft',
        ]);
    }

    public function testHaveProductMetaInDatabase(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();

        $metaId = $I->haveProductMetaInDatabase($productId, '_price', '99.99');

        assert(is_int($metaId) && $metaId > 0, 'Meta ID should be a positive integer');

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_price',
            'meta_value' => '99.99',
        ]);
    }

    public function testHaveProductMetaMultiple(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();

        $I->haveProductMetaInDatabase($productId, '_price', '150.00');
        $I->haveProductMetaInDatabase($productId, '_stock', '50');
        $I->haveProductMetaInDatabase($productId, '_sku', 'SKU-123');

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_price',
            'meta_value' => '150.00',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_stock',
            'meta_value' => '50',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_sku',
            'meta_value' => 'SKU-123',
        ]);
    }

    public function testHaveProductCategoryInDatabase(AcceptanceTester $I): void
    {
        $categoryId = $I->haveProductCategoryInDatabase('electronics');

        assert(is_int($categoryId) && $categoryId > 0, 'Category ID should be a positive integer');

        $I->seeTermInDatabase([
            'term_id' => $categoryId,
            'slug' => 'electronics',
            'name' => 'electronics',
        ]);

        $I->seeTermTaxonomyInDatabase([
            'term_id' => $categoryId,
            'taxonomy' => 'product_cat',
        ]);
    }

    public function testHaveProductCategoryInDatabaseWithName(AcceptanceTester $I): void
    {
        $categoryId = $I->haveProductCategoryInDatabase('electronics', [
            'name' => 'Electronics',
            'description' => 'Electronic products',
        ]);

        $I->seeTermInDatabase([
            'term_id' => $categoryId,
            'slug' => 'electronics',
            'name' => 'Electronics',
        ]);

        $I->seeTermTaxonomyInDatabase([
            'term_id' => $categoryId,
            'taxonomy' => 'product_cat',
            'description' => 'Electronic products',
        ]);
    }

    public function testHaveProductWithCategory(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Categorized Product',
        ]);

        $categoryId = $I->haveProductCategoryInDatabase('clothing');

        $I->haveProductCategoryRelationshipInDatabase($productId, $categoryId);

        $I->seeInDatabase('wp_term_relationships', [
            'object_id' => $productId,
            'term_taxonomy_id' => $categoryId,
        ]);
    }

    public function testHaveProductWithMultipleCategories(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Multi-category Product',
        ]);

        $category1Id = $I->haveProductCategoryInDatabase('category-1');
        $category2Id = $I->haveProductCategoryInDatabase('category-2');

        $I->haveProductCategoryRelationshipInDatabase($productId, $category1Id);
        $I->haveProductCategoryRelationshipInDatabase($productId, $category2Id);

        $I->seeInDatabase('wp_term_relationships', [
            'object_id' => $productId,
            'term_taxonomy_id' => $category1Id,
        ]);

        $I->seeInDatabase('wp_term_relationships', [
            'object_id' => $productId,
            'term_taxonomy_id' => $category2Id,
        ]);
    }

    public function testProductWithMetaAndCategory(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Complete Product',
        ]);

        $I->haveProductMetaInDatabase($productId, '_price', '299.99');
        $I->haveProductMetaInDatabase($productId, '_sku', 'COMPLETE-001');

        $categoryId = $I->haveProductCategoryInDatabase('premium', [
            'name' => 'Premium Products',
        ]);

        $I->haveProductCategoryRelationshipInDatabase($productId, $categoryId);

        $I->seePostInDatabase([
            'ID' => $productId,
            'post_type' => 'product',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_price',
            'meta_value' => '299.99',
        ]);

        $I->seeInDatabase('wp_term_relationships', [
            'object_id' => $productId,
            'term_taxonomy_id' => $categoryId,
        ]);
    }

    // ==================== Phase 2 Tests ====================

    public function testGrabProductMeta(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();
        $I->haveProductMetaInDatabase($productId, '_price', '199.99');

        $value = $I->grabProductMetaFromDatabase($productId, '_price', true);

        assert($value === '199.99', 'Product meta value should match');
    }

    public function testGrabProductMetaMultiple(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();
        $I->haveProductMetaInDatabase($productId, '_price', '100.00');
        $I->haveProductMetaInDatabase($productId, '_stock', '25');

        $price = $I->grabProductMetaFromDatabase($productId, '_price', true);
        $stock = $I->grabProductMetaFromDatabase($productId, '_stock', true);

        assert($price === '100.00', 'Price meta should match');
        assert($stock === '25', 'Stock meta should match');
    }

    public function testGrabProductCategories(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();
        $category1Id = $I->haveProductCategoryInDatabase('cat-1');
        $category2Id = $I->haveProductCategoryInDatabase('cat-2');

        $I->haveProductCategoryRelationshipInDatabase($productId, $category1Id);
        $I->haveProductCategoryRelationshipInDatabase($productId, $category2Id);

        $categories = $I->grabProductCategoriesFromDatabase($productId);

        assert(count($categories) === 2, 'Product should have 2 categories');
        assert(in_array($category1Id, $categories, true), 'Category 1 should be in result');
        assert(in_array($category2Id, $categories, true), 'Category 2 should be in result');
    }

    public function testGrabProductCategoriesEmpty(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();

        $categories = $I->grabProductCategoriesFromDatabase($productId);

        assert(count($categories) === 0, 'Product without categories should return empty array');
    }

    public function testSeeProductInCategory(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();
        $categoryId = $I->haveProductCategoryInDatabase('test-cat');

        $I->haveProductCategoryRelationshipInDatabase($productId, $categoryId);

        $I->seeProductInCategoryInDatabase($productId, $categoryId);
    }

    public function testSeeProductCategoryCount(AcceptanceTester $I): void
    {
        $categoryId = $I->haveProductCategoryInDatabase('counted-cat');

        $product1Id = $I->haveProductInDatabase();
        $product2Id = $I->haveProductInDatabase();

        $I->haveProductCategoryRelationshipInDatabase($product1Id, $categoryId);
        $I->haveProductCategoryRelationshipInDatabase($product2Id, $categoryId);

        $I->seeNumRecords(2, $I->grabTermRelationshipsTableName(), [
            'term_taxonomy_id' => $categoryId,
        ]);
    }

    public function testSeeProductCategoryCountZero(AcceptanceTester $I): void
    {
        $categoryId = $I->haveProductCategoryInDatabase('empty-cat');

        $I->seeNumRecords(0, $I->grabTermRelationshipsTableName(), [
            'term_taxonomy_id' => $categoryId,
        ]);
    }

    public function testHaveProductInCategories(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();
        $category1Id = $I->haveProductCategoryInDatabase('multi-cat-1');
        $category2Id = $I->haveProductCategoryInDatabase('multi-cat-2');
        $category3Id = $I->haveProductCategoryInDatabase('multi-cat-3');

        $I->haveProductInCategoriesInDatabase($productId, [$category1Id, $category2Id, $category3Id]);

        $I->seeProductInCategoryInDatabase($productId, $category1Id);
        $I->seeProductInCategoryInDatabase($productId, $category2Id);
        $I->seeProductInCategoryInDatabase($productId, $category3Id);

        $termRelationshipsTable = $I->grabTermRelationshipsTableName();
        $I->seeNumRecords(1, $termRelationshipsTable, ['term_taxonomy_id' => $category1Id]);
        $I->seeNumRecords(1, $termRelationshipsTable, ['term_taxonomy_id' => $category2Id]);
        $I->seeNumRecords(1, $termRelationshipsTable, ['term_taxonomy_id' => $category3Id]);
    }

    public function testHaveProductInCategoriesWithGrab(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();
        $categoryIds = [
            $I->haveProductCategoryInDatabase('grab-cat-1'),
            $I->haveProductCategoryInDatabase('grab-cat-2'),
        ];

        $I->haveProductInCategoriesInDatabase($productId, $categoryIds);

        $grabbedCategories = $I->grabProductCategoriesFromDatabase($productId);

        assert(count($grabbedCategories) === 2, 'Should have 2 categories');
        foreach ($categoryIds as $catId) {
            assert(in_array($catId, $grabbedCategories, true), "Category $catId should be present");
        }
    }
}
