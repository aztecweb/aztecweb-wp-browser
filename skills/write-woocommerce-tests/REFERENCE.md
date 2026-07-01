# REFERENCE — WooCommerce method conventions

Curated, project-specific detail for `write-woocommerce-tests`. For the full Codeception / WPDb / WPWebDriver API, read the source directly — this file does not reproduce it.

## Read the source

- **Library Method Traits** (canonical naming reference — read, don't edit): `vendor/aztecweb/aztecweb-wp-browser/src/WooCommerce/Method/`
- **Library Plugin Modules** the Helper delegates to via `getModule()`: `.../src/WooCommerce/Module/{WooCommerceDb,WooCommerceWebDriver}.php`
- **Storage split** (HPOS/Legacy): `.../src/WooCommerce/OrderStorage/`, `.../src/WooCommerce/SubscriptionStorage/`
- **WPDb / WPWebDriver**: `vendor/lucatume/wp-browser/src/Module/{WPDb,WPWebDriver}.php`
- **WooCommerce source**: WooCommerce is a **plugin in the target WordPress site**, not a Composer package. Its directory is **dynamic** — do not assume `wp-content/plugins/`. Locate it in the site under test (e.g. `wp plugin path woocommerce` via WP-CLI, or the site's configured plugins dir) and read the source there, plus the [WooCommerce code reference](https://woocommerce.github.io/code-reference/)

## Entity → table → method

| Entity | WP table | Verify entity | Verify meta | Grab field | Meta id remap |
|--------|----------|---------------|-------------|------------|---------------|
| Product | wp_posts | `seeProductInDatabase` | `seeProductMetaInDatabase` | `grabProductFieldFromDatabase` | `product_id` → `post_id` |
| Coupon | wp_posts | `seeCouponInDatabase` | `seeCouponMetaInDatabase` | — | `coupon_id` → `post_id` |
| Customer | wp_users | `seeCustomerInDatabase` | `seeCustomerMetaInDatabase` | `grabCustomerFieldFromDatabase` | `customer_id` → `user_id` |
| Order | wc_orders (HPOS) / wp_posts (Legacy) | `seeOrderInDatabase` | `seeOrderMetaInDatabase` | — | via `OrderStorage` |
| Subscription | wc_orders / wp_posts | `seeSubscriptionInDatabase` | `seeSubscriptionMetaInDatabase` | `grabSubscriptionFieldFromDatabase` | via `SubscriptionStorage` |

## Method inventory by entity (library-provided, mirror these)

- **Product** — `have{Product,ProductCategory,ManyProducts}InDatabase`, `haveProductMetaInDatabase`, `haveProductInCategoriesInDatabase`, `grabProduct{Id,Field,Meta,Categories,CategoryIds}FromDatabase`, `see/dontSeeProduct[Meta]InDatabase`, `seeProductInCategoryInDatabase`, `grabProductsTableName`
- **Coupon** — `haveCouponInDatabase`, `have{Percentage,FixedCart,FixedProduct,FreeShipping}CouponInDatabase`, `haveCouponMetaInDatabase`, `{have,see,grab}CouponStatus`, `grabCouponIdFromDatabase`, `see/dontSeeCoupon[Meta]InDatabase`
- **Customer** — `haveCustomerInDatabase`, `haveCustomer{Meta,BillingField,ShippingField}InDatabase`, `grabCustomer{Id,Field,Meta,BillingAddress,ShippingAddress}`, `see/dontSeeCustomer[Meta]InDatabase`, `seeCustomer{Billing,Shipping}FieldInDatabase`
- **Order** — `have{Order,ManyOrders,OrderMeta,OrderAddress,OrderItem,OrderItemMeta}InDatabase`, `{have,see,grab}OrderStatus`, `grabOrder{Id,Item}FromDatabase`, `grabOrderMeta`, `see/dontSeeOrder{,Item,ItemMeta}InDatabase`, `seeOrderAddressInDatabase`, `grabOrderItemsTableName`
- **Subscription** — `haveSubscription[Meta,Product]InDatabase`, `grabSubscription{Id,Field,Meta,Status}`, `{cancel,reactivate,expire,suspend,pendingCancel}Subscription`, `haveSubscriptionStatus`, `see/dontSeeSubscription[Meta]InDatabase`, `seeSubscriptionStatus`
- **Cart** (browser) — `amOnCartPage`, `addProductToCart`, `see/dontSeeProductInCart`, `seeCartItemQuantity`, `seeCartTotalQuantity`, `clearCart`
- **Checkout** (browser) — `amOnCheckoutPage`, `fillCheckoutField`, `fillCheckoutForm`, `selectPaymentMethod`, `placeOrder`, `applyCouponOnCheckout`, `seeCouponApplied`, `seeOrderReceived`, `grabOrderIdFromOrderReceived`

## Method contract (library-specific rules)

- `grab…IdFromDatabase` returns `int|false` — return `false` when absent, never `assertIsNumeric` or throw.
- `see…InDatabase` / `see…MetaInDatabase` delegate to WPDb and never `throw` manually — let the assertion fail.
- `have…MetaInDatabase(int $id, string $key, mixed $value)` uses **positional** args; `see…MetaInDatabase(array $criteria)` uses a **criteria array** and remaps the friendly id (see table).
- Every file: `declare(strict_types=1);`, full param/return type hints, PSR-4 namespace.

## HPOS vs Legacy

Orders and subscriptions have two storage backends; a test touching order/subscription storage must pass under **both**. Toggle storage with a per-suite `WooCommerceWebDriver` `legacyOrderStorage` override, or at runtime from a Helper:

```php
$this->getModule('WooCommerceWebDriver')->_reconfigure(['legacyOrderStorage' => true]);
```

## Helper example (support)

A Helper composes library actor methods to remove duplication across Cests — support code, not the primary deliverable:

```php
public function haveProductOnSaleInDatabase(float $regular, float $sale): int
{
    $wc = $this->getModule('WooCommerceDb');
    $id = $wc->haveProductInDatabase(['post_title' => 'Sale item']);
    $wc->haveProductMetaInDatabase($id, '_regular_price', (string) $regular);
    $wc->haveProductMetaInDatabase($id, '_sale_price', (string) $sale);
    return $id;
}
```

## Suite configuration

Prefer a project that is **already configured**: a Codeception suite (`tests/{suite}.suite.yml`) whose `modules.enabled` includes `WooCommerceDb` and `WooCommerceWebDriver` (plus any Helper). Confirm those are enabled; if you add a Helper, also confirm `codeception.yml`'s `support_namespace` matches its namespace, then run `vendor/bin/codecept build`.

If the suite or the modules are **not** configured, do not invent a config — follow the wp-browser documentation to set it up:

- [wpbrowser.wptestkit.dev](https://wpbrowser.wptestkit.dev/) — suites, modules, and configuration
- `vendor/lucatume/wp-browser/` — installed README and module reference
