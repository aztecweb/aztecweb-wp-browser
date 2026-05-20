<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\SubscriptionStorage;

use Aztec\WPBrowser\WooCommerce\Storage\WooCommerceStorageInterface;

interface SubscriptionStorageInterface extends WooCommerceStorageInterface
{
    public function haveSubscriptionInDatabase(array $overrides): int;

    public function haveSubscriptionMetaInDatabase(int $subscriptionId, string $key, mixed $value): int;

    public function grabSubscriptionMeta(int $subscriptionId, string $key, bool $single = false): mixed;

    public function grabSubscriptionStatus(int $subscriptionId): string;

    public function haveSubscriptionStatus(int $subscriptionId, string $status): void;
}
