<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Method;

use Aztec\WPBrowser\OrderStorage\OrderStorageInterface;
use lucatume\WPBrowser\Module\WPWebDriver;

trait OrderMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;

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
}
