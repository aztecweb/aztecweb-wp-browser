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
     * @param array<string, mixed> $overrides
     */
    public function haveOrderInDatabase(array $overrides = []): int
    {
        return $this->orderStorage()->haveOrderInDatabase($overrides);
    }

    public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int
    {
        return $this->orderStorage()->haveOrderMetaInDatabase($orderId, $metaKey, $metaValue);
    }

    public function grabOrderMeta(int $orderId, string $key, bool $single = false): mixed
    {
        return $this->orderStorage()->grabOrderMeta($orderId, $key, $single);
    }

    public function grabOrderStatus(int $orderId): string
    {
        return $this->orderStorage()->grabOrderStatus($orderId);
    }

    public function seeOrderStatus(int $orderId, string $status): void
    {
        $this->seeOrderInDatabase(['id' => $orderId, 'status' => $status]);
    }

    public function haveOrderStatus(int $orderId, string $newStatus): void
    {
        $this->orderStorage()->haveOrderStatus($orderId, $newStatus);
    }

    /**
     * @param array<string, mixed> $overrides
     */
    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $overrides): int
    {
        return $this->orderStorage()->haveOrderAddressInDatabase($orderId, $addressType, $overrides);
    }

    /**
     * @param array<string, mixed> $overrides
     */
    public function haveOrderItemInDatabase(int $orderId, array $overrides = []): int
    {
        return $this->orderStorage()->haveOrderItemInDatabase($orderId, $overrides);
    }

    public function haveOrderItemMetaInDatabase(int $orderItemId, string $metaKey, mixed $metaValue): int
    {
        return $this->orderStorage()->haveOrderItemMetaInDatabase($orderItemId, $metaKey, $metaValue);
    }

    /**
     * @param array<string, mixed> $criteria
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
     * @param array<string, mixed> $criteria
     * @return array<int, array<string, mixed>>
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
     * @param array<string, mixed> $criteria
     */
    public function seeOrderInDatabase(array $criteria): void
    {
        $tableName = $this->orderStorage()->getTableName();
        $mappedCriteria = $this->orderStorage()->mapCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    /**
     * @param array<string, mixed> $criteria
     */
    public function seeOrderMetaInDatabase(array $criteria): void
    {
        $tableName = $this->orderStorage()->getMetaTableName();
        $mappedCriteria = $this->orderStorage()->mapMetaCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    /**
     * @param array<string, mixed> $criteria
     */
    public function seeOrderItemInDatabase(array $criteria): void
    {
        $this->wpDb()->seeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items'),
            $criteria,
        );
    }

    /**
     * @param array<string, mixed> $criteria
     */
    public function seeOrderItemMetaInDatabase(array $criteria): void
    {
        $this->wpDb()->seeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_itemmeta'),
            $criteria,
        );
    }

    /**
     * @param array<string, mixed> $criteria
     */
    public function dontSeeOrderItemInDatabase(array $criteria): void
    {
        $this->wpDb()->dontSeeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items'),
            $criteria,
        );
    }

    /**
     * @param array<string, mixed> $criteria
     */
    public function dontSeeOrderItemMetaInDatabase(array $criteria): void
    {
        $this->wpDb()->dontSeeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_itemmeta'),
            $criteria,
        );
    }

    /**
     * @param array<string, mixed> $criteria
     */
    public function seeOrderAddressInDatabase(string $type, array $criteria): void
    {
        $this->orderStorage()->seeAddressInDatabase($type, $criteria);
    }

    public function grabOrderItemsTableName(): string
    {
        return $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items');
    }

    /**
     * @param array<string, mixed> $overrides
     * @return array<int, int>
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
