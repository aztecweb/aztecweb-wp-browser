<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\OrderStorage;

use Aztec\WPBrowser\WooCommerce\Storage\WooCommerceStorageInterface;

interface OrderStorageInterface extends WooCommerceStorageInterface
{
    public function haveOrderInDatabase(array $overrides): int;

    public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int;

    public function grabOrderMeta(int $orderId, string $key, bool $single = false): mixed;

    public function grabOrderStatus(int $orderId): string;

    public function haveOrderStatus(int $orderId, string $newStatus): void;

    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $overrides): int;

    public function haveOrderItemInDatabase(int $orderId, array $overrides = []): int;

    public function haveOrderItemMetaInDatabase(int $orderItemId, string $metaKey, mixed $metaValue): int;

    public function getAdminOrderEditUrl(int $orderId): string;

    public function getMetaIdColumnName(): string;

    public function mapAddressCriteria(string $type, array $criteria): array;

    public function seeAddressInDatabase(string $addressType, array $criteria): void;

    public function getOrderAddressTableName(): string;
}
