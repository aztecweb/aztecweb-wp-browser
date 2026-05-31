<?php
/**
 * Plugin Name: Test Environment Quiesce
 * Description: Disables background/loopback admin traffic that deadlocks the
 *   single-worker PHP built-in server during acceptance tests.
 */

// --- Action Scheduler: stop the async queue runner (the admin-ajax loopback).
add_filter( 'action_scheduler_allow_async_request_runner', '__return_false' );

// --- WordPress Site Health: stop all loopback / async status checks. ---
add_filter( 'site_status_tests', '__return_empty_array' );
add_filter( 'site_status_test_php_modules', '__return_empty_array' );

// Remove the Site Health dashboard widget that triggers the async loopback test.
add_action( 'wp_dashboard_setup', static function () {
    remove_meta_box( 'dashboard_site_health', 'dashboard', 'normal' );
}, 99 );

// Belt-and-braces: short-circuit the loopback test endpoint itself so it can
// never fire a server-to-server request even if invoked directly.
add_action( 'admin_init', static function () {
    remove_action( 'wp_ajax_health-check-loopback-requests', 'wp_ajax_health_check_loopback_requests' );
}, 1 );

// --- WordPress heartbeat API (continuous admin-ajax polling). ---
add_action( 'init', static function () {
    wp_deregister_script( 'heartbeat' );
}, 1 );
