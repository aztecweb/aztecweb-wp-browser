<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\OrderStorage;

interface OrderStorageInterface
{
    public function haveOrderInDatabase(array $data): int;

    public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int;

    public function grabOrderMeta(int $orderId, string $key, bool $single = false): mixed;

    public function grabOrderStatus(int $orderId): string;

    public function haveOrderStatus(int $orderId, string $newStatus): void;

    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $data): int;

    public function haveOrderItemInDatabase(int $orderId, array $data = []): int;

    public function haveOrderItemMetaInDatabase(int $orderItemId, string $metaKey, mixed $metaValue): int;

    public function getAdminOrderEditUrl(int $orderId): string;

    public function getTableName(): string;

    public function getMetaTableName(): string;

    public function getMetaIdColumnName(): string;

    public function mapCriteria(array $criteria): array;

    public function mapMetaCriteria(array $criteria): array;

    public function mapAddressCriteria(string $type, array $criteria): array;

    public function seeAddressInDatabase(string $addressType, array $criteria): void;

    public function getIdColumnName(): string;

    public function getOrderAddressTableName(): string;
}
