<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use lucatume\WPBrowser\Module\WPDb;

trait CustomerMethods
{
    abstract protected function wpDb(): WPDb;

    /**
     * Create a customer (user) in the database.
     *
     * @param array<string, mixed> $overrides Database row overrides and metadata.
     * @return int The user ID.
     */
    public function haveCustomerInDatabase(array $overrides = []): int
    {
        $billing = is_array($overrides['billing'] ?? null) ? $overrides['billing'] : [];
        $shipping = is_array($overrides['shipping'] ?? null) ? $overrides['shipping'] : [];
        $meta = is_array($overrides['meta'] ?? null) ? $overrides['meta'] : [];

        unset($overrides['billing'], $overrides['shipping'], $overrides['meta']);

        $userLoginValue = $overrides['user_login'] ?? 'customer';
        $userLogin = is_string($userLoginValue) ? $userLoginValue : 'customer';

        $userEmailValue = $overrides['user_email'] ?? null;
        $userEmail = is_string($userEmailValue) ? $userEmailValue : $userLogin . '@example.com';

        $userRoleValue = $overrides['role'] ?? 'subscriber';
        $userRole = is_string($userRoleValue) ? $userRoleValue : 'subscriber';

        unset($overrides['user_login'], $overrides['user_email'], $overrides['role']);

        $userData = array_merge([
            'user_login' => $userLogin,
            'user_email' => $userEmail,
            'role'       => $userRole,
        ], $overrides);

        $userId = $this->wpDb()->haveUserInDatabase(
            $userLogin,
            $userRole,
            ['user_email' => $userEmail, ...$overrides]
        );

        foreach ($billing as $key => $value) {
            if (is_string($key)) {
                $this->wpDb()->haveUserMetaInDatabase($userId, 'billing_' . $key, $value);
            }
        }

        foreach ($shipping as $key => $value) {
            if (is_string($key)) {
                $this->wpDb()->haveUserMetaInDatabase($userId, 'shipping_' . $key, $value);
            }
        }

        foreach ($meta as $key => $value) {
            if (is_string($key)) {
                $this->wpDb()->haveUserMetaInDatabase($userId, $key, $value);
            }
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

    /**
     * @return array<string, mixed>
     */
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

    /**
     * @return array<string, mixed>
     */
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

    /**
     * Assert a customer (user) exists in the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     */
    public function seeCustomerInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUsersTableName();
        $this->wpDb()->seeInDatabase($table, $criteria);
    }

    /**
     * Assert a customer (user) does not exist in the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     */
    public function dontSeeCustomerInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUsersTableName();
        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    public function haveCustomerMetaInDatabase(int $customerId, string $metaKey, mixed $metaValue): int
    {
        $ids = $this->wpDb()->haveUserMetaInDatabase($customerId, $metaKey, $metaValue);

        $firstId = array_shift($ids);
        return is_int($firstId) ? $firstId : 0;
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

    /**
     * Assert customer meta exists in the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     */
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

    /**
     * Assert customer meta does not exist in the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     */
    public function dontSeeCustomerMetaInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUserMetaTableName();
        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    /**
     * Get a customer (user) ID from the database.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     * @return int|false The user ID, or false if not found.
     */
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

        return is_numeric($id) ? (int)$id : false;
    }
}
