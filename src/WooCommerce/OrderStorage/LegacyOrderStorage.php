<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\OrderStorage;

use Aztec\WPBrowser\WooCommerce\Storage\AbstractLegacyStorage;

class LegacyOrderStorage extends AbstractLegacyStorage implements OrderStorageInterface
{
    use OrderTrait;

    protected function getEntityIdKey(): string
    {
        return 'order_id';
    }

    protected function grabOrderItemsTableName(): string
    {
        return $this->wpDb->grabTablePrefix() . 'woocommerce_order_items';
    }

    protected function grabOrderItemMetaTableName(): string
    {
        return $this->wpDb->grabTablePrefix() . 'woocommerce_order_itemmeta';
    }

    /**
     * Create an order record in the legacy (wp_posts) table.
     *
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The order post ID.
     */
    protected function createOrderRecord(array $overrides): int
    {
        return $this->wpDb->havePostInDatabase(array_merge([
            'post_type' => 'shop_order',
            'post_status' => 'wc-pending',
        ], $overrides));
    }

    public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int
    {
        return $this->haveEntityMetaInDatabase($orderId, $metaKey, $metaValue);
    }

    public function grabOrderMeta(int $orderId, string $key, bool $single = false): mixed
    {
        return $this->grabEntityMeta($orderId, $key, $single);
    }

    public function grabOrderStatus(int $orderId): string
    {
        return $this->grabEntityStatus($orderId);
    }

    public function haveOrderStatus(int $orderId, string $newStatus): void
    {
        $this->haveEntityStatus($orderId, $newStatus);
    }

    /**
     * Create an order address in the database (stored as post meta in legacy mode).
     *
     * @param int $orderId The order ID.
     * @param string $addressType The address type ('billing' or 'shipping').
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The meta ID.
     */
    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $overrides): int
    {
        $metaId = 0;
        $prefix = '_' . $addressType . '_';

        $fieldMapping = [
            'first_name' => $prefix . 'first_name',
            'last_name' => $prefix . 'last_name',
            'company' => $prefix . 'company',
            'address_1' => $prefix . 'address_1',
            'address_2' => $prefix . 'address_2',
            'city' => $prefix . 'city',
            'state' => $prefix . 'state',
            'postcode' => $prefix . 'postcode',
            'country' => $prefix . 'country',
        ];

        if ($addressType === 'billing') {
            $fieldMapping['email'] = '_billing_email';
            $fieldMapping['phone'] = '_billing_phone';
        }

        foreach ($fieldMapping as $field => $metaKey) {
            if (isset($overrides[$field])) {
                $metaId = $this->haveOrderMetaInDatabase($orderId, $metaKey, $overrides[$field]);
            }
        }

        return $metaId;
    }

    public function getAdminOrderEditUrl(int $orderId): string
    {
        return "post.php?post={$orderId}&action=edit";
    }

    /**
     * Map criteria to legacy (wp_posts) format.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapCriteria(array $criteria): array
    {
        $prepped = [];
        foreach ($criteria as $key => $value) {
            $prepped[$key === 'title' ? 'post_title' : $key] = $value;
        }
        return parent::mapCriteria($prepped);
    }

    /**
     * Map and add address type prefix to address criteria.
     *
     * @param string $type The address type ('billing' or 'shipping').
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapAddressCriteria(string $type, array $criteria): array
    {
        $mapped = [];
        $prefix = '_' . $type . '_';

        foreach ($criteria as $key => $value) {
            $mapped[str_starts_with($key, $prefix) ? $key : $prefix . $key] = $value;
        }

        return $mapped;
    }

    /**
     * Assert an address exists in the database.
     *
     * @param string $addressType The address type ('billing' or 'shipping').
     * @param array<string, mixed> $criteria Database query criteria.
     */
    public function seeAddressInDatabase(string $addressType, array $criteria): void
    {
        foreach ($this->mapAddressCriteria($addressType, $criteria) as $metaKey => $metaValue) {
            $this->wpDb->seeInDatabase(
                $this->getMetaTableName(),
                ['meta_key' => $metaKey, 'meta_value' => $metaValue]
            );
        }
    }

    public function getMetaIdColumnName(): string
    {
        return 'post_id';
    }

    public function getOrderAddressTableName(): string
    {
        return $this->getMetaTableName();
    }
}
