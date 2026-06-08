<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\SubscriptionStorageInterface;
use lucatume\WPBrowser\Module\WPDb;

trait SubscriptionMethods
{
    abstract protected function wpDb(): WPDb;

    abstract protected function subscriptionStorage(): SubscriptionStorageInterface;

    /**
     * Create a subscription in the database.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase([
     *     'status' => 'wc-active',
     *     'customer_id' => 123,
     * ]);
     * $I->seeSubscriptionInDatabase(['id' => $subscriptionId, 'status' => 'wc-active']);
     * ```
     *
     * @param array<string, mixed> $overrides Subscription data overrides (status, customer_id, etc.)
     *
     * @return int The created subscription ID
     */
    public function haveSubscriptionInDatabase(array $overrides = []): int
    {
        return $this->subscriptionStorage()->haveSubscriptionInDatabase($overrides);
    }

    /**
     * Create a meta entry for a subscription in the database.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase();
     * $metaId = $I->haveSubscriptionMetaInDatabase($subscriptionId, '_custom_field', 'value');
     * $I->assertGreaterThan(0, $metaId);
     * ```
     *
     * @param int    $subscriptionId  Subscription ID
     * @param string $key             Meta key name
     * @param mixed  $value           Meta value
     *
     * @return int Meta ID of the created entry
     */
    public function haveSubscriptionMetaInDatabase(int $subscriptionId, string $key, mixed $value): int
    {
        return $this->subscriptionStorage()->haveSubscriptionMetaInDatabase($subscriptionId, $key, $value);
    }

    /**
     * Create a subscription product in the database with all subscription metadata.
     *
     * @example
     * ```php
     * $productId = $I->haveSubscriptionProductInDatabase([
     *     'post_title' => 'Monthly Subscription',
     *     'meta' => [
     *         '_subscription_period' => 'month',
     *         '_subscription_price' => '29.99',
     *     ],
     * ]);
     * $I->seePostInDatabase(['ID' => $productId, 'post_type' => 'product']);
     * ```
     *
     * @param array<string, mixed> $overrides Post data overrides and meta. Special key 'meta' contains product metadata (e.g., '_subscription_price', '_subscription_period')
     *
     * @return int The created product ID
     */
    public function haveSubscriptionProductInDatabase(array $overrides = []): int
    {
        $meta = is_array($overrides['meta'] ?? null) ? $overrides['meta'] : [];
        unset($overrides['meta']);

        $productData = array_merge([
            'post_type' => 'product',
            'post_status' => 'publish',
            'post_title' => 'Subscription Product',
        ], $overrides);

        $productId = $this->wpDb()->havePostInDatabase($productData);

        $termTaxonomyId = $this->grabOrCreateProductTypeTerm('subscription');
        $this->wpDb()->haveTermRelationshipInDatabase($productId, $termTaxonomyId);

        $defaultMeta = [
            '_price' => '10.00',
            '_regular_price' => '10.00',
            '_subscription_price' => '10.00',
            '_subscription_period' => 'month',
            '_subscription_period_interval' => '1',
            '_subscription_length' => '0',
            '_subscription_trial_period' => 'day',
            '_subscription_trial_length' => '0',
            '_subscription_sign_up_fee' => '0',
            '_stock_status' => 'instock',
            '_virtual' => 'yes',
        ];

        $finalMeta = array_merge($defaultMeta, $meta);
        foreach ($finalMeta as $key => $value) {
            $this->wpDb()->havePostMetaInDatabase($productId, $key, $value);
        }

        return $productId;
    }

    /**
     * Extract a subscription ID from the database by query criteria.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $found = $I->grabSubscriptionIdFromDatabase(['status' => 'wc-active']);
     * $I->assertSame($subscriptionId, $found);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['status' => 'wc-active', 'id' => 123])
     *
     * @return int|false Subscription ID if found, false otherwise
     */
    public function grabSubscriptionIdFromDatabase(array $criteria): int|false
    {
        $mappedCriteria = $this->subscriptionStorage()->mapCriteria($criteria);

        $id = $this->wpDb()->grabFromDatabase(
            $this->subscriptionStorage()->getTableName(),
            $this->subscriptionStorage()->getIdColumnName(),
            $mappedCriteria,
        );

        if ($id === false) {
            return false;
        }

        return is_numeric($id) ? (int) $id : false;
    }

