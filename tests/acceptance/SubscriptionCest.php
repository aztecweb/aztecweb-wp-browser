<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class SubscriptionCest
{
    public function _before(AcceptanceTester $I): void
    {
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no');
    }

    public function testHaveSubscriptionInDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        assert(is_int($subscriptionId) && $subscriptionId > 0);

        $I->seeSubscriptionInDatabase([
            'ID' => $subscriptionId,
            'post_status' => 'wc-active',
        ]);
    }

    public function testHaveSubscriptionWithCustomStatus(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-on-hold',
        ]);

        $I->seeSubscriptionInDatabase([
            'ID' => $subscriptionId,
            'post_status' => 'wc-on-hold',
        ]);
    }

    public function testHaveSubscriptionWithMeta(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'meta' => [
                '_billing_period' => 'year',
                '_billing_interval' => '1',
                '_customer_user' => '1',
            ],
        ]);

        $I->seeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_billing_period',
            'meta_value' => 'year',
        ]);

        $I->seeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_customer_user',
            'meta_value' => '1',
        ]);
    }

    public function testHaveSubscriptionMetaInDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        $metaId = $I->haveSubscriptionMetaInDatabase($subscriptionId, '_order_total', '99.00');

        assert(is_int($metaId) && $metaId > 0);

        $I->seeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_order_total',
            'meta_value' => '99.00',
        ]);
    }

    public function testGrabSubscriptionIdFromDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-active',
            'post_name' => 'test-subscription-legacy',
        ]);

        $grabbedId = $I->grabSubscriptionIdFromDatabase([
            'post_status' => 'wc-active',
            'post_name' => 'test-subscription-legacy',
        ]);

        assert($subscriptionId === $grabbedId);
    }

    public function testGrabSubscriptionIdNotFound(AcceptanceTester $I): void
    {
        $result = $I->grabSubscriptionIdFromDatabase([
            'post_name' => 'nonexistent-subscription-xyz-legacy',
        ]);

        assert($result === false);
    }

    public function testGrabSubscriptionFieldFromDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_title' => 'My Legacy Subscription',
        ]);

        $title = $I->grabSubscriptionFieldFromDatabase($subscriptionId, 'post_title');

        assert($title === 'My Legacy Subscription');
    }

    public function testGrabSubscriptionMetaFromDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'meta' => ['_billing_period' => 'week'],
        ]);

        $meta = $I->grabSubscriptionMetaFromDatabase($subscriptionId, '_billing_period');

        assert(reset($meta) === 'week');
    }

    public function testGrabSubscriptionStatus(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-on-hold',
        ]);

        $status = $I->grabSubscriptionStatus($subscriptionId);

        assert($status === 'wc-on-hold', "Expected 'wc-on-hold', got '$status'");
    }

    public function testHaveSubscriptionStatus(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-pending',
        ]);

        $I->haveSubscriptionStatus($subscriptionId, 'wc-active');

        $I->seeSubscriptionInDatabase([
            'ID' => $subscriptionId,
            'post_status' => 'wc-active',
        ]);
    }

    public function testCancelSubscription(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-active',
        ]);

        $I->cancelSubscription($subscriptionId);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-cancelled');
    }

    public function testReactivateSubscription(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-cancelled',
        ]);

        $I->reactivateSubscription($subscriptionId);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-active');
    }

    public function testExpireSubscription(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-active',
        ]);

        $I->expireSubscription($subscriptionId);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-expired');
    }

    public function testSeeSubscriptionInDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-active',
        ]);

        $I->seeSubscriptionInDatabase(['post_status' => 'wc-active']);
        $I->seeSubscriptionInDatabase(['ID' => $subscriptionId, 'post_status' => 'wc-active']);
    }

    public function testSeeSubscriptionMetaWithSubscriptionId(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        $I->haveSubscriptionMetaInDatabase($subscriptionId, '_test_meta', 'test_value');

        $I->seeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_test_meta',
            'meta_value' => 'test_value',
        ]);
    }

    public function testSeeSubscriptionMetaWithPostId(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        $I->haveSubscriptionMetaInDatabase($subscriptionId, '_another_meta', 'another_value');

        $I->seeSubscriptionMetaInDatabase([
            'post_id' => $subscriptionId,
            'meta_key' => '_another_meta',
            'meta_value' => 'another_value',
        ]);
    }

    public function testSeeSubscriptionStatus(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-active',
        ]);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-active');
    }

    public function testDontSeeSubscriptionInDatabase(AcceptanceTester $I): void
    {
        $I->dontSeeSubscriptionInDatabase([
            'post_name' => 'nonexistent-subscription-xyz-123',
        ]);
    }

    public function testHaveSubscriptionProductInDatabase(AcceptanceTester $I): void
    {
        $productId = $I->haveSubscriptionProductInDatabase();

        assert(is_int($productId) && $productId > 0);

        $I->seeProductInDatabase([
            'ID' => $productId,
            'post_status' => 'publish',
        ]);

        $I->seeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_subscription_price',
        ]);

        $I->seeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_subscription_period',
        ]);
    }

    public function testHaveSubscriptionProductWithCustomMeta(AcceptanceTester $I): void
    {
        $productId = $I->haveSubscriptionProductInDatabase([
            'post_title' => 'Premium Monthly Subscription',
            'meta' => [
                '_subscription_price' => '29.99',
                '_subscription_period' => 'month',
                '_subscription_sign_up_fee' => '5.00',
            ],
        ]);

        $I->seeProductInDatabase([
            'ID' => $productId,
            'post_title' => 'Premium Monthly Subscription',
        ]);

        $I->seeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_subscription_price',
            'meta_value' => '29.99',
        ]);

        $I->seeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_subscription_sign_up_fee',
            'meta_value' => '5.00',
        ]);
    }

    public function testSubscriptionLifecycle(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'post_status' => 'wc-pending',
        ]);

        $I->haveSubscriptionStatus($subscriptionId, 'wc-active');
        $I->seeSubscriptionStatus($subscriptionId, 'wc-active');

        $I->haveSubscriptionStatus($subscriptionId, 'wc-on-hold');
        $I->seeSubscriptionStatus($subscriptionId, 'wc-on-hold');

        $I->reactivateSubscription($subscriptionId);
        $I->seeSubscriptionStatus($subscriptionId, 'wc-active');

        $I->cancelSubscription($subscriptionId);
        $I->seeSubscriptionStatus($subscriptionId, 'wc-cancelled');
    }

    public function testSubscriptionDefaultMeta(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        $I->seeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_billing_period',
            'meta_value' => 'month',
        ]);

        $I->seeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_billing_interval',
            'meta_value' => '1',
        ]);

        $I->seeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_subscription_expiry_date',
            'meta_value' => '0',
        ]);
    }
}
