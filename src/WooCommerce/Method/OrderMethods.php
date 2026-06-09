<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Aztec\WPBrowser\WooCommerce\OrderStorage\OrderStorageInterface;
use lucatume\WPBrowser\Module\WPDb;

trait OrderMethods
{
    abstract protected function wpDb(): WPDb;

    abstract protected function orderStorage(): OrderStorageInterface;

    /**
     * Create an order in the database (auto-detects HPOS or Legacy storage).
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase([
     *     'status' => 'processing',
     * ]);
     * $I->seeOrderInDatabase(['id' => $orderId, 'status' => 'processing']);
     * ```
     *
     * @param array<string, mixed> $overrides Order data overrides (status, customer_id, etc.). Behavior depends on storage mode (HPOS or Legacy)
     *
     * @return int The created order ID
     */
    public function haveOrderInDatabase(array $overrides = []): int
    {
        return $this->orderStorage()->haveOrderInDatabase($overrides);
    }

    /**
     * Create a meta entry for an order in the database.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $metaId = $I->haveOrderMetaInDatabase($orderId, '_customer_user', '123');
     * $I->assertGreaterThan(0, $metaId);
     * ```
     *
     * @param int    $orderId    Order ID
     * @param string $metaKey    Meta key name
     * @param mixed  $metaValue  Meta value
     *
     * @return int Meta ID of the created entry
     */
    public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int
    {
        return $this->orderStorage()->haveOrderMetaInDatabase($orderId, $metaKey, $metaValue);
    }

    /**
     * Extract a meta value from an order in the database.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $I->haveOrderMetaInDatabase($orderId, '_billing_first_name', 'John');
     * $value = $I->grabOrderMeta($orderId, '_billing_first_name', true);
     * $I->assertSame('John', $value);
     * ```
     *
     * @param int    $orderId  Order ID
     * @param string $key      Meta key to retrieve
     * @param bool   $single   Whether to return a single value (true) or array of values (false)
     *
     * @return mixed Meta value or array of meta values
     */
    public function grabOrderMeta(int $orderId, string $key, bool $single = false): mixed
    {
        return $this->orderStorage()->grabOrderMeta($orderId, $key, $single);
    }

    /**
     * Extract the current status of an order from the database.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase(['status' => 'pending']);
     * $status = $I->grabOrderStatus($orderId);
     * $I->assertSame('pending', $status);
     * ```
     *
     * @param int $orderId  Order ID
     *
     * @return string Order status (e.g., 'pending', 'processing', 'completed', 'cancelled')
     */
    public function grabOrderStatus(int $orderId): string
    {
        return $this->orderStorage()->grabOrderStatus($orderId);
    }

    /**
     * Verify that an order has the expected status in the database.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase(['status' => 'processing']);
     * $I->seeOrderStatus($orderId, 'processing');
     * ```
     *
     * @param int    $orderId  Order ID to verify
     * @param string $status   Expected order status
     *
     * @return void
     */
    public function seeOrderStatus(int $orderId, string $status): void
    {
        $this->seeOrderInDatabase(['id' => $orderId, 'status' => $status]);
    }

    /**
     * Change an order's status in the database.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase(['status' => 'pending']);
     * $I->haveOrderStatus($orderId, 'completed');
     * $I->seeOrderStatus($orderId, 'completed');
     * ```
     *
     * @param int    $orderId    Order ID to modify
     * @param string $newStatus  New order status to set
     *
     * @return void
     */
    public function haveOrderStatus(int $orderId, string $newStatus): void
    {
        $this->orderStorage()->haveOrderStatus($orderId, $newStatus);
    }

