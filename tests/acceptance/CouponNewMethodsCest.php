<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class CouponNewMethodsCest
{
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
}