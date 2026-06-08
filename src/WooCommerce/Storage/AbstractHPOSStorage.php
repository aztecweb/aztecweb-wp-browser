<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

abstract class AbstractHPOSStorage extends AbstractStorage
{
    use HPOSStorageTrait;

    public function getTableName(): string
    {
        return $this->grabWcOrdersTableName();
    }

    public function getIdColumnName(): string
    {
        return 'id';
    }

    /**
     * Map criteria to HPOS (wc_orders) format.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapCriteria(array $criteria): array
    {
        $mapped = [];
        foreach ($criteria as $key => $value) {
            $mapped[$key === 'post_status' ? 'status' : $key] = $value;
        }

        return $mapped;
    }

    protected function grabEntityStatus(int $entityId): string
    {
        $status = $this->wpDb->grabFromDatabase(
            $this->grabWcOrdersTableName(),
            'status',
            ['id' => $entityId],
        );
        return is_string($status) ? $status : '';
    }

    protected function haveEntityStatus(int $entityId, string $status): void
    {
        $this->wpDb->updateInDatabase(
            $this->grabWcOrdersTableName(),
            ['status' => $status],
            ['id' => $entityId],
        );
    }
}
