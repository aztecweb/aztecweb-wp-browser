<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\SubscriptionStorage;

use Aztec\WPBrowser\WooCommerce\Storage\AbstractLegacyStorage;

class LegacySubscriptionStorage extends AbstractLegacyStorage implements SubscriptionStorageInterface
{
    protected function getEntityIdKey(): string
    {
        return 'subscription_id';
    }

    /**
     * Create a subscription in the database.
     *
     * @param array<string, mixed> $overrides Database row overrides and metadata.
     * @return int The subscription post ID.
     */
    public function haveSubscriptionInDatabase(array $overrides): int
    {
        $meta = is_array($overrides['meta'] ?? null) ? $overrides['meta'] : [];
        unset($overrides['meta']);

        $subscriptionId = $this->wpDb->havePostInDatabase(array_merge([
            'post_type' => 'shop_subscription',
            'post_status' => 'wc-active',
            'post_title' => 'Subscription',
        ], $overrides));

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
}
