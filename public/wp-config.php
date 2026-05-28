<?php

declare(strict_types=1);

$envOr = static function (string $key, string $default): string {
    $value = getenv($key);

    return $value === false || $value === '' ? $default : (string) $value;
};

if (!defined('DB_ENGINE')) {
    define('DB_ENGINE', $envOr('DB_ENGINE', 'sqlite'));
}
define('DB_NAME', $envOr('DB_NAME', 'wordpress'));
define('DB_USER', $envOr('DB_USER', 'wordpress'));
define('DB_PASSWORD', $envOr('DB_PASSWORD', 'wordpress'));
define('DB_HOST', $envOr('DB_HOST', '127.0.0.1'));
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

$tablePrefix = $envOr('DB_TABLE_PREFIX', 'wp_');
$table_prefix = $tablePrefix;

define('WP_HOME', $envOr('WP_HOME', 'http://localhost:8080'));
define('WP_SITEURL', WP_HOME . '/wp');

define('WP_CONTENT_DIR', __DIR__ . '/packages');
define('WP_CONTENT_URL', WP_HOME . '/packages');

define('AUTH_KEY',         $envOr('AUTH_KEY', 'aztec-wp-browser-test-key'));
define('SECURE_AUTH_KEY',  $envOr('SECURE_AUTH_KEY', 'aztec-wp-browser-test-key'));
define('LOGGED_IN_KEY',    $envOr('LOGGED_IN_KEY', 'aztec-wp-browser-test-key'));
define('NONCE_KEY',        $envOr('NONCE_KEY', 'aztec-wp-browser-test-key'));
define('AUTH_SALT',        $envOr('AUTH_SALT', 'aztec-wp-browser-test-salt'));
define('SECURE_AUTH_SALT', $envOr('SECURE_AUTH_SALT', 'aztec-wp-browser-test-salt'));
define('LOGGED_IN_SALT',   $envOr('LOGGED_IN_SALT', 'aztec-wp-browser-test-salt'));
define('NONCE_SALT',       $envOr('NONCE_SALT', 'aztec-wp-browser-test-salt'));

define('WP_DEBUG', filter_var($envOr('WP_DEBUG', 'true'), FILTER_VALIDATE_BOOLEAN));
define('WP_DEBUG_LOG', filter_var($envOr('WP_DEBUG_LOG', 'false'), FILTER_VALIDATE_BOOLEAN));
define('WP_DEBUG_DISPLAY', filter_var($envOr('WP_DEBUG_DISPLAY', 'false'), FILTER_VALIDATE_BOOLEAN));

define('DISABLE_WP_CRON', true);
define('WP_ENVIRONMENT_TYPE', 'local');

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/wp/');
}

require_once ABSPATH . 'wp-settings.php';
