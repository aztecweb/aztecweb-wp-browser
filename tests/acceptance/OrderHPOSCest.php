<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class OrderHPOSCest
{
    public function _before(AcceptanceTester $I): void
    {
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'yes');
    }

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

    public function testGrabOrderIdFromDatabase(AcceptanceTester $I): void
    {
        $uniqueCustomerId = 9999;

        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-pending',
            'customer_id' => $uniqueCustomerId,
        ]);

        $grabbedId = $I->grabOrderIdFromDatabase(['status' => 'wc-pending', 'customer_id' => $uniqueCustomerId]);
        assert($orderId === $grabbedId);

        $grabbedId = $I->grabOrderIdFromDatabase([
            'status' => 'wc-pending',
            'customer_id' => $uniqueCustomerId,
        ]);
        assert($orderId === $grabbedId);

        $notFound = $I->grabOrderIdFromDatabase(['status' => 'wc-completed', 'customer_id' => $uniqueCustomerId]);
        assert($notFound === false);
    }

    public function testGrabOrderItemFromDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $orderItemId = $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Test Product Item',
            'order_item_type' => 'line_item',
        ]);

        $items = $I->grabOrderItemFromDatabase(['order_id' => $orderId]);
        assert(is_array($items));
        assert(count($items) > 0);

        $foundItem = null;
        foreach ($items as $item) {
            if ($item['order_item_id'] == $orderItemId) {
                $foundItem = $item;
                break;
            }
        }
        assert($foundItem !== null);
        assert($foundItem['order_item_name'] === 'Test Product Item');
    }

    public function testGrabOrderItemByType(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Product Item',
            'order_item_type' => 'line_item',
        ]);

        $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Shipping Fee',
            'order_item_type' => 'shipping',
        ]);

        $lineItems = $I->grabOrderItemFromDatabase([
            'order_id' => $orderId,
            'order_item_type' => 'line_item',
        ]);

        assert(count($lineItems) === 1);
        assert($lineItems[0]['order_item_name'] === 'Product Item');
    }

    public function testSeeOrderInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-processing',
        ]);

        $I->seeOrderInDatabase(['status' => 'wc-processing']);
        $I->seeOrderInDatabase([
            'id' => $orderId,
            'status' => 'wc-processing',
        ]);
    }

    public function testSeeOrderMetaInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $I->haveOrderMetaInDatabase($orderId, '_order_key', 'test_key_456');
        $I->haveOrderMetaInDatabase($orderId, '_order_total', '299.99');

        $I->seeOrderMetaInDatabase([
            'order_id' => $orderId,
            'meta_key' => '_order_key',
            'meta_value' => 'test_key_456',
        ]);

        $I->seeOrderMetaInDatabase([
            'order_id' => $orderId,
            'meta_key' => '_order_total',
        ]);
    }

    public function testSeeOrderItemInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $orderItemId = $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Visible Product',
            'order_item_type' => 'line_item',
        ]);

        $I->seeOrderItemInDatabase([
            'order_item_id' => $orderItemId,
            'order_id' => $orderId,
            'order_item_name' => 'Visible Product',
        ]);

        $I->seeOrderItemInDatabase([
            'order_id' => $orderId,
            'order_item_type' => 'line_item',
        ]);
    }

    public function testDontSeeOrderItemInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $I->dontSeeOrderItemInDatabase([
            'order_id' => $orderId,
            'order_item_name' => 'Nonexistent Item',
        ]);
    }

    public function testSeeOrderItemMetaInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $orderItemId = $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Product with Meta',
            'order_item_type' => 'line_item',
        ]);

        $I->haveOrderItemMetaInDatabase($orderItemId, '_product_id', '789');
        $I->haveOrderItemMetaInDatabase($orderItemId, '_qty', '3');

        $I->seeOrderItemMetaInDatabase([
            'order_item_id' => $orderItemId,
            'meta_key' => '_product_id',
            'meta_value' => '789',
        ]);

        $I->seeOrderItemMetaInDatabase([
            'order_item_id' => $orderItemId,
            'meta_key' => '_qty',
        ]);
    }

    public function testDontSeeOrderItemMetaInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $orderItemId = $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Test Item',
            'order_item_type' => 'line_item',
        ]);

        $I->dontSeeOrderItemMetaInDatabase([
            'order_item_id' => $orderItemId,
            'meta_key' => '_nonexistent_meta',
        ]);
    }

    public function testSeeOrderAddressInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $addressId = $I->haveOrderAddressInDatabase($orderId, 'billing', [
            'first_name' => 'John',
            'last_name' => 'Doe',
            'address_1' => '123 Test St',
            'city' => 'Test City',
            'postcode' => '12345',
            'country' => 'US',
        ]);

        assert(is_int($addressId) && $addressId > 0);

        $I->seeOrderAddressInDatabase('billing', [
            'first_name' => 'John',
            'last_name' => 'Doe',
        ]);

        $I->seeOrderAddressInDatabase('billing', [
            'address_1' => '123 Test St',
            'city' => 'Test City',
        ]);
    }

    public function testSeeShippingOrderAddressInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $addressId = $I->haveOrderAddressInDatabase($orderId, 'shipping', [
            'first_name' => 'Jane',
            'last_name' => 'Smith',
            'company' => 'Test Company',
            'address_1' => '456 Ship St',
            'city' => 'Ship City',
        ]);

        assert(is_int($addressId) && $addressId > 0);

        $I->seeOrderAddressInDatabase('shipping', [
            'first_name' => 'Jane',
            'company' => 'Test Company',
        ]);

        $I->seeOrderAddressInDatabase('shipping', [
            'address_1' => '456 Ship St',
            'city' => 'Ship City',
        ]);
    }

    public function testGrabOrderItemsTableName(AcceptanceTester $I): void
    {
        $tableName = $I->grabOrderItemsTableName();

        $expectedTable = $I->grabPrefixedTableNameFor('woocommerce_order_items');
        assert($tableName === $expectedTable);
    }

    public function testHaveManyOrdersInDatabase(AcceptanceTester $I): void
    {
        $count = 5;
        $overrides = ['status' => 'wc-pending'];

        $orderIds = $I->haveManyOrdersInDatabase($count, $overrides);

        assert(count($orderIds) === $count);

        foreach ($orderIds as $orderId) {
            $I->seeInDatabase('wp_wc_orders', [
                'id' => $orderId,
                'status' => 'wc-pending',
            ]);
        }
    }

    public function testHaveManyOrdersWithDefaults(AcceptanceTester $I): void
    {
        $count = 3;

        $orderIds = $I->haveManyOrdersInDatabase($count);

        assert(count($orderIds) === $count);

        foreach ($orderIds as $orderId) {
            $I->seeInDatabase('wp_wc_orders', [
                'id' => $orderId,
            ]);
        }
    }

    public function testSeeOrderItemMetaWithOrderId(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $orderItemId = $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Meta Test Item',
            'order_item_type' => 'line_item',
        ]);

        $metaId = $I->haveOrderItemMetaInDatabase($orderItemId, '_test_meta', 'test_value');

        assert(is_int($metaId) && $metaId > 0);

        $I->seeOrderItemMetaInDatabase([
            'order_item_id' => $orderItemId,
            'meta_key' => '_test_meta',
            'meta_value' => 'test_value',
        ]);
    }
}
