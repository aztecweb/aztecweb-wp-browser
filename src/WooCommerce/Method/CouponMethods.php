<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use lucatume\WPBrowser\Module\WPDb;

trait CouponMethods
{
    abstract protected function wpDb(): WPDb;

    /**
     * Create a coupon in the database.
     *
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The coupon post ID.
     */
    public function haveCouponInDatabase(array $overrides = []): int
    {
        $meta = isset($overrides['meta']) && is_array($overrides['meta']) ? $overrides['meta'] : [];
        unset($overrides['meta']);

        $couponData = array_merge([
            'post_type' => 'shop_coupon',
            'post_status' => 'publish',
            'post_title' => $overrides['code'] ?? 'coupon',
            'post_name' => $overrides['code'] ?? 'coupon',
        ], $overrides);

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

    /**
     * Create a percentage discount coupon in the database.
     *
     * @param string $code The coupon code.
     * @param float $percentage The discount percentage (0-100).
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The coupon post ID.
     */
    public function havePercentageCouponInDatabase(string $code, float $percentage, array $overrides = []): int
    {
        $overrides['code'] = $code;
        if (!isset($overrides['meta']) || !is_array($overrides['meta'])) {
            $overrides['meta'] = [];
        }
        $overrides['meta']['discount_type'] = 'percent';
        $overrides['meta']['coupon_amount'] = $percentage;

        return $this->haveCouponInDatabase($overrides);
    }

    /**
     * Create a fixed cart discount coupon in the database.
     *
     * @param string $code The coupon code.
     * @param float $amount The discount amount in shop currency.
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The coupon post ID.
     */
    public function haveFixedCartCouponInDatabase(string $code, float $amount, array $overrides = []): int
    {
        $overrides['code'] = $code;
        if (!isset($overrides['meta']) || !is_array($overrides['meta'])) {
            $overrides['meta'] = [];
        }
        $overrides['meta']['discount_type'] = 'fixed_cart';
        $overrides['meta']['coupon_amount'] = $amount;

        return $this->haveCouponInDatabase($overrides);
    }

    /**
     * Create a fixed product discount coupon in the database.
     *
     * @param string $code The coupon code.
     * @param float $amount The discount amount in shop currency.
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The coupon post ID.
     */
    public function haveFixedProductCouponInDatabase(string $code, float $amount, array $overrides = []): int
    {
        $overrides['code'] = $code;
        if (!isset($overrides['meta']) || !is_array($overrides['meta'])) {
            $overrides['meta'] = [];
        }
        $overrides['meta']['discount_type'] = 'fixed_product';
        $overrides['meta']['coupon_amount'] = $amount;

        return $this->haveCouponInDatabase($overrides);
    }

    /**
     * Create a free shipping coupon in the database.
     *
     * @param string $code The coupon code.
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The coupon post ID.
     */
    public function haveFreeShippingCouponInDatabase(string $code, array $overrides = []): int
    {
        $overrides['code'] = $code;
        if (!isset($overrides['meta']) || !is_array($overrides['meta'])) {
            $overrides['meta'] = [];
        }
        $overrides['meta']['discount_type'] = 'fixed_cart';
        $overrides['meta']['free_shipping'] = 'yes';

        return $this->haveCouponInDatabase($overrides);
    }

    /**
     * Assert a coupon exists in the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     */
    public function seeCouponInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostsTableName();

        $this->wpDb()->seeInDatabase($table, array_merge($criteria, ['post_type' => 'shop_coupon']));
    }

    /**
     * Assert a coupon does not exist in the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     */
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

    /**
     * Assert coupon meta exists in the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     */
    public function seeCouponMetaInDatabase(array $criteria): void
    {
        if (isset($criteria['coupon_id'])) {
            $criteria['post_id'] = $criteria['coupon_id'];
            unset($criteria['coupon_id']);
        }

        $this->wpDb()->seePostMetaInDatabase($criteria);
    }

    /**
     * Assert coupon meta does not exist in the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     */
    public function dontSeeCouponMetaInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostMetaTableName();

        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    public function grabCouponStatus(int $couponId): string|false
    {
        $table = $this->wpDb()->grabPostsTableName();
        $status = $this->wpDb()->grabFromDatabase($table, 'post_status', ['ID' => $couponId]);

        return is_string($status) ? $status : false;
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

    /**
     * Get a coupon ID from the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     * @return int|false The coupon post ID, or false if not found.
     */
    public function grabCouponIdFromDatabase(array $criteria): int|false
    {
        $criteria['post_type'] = 'shop_coupon';
        $id = $this->wpDb()->grabFromDatabase(
            $this->wpDb()->grabPostsTableName(),
            'ID',
            $criteria,
        );

        if ($id === false || !is_numeric($id)) {
            return false;
        }

        return (int)$id;
    }
}
