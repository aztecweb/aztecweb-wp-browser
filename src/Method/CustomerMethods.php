<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Method;

use Aztec\WPBrowser\Config\WooCommerceConfig;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

trait CustomerMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;

    abstract protected function wpDb(): WPDb;

    abstract protected function wooCommerceConfig(): WooCommerceConfig;

    public function haveCustomerInDatabase(array $data = []): int
    {
        $billing = $data['billing'] ?? [];
        $shipping = $data['shipping'] ?? [];
        $meta = $data['meta'] ?? [];

        unset($data['billing'], $data['shipping'], $data['meta']);

        $userLogin = $data['user_login'] ?? 'customer';
        $userEmail = $data['user_email'] ?? $userLogin . '@example.com';
        $userRole  = $data['role'] ?? 'subscriber';

        unset($data['user_login'], $data['user_email'], $data['role']);

        $userData = array_merge([
            'user_login' => $userLogin,
            'user_email' => $userEmail,
            'role'       => $userRole,
        ], $data);

        $userId = $this->wpDb()->haveUserInDatabase(
            $userData['user_login'],
            $userData['role'],
            ['user_email' => $userData['user_email'], ...$data]
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
        $table = $this->wpDb()->grabUserMetaTableName();
        $this->wpDb()->seeInDatabase($table, $criteria);
    }

    public function dontSeeCustomerMetaInDatabase(array $criteria): void
    {
        $table = $this->wpDb()->grabUserMetaTableName();
        $this->wpDb()->dontSeeInDatabase($table, $criteria);
    }

    
    public function amOnMyAccountPage(): void
    {
        $this->wpWebDriver()->amOnPage($this->wooCommerceConfig()->myAccountPageSlug());
    }
}
