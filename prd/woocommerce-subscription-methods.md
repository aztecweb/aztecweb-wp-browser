# PRD: WooCommerce Subscription Methods

## Overview

Implement a `SubscriptionMethods` trait for the `AztecWPBrowser` module that provides database-level helpers for testing WooCommerce Subscriptions (plugin: `woocommerce-subscriptions`).

## Entity Mapping

| Entity | WP Table | Post Type |
|--------|----------|-----------|
| Subscription | `wp_posts` | `shop_subscription` |
| Subscription Meta | `wp_postmeta` | — |
| Subscription Product | `wp_posts` + `wp_term_relationships` | `product` + `product_type=subscription` |

## Subscription Statuses

WooCommerce Subscriptions uses `wc-` prefixed post statuses:

- `wc-active` — active subscription
- `wc-on-hold` — paused
- `wc-cancelled` — cancelled
- `wc-expired` — expired (end date reached)
- `wc-pending` — awaiting payment
- `wc-pending-cancel` — cancellation scheduled

## Method Deviations from User Request

The following methods were renamed to comply with `lucatume/wp-browser` naming conventions:

| User requested | Convention name | Reason |
|---|---|---|
| `changeSubscriptionStatus($id, $status)` | `haveSubscriptionStatus(int $id, string $status)` | Update methods use `have` prefix |
| `seeSubscriptionMeta($id, $key, $value)` | `seeSubscriptionMetaInDatabase(array $criteria)` | WPDb meta methods take `array $criteria` |
| `grabSubscriptionMeta($id, $key)` | `grabSubscriptionMetaFromDatabase(int $id, string $key, bool $single)` | Grab methods use `FromDatabase` suffix |

## Methods

### Create

- `haveSubscriptionInDatabase(array $data = []): int`
  - Creates a `shop_subscription` post
  - Defaults: `post_status=wc-active`, `_billing_period=month`, `_billing_interval=1`
  - Accepts `meta` key in `$data` for post meta
  - Returns subscription ID

- `haveSubscriptionMetaInDatabase(int $subscriptionId, string $key, mixed $value): int`
  - Delegates to `wpDb()->havePostMetaInDatabase`
  - Returns meta ID

- `haveSubscriptionProductInDatabase(array $data = []): int`
  - Creates a `product` post with `product_type=subscription` taxonomy
  - Defaults: `_subscription_price=10.00`, `_subscription_period=month`, `_subscription_period_interval=1`
  - Accepts `meta` key for overrides
  - Returns product ID

### Retrieve

- `grabSubscriptionIdFromDatabase(array $criteria): int|false`
- `grabSubscriptionFieldFromDatabase(int $id, string $field): mixed`
- `grabSubscriptionMetaFromDatabase(int $subscriptionId, string $key, bool $single = false): mixed`
- `grabSubscriptionStatus(int $subscriptionId): string`

### Verify

- `seeSubscriptionInDatabase(array $criteria): void`
- `seeSubscriptionMetaInDatabase(array $criteria): void` — supports `subscription_id` key (maps to `post_id`)
- `seeSubscriptionStatus(int $subscriptionId, string $status): void`
- `dontSeeSubscriptionInDatabase(array $criteria): void`

### Update

- `haveSubscriptionStatus(int $subscriptionId, string $status): void`
- `cancelSubscription(int $subscriptionId): void` → sets `wc-cancelled`
- `reactivateSubscription(int $subscriptionId): void` → sets `wc-active`
- `expireSubscription(int $subscriptionId): void` → sets `wc-expired`

## Installation Infrastructure

WooCommerce Subscriptions is a premium plugin. The following files are added to support its installation:

- `install-woocommerce-subscriptions.sh` — copies plugin from local zip/directory
- Makefile target `test-install-subscriptions`
- `setup-wordpress.sh` — conditionally activates plugin if present

## Acceptance Tests

All methods covered in `tests/acceptance/SubscriptionCest.php`:
- CRUD operations
- Status transitions (lifecycle)
- Meta operations
- Product creation with subscription type
