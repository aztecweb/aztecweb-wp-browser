<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\SubscriptionStorage;

use Aztec\WPBrowser\WooCommerce\Storage\AbstractHPOSStorage;

class HPOSSubscriptionStorage extends AbstractHPOSStorage implements SubscriptionStorageInterface
{
    protected function getEntityIdKey(): string
    {
        return 'subscription_id';
    }

    /**
     * Create a subscription in the database.
     *
     * @param array<string, mixed> $overrides Database row overrides and metadata.
     * @return int The subscription ID.
     */
    public function haveSubscriptionInDatabase(array $overrides): int
    {
        $meta = is_array($overrides['meta'] ?? null) ? $overrides['meta'] : [];
        unset($overrides['meta']);

        $subscriptionId = $this->generateId();

        $subscriptionData = array_merge([
            'id' => $subscriptionId,
            'status' => 'wc-active',
            'currency' => 'USD',
            'type' => 'shop_subscription',
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

        $subscriptionData['id'] = $subscriptionId;
        $subscriptionData['type'] = 'shop_subscription';

        $this->wpDb->haveInDatabase($this->grabWcOrdersTableName(), $subscriptionData);

        $finalMeta = array_merge([
            '_billing_period' => 'month',
            '_billing_interval' => '1',
            '_subscription_start_date' => gmdate('Y-m-d H:i:s'),
            '_subscription_expiry_date' => '0',
            '_subscription_end_date' => '0',
        ], $meta);

        foreach ($finalMeta as $key => $value) {
            $this->haveSubscriptionMetaInDatabase($subscriptionId, $key, $value);
        }

        return $subscriptionId;
    }

    public function haveSubscriptionMetaInDatabase(int $subscriptionId, string $key, mixed $value): int
    {
        return $this->haveEntityMetaInDatabase($subscriptionId, $key, $value);
    }

    public function grabSubscriptionMeta(int $subscriptionId, string $key, bool $single = false): mixed
    {
        return $this->grabEntityMeta($subscriptionId, $key, $single);
    }

    public function grabSubscriptionStatus(int $subscriptionId): string
    {
        return $this->grabEntityStatus($subscriptionId);
    }

    public function haveSubscriptionStatus(int $subscriptionId, string $status): void
    {
        $this->haveEntityStatus($subscriptionId, $status);
    }

    public function mapCriteria(array $criteria): array
    {
        $mapped = [];
        foreach ($criteria as $key => $value) {
            if ($key === 'post_status') {
                $mapped['status'] = $value;
            } elseif ($key === 'ID') {
                $mapped['id'] = $value;
            } else {
                $mapped[$key] = $value;
            }
        }
        $mapped['type'] = 'shop_subscription';
        return $mapped;
    }
}
