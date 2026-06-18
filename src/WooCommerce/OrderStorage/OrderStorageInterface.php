<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\OrderStorage;

use Aztec\WPBrowser\WooCommerce\Storage\WooCommerceStorageInterface;

interface OrderStorageInterface extends WooCommerceStorageInterface
{
    /**
     * Create an order in the database.
     *
     * @param array<string, mixed> $overrides Database row overrides and related data.
     * @return int The order ID.
     */
    public function haveOrderInDatabase(array $overrides): int;

    public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int;

    public function grabOrderMeta(int $orderId, string $key, bool $single = false): mixed;

    public function grabOrderStatus(int $orderId): string;

    public function haveOrderStatus(int $orderId, string $newStatus): void;

    /**
     * Create an order address in the database.
     *
     * @param int $orderId The order ID.
     * @param string $addressType The address type ('billing' or 'shipping').
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The address ID.
     */
    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $overrides): int;

    /**
     * Create an order item in the database.
     *
     * @param int $orderId The order ID.
     * @param array<string, mixed> $overrides Database row overrides and metadata.
     * @return int The order item ID.
     */
    public function haveOrderItemInDatabase(int $orderId, array $overrides = []): int;

    public function haveOrderItemMetaInDatabase(int $orderItemId, string $metaKey, mixed $metaValue): int;

    public function getMetaIdColumnName(): string;

    /**
     * Map and add address type to address criteria.
     *
     * @param string $type The address type ('billing' or 'shipping').
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapAddressCriteria(string $type, array $criteria): array;

    /**
     * Assert an address exists in the database.
     *
     * @param string $addressType The address type ('billing' or 'shipping').
     * @param array<string, mixed> $criteria Database query criteria.
     */
    public function seeAddressInDatabase(string $addressType, array $criteria): void;

    public function getOrderAddressTableName(): string;
}
