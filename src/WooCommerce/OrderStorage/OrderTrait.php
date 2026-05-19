<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\OrderStorage;

trait OrderTrait
{
    abstract protected function grabOrderItemsTableName(): string;

    abstract protected function grabOrderItemMetaTableName(): string;

    abstract protected function createOrderRecord(array $data): int;

    abstract public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $data): int;

    abstract public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int;

    final public function haveOrderInDatabase(array $data = []): int
    {
        $billing = $data['address']['billing'] ?? [];
        $shipping = $data['address']['shipping'] ?? [];
        $items = $data['items'] ?? [];
        $meta = $data['meta'] ?? [];

        unset($data['address'], $data['items'], $data['meta']);

        $orderId = $this->createOrderRecord($data);

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

    public function haveOrderItemInDatabase(int $orderId, array $data = []): int
    {
        $meta = $data['meta'] ?? [];

        $orderItemId = $this->wpDb->haveInDatabase($this->grabOrderItemsTableName(), [
            'order_id' => $orderId,
            'order_item_name' => $data['order_item_name'] ?? 'Item',
            'order_item_type' => $data['order_item_type'] ?? 'line_item',
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
