<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use lucatume\WPBrowser\Module\WPDb;

trait CustomerMethods
{
    abstract protected function wpDb(): WPDb;

    /**
     * Create a customer (user) in the database with optional billing and shipping addresses.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase([
     *     'user_login' => 'johndoe',
     *     'user_email' => 'john@example.com',
     *     'billing' => [
     *         'first_name' => 'John',
     *         'address_1' => '123 Main St',
     *     ],
     *     'shipping' => [
     *         'first_name' => 'John',
     *         'address_1' => '456 Oak Ave',
     *     ],
     * ]);
     * ```
     *
     * @param array<string, mixed> $overrides Database row overrides, billing/shipping addresses, and metadata. Special keys: 'billing' (address array), 'shipping' (address array), 'meta' (metadata array), 'role' (user role)
     *
     * @return int The created user ID
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
            ['user_email' => $userEmail, ...$overrides],
        );

        foreach ($billing as $key => $value) {
            if (!is_string($key)) {
                continue;
            }

            $this->wpDb()->haveUserMetaInDatabase($userId, 'billing_' . $key, $value);
        }

        foreach ($shipping as $key => $value) {
            if (!is_string($key)) {
                continue;
            }

            $this->wpDb()->haveUserMetaInDatabase($userId, 'shipping_' . $key, $value);
        }

        foreach ($meta as $key => $value) {
            if (!is_string($key)) {
                continue;
            }

            $this->wpDb()->haveUserMetaInDatabase($userId, $key, $value);
        }

        return $userId;
    }

    /**
     * Extract a field value from a customer (user) record in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase(['user_login' => 'testuser']);
     * $email = $I->grabCustomerFieldFromDatabase($customerId, 'user_email');
     * $I->assertStringContainsString('@example.com', $email);
     * ```
     *
     * @param int    $customerId  Customer (user) ID
     * @param string $field       Database field name to retrieve (e.g., 'user_email', 'user_login')
     *
     * @return mixed Field value from the customer record
     */
    public function grabCustomerFieldFromDatabase(int $customerId, string $field): mixed
    {
        return $this->wpDb()->grabFromDatabase($this->wpDb()->grabUsersTableName(), $field, ['ID' => $customerId]);
    }

    /**
     * Extract a meta value from a customer (user) record in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->haveCustomerMetaInDatabase($customerId, '_preferred_language', 'en_US');
     * $language = $I->grabCustomerMeta($customerId, '_preferred_language', true);
     * $I->assertSame('en_US', $language);
     * ```
     *
     * @param int    $customerId  Customer (user) ID
     * @param string $key         Meta key to retrieve
     * @param bool   $single      Whether to return a single value (true) or array of values (false)
     *
     * @return mixed Meta value or array of values
     */
    public function grabCustomerMeta(int $customerId, string $key, bool $single = false): mixed
    {
        return $this->wpDb()->grabUserMetaFromDatabase($customerId, $key, $single);
    }

