<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\OrderStorage;

class HPOSOrderStorage extends AbstractOrderStorage
{
    private function grabOrdersTableName(): string
    {
        return $this->wpDb->grabTablePrefix() . 'wc_orders';
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

    protected function createOrderRecord(array $data): int
    {
        $orderId = $this->generateOrderId();

        $defaults = [
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
        ];

        $orderData = array_merge($defaults, $data);
        $orderData['id'] = $orderId;

        $this->wpDb->haveInDatabase($this->grabOrdersTableName(), $orderData);

        return $orderId;
    }

    private function generateOrderId(): int
    {
        $ordersTable = $this->grabOrdersTableName();
        $postsTable = $this->wpDb->grabPostsTableName();

        $maxOrderId = $this->wpDb->grabLatestEntryByFromDatabase($ordersTable, 'id');
        $maxPostId = $this->wpDb->grabLatestEntryByFromDatabase($postsTable, 'ID');

        return max($maxOrderId, $maxPostId) + 1;
    }

    public function haveOrderMetaInDatabase(int $orderId, string $metaKey, mixed $metaValue): int
    {
        return $this->wpDb->havePostmetaInDatabase($orderId, $metaKey, $metaValue);
    }

    public function grabOrderMeta(int $orderId, string $key, bool $single = false): mixed
    {
        return $this->wpDb->grabPostMetaFromDatabase($orderId, $key, $single);
    }

    public function grabOrderStatus(int $orderId): string
    {
        return $this->wpDb->grabFromDatabase($this->grabOrdersTableName(), 'status', ['id' => $orderId]);
    }

    public function haveOrderStatus(int $orderId, string $newStatus): void
    {
        $this->wpDb->updateInDatabase(
            $this->grabOrdersTableName(),
            ['status' => $newStatus],
            ['id' => $orderId]
        );
    }

    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $data): int
    {
        $defaults = [
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
        ];

        $addressData = array_merge($defaults, $data);

        return $this->wpDb->haveInDatabase($this->grabOrderAddressesTableName(), $addressData);
    }

    public function getAdminOrderEditUrl(int $orderId): string
    {
        return "admin.php?page=wc-orders&action=edit&id={$orderId}";
    }
}
