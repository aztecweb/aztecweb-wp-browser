<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

use lucatume\WPBrowser\Utils\Serializer;

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

    public function getMetaTableName(): string
    {
        return $this->grabWcOrdersMetaTableName();
    }

    public function getMetaIdColumnName(): string
    {
        return 'order_id';
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

    protected function grabEntityMeta(int $entityId, string $key, bool $single = false): mixed
    {
        $grabbed = $this->wpDb->grabColumnFromDatabase(
            $this->grabWcOrdersMetaTableName(),
            'meta_value',
            [$this->getMetaIdColumnName() => $entityId, 'meta_key' => $key],
        );

        $values = array_reduce($grabbed, static function (array $metaValues, $value): array {
            $values = (array)Serializer::maybeUnserialize($value);
            array_push($metaValues, ...$values);
            return $metaValues;
        }, []);

        return $single ? $values[0] : $values;
    }

    protected function haveEntityMetaInDatabase(int $entityId, string $key, mixed $value): int
    {
        return $this->wpDb->haveInDatabase($this->grabWcOrdersMetaTableName(), [
            $this->getMetaIdColumnName() => $entityId,
            'meta_key' => $key,
            'meta_value' => Serializer::maybeSerialize($value),
        ]);
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
