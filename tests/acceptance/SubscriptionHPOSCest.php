<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class SubscriptionHPOSCest
{
    public function _before(AcceptanceTester $I): void
    {
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'yes');
    }

    public function testHaveSubscriptionInDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        assert(is_int($subscriptionId) && $subscriptionId > 0);

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $subscriptionId,
            'type' => 'shop_subscription',
            'status' => 'wc-active',
        ]);
    }

    public function testHaveSubscriptionWithCustomStatus(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-on-hold',
        ]);

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $subscriptionId,
            'type' => 'shop_subscription',
            'status' => 'wc-on-hold',
        ]);
    }

    public function testHaveSubscriptionWithCustomer(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'customer_id' => 1,
            'billing_email' => 'customer@example.com',
            'status' => 'wc-active',
        ]);

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $subscriptionId,
            'customer_id' => 1,
            'billing_email' => 'customer@example.com',
            'status' => 'wc-active',
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
        $uniqueCustomerId = 8888;

        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-active',
            'customer_id' => $uniqueCustomerId,
        ]);

        $grabbedId = $I->grabSubscriptionIdFromDatabase([
            'status' => 'wc-active',
            'customer_id' => $uniqueCustomerId,
        ]);

        assert($subscriptionId === $grabbedId);
    }

    public function testGrabSubscriptionIdNotFound(AcceptanceTester $I): void
    {
        $result = $I->grabSubscriptionIdFromDatabase([
            'customer_id' => 99999,
        ]);

        assert($result === false);
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
            'status' => 'wc-on-hold',
        ]);

        $status = $I->grabSubscriptionStatus($subscriptionId);

        assert($status === 'wc-on-hold', "Expected 'wc-on-hold', got '$status'");
    }

    public function testHaveSubscriptionStatus(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-pending',
        ]);

        $I->haveSubscriptionStatus($subscriptionId, 'wc-active');

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $subscriptionId,
            'status' => 'wc-active',
        ]);
    }

    public function testCancelSubscription(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-active',
        ]);

        $I->cancelSubscription($subscriptionId);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-cancelled');
    }

    public function testReactivateSubscription(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-cancelled',
        ]);

        $I->reactivateSubscription($subscriptionId);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-active');
    }

    public function testExpireSubscription(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-active',
        ]);

        $I->expireSubscription($subscriptionId);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-expired');
    }

    public function testSeeSubscriptionInDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-active',
        ]);

        $I->seeSubscriptionInDatabase(['status' => 'wc-active']);
        $I->seeSubscriptionInDatabase(['id' => $subscriptionId, 'status' => 'wc-active']);
    }

    public function testSeeSubscriptionMetaWithSubscriptionId(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        $I->haveSubscriptionMetaInDatabase($subscriptionId, '_hpos_test_meta', 'hpos_value');

        $I->seeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_hpos_test_meta',
            'meta_value' => 'hpos_value',
        ]);
    }

    public function testSeeSubscriptionMetaWithPostId(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        $I->haveSubscriptionMetaInDatabase($subscriptionId, '_hpos_meta2', 'value2');

        $I->seeSubscriptionMetaInDatabase([
            'post_id' => $subscriptionId,
            'meta_key' => '_hpos_meta2',
            'meta_value' => 'value2',
        ]);
    }

    public function testSeeSubscriptionStatus(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-active',
        ]);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-active');
    }

    public function testDontSeeSubscriptionInDatabase(AcceptanceTester $I): void
    {
        $I->dontSeeSubscriptionInDatabase([
            'customer_id' => 999999,
        ]);
    }

    public function testDontSeeSubscriptionMetaInDatabase(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase();

        $I->dontSeeSubscriptionMetaInDatabase([
            'subscription_id' => $subscriptionId,
            'meta_key' => '_nonexistent_meta_key',
        ]);
    }

    public function testSuspendSubscription(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-active',
        ]);

        $I->suspendSubscription($subscriptionId);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-on-hold');
    }

    public function testPendingCancelSubscription(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-active',
        ]);

        $I->pendingCancelSubscription($subscriptionId);

        $I->seeSubscriptionStatus($subscriptionId, 'wc-pending-cancel');
    }

    public function testSubscriptionLifecycle(AcceptanceTester $I): void
    {
        $subscriptionId = $I->haveSubscriptionInDatabase([
            'status' => 'wc-pending',
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
    }

    public function testHaveSubscriptionProductInDatabase(AcceptanceTester $I): void
    {
        $productId = $I->haveSubscriptionProductInDatabase([
            'meta' => [
                '_subscription_price' => '49.99',
                '_subscription_period' => 'year',
            ],
        ]);

        assert(is_int($productId) && $productId > 0);

        $I->seeProductInDatabase([
            'ID' => $productId,
        ]);

        $I->seeProductMetaInDatabase([
            'product_id' => $productId,
            'meta_key' => '_subscription_price',
            'meta_value' => '49.99',
        ]);
    }
}
