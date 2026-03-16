<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Method;

use Aztec\WPBrowser\OrderStorage\OrderStorageInterface;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

trait OrderMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;

    abstract protected function wpDb(): WPDb;

    abstract protected function orderStorage(): OrderStorageInterface;

    public function haveOrderInDatabase(array $data = []): int
    {
        return $this->orderStorage()->haveOrderInDatabase($data);
    }

    public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int
    {
        return $this->orderStorage()->haveOrderMetaInDatabase($orderId, $metaKey, $metaValue);
    }

    public function grabOrderMeta(int $orderId, string $key, bool $single = false): mixed
    {
        return $this->orderStorage()->grabOrderMeta($orderId, $key, $single);
    }

    public function amOnAdminOrderPage(int $orderId): void
    {
        $url = $this->orderStorage()->getAdminOrderEditUrl($orderId);
        $this->wpWebDriver()->amOnAdminPage($url);
    }

    public function grabOrderStatus(int $orderId): string
    {
        return $this->orderStorage()->grabOrderStatus($orderId);
    }

    public function seeOrderStatus(int $orderId, string $status): void
    {
        $actualStatus = $this->grabOrderStatus($orderId);
        $this->assertEquals($status, $actualStatus, "Order {$orderId} status is not {$status}");
    }

    public function haveOrderStatus(int $orderId, string $newStatus): void
    {
        $this->orderStorage()->haveOrderStatus($orderId, $newStatus);
    }

    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $data): int
    {
        return $this->orderStorage()->haveOrderAddressInDatabase($orderId, $addressType, $data);
    }

    public function haveOrderItemInDatabase(int $orderId, array $data = []): int
    {
        return $this->orderStorage()->haveOrderItemInDatabase($orderId, $data);
    }

    public function haveOrderItemMetaInDatabase(int $orderItemId, string $metaKey, mixed $metaValue): int
    {
        return $this->orderStorage()->haveOrderItemMetaInDatabase($orderItemId, $metaKey, $metaValue);
    }

    public function grabOrderIdFromDatabase(array $criteria): int|false
    {
        $mappedCriteria = $this->orderStorage()->mapCriteria($criteria);

        $id = $this->wpDb()->grabFromDatabase(
            $this->orderStorage()->getTableName(),
            $this->orderStorage()->getIdColumnName(),
            $mappedCriteria
        );

        if ($id === false) {
            return false;
        }

        return (int)$id;
    }

    public function grabOrderItemFromDatabase(array $criteria): array
    {
        $items = $this->wpDb()->grabAllFromDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items'),
            '*',
            $criteria
        );

        return $items;
    }

    public function seeOrderInDatabase(array $criteria): void
    {
        $tableName = $this->orderStorage()->getTableName();
        $mappedCriteria = $this->orderStorage()->mapCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    public function seeOrderMetaInDatabase(array $criteria): void
    {
        $tableName = $this->orderStorage()->getMetaTableName();
        $mappedCriteria = $this->orderStorage()->mapMetaCriteria($criteria);
        $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
    }

    public function seeOrderItemInDatabase(array $criteria): void
    {
        $this->wpDb()->seeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items'),
            $criteria
        );
    }

    public function seeOrderItemMetaInDatabase(array $criteria): void
    {
        $this->wpDb()->seeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_itemmeta'),
            $criteria
        );
    }

    public function dontSeeOrderItemInDatabase(array $criteria): void
    {
        $this->wpDb()->dontSeeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items'),
            $criteria
        );
    }

    public function dontSeeOrderItemMetaInDatabase(array $criteria): void
    {
        $this->wpDb()->dontSeeInDatabase(
            $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_itemmeta'),
            $criteria
        );
    }

    public function seeOrderAddressInDatabase(string $type, array $criteria): void
    {
        $this->orderStorage()->seeAddressInDatabase($type, $criteria);
    }

    public function grabOrderItemsTableName(): string
    {
        return $this->wpDb()->grabPrefixedTableNameFor('woocommerce_order_items');
    }

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
