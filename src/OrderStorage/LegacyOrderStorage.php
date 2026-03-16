<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\OrderStorage;

class LegacyOrderStorage extends AbstractOrderStorage
{
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
        $orderData = array_merge([
            'post_type' => 'shop_order',
            'post_status' => 'wc-pending',
        ], $data);

        return $this->wpDb->havePostInDatabase($orderData);
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
        return $this->wpDb->grabPostFieldFromDatabase($orderId, 'post_status');
    }

    public function haveOrderStatus(int $orderId, string $newStatus): void
    {
        $this->wpDb->updateInDatabase(
            $this->wpDb->grabPostsTableName(),
            ['post_status' => $newStatus],
            ['ID' => $orderId]
        );
    }

    public function haveOrderAddressInDatabase(int $orderId, string $addressType, array $data): int
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
            if (isset($data[$field])) {
                $metaId = $this->haveOrderMetaInDatabase($orderId, $metaKey, $data[$field]);
            }
        }

        return $metaId;
    }

    public function getAdminOrderEditUrl(int $orderId): string
    {
        return "post.php?post={$orderId}&action=edit";
    }

    public function getTableName(): string
    {
        return $this->wpDb->grabPostsTableName();
    }

    public function getMetaTableName(): string
    {
        return $this->wpDb->grabPostMetaTableName();
    }

    public function getMetaIdColumnName(): string
    {
        return 'post_id';
    }

    public function mapCriteria(array $criteria): array
    {
        $mapped = [];

        // Map HPOS field names to legacy field names
        foreach ($criteria as $key => $value) {
            if ($key === 'status') {
                $mapped['post_status'] = $value;
            } elseif ($key === 'title') {
                $mapped['post_title'] = $value;
            } elseif ($key === 'id') {
                $mapped['ID'] = $value;
            } else {
                $mapped[$key] = $value;
            }
        }

        return $mapped;
    }

    public function mapAddressCriteria(string $type, array $criteria): array
    {
        $mapped = [];
        $prefix = '_' . $type . '_';

        foreach ($criteria as $key => $value) {
            $prefixedKey = str_starts_with($key, $prefix) ? $key : $prefix . $key;
            $mapped[$prefixedKey] = $value;
        }

        return $mapped;
    }

    public function seeAddressInDatabase(string $addressType, array $criteria): void
    {
        $mapped = $this->mapAddressCriteria($addressType, $criteria);

        foreach ($mapped as $metaKey => $metaValue) {
            $this->wpDb->seeInDatabase(
                $this->getMetaTableName(),
                [
                    'meta_key' => $metaKey,
                    'meta_value' => $metaValue,
                ]
            );
        }
    }

    public function mapMetaCriteria(array $criteria): array
    {
        $mapped = $criteria;
        if (isset($mapped['order_id'])) {
            $mapped['post_id'] = $mapped['order_id'];
            unset($mapped['order_id']);
        }
        return $mapped;
    }

    public function getIdColumnName(): string
    {
        return 'ID';
    }

    public function getOrderAddressTableName(): string
    {
        return $this->getMetaTableName();
    }
}
