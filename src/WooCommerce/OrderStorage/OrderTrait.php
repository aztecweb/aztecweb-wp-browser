<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\OrderStorage;

trait OrderTrait
{
    abstract protected function grabOrderItemsTableName(): string;

    abstract protected function grabOrderItemMetaTableName(): string;

    /**
     * Create an order record.
     *
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The order ID.
     */
    abstract protected function createOrderRecord(array $overrides): int;

    /**
     * Create an order address in the database.
     *
     * @param int $orderId The order ID.
     * @param string $addressType The address type ('billing' or 'shipping').
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The address ID.
     */
    abstract public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $overrides): int;

    abstract public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int;

    /**
     * Create an order in the database.
     *
     * @param array<string, mixed> $overrides Database row overrides and related data.
     * @return int The order ID.
     */
    final public function haveOrderInDatabase(array $overrides = []): int
    {
        $address = is_array($overrides['address'] ?? null) ? $overrides['address'] : [];
        /** @var array<string, mixed> $billing */
        $billing = is_array($address['billing'] ?? null) ? $address['billing'] : [];
        /** @var array<string, mixed> $shipping */
        $shipping = is_array($address['shipping'] ?? null) ? $address['shipping'] : [];
        $items = is_array($overrides['items'] ?? null) ? $overrides['items'] : [];
        $meta = is_array($overrides['meta'] ?? null) ? $overrides['meta'] : [];

        unset($overrides['address'], $overrides['items'], $overrides['meta']);

        $orderId = $this->createOrderRecord($overrides);

        if (!empty($billing)) {
            $this->haveOrderAddressInDatabase($orderId, 'billing', $billing);
        }

        if (!empty($shipping)) {
            $this->haveOrderAddressInDatabase($orderId, 'shipping', $shipping);
        }

        foreach ($items as $item) {
            /** @var array<string, mixed> $itemOverrides */
            $itemOverrides = (array) $item;
            $this->haveOrderItemInDatabase($orderId, $itemOverrides);
        }

        foreach ($meta as $metaKey => $metaValue) {
            $this->haveOrderMetaInDatabase($orderId, $metaKey, $metaValue);
        }

        return $orderId;
    }

    /**
     * Create an order item in the database.
     *
     * @param int $orderId The order ID.
     * @param array<string, mixed> $overrides Database row overrides and metadata.
     * @return int The order item ID.
     */
    public function haveOrderItemInDatabase(int $orderId, array $overrides = []): int
    {
        $meta = is_array($overrides['meta'] ?? null) ? $overrides['meta'] : [];

        $orderItemId = $this->wpDb->haveInDatabase($this->grabOrderItemsTableName(), [
            'order_id' => $orderId,
            'order_item_name' => $overrides['order_item_name'] ?? 'Item',
            'order_item_type' => $overrides['order_item_type'] ?? 'line_item',
        ]);

        foreach ($meta as $metaKey => $metaValue) {
            $this->haveOrderItemMetaInDatabase($orderItemId, $metaKey, $metaValue);
        }

        return $orderItemId;
    }

    public function haveOrderItemMetaInDatabase(int $orderItemId, string $metaKey, mixed $metaValue): int
    {
        return $this->wpDb->haveInDatabase(
            $this->grabOrderItemMetaTableName(),
            [
                'order_item_id' => $orderItemId,
                'meta_key' => $metaKey,
                'meta_value' => is_array($metaValue) ? serialize($metaValue) : $metaValue,
            ]
        );
    }
}
