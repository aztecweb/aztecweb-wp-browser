<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class ProductNewMethodsCest
{
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
}