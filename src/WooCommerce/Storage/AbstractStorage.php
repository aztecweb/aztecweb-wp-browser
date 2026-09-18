<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

use Aztec\WPBrowser\Normalizer\StatusNormalizer;
use lucatume\WPBrowser\Module\WPDb;

abstract class AbstractStorage implements WooCommerceStorageInterface
{
    public function __construct(protected WPDb $wpDb)
    {
    }

    abstract protected function getEntityIdKey(): string;

    /**
     * Normalize a status value, with an unprefixed WC status accepted.
     *
     * Non-string values pass through unchanged, so callers can hand over a raw override value.
     */
    protected function normalizeStatusValue(mixed $status): mixed
    {
        return is_string($status) ? StatusNormalizer::normalize($status) : $status;
    }

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
