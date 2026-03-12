<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Method;

use lucatume\WPBrowser\Module\WPDb;

trait CouponMethods
{
    abstract protected function wpDb(): WPDb;

    public function haveCouponInDatabase(array $data = []): int
    {
        $meta = $data['meta'] ?? [];
        unset($data['meta']);

        $couponData = array_merge([
            'post_type' => 'shop_coupon',
            'post_status' => 'publish',
            'post_title' => $data['code'] ?? 'coupon',
            'post_name' => $data['code'] ?? 'coupon',
        ], $data);

        unset($couponData['code']);

        $couponId = $this->wpDb()->havePostInDatabase($couponData);

        $defaultMeta = [
            'discount_type' => 'percent',
            'coupon_amount' => '10.00',
            'free_shipping' => 'no',
            'minimum_amount' => '0',
            'usage_limit' => '',
            'usage_limit_per_user' => '',
            'limit_usage_to_x_items' => '',
            'product_ids' => '',
            'exclude_product_ids' => '',
            'product_categories' => '',
            'exclude_product_categories' => '',
            'individual_use' => 'no',
            'usage_count' => '0',
        ];

        $finalMeta = array_merge($defaultMeta, $meta);
        foreach ($finalMeta as $key => $value) {
            $this->haveCouponMetaInDatabase($couponId, $key, $value);
        }

        return $couponId;
    }

    public function havePercentageCouponInDatabase(string $code, float $percentage, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta']['discount_type'] = 'percent';
        $overrides['meta']['coupon_amount'] = $percentage;

        return $this->haveCouponInDatabase($overrides);
    }

    public function haveFixedCartCouponInDatabase(string $code, float $amount, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta']['discount_type'] = 'fixed_cart';
        $overrides['meta']['coupon_amount'] = $amount;

        return $this->haveCouponInDatabase($overrides);
    }

    public function haveFixedProductCouponInDatabase(string $code, float $amount, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta']['discount_type'] = 'fixed_product';
        $overrides['meta']['coupon_amount'] = $amount;

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

        return $coupon === false ? null : (int) $coupon;
    }

    public function seeCouponInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostsTableName();

        $this->wpDb()->seeInDatabase($table, array_merge($criteria, ['post_type' => 'shop_coupon']));
    }

    public function dontSeeCouponInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostsTableName();

        $this->wpDb()->dontSeeInDatabase($table, array_merge($criteria, ['post_type' => 'shop_coupon']));
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