<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\OrderStorage;

trait OrderTrait
{
    abstract protected function grabOrderItemsTableName(): string;

    abstract protected function grabOrderItemMetaTableName(): string;

    abstract protected function createOrderRecord(array $overrides): int;

    abstract public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $overrides): int;

    abstract public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int;

    final public function haveOrderInDatabase(array $overrides = []): int
    {
        $billing = $overrides['address']['billing'] ?? [];
        $shipping = $overrides['address']['shipping'] ?? [];
        $items = $overrides['items'] ?? [];
        $meta = $overrides['meta'] ?? [];

        unset($overrides['address'], $overrides['items'], $overrides['meta']);

        $orderId = $this->createOrderRecord($overrides);

        if (!empty($billing)) {
            $this->haveOrderAddressInDatabase($orderId, 'billing', $billing);
        }

        if (!empty($shipping)) {
            $this->haveOrderAddressInDatabase($orderId, 'shipping', $shipping);
        }

        foreach ($items as $item) {
            $this->haveOrderItemInDatabase($orderId, $item);
        }

        foreach ($meta as $metaKey => $metaValue) {
            $this->haveOrderMetaInDatabase($orderId, $metaKey, $metaValue);
        }

        return $orderId;
    }

    public function haveOrderItemInDatabase(int $orderId, array $overrides = []): int
    {
        $meta = $overrides['meta'] ?? [];

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
