<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\OrderStorage;

use Aztec\WPBrowser\WooCommerce\Storage\AbstractHPOSStorage;

class HPOSOrderStorage extends AbstractHPOSStorage implements OrderStorageInterface
{
    use OrderTrait;

    protected function getEntityIdKey(): string
    {
        return 'order_id';
    }

    private function grabOrderAddressesTableName(): string
    {
        return $this->wpDb->grabTablePrefix() . 'wc_order_addresses';
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
     * Create an order record in the HPOS (wc_orders) table.
     *
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The order ID.
     */
    protected function createOrderRecord(array $overrides): int
    {
        $orderId = $this->generateId();

        $orderData = array_merge([
            'id' => $orderId,
            'status' => 'wc-pending',
            'currency' => 'USD',
            'type' => 'shop_order',
            'tax_amount' => '0.00',
            'total_amount' => '0.00',
            'customer_id' => 0,
            'billing_email' => '',
            'date_created_gmt' => gmdate('Y-m-d H:i:s'),
            'date_updated_gmt' => gmdate('Y-m-d H:i:s'),
            'parent_order_id' => 0,
            'payment_method' => '',
            'payment_method_title' => '',
            'transaction_id' => '',
            'ip_address' => '',
            'user_agent' => '',
            'customer_note' => '',
        ], $overrides);

        $orderData['id'] = $orderId;

        $this->wpDb->haveInDatabase($this->grabWcOrdersTableName(), $orderData);

        return $orderId;
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
     * Create an order address in the database.
     *
     * @param int $orderId The order ID.
     * @param string $addressType The address type ('billing' or 'shipping').
     * @param array<string, mixed> $overrides Database row overrides.
     * @return int The address ID.
     */
    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $overrides): int
    {
        return $this->wpDb->haveInDatabase($this->grabOrderAddressesTableName(), array_merge([
            'order_id' => $orderId,
            'address_type' => $addressType,
            'first_name' => '',
            'last_name' => '',
            'company' => '',
            'address_1' => '',
            'address_2' => '',
            'city' => '',
            'state' => '',
            'postcode' => '',
            'country' => '',
            'email' => '',
            'phone' => '',
        ], $overrides));
    }

    public function getAdminOrderEditUrl(int $orderId): string
    {
        return "admin.php?page=wc-orders&action=edit&id={$orderId}";
    }

    /**
     * Map criteria from legacy (wp_posts) format to HPOS (wc_orders) format.
     *
     * @param array<string, mixed> $criteria Legacy format criteria.
     * @return array<string, mixed> HPOS format criteria.
     */
    public function mapCriteria(array $criteria): array
    {
        $mapped = [];
        foreach ($criteria as $key => $value) {
            if ($key === 'post_status') {
                $mapped['status'] = $value;
            } elseif ($key === 'post_title') {
                $mapped['title'] = $value;
            } else {
                $mapped[$key] = $value;
            }
        }
        return $mapped;
    }

    /**
     * Map and add address type to address criteria.
     *
     * @param string $type The address type ('billing' or 'shipping').
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapAddressCriteria(string $type, array $criteria): array
    {
        $mapped = $criteria;
        $mapped['address_type'] = $type;
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
        $this->wpDb->seeInDatabase(
            $this->grabOrderAddressesTableName(),
            $this->mapAddressCriteria($addressType, $criteria)
        );
    }

    public function getMetaIdColumnName(): string
    {
        return 'order_id';
    }

    public function getOrderAddressTableName(): string
    {
        return $this->grabOrderAddressesTableName();
    }
}
