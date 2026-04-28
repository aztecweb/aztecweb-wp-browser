<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Storage;

use lucatume\WPBrowser\Module\WPDb;

abstract class AbstractLegacyStorage implements WooCommerceStorageInterface
{
    public function __construct(protected WPDb $wpDb) {}

    abstract protected function getEntityIdKey(): string;

    public function getTableName(): string
    {
        return $this->wpDb->grabPostsTableName();
    }

    public function getMetaTableName(): string
    {
        return $this->wpDb->grabPostMetaTableName();
    }

    public function getIdColumnName(): string
    {
        return 'ID';
    }

    public function mapCriteria(array $criteria): array
    {
        $mapped = [];
        foreach ($criteria as $key => $value) {
            if ($key === 'status') {
                $mapped['post_status'] = $value;
            } elseif ($key === 'id') {
                $mapped['ID'] = $value;
            } else {
                $mapped[$key] = $value;
            }
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
            $this->wpDb->grabPostsTableName(),
            'post_status',
            ['ID' => $entityId]
        );
    }

    protected function haveEntityStatus(int $entityId, string $status): void
    {
        $this->wpDb->updateInDatabase(
            $this->wpDb->grabPostsTableName(),
            ['post_status' => $status],
            ['ID' => $entityId]
        );
    }
}
