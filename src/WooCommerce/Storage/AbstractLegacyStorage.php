<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

abstract class AbstractLegacyStorage extends AbstractStorage
{
    public function getTableName(): string
    {
        return $this->wpDb->grabPostsTableName();
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

    protected function grabEntityStatus(int $entityId): string
    {
        return (string) $this->wpDb->grabFromDatabase(
            $this->wpDb->grabPostsTableName(),
            'post_status',
            ['ID' => $entityId],
        );
    }

    protected function haveEntityStatus(int $entityId, string $status): void
    {
        $this->wpDb->updateInDatabase(
            $this->wpDb->grabPostsTableName(),
            ['post_status' => $status],
            ['ID' => $entityId],
        );
    }
}
