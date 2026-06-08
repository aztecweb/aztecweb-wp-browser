<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

interface WooCommerceStorageInterface
{
    public function getTableName(): string;

    public function getMetaTableName(): string;

    public function getIdColumnName(): string;

    /**
     * Map query criteria to storage format.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapCriteria(array $criteria): array;

    /**
     * Map meta query criteria to storage format.
     *
     * @param array<string, mixed> $criteria Database query criteria.
     * @return array<string, mixed> Mapped criteria.
     */
    public function mapMetaCriteria(array $criteria): array;
}
