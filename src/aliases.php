<?php

declare(strict_types=1);

(static function (): void {
    $aliases = [
        'Codeception\\Module\\WooCommerceDb' => \Aztec\WPBrowser\WooCommerce\Module\WooCommerceDb::class,
        'Codeception\\Module\\WooCommerceWebDriver' => \Aztec\WPBrowser\WooCommerce\Module\WooCommerceWebDriver::class,
    ];

    foreach ($aliases as $alias => $target) {
        if (class_exists($alias, false)) {
            trigger_error(
                sprintf(
                    'aztecweb/aztecweb-wp-browser: short-name alias %s is already registered; '
                    . 'skipping. Reference %s by its fully-qualified class name in suite.yml.',
                    $alias,
                    $target,
                ),
                E_USER_WARNING,
            );
            continue;
        }

        class_alias($target, $alias);
    }
})();