    /**
     * Extract a field value from a subscription record in the database.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['post_title' => 'My Subscription']);
     * $title = $I->grabSubscriptionFieldFromDatabase($subscriptionId, 'post_title');
     * $I->assertSame('My Subscription', $title);
     * ```
     *
     * @param int    $id     Subscription ID
     * @param string $field  Database field name to retrieve (e.g., 'post_title', 'post_status')
     *
     * @return mixed Field value from the subscription record
     */
    public function grabSubscriptionFieldFromDatabase(int $id, string $field): mixed
    {
        return $this->wpDb()->grabPostFieldFromDatabase($id, $field);
    }

    /**
     * Extract a meta value from a subscription record in the database.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase();
     * $I->haveSubscriptionMetaInDatabase($subscriptionId, '_custom_field', 'test_value');
     * $value = $I->grabSubscriptionMetaFromDatabase($subscriptionId, '_custom_field', true);
     * $I->assertSame('test_value', $value);
     * ```
     *
     * @param int    $subscriptionId  Subscription ID
     * @param string $key             Meta key to retrieve
     * @param bool   $single          Whether to return a single value (true) or array of values (false)
     *
     * @return mixed Meta value or array of meta values
     */
    public function grabSubscriptionMetaFromDatabase(int $subscriptionId, string $key, bool $single = false): mixed
    {
        return $this->subscriptionStorage()->grabSubscriptionMeta($subscriptionId, $key, $single);
    }

    /**
     * Extract the current status of a subscription from the database.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $status = $I->grabSubscriptionStatus($subscriptionId);
     * $I->assertSame('wc-active', $status);
     * ```
     *
     * @param int $subscriptionId  Subscription ID
     *
     * @return string Subscription status (e.g., 'wc-active', 'wc-on-hold', 'wc-cancelled', 'wc-expired')
     */
    public function grabSubscriptionStatus(int $subscriptionId): string
    {
        return $this->subscriptionStorage()->grabSubscriptionStatus($subscriptionId);
    }

    /**
     * Change a subscription's status in the database.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $I->haveSubscriptionStatus($subscriptionId, 'wc-on-hold');
     * $I->seeSubscriptionStatus($subscriptionId, 'wc-on-hold');
     * ```
     *
     * @param int    $subscriptionId  Subscription ID to modify
     * @param string $status          New subscription status
     *
     * @return void
     */
    public function haveSubscriptionStatus(int $subscriptionId, string $status): void
    {
        $this->subscriptionStorage()->haveSubscriptionStatus($subscriptionId, $status);
    }

