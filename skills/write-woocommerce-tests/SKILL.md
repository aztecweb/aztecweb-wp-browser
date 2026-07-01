---
name: write-woocommerce-tests
description: Write WooCommerce Codeception tests (Cests) in a project that installs aztecweb/wp-browser, using the library's actor methods. Use when the user wants tests for WooCommerce behavior — products, coupons, orders, customers, cart, checkout, subscriptions — or a reusable custom test method to support them.
---

# Write WooCommerce Codeception tests

You are working in a project that installs **`aztecweb/aztecweb-wp-browser`** as a dev dependency. The goal is to **write tests as Cests** that exercise WooCommerce behavior through the actor methods the library already provides — and to keep the suite green.

## Primary deliverable: Cests

Tests live in **Cest classes**, one per domain (`ProductCest`, `CouponCest`, `OrderCest`, …), under the suite's test directory. Each test method drives WooCommerce through library actor methods:

```php
<?php
declare(strict_types=1);

class ProductCest
{
    public function seesProductPrice(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase(['post_title' => 'Beanie']);
        $I->haveProductMetaInDatabase($productId, '_price', '10.00');   // positional

        $I->seeProductInDatabase(['ID' => $productId, 'post_title' => 'Beanie']);
        $I->seeProductMetaInDatabase([                                  // criteria array
            'product_id' => $productId,   // remapped to post_id internally
            'meta_key'   => '_price',
            'meta_value' => '10.00',
        ]);
    }
}
```

The suite's actor (`AcceptanceTester`, or whatever the suite defines) already exposes every library method — see [REFERENCE.md](./REFERENCE.md) for the inventory. Prefer these over raw SQL or hand-rolled setup.

## Support: a Helper, only when needed

If several Cests repeat the same custom setup the library doesn't provide, extract it into a **Codeception Helper** (support code) — `tests/_support/Helper/{Name}.php`, a class extending `\Codeception\Module` that reaches library methods via `getModule()` — then enable that Helper and rebuild. A Helper is support, not the goal; reach for one only to remove duplication across Cests. See [REFERENCE.md](./REFERENCE.md) for an example. Do **not** create Method Traits or Plugin Modules, and do **not** edit the library under `vendor/`; that structure is an override path, used only when explicitly requested.

## Calling conventions

Mirror the library's signatures when you call them (full inventory in [REFERENCE.md](./REFERENCE.md)):

| Kind | Signature | Note |
|------|-----------|------|
| Create | `have{Entity}InDatabase(array $overrides)` | returns `int` ID |
| Create meta | `have{Entity}MetaInDatabase(int $id, string $key, mixed $value)` | **positional** args |
| Retrieve ID | `grab{Entity}IdFromDatabase(array $criteria)` | returns `int\|false` |
| Verify | `see{Entity}InDatabase(array $criteria)` | — |
| Verify meta | `see{Entity}MetaInDatabase(array $criteria)` | **criteria array** |

`see`/`dontSee` meta methods take `array $criteria` and remap the friendly id, accepting **either** form — posts (product, coupon): `product_id`/`coupon_id` → `post_id`; users (customer): `customer_id` → `user_id`. Pass **real DB column names**, not abstractions (`order_item_name`, not `name`); the exception is `haveOrderAddressInDatabase`, which uses abstract fields (`first_name`, `last_name`) to unify HPOS and Legacy.

## Suite configuration

These tests run in a Codeception **suite** — it may be `acceptance`, `functional`, or any suite the project defines; treat the suite name as a variable. The tests need the library modules `WooCommerceDb` and `WooCommerceWebDriver` (plus any Helper you add) enabled in that suite's config (`tests/{suite}.suite.yml`).

It is desirable that the project already has this configuration; if it does, just confirm the needed modules are enabled. If the suite or the modules are **not** configured, do not invent a config — explore the wp-browser documentation ([wpbrowser.wptestkit.dev](https://wpbrowser.wptestkit.dev/), and the installed README under `vendor/lucatume/wp-browser/`) and set it up per those instructions.

## Workflow

1. List the behaviors to test; group them by domain (one Cest per domain).
2. **Baseline:** run the suite and confirm it is green before changing anything — `vendor/bin/codecept run {suite}`.
3. Confirm the suite enables `WooCommerceDb`/`WooCommerceWebDriver` (see *Suite configuration*).
4. Write the Cests using library actor methods (REFERENCE.md); cover success and failure, and both storage modes for order/subscription tests (see *HPOS vs Legacy* in REFERENCE.md).
5. Only if reusable custom setup is missing, add a Helper method (support), enable it, and run `vendor/bin/codecept build`.
6. **Done** = the new tests pass **and** the previously-green suite is still green — `vendor/bin/codecept run {suite}`.

## Golden rule

Follow the conventions of Codeception, `lucatume/wp-browser`, `WPDb`, and this library — in that order. If a request conflicts with them, flag it and propose the conventional pattern instead.
