<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use lucatume\WPBrowser\Module\WPDb;

/**
 * @phpstan-type CouponStatus 'publish'|'draft'|'pending'|'private'|'trash'
 * @phpstan-type CouponDiscountType 'percent'|'fixed_cart'|'fixed_product'
 * @phpstan-type CouponYesNo 'yes'|'no'
 * @phpstan-type CouponMeta array{
 *     discount_type?: CouponDiscountType,
 *     coupon_amount?: string|float,
 *     free_shipping?: CouponYesNo,
 *     minimum_amount?: string,
 *     usage_limit?: string|int,
 *     usage_limit_per_user?: string|int,
 *     limit_usage_to_x_items?: string|int,
 *     product_ids?: string,
 *     exclude_product_ids?: string,
 *     product_categories?: string,
 *     exclude_product_categories?: string,
 *     individual_use?: CouponYesNo,
 *     usage_count?: string|int,
 *     ...
 * }
 * @phpstan-type CouponOverrides array{
 *     code?: string,
 *     post_type?: string,
 *     post_status?: CouponStatus,
 *     post_title?: string,
 *     post_name?: string,
 *     meta?: CouponMeta,
 *     ...
 * }
 */
trait CouponMethods
{
    abstract protected function wpDb(): WPDb;

    /**
     * Creates a coupon in the database with default meta values.
     *
     * @example
     * ```php
     * $couponId = $I->haveCouponInDatabase([
     *     'code' => 'SAVE10',
     *     'meta' => [
     *         'discount_type' => 'percent',
     *         'coupon_amount' => '10.00',
     *     ],
     * ]);
     * ```
     *
     * @param CouponOverrides $overrides Post and meta data overrides. Meta is passed under the 'meta' key.
     *
     * @return int The coupon post ID.
     */
    public function haveCouponInDatabase(array $overrides = []): int
    {
        $meta = $overrides['meta'] ?? [];
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
     * Creates a percentage discount coupon in the database.
     *
     * @example
     * ```php
     * $couponId = $I->havePercentageCouponInDatabase('PCT20', 20.0, [
     *     'description' => 'Summer 2026 promo',
     *     'usage_limit' => 100,
     * ]);
     * ```
     *
     * @param string          $code       The coupon code.
     * @param float           $percentage The discount percentage (0-100).
     * @param CouponOverrides $overrides  Post and meta data overrides.
     *
     * @return int The coupon post ID.
     */
    public function havePercentageCouponInDatabase(string $code, float $percentage, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta'] ??= [];
        $overrides['meta']['discount_type'] = 'percent';
        $overrides['meta']['coupon_amount'] = $percentage;

        return $this->haveCouponInDatabase($overrides);
    }

    /**
     * Creates a fixed cart discount coupon in the database.
     *
     * @example
     * ```php
     * $couponId = $I->haveFixedCartCouponInDatabase('FIXED5', 5.00);
     * ```
     *
     * @param string          $code      The coupon code.
     * @param float           $amount    The discount amount in shop currency.
     * @param CouponOverrides $overrides Post and meta data overrides.
     *
     * @return int The coupon post ID.
     */
    public function haveFixedCartCouponInDatabase(string $code, float $amount, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta'] ??= [];
        $overrides['meta']['discount_type'] = 'fixed_cart';
        $overrides['meta']['coupon_amount'] = $amount;

        return $this->haveCouponInDatabase($overrides);
    }

    /**
     * Creates a fixed product discount coupon in the database.
     *
     * @example
     * ```php
     * $couponId = $I->haveFixedProductCouponInDatabase('PROD10', 10.00);
     * ```
     *
     * @param string          $code      The coupon code.
     * @param float           $amount    The discount amount in shop currency.
     * @param CouponOverrides $overrides Post and meta data overrides.
     *
     * @return int The coupon post ID.
     */
    public function haveFixedProductCouponInDatabase(string $code, float $amount, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta'] ??= [];
        $overrides['meta']['discount_type'] = 'fixed_product';
        $overrides['meta']['coupon_amount'] = $amount;

        return $this->haveCouponInDatabase($overrides);
    }

    /**
     * Creates a free shipping coupon in the database.
     *
     * @example
     * ```php
     * $couponId = $I->haveFreeShippingCouponInDatabase('FREESHIPPING');
     * ```
     *
     * @param string          $code      The coupon code.
     * @param CouponOverrides $overrides Post and meta data overrides.
     *
     * @return int The coupon post ID.
     */
    public function haveFreeShippingCouponInDatabase(string $code, array $overrides = []): int
    {
        $overrides['code'] = $code;
        $overrides['meta'] ??= [];
        $overrides['meta']['discount_type'] = 'fixed_cart';
        $overrides['meta']['free_shipping'] = 'yes';

        return $this->haveCouponInDatabase($overrides);
    }

    /**
     * Asserts a coupon exists in the database.
     *
     * @example
     * ```php
     * $I->seeCouponInDatabase(['post_title' => 'SAVE10']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (post_title, post_status, etc.).
     *
     * @return void
     */
    public function seeCouponInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostsTableName();

        $this->wpDb()->seeInDatabase($table, array_merge($criteria, ['post_type' => 'shop_coupon']));
    }

