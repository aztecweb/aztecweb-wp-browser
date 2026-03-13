<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\OrderStorage;

use lucatume\WPBrowser\Module\WPDb;

abstract class AbstractOrderStorage implements OrderStorageInterface
{
    public function __construct(
        protected WPDb $wpDb
    ) {}

    abstract protected function grabOrderItemsTableName(): string;

    abstract protected function grabOrderItemMetaTableName(): string;

    abstract protected function createOrderRecord(array $data): int;

    abstract protected function getIdColumnName(): string;

    abstract public function getTableName(): string;

    abstract public function getMetaTableName(): string;

    abstract public function getMetaIdColumnName(): string;

    public function mapCriteria(array $criteria): array
    {
        return $criteria;
    }

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
        $name = $data['order_item_name'] ?? 'Item';
        $type = $data['order_item_type'] ?? 'line_item';
        $meta = $data['meta'] ?? [];

        $itemRow = [
            'order_id' => $orderId,
            'order_item_name' => $name,
            'order_item_type' => $type,
        ];

        $orderItemId = $this->wpDb->haveInDatabase($this->grabOrderItemsTableName(), $itemRow);

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
