<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use lucatume\WPBrowser\Module\WPDb;

trait CustomerMethods
{
    abstract protected function wpDb(): WPDb;

    public function haveCustomerInDatabase(array $overrides = []): int
    {
        $billing = $overrides['billing'] ?? [];
        $shipping = $overrides['shipping'] ?? [];
        $meta = $overrides['meta'] ?? [];

        unset($overrides['billing'], $overrides['shipping'], $overrides['meta']);

        $userLogin = $overrides['user_login'] ?? 'customer';
        $userEmail = $overrides['user_email'] ?? $userLogin . '@example.com';
        $userRole  = $overrides['role'] ?? 'subscriber';

        unset($overrides['user_login'], $overrides['user_email'], $overrides['role']);

        $userData = array_merge([
            'user_login' => $userLogin,
            'user_email' => $userEmail,
            'role'       => $userRole,
        ], $overrides);

        $userId = $this->wpDb()->haveUserInDatabase(
            $userData['user_login'],
            $userData['role'],
            ['user_email' => $userData['user_email'], ...$overrides]
        );

        foreach ($billing as $key => $value) {
            $this->wpDb()->haveUserMetaInDatabase($userId, 'billing_' . $key, $value);
        }

        foreach ($shipping as $key => $value) {
            $this->wpDb()->haveUserMetaInDatabase($userId, 'shipping_' . $key, $value);
        }

        foreach ($meta as $key => $value) {
            $this->wpDb()->haveUserMetaInDatabase($userId, $key, $value);
        }

        return $userId;
    }

    public function grabCustomerFieldFromDatabase(int $customerId, string $field): mixed
    {
        return $this->wpDb()->grabFromDatabase($this->wpDb()->grabUsersTableName(), $field, ['ID' => $customerId]);
    }

    public function grabCustomerMeta(int $customerId, string $key, bool $single = false): mixed
    {
        return $this->wpDb()->grabUserMetaFromDatabase($customerId, $key, $single);
    }

    public function grabCustomerBillingAddress(int $customerId): array
    {
        $billingFields = [
            'first_name',
            'last_name',
            'company',
            'address_1',
            'address_2',
            'city',
            'state',
            'postcode',
            'country',
            'email',
            'phone',
        ];

        $address = [];
        foreach ($billingFields as $field) {
            $value = $this->grabCustomerMeta($customerId, 'billing_' . $field, true);
            if ($value !== '') {
                $address[$field] = $value;
            }
        }

        return $address;
    }

    public function grabCustomerShippingAddress(int $customerId): array
    {
        $shippingFields = [
            'first_name',
            'last_name',
            'company',
            'address_1',
            'address_2',
            'city',
            'state',
            'postcode',
            'country',
        ];

        $address = [];
        foreach ($shippingFields as $field) {
            $value = $this->grabCustomerMeta($customerId, 'shipping_' . $field, true);
            if ($value !== '') {
                $address[$field] = $value;
            }
        }

        return $address;
    }

    public function seeCustomerInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUsersTableName();
        $this->wpDb()->seeInDatabase($table, $criteria);
    }

    public function dontSeeCustomerInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUsersTableName();
        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    public function haveCustomerMetaInDatabase(int $customerId, string $metaKey, mixed $metaValue): int
    {
        $ids = $this->wpDb()->haveUserMetaInDatabase($customerId, $metaKey, $metaValue);

        return array_shift($ids);
    }

    public function haveCustomerBillingFieldInDatabase(int $customerId, string $field, mixed $value): int
    {
        return $this->haveCustomerMetaInDatabase($customerId, 'billing_' . $field, $value);
    }

    public function haveCustomerShippingFieldInDatabase(int $customerId, string $field, mixed $value): int
    {
        return $this->haveCustomerMetaInDatabase($customerId, 'shipping_' . $field, $value);
    }

    public function seeCustomerBillingFieldInDatabase(int $customerId, string $field, mixed $value): void
    {
        $this->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'billing_' . $field,
            'meta_value' => $value,
        ]);
    }

    public function seeCustomerShippingFieldInDatabase(int $customerId, string $field, mixed $value): void
    {
        $this->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'shipping_' . $field,
            'meta_value' => $value,
        ]);
    }

    public function seeCustomerMetaInDatabase(array $criteria): void
    {
        // Validate if using customer_id or user_id format
        if (isset($criteria['customer_id'])) {
            $criteria['user_id'] = $criteria['customer_id'];
            unset($criteria['customer_id']);
        }
        // If user_id is already set, use it as is

        $this->wpDb()->seeUserMetaInDatabase($criteria);
    }

    public function dontSeeCustomerMetaInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUserMetaTableName();
        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    public function grabCustomerIdFromDatabase(array $criteria): int|false
    {
        $id = $this->wpDb()->grabFromDatabase(
            $this->wpDb()->grabUsersTableName(),
            'ID',
            $criteria
        );

        if ($id === false) {
            return false;
        }

        return (int)$id;
    }
}