    /**
     * Asserts a coupon does not exist in the database.
     *
     * @example
     * ```php
     * $I->dontSeeCouponInDatabase(['ID' => $couponId]);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (post_title, post_status, etc.).
     *
     * @return void
     */
    public function dontSeeCouponInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostsTableName();

        $this->wpDb()->dontSeeInDatabase($table, array_merge($criteria, ['post_type' => 'shop_coupon']));
    }

    /**
     * Adds meta data to a coupon.
     *
     * @example
     * ```php
     * $metaId = $I->haveCouponMetaInDatabase($couponId, 'coupon_amount', '10.00');
     * ```
     *
     * @param int   $couponId  The coupon post ID.
     * @param string $metaKey  The meta key.
     * @param mixed  $metaValue The meta value.
     *
     * @return int The created post meta ID.
     */
    public function haveCouponMetaInDatabase(int $couponId, string $metaKey, mixed $metaValue): int
    {
        return $this->wpDb()->havePostMetaInDatabase($couponId, $metaKey, $metaValue);
    }

    /**
     * Retrieves coupon meta data by key.
     *
     * @example
     * ```php
     * $discountType = $I->grabCouponMetaFromDatabase($couponId, 'discount_type', true);
     * ```
     *
     * @param int    $couponId The coupon post ID.
     * @param string $key     The meta key to retrieve.
     * @param bool   $single  Whether to return a single value or array of values.
     *
     * @return mixed The meta value(s).
     */
    public function grabCouponMetaFromDatabase(int $couponId, string $key, bool $single = false): mixed
    {
        return $this->wpDb()->grabPostMetaFromDatabase($couponId, $key, $single);
    }

    /**
     * Asserts coupon meta exists in the database.
     *
     * @example
     * ```php
     * $I->seeCouponMetaInDatabase([
     *     'coupon_id' => $couponId,
     *     'meta_key' => 'discount_type',
     *     'meta_value' => 'percent',
     * ]);
     * ```
     *
     * @param array<string, mixed> $criteria Query criteria (coupon_id, meta_key, meta_value, etc.).
     *
     * @return void
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
     * Asserts coupon meta does not exist in the database.
     *
     * @example
     * ```php
     * $I->dontSeeCouponMetaInDatabase([
     *     'coupon_id' => $couponId,
     *     'meta_key' => 'usage_limit',
     * ]);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (coupon_id, meta_key, meta_value, etc.).
     *
     * @return void
     */
    public function dontSeeCouponMetaInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabPostMetaTableName();

        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    /**
     * Retrieves a coupon's status.
     *
     * @example
     * ```php
     * $status = $I->grabCouponStatus($couponId);
     * ```
     *
     * @param int $couponId The coupon post ID.
     *
     * @return string|false The coupon status, or false if not found.
     */
    public function grabCouponStatus(int $couponId): string|false
    {
        $table = $this->wpDb()->grabPostsTableName();
        $status = $this->wpDb()->grabFromDatabase($table, 'post_status', ['ID' => $couponId]);

        return is_string($status) ? $status : false;
    }

    /**
     * Sets a coupon's status.
     *
     * @example
     * ```php
     * $I->haveCouponStatus($couponId, 'draft');
     * ```
     *
     * @param int    $couponId The coupon post ID.
     * @param string $status   The post status (publish, draft, etc.).
     *
     * @return void
     */
    public function haveCouponStatus(int $couponId, string $status): void
    {
        $table = $this->wpDb()->grabPostsTableName();
        $this->wpDb()->updateInDatabase($table, [
            'post_status' => $status,
        ], ['ID' => $couponId]);
    }

    /**
     * Asserts a coupon has a specific status.
     *
     * @example
     * ```php
     * $I->seeCouponStatus($couponId, 'publish');
     * ```
     *
     * @param int    $couponId The coupon post ID.
     * @param string $status   The expected post status.
     *
     * @return void
     */
    public function seeCouponStatus(int $couponId, string $status): void
    {
        $table = $this->wpDb()->grabPostsTableName();
        $this->wpDb()->seeInDatabase($table, [
            'ID' => $couponId,
            'post_status' => $status,
        ]);
    }

    /**
     * Retrieves a coupon ID by criteria.
     *
     * @example
     * ```php
     * $couponId = $I->grabCouponIdFromDatabase(['post_title' => 'SAVE10']);
     * ```
     *
     * @param array<string, mixed> $criteria Query criteria (post_title, post_status, etc.).
     *
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
