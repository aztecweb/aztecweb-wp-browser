<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class CouponCest
{
    public function testHaveCouponInDatabase(AcceptanceTester $I): void
    {
        $couponId = $I->haveCouponInDatabase([
            'code' => 'SAVE10',
            'meta' => [
                'discount_type' => 'percent',
                'coupon_amount' => '10.00',
            ],
        ]);

        assert(is_int($couponId) && $couponId > 0, 'Coupon ID should be a positive integer');
        $I->seeCouponInDatabase(['post_title' => 'SAVE10']);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'discount_type',
            'meta_value' => 'percent',
        ]);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'coupon_amount',
            'meta_value' => '10.00',
        ]);
    }

    public function testHavePercentageCouponInDatabase(AcceptanceTester $I): void
    {
        $couponId = $I->havePercentageCouponInDatabase('PCT20', 20.0);

        assert(is_int($couponId) && $couponId > 0, 'Coupon ID should be a positive integer');
        $I->seeCouponInDatabase(['post_title' => 'PCT20']);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'discount_type',
            'meta_value' => 'percent',
        ]);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'coupon_amount',
            'meta_value' => 20.0,
        ]);
    }

    public function testHaveFixedCartCouponInDatabase(AcceptanceTester $I): void
    {
        $couponId = $I->haveFixedCartCouponInDatabase('FIXED5', 5.00);

        assert(is_int($couponId) && $couponId > 0, 'Coupon ID should be a positive integer');
        $I->seeCouponInDatabase(['post_title' => 'FIXED5']);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'discount_type',
            'meta_value' => 'fixed_cart',
        ]);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'coupon_amount',
            'meta_value' => 5.00,
        ]);
    }

    public function testHaveFixedProductCouponInDatabase(AcceptanceTester $I): void
    {
        $couponId = $I->haveFixedProductCouponInDatabase('PROD10', 10.00);

        assert(is_int($couponId) && $couponId > 0, 'Coupon ID should be a positive integer');
        $I->seeCouponInDatabase(['post_title' => 'PROD10']);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'discount_type',
            'meta_value' => 'fixed_product',
        ]);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'coupon_amount',
            'meta_value' => 10.00,
        ]);
    }

    public function testHaveFreeShippingCouponInDatabase(AcceptanceTester $I): void
    {
        $couponId = $I->haveFreeShippingCouponInDatabase('FREESHIP');

        assert(is_int($couponId) && $couponId > 0, 'Coupon ID should be a positive integer');
        $I->seeCouponInDatabase(['post_title' => 'FREESHIP']);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'discount_type',
            'meta_value' => 'fixed_cart',
        ]);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'free_shipping',
            'meta_value' => 'yes',
        ]);
    }

    public function testGrabCouponIdFromDatabase(AcceptanceTester $I): void
    {
        // Create a coupon first
        $couponId = $I->haveCouponInDatabase([
            'code' => 'TEST10',
            'meta' => [
                'discount_type' => 'percent',
                'coupon_amount' => '10',
            ],
        ]);

        // Test finding existing coupon by code (stored in post_name)
        $grabbedId = $I->grabCouponIdFromDatabase(['post_name' => 'TEST10']);
        assert($couponId === $grabbedId);

        // Test with post_status
        $grabbedId = $I->grabCouponIdFromDatabase([
            'post_name' => 'TEST10',
            'post_status' => 'publish',
        ]);
        assert($couponId === $grabbedId);

        // Test non-existent coupon
        $notFound = $I->grabCouponIdFromDatabase(['post_name' => 'NONEXISTENT']);
        assert($notFound === false);
    }

    public function testSeeCouponInDatabase(AcceptanceTester $I): void
    {
        // Create a coupon
        $couponId = $I->haveCouponInDatabase([
            'code' => 'VISIBLE',
            'meta' => [
                'discount_type' => 'fixed_cart',
                'coupon_amount' => '5',
            ],
        ]);

        // Should see the coupon
        $I->seeCouponInDatabase(['post_title' => 'VISIBLE']);
        $I->seeCouponInDatabase(['post_status' => 'publish']);

        // Multiple criteria
        $I->seeCouponInDatabase([
            'post_title' => 'VISIBLE',
            'post_status' => 'publish',
        ]);
    }

    public function testSeeCouponMetaInDatabase(AcceptanceTester $I): void
    {
        $couponId = $I->haveCouponInDatabase([
            'code' => 'META-COUPON',
            'meta' => [
                'discount_type' => 'percent',
                'coupon_amount' => '20',
            ],
        ]);

        // Test with post_id, meta_key, and meta_value
        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'discount_type',
            'meta_value' => 'percent',
        ]);

        // Test with just post_id and meta_key
        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'coupon_amount',
        ]);

        // Test with non-existent meta
        $I->dontSeeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'nonexistent_key',
        ]);
    }

    public function testCouponAssertions(AcceptanceTester $I): void
    {
        $I->haveCouponInDatabase([
            'code' => 'EXISTING',
        ]);

        $I->seeCouponInDatabase(['post_title' => 'EXISTING']);
        $I->dontSeeCouponInDatabase(['post_title' => 'MISSING']);
    }

    public function testCouponMetaMethods(AcceptanceTester $I): void
    {
        $couponId = $I->haveCouponInDatabase([
            'code' => 'META',
            'meta' => [
                'minimum_amount' => '50.00',
                'individual_use' => 'yes',
                'usage_limit' => '5',
            ],
        ]);

        $metaValue = $I->grabCouponMetaFromDatabase($couponId, 'minimum_amount', true);
        assert($metaValue === '50.00', 'Meta value should match expected value');

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'individual_use',
            'meta_value' => 'yes',
        ]);

        $I->dontSeeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'invalid_key',
            'meta_value' => 'invalid_value',
        ]);
    }

    public function testCouponStatusMethods(AcceptanceTester $I): void
    {
        $couponId = $I->haveCouponInDatabase([
            'code' => 'STATUS',
            'post_status' => 'draft',
        ]);

        $status = $I->grabCouponStatus($couponId);
        assert($status === 'draft', 'Coupon status should be draft');

        $I->seeCouponStatus($couponId, 'draft');

        $I->haveCouponStatus($couponId, 'publish');
        $I->seeCouponStatus($couponId, 'publish');
    }

    public function testCouponWithAllMeta(AcceptanceTester $I): void
    {
        $couponId = $I->haveCouponInDatabase([
            'code' => 'FULLMETA',
            'meta' => [
                'discount_type' => 'percent',
                'coupon_amount' => '15.00',
                'free_shipping' => 'no',
                'minimum_amount' => '100.00',
                'maximum_amount' => '500.00',
                'usage_limit' => '10',
                'usage_limit_per_user' => '2',
                'limit_usage_to_x_items' => '1',
                'product_ids' => '1,2,3',
                'exclude_product_ids' => '4,5',
                'product_categories' => '6,7',
                'exclude_product_categories' => '8,9',
                'date_expires' => '1735689600',
                'individual_use' => 'yes',
                'usage_count' => '0',
            ],
        ]);

        assert(is_int($couponId) && $couponId > 0, 'Coupon ID should be a positive integer');
        $I->seeCouponInDatabase(['post_title' => 'FULLMETA']);

        foreach ([
            'discount_type' => 'percent',
            'coupon_amount' => '15.00',
            'minimum_amount' => '100.00',
            'product_ids' => '1,2,3',
            'individual_use' => 'yes',
        ] as $key => $value) {
            $I->seeCouponMetaInDatabase([
                'post_id' => $couponId,
                'meta_key' => $key,
                'meta_value' => $value,
            ]);
        }
    }
}