<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\SubscriptionStorageInterface;
use lucatume\WPBrowser\Module\WPDb;

trait SubscriptionMethods
{
    abstract protected function wpDb(): WPDb;

    abstract protected function subscriptionStorage(): SubscriptionStorageInterface;

    public function haveSubscriptionInDatabase(array $overrides = []): int
    {
        return $this->subscriptionStorage()->haveSubscriptionInDatabase($overrides);
    }

    public function haveSubscriptionMetaInDatabase(int $subscriptionId, string $key, mixed $value): int
    {
        return $this->subscriptionStorage()->haveSubscriptionMetaInDatabase($subscriptionId, $key, $value);
    }

    public function haveSubscriptionProductInDatabase(array $overrides = []): int
    {
        $meta = $overrides['meta'] ?? [];
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

    public function grabSubscriptionIdFromDatabase(array $criteria): int|false
    {
        $mappedCriteria = $this->subscriptionStorage()->mapCriteria($criteria);

        $id = $this->wpDb()->grabFromDatabase(
            $this->subscriptionStorage()->getTableName(),
            $this->subscriptionStorage()->getIdColumnName(),
            $mappedCriteria
        );

        if ($id === false) {
            return false;
        }

        return (int) $id;
    }

    public function grabSubscriptionFieldFromDatabase(int $id, string $field): mixed
    {
        return $this->wpDb()->grabPostFieldFromDatabase($id, $field);
    }

    public function grabSubscriptionMetaFromDatabase(int $subscriptionId, string $key, bool $single = false): mixed
    {
        return $this->subscriptionStorage()->grabSubscriptionMeta($subscriptionId, $key, $single);
    }

    public function grabSubscriptionStatus(int $subscriptionId): string
    {
        return $this->subscriptionStorage()->grabSubscriptionStatus($subscriptionId);
    }

    public function haveSubscriptionStatus(int $subscriptionId, string $status): void
    {
        $this->subscriptionStorage()->haveSubscriptionStatus($subscriptionId, $status);
    }

    public function cancelSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-cancelled');
    }

    public function reactivateSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-active');
    }

    public function expireSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-expired');
    }

    public function seeSubscriptionInDatabase(array $criteria): void
    {
        $tableName = $this->subscriptionStorage()->getTableName();
        $mappedCriteria = $this->subscriptionStorage()->mapCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    public function seeSubscriptionMetaInDatabase(array $criteria): void
    {
        $tableName = $this->subscriptionStorage()->getMetaTableName();
        $mappedCriteria = $this->subscriptionStorage()->mapMetaCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    public function seeSubscriptionStatus(int $subscriptionId, string $status): void
    {
        $this->seeSubscriptionInDatabase(['id' => $subscriptionId, 'status' => $status]);
    }

    public function dontSeeSubscriptionInDatabase(array $criteria): void
    {
        $tableName = $this->subscriptionStorage()->getTableName();
        $mappedCriteria = $this->subscriptionStorage()->mapCriteria($criteria);
        $this->wpDb()->dontSeeInDatabase($tableName, $mappedCriteria);
    }

    public function dontSeeSubscriptionMetaInDatabase(array $criteria): void
    {
        $tableName = $this->subscriptionStorage()->getMetaTableName();
        $mappedCriteria = $this->subscriptionStorage()->mapMetaCriteria($criteria);
        $this->wpDb()->dontSeeInDatabase($tableName, $mappedCriteria);
    }

    public function suspendSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-on-hold');
    }

    public function pendingCancelSubscription(int $subscriptionId): void
    {
        $this->haveSubscriptionStatus($subscriptionId, 'wc-pending-cancel');
    }

    private function grabOrCreateProductTypeTerm(string $productType): int
    {
        $termsTable = $this->wpDb()->grabPrefixedTableNameFor('terms');
        $termTaxonomyTable = $this->wpDb()->grabPrefixedTableNameFor('term_taxonomy');

        $termId = $this->wpDb()->grabFromDatabase($termsTable, 'term_id', ['slug' => $productType]);

        if ($termId !== false) {
            $termTaxonomyId = $this->wpDb()->grabFromDatabase(
                $termTaxonomyTable,
                'term_taxonomy_id',
                ['term_id' => (int) $termId, 'taxonomy' => 'product_type']
            );

            if ($termTaxonomyId !== false) {
                return (int) $termTaxonomyId;
            }
        }

        $termIds = $this->wpDb()->haveTermInDatabase($productType, 'product_type', ['slug' => $productType]);

        return $termIds[1];
    }
}