    /**
     * Create a billing or shipping address for an order in the database.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $addressId = $I->haveOrderAddressInDatabase($orderId, 'billing', [
     *     'first_name' => 'John',
     *     'last_name' => 'Doe',
     *     'address_1' => '123 Main St',
     *     'city' => 'New York',
     * ]);
     * $I->assertGreaterThan(0, $addressId);
     * ```
     *
     * @param int                  $orderId      Order ID
     * @param string               $addressType  Address type ('billing' or 'shipping')
     * @param array<string, mixed> $overrides    Address fields (first_name, last_name, company, address_1, address_2, city, state, postcode, country, email, phone)
     *
     * @return int Address ID
     */
    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $overrides): int
    {
        return $this->orderStorage()->haveOrderAddressInDatabase($orderId, $addressType, $overrides);
    }

    /**
     * Create a line item for an order in the database.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $itemId = $I->haveOrderItemInDatabase($orderId, [
     *     'order_item_name' => 'Test Product',
     *     'order_item_type' => 'line_item',
     *     'meta' => ['_product_id' => 123, '_qty' => 1],
     * ]);
     * $I->assertGreaterThan(0, $itemId);
     * ```
     *
     * @param int                  $orderId   Order ID
     * @param array<string, mixed> $overrides Line item data (order_item_name, order_item_type, meta array for item meta)
     *
     * @return int Order item ID
     */
    public function haveOrderItemInDatabase(int $orderId, array $overrides = []): int
    {
        return $this->orderStorage()->haveOrderItemInDatabase($orderId, $overrides);
    }

    /**
     * Create a meta entry for an order item in the database.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $itemId = $I->haveOrderItemInDatabase($orderId, ['order_item_name' => 'Product']);
     * $metaId = $I->haveOrderItemMetaInDatabase($itemId, '_product_id', '456');
     * $I->assertGreaterThan(0, $metaId);
     * ```
     *
     * @param int    $orderItemId  Order item ID
     * @param string $metaKey      Meta key name
     * @param mixed  $metaValue    Meta value
     *
     * @return int Item meta ID
     */
    public function haveOrderItemMetaInDatabase(int $orderItemId, string $metaKey, mixed $metaValue): int
    {
        return $this->orderStorage()->haveOrderItemMetaInDatabase($orderItemId, $metaKey, $metaValue);
    }

    /**
     * Extract an order ID from the database by query criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase(['status' => 'processing']);
     * $found = $I->grabOrderIdFromDatabase(['status' => 'processing']);
     * $I->assertSame($orderId, $found);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['status' => 'pending', 'id' => 123]). Supports storage-agnostic keys like 'id', 'status'
     *
     * @return int|false Order ID if found, false otherwise
     */
    public function grabOrderIdFromDatabase(array $criteria): int|false
    {
        $mappedCriteria = $this->orderStorage()->mapCriteria($criteria);

        $id = $this->wpDb()->grabFromDatabase(
            $this->orderStorage()->getTableName(),
            $this->orderStorage()->getIdColumnName(),
            $mappedCriteria,
        );

        if ($id === false) {
            return false;
        }

        return is_numeric($id) ? (int)$id : false;
    }

    /**
     * Extract order items from the database by query criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $itemId = $I->haveOrderItemInDatabase($orderId, ['order_item_name' => 'Product']);
     * $items = $I->grabOrderItemFromDatabase(['order_id' => $orderId]);
     * $I->assertCount(1, $items);
     * $I->assertSame('Product', $items[0]['order_item_name']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['order_id' => 123, 'order_item_type' => 'line_item'])
     *
     * @return array<int, array<string, mixed>> Array of order item records
     */
    public function grabOrderItemFromDatabase(array $criteria): array
    {
        $items = $this->wpDb()->grabAllFromDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items'),
            '*',
            $criteria,
        );

        /** @var array<int, array<string, mixed>> */
        return array_values($items);
    }

    /**
     * Verify that an order exists in the database with the given criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase(['status' => 'completed']);
     * $I->seeOrderInDatabase(['id' => $orderId, 'status' => 'completed']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['id' => 123, 'status' => 'pending']). Supports storage-agnostic keys like 'id', 'status'
     *
     * @return void
     */
    public function seeOrderInDatabase(array $criteria): void
    {
        $tableName = $this->orderStorage()->getTableName();
        $mappedCriteria = $this->orderStorage()->mapCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    /**
     * Verify that order meta exists in the database with the given criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $I->haveOrderMetaInDatabase($orderId, '_custom_field', 'value123');
     * $I->seeOrderMetaInDatabase(['order_id' => $orderId, 'meta_key' => '_custom_field']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['order_id' => 123, 'meta_key' => '_custom_field']). Supports storage-agnostic keys
     *
     * @return void
     */
    public function seeOrderMetaInDatabase(array $criteria): void
    {
        $tableName = $this->orderStorage()->getMetaTableName();
        $mappedCriteria = $this->orderStorage()->mapMetaCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    /**
     * Verify that an order item exists in the database with the given criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $itemId = $I->haveOrderItemInDatabase($orderId, ['order_item_name' => 'Test Product']);
     * $I->seeOrderItemInDatabase(['order_id' => $orderId, 'order_item_type' => 'line_item']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['order_id' => 123, 'order_item_type' => 'line_item'])
     *
     * @return void
     */
    public function seeOrderItemInDatabase(array $criteria): void
    {
        $this->wpDb()->seeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items'),
            $criteria,
        );
    }

    /**
     * Verify that order item meta exists in the database with the given criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $itemId = $I->haveOrderItemInDatabase($orderId, ['order_item_name' => 'Product']);
     * $I->haveOrderItemMetaInDatabase($itemId, '_product_id', '789');
     * $I->seeOrderItemMetaInDatabase(['order_item_id' => $itemId, 'meta_key' => '_product_id']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['order_item_id' => 123, 'meta_key' => '_product_id'])
     *
     * @return void
     */
    public function seeOrderItemMetaInDatabase(array $criteria): void
    {
        $this->wpDb()->seeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_itemmeta'),
            $criteria,
        );
    }

    /**
     * Verify that an order item does not exist in the database with the given criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $I->dontSeeOrderItemInDatabase(['order_id' => $orderId, 'order_item_name' => 'Nonexistent']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['order_id' => 123, 'order_item_name' => 'Deleted Product'])
     *
     * @return void
     */
    public function dontSeeOrderItemInDatabase(array $criteria): void
    {
        $this->wpDb()->dontSeeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items'),
            $criteria,
        );
    }

    /**
     * Verify that order item meta does not exist in the database with the given criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $itemId = $I->haveOrderItemInDatabase($orderId, ['order_item_name' => 'Product']);
     * $I->dontSeeOrderItemMetaInDatabase(['order_item_id' => $itemId, 'meta_key' => '_nonexistent']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['order_item_id' => 123, 'meta_key' => '_deleted_meta'])
     *
     * @return void
     */
    public function dontSeeOrderItemMetaInDatabase(array $criteria): void
    {
        $this->wpDb()->dontSeeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_itemmeta'),
            $criteria,
        );
    }

    /**
     * Verify that an order address exists in the database with the given criteria.
     *
     * @example
     * ```php
     * $orderId = $I->haveOrderInDatabase();
     * $I->haveOrderAddressInDatabase($orderId, 'billing', ['first_name' => 'John']);
     * $I->seeOrderAddressInDatabase('billing', ['first_name' => 'John']);
     * ```
     *
     * @param string               $type     Address type ('billing' or 'shipping')
     * @param array<string, mixed> $criteria Database query criteria for address fields
     *
     * @return void
     */
    public function seeOrderAddressInDatabase(string $type, array $criteria): void
    {
        $this->orderStorage()->seeAddressInDatabase($type, $criteria);
    }

    /**
     * Get the full prefixed table name for WooCommerce order items.
     *
     * @example
     * ```php
     * $tableName = $I->grabOrderItemsTableName();
     * $I->assertStringContainsString('woocommerce_order_items', $tableName);
     * ```
     *
     * @return string Prefixed order items table name
     */
    public function grabOrderItemsTableName(): string
    {
        return $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items');
    }

    /**
     * Create multiple orders in the database.
     *
     * @example
     * ```php
     * $orderIds = $I->haveManyOrdersInDatabase(3, ['status' => 'pending']);
     * $I->assertCount(3, $orderIds);
     * foreach ($orderIds as $orderId) {
     *     $I->seeOrderStatus($orderId, 'pending');
     * }
     * ```
     *
     * @param int                  $count     Number of orders to create
     * @param array<string, mixed> $overrides Order data overrides applied to each order
     *
     * @return array<int, int> Array of created order IDs
     */
    public function haveManyOrdersInDatabase(int $count, array $overrides = []): array
    {
        $createdIds = [];

        for ($i = 1; $i <= $count; $i++) {
            $orderId = $this->haveOrderInDatabase($overrides);
            $createdIds[] = $orderId;
        }

        return $createdIds;
    }
}
