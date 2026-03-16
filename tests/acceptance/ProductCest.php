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
            'meta' => [
                '_price' => '25.00',
                '_sku' => 'TEST-SKU-001',
            ],
        ]);

        assert(is_int($productId) && $productId > 0, 'Product ID should be a positive integer');

        $I->seePostInDatabase([
            'ID' => $productId,
            'post_type' => 'product',
            'post_status' => 'publish',
            'post_title' => 'Test Product',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_price',
            'meta_value' => '25.00',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_sku',
            'meta_value' => 'TEST-SKU-001',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_stock_status',
            'meta_value' => 'instock',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $productId,
            'meta_key' => '_tax_status',
            'meta_value' => 'taxable',
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

    public function testGrabProductMeta(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();
        $I->haveProductMetaInDatabase($productId, '_custom_test_meta', '199.99');

        $value = $I->grabProductMetaFromDatabase($productId, '_custom_test_meta', true);

        assert($value === '199.99', 'Product meta value should match');
    }

    public function testGrabProductMetaMultiple(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase();
        $I->haveProductMetaInDatabase($productId, '_custom_price', '100.00');
        $I->haveProductMetaInDatabase($productId, '_custom_stock', '25');

        $price = $I->grabProductMetaFromDatabase($productId, '_custom_price', true);
        $stock = $I->grabProductMetaFromDatabase($productId, '_custom_stock', true);

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

    public function testGrabProductIdFromDatabase(AcceptanceTester $I): void
    {
        // Create a product first
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product for Grab',
        ]);

        // Test finding existing product
        $grabbedId = $I->grabProductIdFromDatabase(['post_title' => 'Test Product for Grab']);
        assert($productId === $grabbedId);

        // Test with multiple criteria
        $grabbedId = $I->grabProductIdFromDatabase([
            'post_title' => 'Test Product for Grab',
            'post_status' => 'publish',
        ]);
        assert($productId === $grabbedId);

        // Test non-existent product
        $notFound = $I->grabProductIdFromDatabase(['post_title' => 'Nonexistent Product']);
        assert($notFound === false);
    }

    public function testGrabProductFieldFromDatabase(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product Field',
            'post_status' => 'publish',
            'post_content' => 'Product description',
        ]);

        // Test grabbing title
        $title = $I->grabProductFieldFromDatabase($productId, 'post_title');
        assert($title === 'Test Product Field');

        // Test grabbing status
        $status = $I->grabProductFieldFromDatabase($productId, 'post_status');
        assert($status === 'publish');

        // Test grabbing content
        $content = $I->grabProductFieldFromDatabase($productId, 'post_content');
        assert($content === 'Product description');
    }

    public function testSeeProductInDatabase(AcceptanceTester $I): void
    {
        // Create a product
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Visible Product',
            'post_status' => 'publish',
        ]);

        // Should see the product
        $I->seeProductInDatabase(['post_title' => 'Visible Product']);
        $I->seeProductInDatabase(['post_status' => 'publish']);

        // Multiple criteria
        $I->seeProductInDatabase([
            'post_title' => 'Visible Product',
            'post_status' => 'publish',
        ]);
    }

    public function testSeeProductMetaInDatabase(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Product with Meta',
            'meta' => [
                '_price' => '19.99',
                '_sku' => 'TEST-001',
            ],
        ]);

        // Test with product_id, meta_key, and meta_value
        $I->seeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_price',
            'meta_value' => '19.99',
        ]);

        // Test with just product_id and meta_key
        $I->seeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_sku',
        ]);

        // Test with non-existent meta
        $I->dontSeeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_nonexistent',
        ]);
    }

    public function testGrabProductsTableName(AcceptanceTester $I): void
    {
        $tableName = $I->grabProductsTableName();
        assert($tableName === $I->grabPostsTableName());
    }

    public function testHaveManyProductsInDatabase(AcceptanceTester $I): void
    {
        $count = 3;
        $overrides = [
            'post_title' => 'Bulk Product',
            'post_status' => 'draft',
        ];

        $productIds = $I->haveManyProductsInDatabase($count, $overrides);

        // Should create exactly 3 products
        assert(count($productIds) === $count);

        // Verify each product was created
        foreach ($productIds as $index => $id) {
            $expectedTitle = 'Bulk Product ' . ($index + 1);
            $I->seeProductInDatabase([
                'ID' => $id,
                'post_title' => $expectedTitle,
                'post_status' => 'draft',
            ]);
        }

        // Test without overrides
        $moreIds = $I->haveManyProductsInDatabase(2);
        assert(count($moreIds) === 2);

        // Should have default titles
        $I->seePostInDatabase([
            'ID' => $moreIds[0],
            'post_type' => 'product',
        ]);
    }

    public function testGrabProductCategoryIdsFromDatabase(AcceptanceTester $I): void
    {
        // Create a category first
        $categoryId = $I->haveProductCategoryInDatabase('test-category');

        // Create a product with the category
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Product with Category',
        ]);

        // Assign the category to the product
        $I->haveProductCategoryRelationshipInDatabase($productId, $categoryId);

        // Test grabbing category IDs
        $categoryIds = $I->grabProductCategoryIdsFromDatabase($productId);
        assert(is_array($categoryIds));
        assert(in_array($categoryId, $categoryIds));
    }

    public function testDontSeeProductInDatabase(AcceptanceTester $I): void
    {
        // Create a product
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Existing Product',
        ]);

        // Should not see non-existent product
        $I->dontSeeProductInDatabase(['post_title' => 'Nonexistent Product']);

        // Should not see existing product with wrong criteria
        $I->dontSeeProductInDatabase([
            'ID' => $productId,
            'post_title' => 'Wrong Title',
        ]);

        // Should not see product with wrong status
        $I->dontSeeProductInDatabase([
            'ID' => $productId,
            'post_status' => 'draft',
        ]);
    }

    public function testDontSeeProductMetaInDatabase(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Product for Dont See Test',
        ]);

        // Add meta
        $I->haveProductMetaInDatabase($productId, '_existing_meta', 'existing_value');

        // Should not see non-existent meta
        $I->dontSeeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_nonexistent_meta',
        ]);

        // Should not see meta with wrong value
        $I->dontSeeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_existing_meta',
            'meta_value' => 'wrong_value',
        ]);
    }
}
