<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Unit\WooCommerce\Storage;

use Aztec\WPBrowser\WooCommerce\OrderStorage\HPOSOrderStorage;
use Aztec\WPBrowser\WooCommerce\OrderStorage\LegacyOrderStorage;
use Aztec\WPBrowser\WooCommerce\Storage\WooCommerceStorageInterface;
use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\HPOSSubscriptionStorage;
use Aztec\WPBrowser\WooCommerce\SubscriptionStorage\LegacySubscriptionStorage;
use Codeception\Test\Unit;
use lucatume\WPBrowser\Module\WPDb;

class MapMetaCriteriaTest extends Unit
{
    public function testHposOrderKeepsTheOrderIdCriterion(): void
    {
        $mapped = $this->storage(HPOSOrderStorage::class)->mapMetaCriteria([
            'order_id' => 123,
            'meta_key' => '_custom_field',
        ]);

        $this->assertSame(['order_id' => 123, 'meta_key' => '_custom_field'], $mapped);
    }

    public function testLegacyOrderMapsOrderIdToPostId(): void
    {
        $mapped = $this->storage(LegacyOrderStorage::class)->mapMetaCriteria([
            'order_id' => 123,
            'meta_key' => '_custom_field',
        ]);

        $this->assertSame(['meta_key' => '_custom_field', 'post_id' => 123], $mapped);
    }

    public function testHposSubscriptionMapsSubscriptionIdToOrderId(): void
    {
        $mapped = $this->storage(HPOSSubscriptionStorage::class)->mapMetaCriteria([
            'subscription_id' => 456,
            'meta_key' => '_billing_period',
        ]);

        $this->assertSame(['meta_key' => '_billing_period', 'order_id' => 456], $mapped);
    }

    public function testLegacySubscriptionMapsSubscriptionIdToPostId(): void
    {
        $mapped = $this->storage(LegacySubscriptionStorage::class)->mapMetaCriteria([
            'subscription_id' => 456,
            'meta_key' => '_billing_period',
        ]);

        $this->assertSame(['meta_key' => '_billing_period', 'post_id' => 456], $mapped);
    }

    public function testHposStoragesAcceptPostIdAsAlias(): void
    {
        $this->assertSame(
            ['order_id' => 123],
            $this->storage(HPOSOrderStorage::class)->mapMetaCriteria(['post_id' => 123]),
        );

        $this->assertSame(
            ['order_id' => 456],
            $this->storage(HPOSSubscriptionStorage::class)->mapMetaCriteria(['post_id' => 456]),
        );
    }

    public function testLegacyStoragesKeepPostIdAsIs(): void
    {
        $this->assertSame(
            ['post_id' => 123],
            $this->storage(LegacyOrderStorage::class)->mapMetaCriteria(['post_id' => 123]),
        );

        $this->assertSame(
            ['post_id' => 456],
            $this->storage(LegacySubscriptionStorage::class)->mapMetaCriteria(['post_id' => 456]),
        );
    }

    public function testCriteriaWithoutAnIdAreLeftUntouched(): void
    {
        foreach ($this->allStorages() as $storage) {
            $this->assertSame(
                ['meta_key' => '_custom_field', 'meta_value' => 'value'],
                $storage->mapMetaCriteria(['meta_key' => '_custom_field', 'meta_value' => 'value']),
            );
        }
    }

    public function testEveryStorageMapsOntoItsOwnMetaIdColumn(): void
    {
        foreach ($this->allStorages() as $storage) {
            $mapped = $storage->mapMetaCriteria(['post_id' => 1, 'order_id' => 1, 'meta_key' => '_k']);

            $this->assertArrayHasKey($storage->getMetaIdColumnName(), $mapped);
            $this->assertSame(1, $mapped[$storage->getMetaIdColumnName()]);
        }
    }

    /**
     * @return array<int, WooCommerceStorageInterface>
     */
    private function allStorages(): array
    {
        return [
            $this->storage(HPOSOrderStorage::class),
            $this->storage(LegacyOrderStorage::class),
            $this->storage(HPOSSubscriptionStorage::class),
            $this->storage(LegacySubscriptionStorage::class),
        ];
    }

    /**
     * @param class-string<WooCommerceStorageInterface> $storageClass
     */
    private function storage(string $storageClass): WooCommerceStorageInterface
    {
        return new $storageClass($this->createMock(WPDb::class));
    }
}
