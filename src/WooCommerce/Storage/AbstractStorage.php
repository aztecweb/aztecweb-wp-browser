<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

use lucatume\WPBrowser\Module\WPDb;

abstract class AbstractStorage implements WooCommerceStorageInterface
{
    /**
     * Meta ID columns used across the storages, accepted as aliases in meta criteria.
     */
    private const META_ID_COLUMNS = ['post_id', 'order_id'];

    public function __construct(protected WPDb $wpDb)
    {
    }

    abstract protected function getEntityIdKey(): string;

    public function getMetaTableName(): string
    {
        return $this->wpDb->grabPostMetaTableName();
    }

    public function getMetaIdColumnName(): string
    {
        return 'post_id';
    }

    /**
     * Map meta query criteria to storage format.
     *
     * Entity-specific keys ('order_id', 'subscription_id') and the meta ID columns
     * of the other storages are all normalized to this storage's meta ID column,
     * so criteria stay storage-agnostic.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapMetaCriteria(array $criteria): array
    {
        $metaIdColumn = $this->getMetaIdColumnName();

        foreach ([$this->getEntityIdKey(), ...self::META_ID_COLUMNS] as $alias) {
            if ($alias === $metaIdColumn || !isset($criteria[$alias])) {
                continue;
            }

            $criteria[$metaIdColumn] = $criteria[$alias];
            unset($criteria[$alias]);
        }

        return $criteria;
    }

    protected function grabEntityMeta(int $entityId, string $key, bool $single = false): mixed
    {
        return $this->wpDb->grabPostMetaFromDatabase($entityId, $key, $single);
    }

    protected function haveEntityMetaInDatabase(int $entityId, string $key, mixed $value): int
    {
        return $this->wpDb->havePostMetaInDatabase($entityId, $key, $value);
    }
}
