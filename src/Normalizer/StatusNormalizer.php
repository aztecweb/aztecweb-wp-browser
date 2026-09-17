<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Normalizer;

final class StatusNormalizer
{
    /**
     * @var list<string>
     */
    private const KNOWN_STATUSES = [
        'pending',
        'processing',
        'on-hold',
        'completed',
        'cancelled',
        'refunded',
        'failed',
        'checkout-draft',
        'active',
        'expired',
        'pending-cancel',
        'switched',
    ];

    /**
     * Prefixes a WooCommerce status with `wc-` when it is a known status without the prefix.
     *
     * This is not validation: statuses that are already prefixed, or that are not part of the
     * known WooCommerce allowlist (e.g. `trash`, or a third-party plugin status), pass through
     * unchanged so they are not corrupted.
     */
    public static function normalize(string $status): string
    {
        if (in_array($status, self::KNOWN_STATUSES, true)) {
            return "wc-{$status}";
        }

        return $status;
    }
}