    /**
     * Extract all billing address fields for a customer.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->haveCustomerBillingFieldInDatabase($customerId, 'first_name', 'John');
     * $I->haveCustomerBillingFieldInDatabase($customerId, 'email', 'john@example.com');
     * $address = $I->grabCustomerBillingAddress($customerId);
     * $I->assertArrayHasKey('first_name', $address);
     * ```
     *
     * @param int $customerId  Customer (user) ID
     *
     * @return array<string, mixed> Billing address fields (first_name, last_name, company, address_1, address_2, city, state, postcode, country, email, phone)
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
            if ($value === '') {
                continue;
            }

            $address[$field] = $value;
        }

        return $address;
    }

    /**
     * Extract all shipping address fields for a customer.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->haveCustomerShippingFieldInDatabase($customerId, 'first_name', 'Jane');
     * $I->haveCustomerShippingFieldInDatabase($customerId, 'address_1', '123 Main St');
     * $address = $I->grabCustomerShippingAddress($customerId);
     * $I->assertArrayHasKey('first_name', $address);
     * ```
     *
     * @param int $customerId  Customer (user) ID
     *
     * @return array<string, mixed> Shipping address fields (first_name, last_name, company, address_1, address_2, city, state, postcode, country)
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
            if ($value === '') {
                continue;
            }

            $address[$field] = $value;
        }

        return $address;
    }

    /**
     * Verify that a customer (user) exists in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase(['user_login' => 'johndoe']);
     * $I->seeCustomerInDatabase(['ID' => $customerId, 'user_login' => 'johndoe']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['ID' => 123, 'user_login' => 'johndoe'])
     *
     * @return void
     */
    public function seeCustomerInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUsersTableName();
        $this->wpDb()->seeInDatabase($table, $criteria);
    }

    /**
     * Verify that a customer (user) does not exist in the database.
     *
     * @example
     * ```php
     * $I->dontSeeCustomerInDatabase(['user_login' => 'nonexistent']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['user_login' => 'johndoe'])
     *
     * @return void
     */
    public function dontSeeCustomerInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUsersTableName();
        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    /**
     * Create a meta entry for a customer (user) in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $metaId = $I->haveCustomerMetaInDatabase($customerId, '_loyalty_points', '500');
     * $I->assertGreaterThan(0, $metaId);
     * ```
     *
     * @param int    $customerId  Customer (user) ID
     * @param string $metaKey     Meta key name
     * @param mixed  $metaValue   Meta value
     *
     * @return int Meta ID of the created entry (0 if creation failed)
     */
    public function haveCustomerMetaInDatabase(int $customerId, string $metaKey, mixed $metaValue): int
    {
        $ids = $this->wpDb()->haveUserMetaInDatabase($customerId, $metaKey, $metaValue);

        $firstId = array_shift($ids);
        return is_int($firstId) ? $firstId : 0;
    }

    /**
     * Create a billing address field for a customer in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->haveCustomerBillingFieldInDatabase($customerId, 'first_name', 'John');
     * $I->haveCustomerBillingFieldInDatabase($customerId, 'address_1', '123 Oak Ave');
     * ```
     *
     * @param int    $customerId  Customer (user) ID
     * @param string $field       Billing field name (e.g., 'first_name', 'address_1')
     * @param mixed  $value       Field value
     *
     * @return int Meta ID of the created entry (0 if creation failed)
     */
    public function haveCustomerBillingFieldInDatabase(int $customerId, string $field, mixed $value): int
    {
        return $this->haveCustomerMetaInDatabase($customerId, 'billing_' . $field, $value);
    }

    /**
     * Create a shipping address field for a customer in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->haveCustomerShippingFieldInDatabase($customerId, 'first_name', 'Jane');
     * $I->haveCustomerShippingFieldInDatabase($customerId, 'address_1', '456 Main St');
     * ```
     *
     * @param int    $customerId  Customer (user) ID
     * @param string $field       Shipping field name (e.g., 'first_name', 'address_1')
     * @param mixed  $value       Field value
     *
     * @return int Meta ID of the created entry (0 if creation failed)
     */
    public function haveCustomerShippingFieldInDatabase(int $customerId, string $field, mixed $value): int
    {
        return $this->haveCustomerMetaInDatabase($customerId, 'shipping_' . $field, $value);
    }

    /**
     * Verify that a customer has a specific billing address field value in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->haveCustomerBillingFieldInDatabase($customerId, 'email', 'john@example.com');
     * $I->seeCustomerBillingFieldInDatabase($customerId, 'email', 'john@example.com');
     * ```
     *
     * @param int    $customerId  Customer (user) ID
     * @param string $field       Billing field name to verify
     * @param mixed  $value       Expected field value
     *
     * @return void
     */
    public function seeCustomerBillingFieldInDatabase(int $customerId, string $field, mixed $value): void
    {
        $this->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'billing_' . $field,
            'meta_value' => $value,
        ]);
    }

    /**
     * Verify that a customer has a specific shipping address field value in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->haveCustomerShippingFieldInDatabase($customerId, 'address_1', '789 Elm St');
     * $I->seeCustomerShippingFieldInDatabase($customerId, 'address_1', '789 Elm St');
     * ```
     *
     * @param int    $customerId  Customer (user) ID
     * @param string $field       Shipping field name to verify
     * @param mixed  $value       Expected field value
     *
     * @return void
     */
    public function seeCustomerShippingFieldInDatabase(int $customerId, string $field, mixed $value): void
    {
        $this->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'shipping_' . $field,
            'meta_value' => $value,
        ]);
    }

    /**
     * Verify that customer meta exists in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->haveCustomerMetaInDatabase($customerId, '_marketing_consent', '1');
     * $I->seeCustomerMetaInDatabase(['user_id' => $customerId, 'meta_key' => '_marketing_consent']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria. Supports 'customer_id' or 'user_id' keys (customer_id is automatically converted to user_id)
     *
     * @return void
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
     * Verify that customer meta does not exist in the database.
     *
     * @example
     * ```php
     * $customerId = $I->haveCustomerInDatabase();
     * $I->dontSeeCustomerMetaInDatabase(['user_id' => $customerId, 'meta_key' => '_unwanted_key']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['user_id' => 123, 'meta_key' => '_key'])
     *
     * @return void
     */
    public function dontSeeCustomerMetaInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUserMetaTableName();
        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    /**
     * Extract a customer (user) ID from the database by query criteria.
     *
     * @example
     * ```php
     * $I->haveCustomerInDatabase(['user_login' => 'johndoe']);
     * $customerId = $I->grabCustomerIdFromDatabase(['user_login' => 'johndoe']);
     * $I->assertGreaterThan(0, $customerId);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['user_login' => 'johndoe'])
     *
     * @return int|false Customer (user) ID if found, false otherwise
     */
    public function grabCustomerIdFromDatabase(array $criteria): int|false
    {
        $id = $this->wpDb()->grabFromDatabase(
            $this->wpDb()->grabUsersTableName(),
            'ID',
            $criteria,
        );

        if ($id === false) {
            return false;
        }

        return is_numeric($id) ? (int)$id : false;
    }
}
