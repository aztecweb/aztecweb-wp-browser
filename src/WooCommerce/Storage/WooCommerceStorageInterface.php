<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

interface WooCommerceStorageInterface
{
    public function getTableName(): string;

    public function getMetaTableName(): string;

    public function getIdColumnName(): string;

    public function mapCriteria(array $criteria): array;

    public function mapMetaCriteria(array $criteria): array;
}
