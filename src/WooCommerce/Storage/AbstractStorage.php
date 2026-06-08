<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

use lucatume\WPBrowser\Module\WPDb;

abstract class AbstractStorage implements WooCommerceStorageInterface
{
    public function __construct(protected WPDb $wpDb)
    {
    }

    abstract protected function getEntityIdKey(): string;

    public function getMetaTableName(): string
    {
        return $this->wpDb->grabPostMetaTableName();
    }

    /**
     * Map meta query criteria to storage format.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapMetaCriteria(array $criteria): array
    {
        $entityKey = $this->getEntityIdKey();
        if (isset($criteria[$entityKey])) {
            $criteria['post_id'] = $criteria[$entityKey];
            unset($criteria[$entityKey]);
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
