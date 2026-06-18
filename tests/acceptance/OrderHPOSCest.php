<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class OrderHPOSCest
{
    public function _before(AcceptanceTester $I): void
    {
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'yes');
        $I->setLegacyOrderStorage(false);
    }

    public function testHaveOrderInDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-pending',
            'total_amount' => '100.00',
        ]);

        $I->assertGreaterThan(0, $orderId, 'Order ID should be a positive integer');

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

        $I->assertSame('wc-on-hold', $status, "Order status should be 'wc-on-hold', got '$status'");
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
        $orderTotalValue = is_array($orderTotal) ? reset($orderTotal) : $orderTotal;
        $I->assertSame('99.99', $orderTotalValue, 'Order total meta should be 99.99');

        $paymentMethod = $I->grabOrderMeta($orderId, '_payment_method');
        $paymentMethodValue = is_array($paymentMethod) ? reset($paymentMethod) : $paymentMethod;
        $I->assertSame('bacs', $paymentMethodValue, 'Payment method meta should be bacs');
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

        // Retry login + navigation: a freshly logged-in admin is intermittently
        // not recognized as capable on the order screen (WordPress redirects to
        // the dashboard with "Sorry, you are not allowed to do that"). Both the
        // legacy and HPOS order-edit URLs contain "action=edit", so its presence
        // confirms we landed on the order page.
        $attempts = 0;
        do {
            $I->loginAsAdmin();
            $I->amOnAdminOrderPage($orderId);
            $currentUrl = $I->grabFromCurrentUrl();
            $urlStr = is_string($currentUrl) ? $currentUrl : '';
        } while (
            strpos($urlStr, 'action=edit') === false
            && ++$attempts < 3
        );

        $I->seeInCurrentUrl('page=wc-orders&action=edit&id=' . $orderId);

        $I->restartBuiltInServer();
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

        $I->assertGreaterThan(0, $addressId, 'Address ID should be a positive integer');

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

        $I->assertGreaterThan(0, $orderItemId, 'Order item ID should be a positive integer');

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
        $I->assertGreaterThan(0, $metaId, 'Order item meta ID should be a positive integer');

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
        $I->assertSame($grabbedId, $orderId);

        $grabbedId = $I->grabOrderIdFromDatabase([
            'status' => 'wc-pending',
            'customer_id' => $uniqueCustomerId,
        ]);
        $I->assertSame($grabbedId, $orderId);

        $notFound = $I->grabOrderIdFromDatabase(['status' => 'wc-completed', 'customer_id' => $uniqueCustomerId]);
        $I->assertFalse($notFound);
    }

    public function testGrabOrderItemFromDatabase(AcceptanceTester $I): void
    {
        $orderId = $I->haveOrderInDatabase();

        $orderItemId = $I->haveOrderItemInDatabase($orderId, [
            'order_item_name' => 'Test Product Item',
            'order_item_type' => 'line_item',
        ]);

        $items = $I->grabOrderItemFromDatabase(['order_id' => $orderId]);
        $I->assertNotEmpty($items);

        $foundItem = null;
        foreach ($items as $item) {
            if ($item['order_item_id'] == $orderItemId) {
                $foundItem = $item;
                break;
            }
        }
        $I->assertNotNull($foundItem);
        $I->assertSame('Test Product Item', $foundItem['order_item_name']);
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

        $I->assertCount(1, $lineItems);
        $I->assertSame('Product Item', $lineItems[0]['order_item_name']);
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

        $I->assertGreaterThan(0, $addressId);

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

        $I->assertGreaterThan(0, $addressId);

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
        $I->assertSame($expectedTable, $tableName);
    }

    public function testHaveManyOrdersInDatabase(AcceptanceTester $I): void
    {
        $count = 5;
        $overrides = ['status' => 'wc-pending'];

        $orderIds = $I->haveManyOrdersInDatabase($count, $overrides);

        $I->assertCount($count, $orderIds);

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

        $I->assertCount($count, $orderIds);

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

        $I->assertGreaterThan(0, $metaId);

        $I->seeOrderItemMetaInDatabase([
            'order_item_id' => $orderItemId,
            'meta_key' => '_test_meta',
            'meta_value' => 'test_value',
        ]);
    }
}
