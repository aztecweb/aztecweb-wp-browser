<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class OrderCest
{
    public function testHaveOrderInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-pending',
        ]);

        assert(is_int($orderId) && $orderId > 0, 'Order ID should be a positive integer');

        $I->seePostInDatabase([
            'ID' => $orderId,
            'post_type' => 'shop_order',
            'post_status' => 'wc-pending',
        ]);
    }

    public function testHaveOrderWithCustomer(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-processing',
        ]);

        $I->haveOrderMetaInDatabase($orderId, '_customer_user', '1');
        $I->haveOrderMetaInDatabase($orderId, '_billing_email', 'customer@example.com');

        $I->seePostInDatabase([
            'ID' => $orderId,
            'post_type' => 'shop_order',
            'post_status' => 'wc-processing',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $orderId,
            'meta_key' => '_customer_user',
            'meta_value' => '1',
        ]);
    }

    public function testGrabOrderStatus(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-on-hold',
        ]);

        $status = $I->grabOrderStatus($orderId);

        assert($status === 'wc-on-hold', "Order status should be 'wc-on-hold', got '$status'");
    }

    public function testHaveOrderStatus(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-pending',
        ]);

        $I->haveOrderStatus($orderId, 'wc-completed');

        $I->seePostInDatabase([
            'ID' => $orderId,
            'post_status' => 'wc-completed',
        ]);
    }

    public function testSeeOrderStatus(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-completed',
        ]);

        $I->seeOrderStatus($orderId, 'wc-completed');
    }

    public function testHaveOrderMeta(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $I->haveOrderMetaInDatabase($orderId, '_order_total', '99.99');
        $I->haveOrderMetaInDatabase($orderId, '_payment_method', 'bacs');

        $orderTotal = $I->grabOrderMeta($orderId, '_order_total');
        assert(reset($orderTotal) === '99.99', 'Order total meta should be 99.99');

        $paymentMethod = $I->grabOrderMeta($orderId, '_payment_method');
        assert(reset($paymentMethod) === 'bacs', 'Payment method meta should be bacs');
    }

    public function testOrderWithPaymentDetails(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-processing',
        ]);

        $I->haveOrderMetaInDatabase($orderId, '_payment_method', 'stripe');
        $I->haveOrderMetaInDatabase($orderId, '_payment_method_title', 'Credit Card');
        $I->haveOrderMetaInDatabase($orderId, '_transaction_id', 'txn_123456');

        $I->seePostMetaInDatabase([
            'post_id' => $orderId,
            'meta_key' => '_payment_method',
            'meta_value' => 'stripe',
        ]);
    }

    public function testAmOnAdminOrderPage(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-processing',
        ]);

        $I->loginAsAdmin();
        $I->amOnAdminOrderPage($orderId);

        $I->seeInCurrentUrl('post.php?post=' . $orderId . '&action=edit');
    }

    public function testHaveOrderAddressInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $metaId = $I->haveOrderAddressInDatabase($orderId, 'billing', [
            'first_name' => 'John',
            'last_name' => 'Doe',
            'email' => 'john.doe@example.com',
            'phone' => '555-1234',
            'address_1' => '123 Main St',
            'city' => 'New York',
            'postcode' => '10001',
            'country' => 'US',
        ]);

        assert(is_int($metaId) && $metaId > 0, 'Meta ID should be a positive integer');

        $I->seePostMetaInDatabase([
            'post_id' => $orderId,
            'meta_key' => '_billing_first_name',
            'meta_value' => 'John',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $orderId,
            'meta_key' => '_billing_last_name',
            'meta_value' => 'Doe',
        ]);

        $I->seePostMetaInDatabase([
            'post_id' => $orderId,
            'meta_key' => '_billing_email',
            'meta_value' => 'john.doe@example.com',
        ]);
    }

    public function testHaveOrderItemInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $orderItemId = $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Test Product',
            'order_item_type' => 'line_item',
        ]);

        assert(is_int($orderItemId) && $orderItemId > 0, 'Order item ID should be a positive integer');

        $I->seeInDatabase('wp_woocommerce_order_items', [
            'order_item_id' => $orderItemId,
            'order_id' => $orderId,
            'order_item_name' => 'Test Product',
            'order_item_type' => 'line_item',
        ]);
    }

    public function testHaveOrderItemMetaInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $orderItemId = $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Test Product',
            'order_item_type' => 'line_item',
        ]);

        $metaId = $I->haveOrderItemMetaInDatabase($orderItemId, '_product_id', '123');
        assert(is_int($metaId) && $metaId > 0, 'Order item meta ID should be a positive integer');

        $I->seeInDatabase('wp_woocommerce_order_itemmeta', [
            'order_item_id' => $orderItemId,
            'meta_key' => '_product_id',
            'meta_value' => '123',
        ]);
    }
}
