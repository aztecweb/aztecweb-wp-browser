<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Storage;

trait HPOSStorageTrait
{
    protected function grabWcOrdersTableName(): string
    {
        return $this->wpDb->grabTablePrefix() . 'wc_orders';
    }

    protected function generateId(): int
    {
        $maxOrderId = $this->wpDb->grabLatestEntryByFromDatabase($this->grabWcOrdersTableName(), 'id');
        $maxPostId = $this->wpDb->grabLatestEntryByFromDatabase($this->wpDb->grabPostsTableName(), 'ID');

        return max($maxOrderId, $maxPostId) + 1;
    }
}
