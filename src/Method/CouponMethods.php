<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Method;

use lucatume\WPBrowser\Module\WPDb;

trait CouponMethods
{
    abstract protected function wpDb(): WPDb;

    private const POST_DEFAULTS = [
        'post_type' => 'shop_coupon',
        'post_status' => 'publish',
    ];

    private const META_DEFAULTS = [
        'discount_type' => 'percent',
        'coupon_amount' => '10.00',
        'free_shipping' => 'no',
        'minimum_amount' => '0',
        'maximum_amount' => '',
        'usage_limit' => '',
        'usage_limit_per_user' => '',
        'limit_usage_to_x_items' => '',
        'product_ids' => '',
        'exclude_product_ids' => '',
        'product_categories' => '',
        'exclude_product_categories' => '',
        'expiry_date' => '',
        'date_expires' => '',
        'individual_use' => 'no',
        'usage_count' => '0',
    ];

    public function haveCouponInDatabase(array $data = []): int
    {
        $meta = $data['meta'] ?? [];
        unset($data['meta']);

        // Move coupon-specific fields to meta if they're in the main data array
        $couponMetaFields = [
            'discount_type', 'coupon_amount', 'free_shipping', 'minimum_amount', 'maximum_amount',
            'usage_limit', 'usage_limit_per_user', 'limit_usage_to_x_items', 'product_ids',
            'exclude_product_ids', 'product_categories', 'exclude_product_categories',
            'expiry_date', 'date_expires', 'individual_use', 'usage_count'
        ];

        foreach ($couponMetaFields as $field) {
            if (isset($data[$field])) {
                $meta[$field] = $data[$field];
                unset($data[$field]);
            }
        }

        $couponCode = $data['code'] ?? 'TESTCOUPON';
        unset($data['code']); // Remove code field as it's handled separately

        $postData = array_merge(self::POST_DEFAULTS, $data);
        $postData['post_title'] = $couponCode;
        $postData['post_name'] = $couponCode;

        $couponId = $this->wpDb()->havePostInDatabase($postData);

        $finalMeta = array_merge(self::META_DEFAULTS, $meta);
        foreach ($finalMeta as $key => $value) {
            // Save all meta except explicitly empty strings for optional fields
            if ($value !== '' || !in_array($key, ['product_ids', 'exclude_product_ids', 'product_categories', 'exclude_product_categories'], true)) {
                $this->haveCouponMetaInDatabase($couponId, $key, $value);
            }
        }

        return $couponId;
    }

    public function havePercentageCouponInDatabase(string $code, float $percentage, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta']['discount_type'] = 'percent';
        $overrides['meta']['coupon_amount'] = number_format($percentage, 2, '.', '');

        return $this->haveCouponInDatabase($overrides);
    }

    public function haveFixedCartCouponInDatabase(string $code, float $amount, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta']['discount_type'] = 'fixed_cart';
        $overrides['meta']['coupon_amount'] = number_format($amount, 2, '.', '');

        return $this->haveCouponInDatabase($overrides);
    }

    public function haveFixedProductCouponInDatabase(string $code, float $amount, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta']['discount_type'] = 'fixed_product';
        $overrides['meta']['coupon_amount'] = number_format($amount, 2, '.', '');

        return $this->haveCouponInDatabase($overrides);
    }

    public function haveFreeShippingCouponInDatabase(string $code, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta']['discount_type'] = 'fixed_cart';
        $overrides['meta']['free_shipping'] = 'yes';

        return $this->haveCouponInDatabase($overrides);
    }

    public function grabCouponIdByCode(string $code): ?int
    {
        $table = $this->wpDb()->grabPostsTableName();
        $coupon = $this->wpDb()->grabFromDatabase($table, 'ID', ['post_title' => $code, 'post_type' => 'shop_coupon']);

        return $coupon === null ? null : (int) $coupon;
    }

    public function seeCouponInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostsTableName();

        $where = array_merge(['post_type' => 'shop_coupon'], $criteria);

        // Handle 'code' field by converting it to 'post_title'
        if (isset($where['code'])) {
            $where['post_title'] = $where['code'];
            unset($where['code']);
        }

        $this->wpDb()->seeInDatabase($table, $where);
    }

    public function dontSeeCouponInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostsTableName();

        $where = array_merge(['post_type' => 'shop_coupon'], $criteria);

        // Handle 'code' field by converting it to 'post_title'
        if (isset($where['code'])) {
            $where['post_title'] = $where['code'];
            unset($where['code']);
        }

        $this->wpDb()->dontSeeInDatabase($table, $where);
    }

    public function haveCouponMetaInDatabase(int $couponId, string $metaKey, mixed $metaValue): int
    {
        return $this->wpDb()->havePostMetaInDatabase($couponId, $metaKey, $metaValue);
    }

    public function grabCouponMetaFromDatabase(int $couponId, string $key, bool $single = false): mixed
    {
        return $this->wpDb()->grabPostMetaFromDatabase($couponId, $key, $single);
    }

    public function seeCouponMetaInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostMetaTableName();

        $this->wpDb()->seeInDatabase($table, $criteria);
    }

    public function dontSeeCouponMetaInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostMetaTableName();

        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    public function grabCouponStatus(int $couponId): string
    {
        $table = $this->wpDb()->grabPostsTableName();
        $status = $this->wpDb()->grabFromDatabase($table, 'post_status', ['ID' => $couponId]);

        return $status ?: '';
    }

    public function haveCouponStatus(int $couponId, string $status): void
    {
        $table = $this->wpDb()->grabPostsTableName();
        $this->wpDb()->updateInDatabase($table, [
            'post_status' => $status,
        ], ['ID' => $couponId]);
    }

    public function seeCouponStatus(int $couponId, string $status): void
    {
        $table = $this->wpDb()->grabPostsTableName();
        $this->wpDb()->seeInDatabase($table, [
            'ID' => $couponId,
            'post_status' => $status,
        ]);
    }
}