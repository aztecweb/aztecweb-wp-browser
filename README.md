# aztecweb/aztecweb-wp-browser

High-level Codeception modules for writing WooCommerce acceptance tests on top of
[`lucatume/wp-browser`](https://github.com/lucatume/wp-browser).

This library gives test authors a vocabulary of WooCommerce-aware actor methods —
`haveCouponInDatabase`, `addProductToCart`, `seeOrderStatus` — so you can express
store behaviour directly instead of hand-rolling SQL and CSS selectors. Order
storage (HPOS vs. legacy) is detected and encapsulated for you, so the same test
runs unchanged in both modes.

## Requirements

| Dependency | Version |
| --- | --- |
| PHP | `^8.0` |
| `codeception/codeception` | `^5.0` |
| `lucatume/wp-browser` | `^4.3` |
| WordPress | any version your suite targets |
| WooCommerce | any version your suite targets |

## Installation

```bash
composer require --dev aztecweb/aztecweb-wp-browser:^0.1.0
```

Then enable the modules in your acceptance suite (e.g. `tests/acceptance.suite.yml`).
`WPDb` and `WPWebDriver` must come first, since the Aztec modules build on top of
them:

```yaml
# Default — short form via the Class Alias Trick
modules:
    enabled:
        - WPDb
        - WPWebDriver
        - WooCommerceDb
        - WooCommerceWebDriver
    config:
        WPDb:
            # ...your WPDb config
        WPWebDriver:
            # ...your WPWebDriver config
```

The short names `WooCommerceDb` and `WooCommerceWebDriver` are registered at load
time via `class_alias` (the **Class Alias Trick**, see
[ADR-0004](docs/adr/0004-class-alias-trick.md)). If another package already owns
`Codeception\Module\WooCommerceDb`, the alias is skipped (with a warning) and you
should reference the modules by their fully-qualified class names instead:

```yaml
# Fallback if a class_alias collision is detected (rare)
modules:
    enabled:
        - WPDb
        - WPWebDriver
        - \Aztec\WPBrowser\WooCommerce\Module\WooCommerceDb
        - \Aztec\WPBrowser\WooCommerce\Module\WooCommerceWebDriver
```

After enabling the modules, rebuild the actor classes:

```bash
vendor/bin/codecept build
```

## Quick start

```php
public function customerCheckoutWithCoupon(AcceptanceTester $I): void
{
    $productId = $I->haveProductInDatabase(['post_title' => 'Test Product']);
    $I->havePercentageCouponInDatabase('SAVE10', 10.0);

    $I->amOnCartPage();
    $I->addProductToCart($productId);
    $I->seeProductInCart($productId);

    $I->amOnCheckoutPage();
    $I->applyCouponOnCheckout('SAVE10');
    $I->seeCouponApplied('SAVE10');
}
```

## Provided modules and methods

Methods are split across two Codeception modules. `WooCommerceDb` provides
database-backed setup and assertions; `WooCommerceWebDriver` provides
browser-backed actions and assertions. Each bullet lists related methods — see the
linked source for full signatures and PHPDoc.

### WooCommerceDb (database-backed)

**Coupon** — [`CouponMethods.php`](src/WooCommerce/Method/CouponMethods.php)

- `haveCouponInDatabase` / `havePercentageCouponInDatabase` /
  `haveFixedCartCouponInDatabase` / `haveFixedProductCouponInDatabase` /
  `haveFreeShippingCouponInDatabase` — create coupons of each discount type.
- `haveCouponMetaInDatabase` / `haveCouponStatus` — set coupon meta and status.
- `grabCouponMetaFromDatabase` / `grabCouponIdFromDatabase` / `grabCouponStatus` —
  read coupon data.
- `seeCouponInDatabase` / `seeCouponMetaInDatabase` / `seeCouponStatus` /
  `dontSeeCouponInDatabase` / `dontSeeCouponMetaInDatabase` — assertions.

**Customer** — [`CustomerMethods.php`](src/WooCommerce/Method/CustomerMethods.php)

- `haveCustomerInDatabase` / `haveCustomerMetaInDatabase` /
  `haveCustomerBillingFieldInDatabase` / `haveCustomerShippingFieldInDatabase` —
  create customers and set their fields.
- `grabCustomerFieldFromDatabase` / `grabCustomerMeta` /
  `grabCustomerBillingAddress` / `grabCustomerShippingAddress` /
  `grabCustomerIdFromDatabase` — read customer data.
- `seeCustomerInDatabase` / `seeCustomerMetaInDatabase` /
  `seeCustomerBillingFieldInDatabase` / `seeCustomerShippingFieldInDatabase` /
  `dontSeeCustomerInDatabase` / `dontSeeCustomerMetaInDatabase` — assertions.

**Order** — [`OrderMethods.php`](src/WooCommerce/Method/OrderMethods.php)

- `haveOrderInDatabase` / `haveManyOrdersInDatabase` / `haveOrderMetaInDatabase` /
  `haveOrderAddressInDatabase` / `haveOrderItemInDatabase` /
  `haveOrderItemMetaInDatabase` / `haveOrderStatus` — create orders and their parts.
- `grabOrderMeta` / `grabOrderStatus` / `grabOrderIdFromDatabase` /
  `grabOrderItemFromDatabase` / `grabOrderItemsTableName` — read order data.
- `seeOrderInDatabase` / `seeOrderMetaInDatabase` / `seeOrderItemInDatabase` /
  `seeOrderItemMetaInDatabase` / `seeOrderAddressInDatabase` / `seeOrderStatus` /
  `dontSeeOrderItemInDatabase` / `dontSeeOrderItemMetaInDatabase` — assertions
  (HPOS/legacy criteria auto-mapped).

**Product** — [`ProductMethods.php`](src/WooCommerce/Method/ProductMethods.php)

- `haveProductInDatabase` / `haveManyProductsInDatabase` /
  `haveProductMetaInDatabase` / `haveProductCategoryInDatabase` /
  `haveProductCategoryRelationshipInDatabase` / `haveProductInCategoriesInDatabase` —
  create products and categorise them.
- `grabProductMetaFromDatabase` / `grabProductCategoriesFromDatabase` /
  `grabProductCategoryIdsFromDatabase` / `grabProductIdFromDatabase` /
  `grabProductFieldFromDatabase` / `grabProductsTableName` — read product data.
- `seeProductInDatabase` / `seeProductMetaInDatabase` /
  `seeProductInCategoryInDatabase` / `dontSeeProductInDatabase` /
  `dontSeeProductMetaInDatabase` — assertions.

**Subscription** — [`SubscriptionMethods.php`](src/WooCommerce/Method/SubscriptionMethods.php)

- `haveSubscriptionInDatabase` / `haveSubscriptionProductInDatabase` /
  `haveSubscriptionMetaInDatabase` / `haveSubscriptionStatus` — create
  subscriptions and products.
- `cancelSubscription` / `reactivateSubscription` / `expireSubscription` /
  `suspendSubscription` / `pendingCancelSubscription` — transition status.
- `grabSubscriptionIdFromDatabase` / `grabSubscriptionFieldFromDatabase` /
  `grabSubscriptionMetaFromDatabase` / `grabSubscriptionStatus` — read data.
- `seeSubscriptionInDatabase` / `seeSubscriptionMetaInDatabase` /
  `seeSubscriptionStatus` / `dontSeeSubscriptionInDatabase` /
  `dontSeeSubscriptionMetaInDatabase` — assertions.

**Action Scheduler** — [`ActionMethods.php`](src/ActionScheduler/Method/ActionMethods.php)

- `haveActionInDatabase` / `haveActionGroupInDatabase` — schedule actions and groups.
- `runScheduledActions` / `cancelActionInDatabase` / `markActionCompleteInDatabase` —
  drive action state.
- `grabActionIdFromDatabase` / `grabActionStatusFromDatabase` /
  `grabActionsFromDatabase` / `grabActionLogFromDatabase` — read action data.
- `seeActionScheduled` / `seeActionInDatabase` / `seeActionInGroupInDatabase` /
  `seeActionMetaInDatabase` / `dontSeeActionScheduled` — assertions.

### WooCommerceWebDriver (browser-backed)

**Cart** — [`CartMethods.php`](src/WooCommerce/Method/CartMethods.php)

- `amOnCartPage` / `addProductToCart` / `clearCart` — navigate and mutate the cart.
- `seeProductInCart` / `dontSeeProductInCart` / `seeCartItemQuantity` /
  `seeCartTotalQuantity` — assertions.

**Checkout** — [`CheckoutMethods.php`](src/WooCommerce/Method/CheckoutMethods.php)

- `amOnCheckoutPage` / `fillCheckoutField` / `fillCheckoutForm` /
  `selectPaymentMethod` / `placeOrder` / `applyCouponOnCheckout` — drive checkout.
- `seePaymentMethodAvailable` / `dontSeePaymentMethodAvailable` /
  `seePaymentMethodSelected` / `seeCouponApplied` / `dontSeeCouponApplied` /
  `seeCouponError` / `seeCheckoutError` / `dontSeeCheckoutError` /
  `seeOrderReceived` / `seeCheckoutFieldValue` — assertions.
- `grabOrderIdFromOrderReceived` / `grabCheckoutFieldValue` — read page data.

**Customer (browser)** — [`CustomerBrowserMethods.php`](src/WooCommerce/Method/CustomerBrowserMethods.php)

- `amOnMyAccountPage` — navigate to the My Account page.

**Order (browser)** — [`OrderBrowserMethods.php`](src/WooCommerce/Method/OrderBrowserMethods.php)

- `amOnAdminOrderPage` — open an order's admin edit page (HPOS/legacy URL auto-resolved).

## HPOS support

HPOS (High-Performance Order Storage) is **auto-detected** from the
`woocommerce_custom_orders_table_enabled` option; no consumer configuration is
needed. The same order and subscription methods work whether your site uses the
`wc_orders` tables or the legacy `wp_posts` storage. See
[ADR-0005](docs/adr/0005-hpos-detection-encapsulation.md) for details.

## Architecture

The library favours **composition over inheritance**: each WooCommerce module
composes domain-specific method traits rather than extending a base module
([ADR-0002](docs/adr/0002-composition-over-extension.md)). Capabilities are split
**one module per plugin concern** — `WooCommerceDb`, `WooCommerceWebDriver`, and
the Action Scheduler subnamespace
([ADR-0003](docs/adr/0003-module-per-plugin-architecture.md)) — and HPOS detection
is encapsulated behind the order storage interfaces so tests stay storage-agnostic.
See [`CONTEXT.md`](CONTEXT.md) for shared vocabulary and [`docs/adr/`](docs/adr/)
for the full design rationale.

## Local development

This repo runs its own test suite inside a self-contained Docker image via the
`bin/test` wrapper, which bind-mounts the repo at `/var/www/html`.

```bash
bin/test composer install            # install deps (also installs the pre-push hook)
bin/test bash resources/install.sh   # bootstrap the SQLite WordPress site (idempotent)
bin/test codecept run acceptance     # run the acceptance suite
bin/test codecept run acceptance CouponCest   # run a single Cest
composer check                       # validate composer.json, run PHPStan and PHPCS
```

`composer install` wires up the pre-push hook by running
`git config core.hooksPath .githooks` (the `post-install-cmd` script). The hook
([`.githooks/pre-push`](.githooks/pre-push)) runs only the tests impacted by your
changed files, and falls back to the full acceptance suite when shared
infrastructure changes. In an emergency you can bypass it with
`git push --no-verify` — but CI is the authoritative gate.

## Contributing

Contributions go through pull request: review is required, CI must be green, and
new public methods on the modules and method traits must carry the full PHPDoc
skeleton (see the docblock convention in [`CLAUDE.md`](CLAUDE.md), which also
documents the guidelines for AI coding assistants).

## License

[MIT](LICENSE).

## Changelog

See [`CHANGELOG.md`](CHANGELOG.md).