    /**
     * Cancel a subscription by setting its status to 'wc-cancelled'.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $I->cancelSubscription($subscriptionId);
     * $I->seeSubscriptionStatus($subscriptionId, 'wc-cancelled');
     * ```
     *
     * @param int $subscriptionId  Subscription ID to cancel
     *
     * @return void
     */
    public function cancelSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-cancelled');
    }

    /**
     * Reactivate a subscription by setting its status to 'wc-active'.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-on-hold']);
     * $I->reactivateSubscription($subscriptionId);
     * $I->seeSubscriptionStatus($subscriptionId, 'wc-active');
     * ```
     *
     * @param int $subscriptionId  Subscription ID to reactivate
     *
     * @return void
     */
    public function reactivateSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-active');
    }

    /**
     * Expire a subscription by setting its status to 'wc-expired'.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $I->expireSubscription($subscriptionId);
     * $I->seeSubscriptionStatus($subscriptionId, 'wc-expired');
     * ```
     *
     * @param int $subscriptionId  Subscription ID to expire
     *
     * @return void
     */
    public function expireSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-expired');
    }

    /**
     * Verify that a subscription exists in the database with the given criteria.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $I->seeSubscriptionInDatabase(['id' => $subscriptionId, 'status' => 'wc-active']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['id' => 123, 'status' => 'wc-active'])
     *
     * @return void
     */
    public function seeSubscriptionInDatabase(array $criteria): void
    {
        $tableName = $this->subscriptionStorage()->getTableName();
        $mappedCriteria = $this->subscriptionStorage()->mapCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    /**
     * Verify that subscription meta exists in the database with the given criteria.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase();
     * $I->haveSubscriptionMetaInDatabase($subscriptionId, '_custom_field', 'value');
     * $I->seeSubscriptionMetaInDatabase(['subscription_id' => $subscriptionId, 'meta_key' => '_custom_field']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['subscription_id' => 123, 'meta_key' => '_custom_field'])
     *
     * @return void
     */
    public function seeSubscriptionMetaInDatabase(array $criteria): void
    {
        $tableName = $this->subscriptionStorage()->getMetaTableName();
        $mappedCriteria = $this->subscriptionStorage()->mapMetaCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    /**
     * Verify that a subscription has the expected status in the database.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $I->seeSubscriptionStatus($subscriptionId, 'wc-active');
     * ```
     *
     * @param int    $subscriptionId  Subscription ID to verify
     * @param string $status          Expected subscription status
     *
     * @return void
     */
    public function seeSubscriptionStatus(int $subscriptionId, string $status): void
    {
        $this->seeSubscriptionInDatabase(['id' => $subscriptionId, 'status' => $status]);
    }

    /**
     * Verify that a subscription does not exist in the database with the given criteria.
     *
     * @example
     * ```php
     * $I->dontSeeSubscriptionInDatabase(['id' => 999]);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['status' => 'wc-deleted'])
     *
     * @return void
     */
    public function dontSeeSubscriptionInDatabase(array $criteria): void
    {
        $tableName = $this->subscriptionStorage()->getTableName();
        $mappedCriteria = $this->subscriptionStorage()->mapCriteria($criteria);
        $this->wpDb()->dontSeeInDatabase($tableName, $mappedCriteria);
    }

    /**
     * Verify that subscription meta does not exist in the database with the given criteria.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase();
     * $I->dontSeeSubscriptionMetaInDatabase(['subscription_id' => $subscriptionId, 'meta_key' => '_deleted']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['subscription_id' => 123, 'meta_key' => '_deleted'])
     *
     * @return void
     */
    public function dontSeeSubscriptionMetaInDatabase(array $criteria): void
    {
        $tableName = $this->subscriptionStorage()->getMetaTableName();
        $mappedCriteria = $this->subscriptionStorage()->mapMetaCriteria($criteria);
        $this->wpDb()->dontSeeInDatabase($tableName, $mappedCriteria);
    }

    /**
     * Suspend a subscription by setting its status to 'wc-on-hold'.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $I->suspendSubscription($subscriptionId);
     * $I->seeSubscriptionStatus($subscriptionId, 'wc-on-hold');
     * ```
     *
     * @param int $subscriptionId  Subscription ID to suspend
     *
     * @return void
     */
    public function suspendSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-on-hold');
    }

    /**
     * Mark a subscription as pending cancellation by setting its status to 'wc-pending-cancel'.
     *
     * @example
     * ```php
     * $subscriptionId = $I->haveSubscriptionInDatabase(['status' => 'wc-active']);
     * $I->pendingCancelSubscription($subscriptionId);
     * $I->seeSubscriptionStatus($subscriptionId, 'wc-pending-cancel');
     * ```
     *
     * @param int $subscriptionId  Subscription ID to mark as pending cancellation
     *
     * @return void
     */
    public function pendingCancelSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-pending-cancel');
    }

    private function grabOrCreateProductTypeTerm(string $productType): int
    {
        $termsTable = $this->wpDb()->grabPrefixedTableNameFor('terms');
        $termTaxonomyTable = $this->wpDb()->grabPrefixedTableNameFor('term_taxonomy');

        $termId = $this->wpDb()->grabFromDatabase($termsTable, 'term_id', ['slug' => $productType]);

        if ($termId !== false && is_numeric($termId)) {
            $termTaxonomyId = $this->wpDb()->grabFromDatabase(
                $termTaxonomyTable,
                'term_taxonomy_id',
                ['term_id' => (int) $termId, 'taxonomy' => 'product_type'],
            );

            if ($termTaxonomyId !== false && is_numeric($termTaxonomyId)) {
                return (int) $termTaxonomyId;
            }
        }

        $termIds = $this->wpDb()->haveTermInDatabase($productType, 'product_type', ['slug' => $productType]);

        return (int) ($termIds[1] ?? 0);
    }
}
