<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class OrderHPOSCest
{
    public function testHaveOrderInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-pending',
            'total_amount' => '100.00',
        ]);

        assert(is_int($orderId) && $orderId > 0, 'Order ID should be a positive integer');

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $orderId,
            'status' => 'wc-pending',
            'total_amount' => '100.00000000',
        ]);
    }

    public function testHaveOrderWithCustomer(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'customer_id' => 1,
            'billing_email' => 'customer@example.com',
            'status' => 'wc-processing',
        ]);

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $orderId,
            'customer_id' => 1,
            'billing_email' => 'customer@example.com',
            'status' => 'wc-processing',
        ]);
    }

    public function testGrabOrderStatus(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-on-hold',
        ]);

        $status = $I->grabOrderStatus($orderId);

        assert($status === 'wc-on-hold', "Order status should be 'wc-on-hold', got '$status'");
    }

    public function testHaveOrderStatus(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-pending',
        ]);

        $I->haveOrderStatus($orderId, 'wc-completed');

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $orderId,
            'status' => 'wc-completed',
        ]);
    }

    public function testSeeOrderStatus(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-completed',
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
            'payment_method' => 'stripe',
            'payment_method_title' => 'Credit Card',
            'transaction_id' => 'txn_123456',
        ]);

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $orderId,
            'payment_method' => 'stripe',
            'payment_method_title' => 'Credit Card',
            'transaction_id' => 'txn_123456',
        ]);
    }

    public function testAmOnAdminOrderPage(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-processing',
        ]);

        $I->loginAsAdmin();
        $I->amOnAdminOrderPage($orderId);

        $I->seeInCurrentUrl('page=wc-orders&action=edit&id=' . $orderId);
    }

    public function testHaveOrderAddressInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $addressId = $I->haveOrderAddressInDatabase($orderId, 'billing', [
            'first_name' => 'John',
            'last_name' => 'Doe',
            'email' => 'john.doe@example.com',
            'phone' => '555-1234',
            'address_1' => '123 Main St',
            'city' => 'New York',
            'postcode' => '10001',
            'country' => 'US',
        ]);

        assert(is_int($addressId) && $addressId > 0, 'Address ID should be a positive integer');

        $I->seeInDatabase('wp_wc_order_addresses', [
            'order_id' => $orderId,
            'address_type' => 'billing',
            'first_name' => 'John',
            'last_name' => 'Doe',
            'email' => 'john.doe@example.com',
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
