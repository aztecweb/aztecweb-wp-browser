<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Browser;

/**
 * Maps an order to its admin edit URL based on the declared store-order
 * storage mode.
 *
 * Pure and DB-free by design: the browser layer never inspects the system
 * under test to decide how to build a URL. The storage mode is declared via
 * the `legacyOrderStorage` config flag and passed in. See ADR-0008.
 */
final class AdminOrderUrlResolver
{
    /**
     * Build the admin order edit URL for the given order.
     *
     * @param int  $orderId            The order ID.
     * @param bool $legacyOrderStorage Whether orders use legacy (wp_posts)
     *                                 storage; `false` means HPOS.
     * @return string The admin page URL (relative to the admin path).
     */
    public function resolve(int $orderId, bool $legacyOrderStorage): string
    {
        return $legacyOrderStorage
            ? "post.php?post={$orderId}&action=edit"
            : "admin.php?page=wc-orders&action=edit&id={$orderId}";
    }
}
