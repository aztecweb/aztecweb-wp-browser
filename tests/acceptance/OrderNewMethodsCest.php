<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class OrderNewMethodsCest
{
    public function testGrabOrderIdFromDatabase(AcceptanceTester $I): void
    {
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no');

        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-pending',
            'post_name'  => 'test-order',
        ]);

        $grabbedId = $I->grabOrderIdFromDatabase(['post_status' => 'wc-pending', 'post_name' => 'test-order']);
        assert($orderId === $grabbedId);

        $grabbedId = $I->grabOrderIdFromDatabase([
            'post_status' => 'wc-pending',
            'post_type' => 'shop_order',
            'post_name' => 'test-order',
        ]);
        assert($orderId === $grabbedId);

        $notFound = $I->grabOrderIdFromDatabase(['post_status' => 'wc-completed', 'post_name' => 'test-order']);
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
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no');

        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-processing',
        ]);

        $I->seeOrderInDatabase(['post_status' => 'wc-processing']);
        $I->seeOrderInDatabase([
            'ID' => $orderId,
            'post_status' => 'wc-processing',
        ]);
    }

    public function testSeeOrderMetaInDatabase(AcceptanceTester $I): void
    {
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no');

        $orderId = $I->haveOrderInDatabase();

        $I->haveOrderMetaInDatabase($orderId, '_order_key', 'test_key_123');
        $I->haveOrderMetaInDatabase($orderId, '_order_total', '199.99');

        $I->seeOrderMetaInDatabase([
            'post_id' => $orderId,
            'meta_key' => '_order_key',
            'meta_value' => 'test_key_123',
        ]);

        $I->seeOrderMetaInDatabase([
            'post_id' => $orderId,
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

        $I->haveOrderItemMetaInDatabase($orderItemId, '_product_id', '456');
        $I->haveOrderItemMetaInDatabase($orderItemId, '_qty', '2');

        $I->seeOrderItemMetaInDatabase([
            'order_item_id' => $orderItemId,
            'meta_key' => '_product_id',
            'meta_value' => '456',
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
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no');

        $orderId = $I->haveOrderInDatabase();

        $I->haveOrderAddressInDatabase($orderId, 'billing', [
            'first_name' => 'John',
            'last_name' => 'Doe',
            'address_1' => '123 Test St',
            'city' => 'Test City',
            'postcode' => '12345',
            'country' => 'US',
        ]);

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
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no');

        $orderId = $I->haveOrderInDatabase();

        $I->haveOrderAddressInDatabase($orderId, 'shipping', [
            'first_name' => 'Jane',
            'last_name' => 'Smith',
            'company' => 'Test Company',
            'address_1' => '456 Ship St',
            'city' => 'Ship City',
        ]);

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
        $overrides = ['post_status' => 'wc-pending'];

        $orderIds = $I->haveManyOrdersInDatabase($count, $overrides);

        assert(count($orderIds) === $count);

        foreach ($orderIds as $orderId) {
            $I->seePostInDatabase([
                'ID' => $orderId,
                'post_type' => 'shop_order',
                'post_status' => 'wc-pending',
            ]);
        }
    }

    public function testHaveManyOrdersWithDefaults(AcceptanceTester $I): void
    {
        $count = 3;

        $orderIds = $I->haveManyOrdersInDatabase($count);

        assert(count($orderIds) === $count);

        foreach ($orderIds as $orderId) {
            $I->seePostInDatabase([
                'ID' => $orderId,
                'post_type' => 'shop_order',
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
