<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Storage;

use lucatume\WPBrowser\Module\WPDb;

abstract class AbstractHPOSStorage implements WooCommerceStorageInterface
{
    use HPOSStorageTrait;

    public function __construct(protected WPDb $wpDb) {}

    abstract protected function getEntityIdKey(): string;

    public function getTableName(): string
    {
        return $this->grabWcOrdersTableName();
    }

    public function getMetaTableName(): string
    {
        return $this->wpDb->grabPostMetaTableName();
    }

    public function getIdColumnName(): string
    {
        return 'id';
    }

    public function mapCriteria(array $criteria): array
    {
        $mapped = [];
        foreach ($criteria as $key => $value) {
            $mapped[$key === 'post_status' ? 'status' : $key] = $value;
        }
        return $mapped;
    }

    public function mapMetaCriteria(array $criteria): array
    {
        $mapped = $criteria;
        $entityKey = $this->getEntityIdKey();
        if (isset($mapped[$entityKey])) {
            $mapped['post_id'] = $mapped[$entityKey];
            unset($mapped[$entityKey]);
        }
        return $mapped;
    }

    protected function grabEntityMeta(int $entityId, string $key, bool $single = false): mixed
    {
        return $this->wpDb->grabPostMetaFromDatabase($entityId, $key, $single);
    }

    protected function haveEntityMetaInDatabase(int $entityId, string $key, mixed $value): int
    {
        return $this->wpDb->havePostMetaInDatabase($entityId, $key, $value);
    }

    protected function grabEntityStatus(int $entityId): string
    {
        return (string) $this->wpDb->grabFromDatabase(
            $this->grabWcOrdersTableName(),
            'status',
            ['id' => $entityId]
        );
    }

    protected function haveEntityStatus(int $entityId, string $status): void
    {
        $this->wpDb->updateInDatabase(
            $this->grabWcOrdersTableName(),
            ['status' => $status],
            ['id' => $entityId]
        );
    }
}
