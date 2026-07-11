---
name: write-woocommerce-tests
description: Write WooCommerce Codeception tests (Cests) in a project that installs aztecweb/wp-browser, using the library's actor methods. Use when the user wants tests for WooCommerce behavior — products, coupons, orders, customers, cart, checkout, subscriptions — or a reusable custom test method to support them.
---

# Write WooCommerce Codeception tests

You are working in a project that installs **`aztecweb/aztecweb-wp-browser`** as a dev dependency. The goal is to **write tests as Cests** that exercise WooCommerce behavior through the actor methods the library already provides — and to keep the suite green.

## The method reference is your `vendor/` tree — not this skill

This skill embeds **no method catalog**: a frozen list would drift from the library version you actually installed. The canonical reference is the source on disk. For any method's exact name, signature, accepted argument keys, and a worked call, read its docblock in:

```
vendor/aztecweb/aztecweb-wp-browser/src/**/Method/*Methods.php
```

Every public method carries (100% coverage, enforced by a sniff):

- an **`@example`** block — a canonical, copy-ready call;
- **`@param` / `@phpstan-type`** annotations — the argument shape, i.e. the allowed keys and value types.

Grep these files to discover what exists (e.g. `grep -rl 'function haveCoupon' vendor/aztecweb/aztecweb-wp-browser/src`), then mirror the signature and `@example` you find. Treat the docblock — never this skill — as the source of truth for method shapes.

## Primary deliverable: Cests

Tests live in **Cest classes**, one per domain (`ProductCest`, `CouponCest`, `OrderCest`, …), under the suite's test directory. Each test method sets up state with a **`have*InDatabase`** builder and asserts with the companion **`see*InDatabase`** method:

```php
<?php

class ProductCest
{
    public function seeProduct(AcceptanceTester $I): void
    {
        // exact args for every call → the method's @example block in vendor/
        $productId = $I->haveProductInDatabase(['post_title' => 'Beanie']);
        $I->seeProductInDatabase(['ID' => $productId, 'post_title' => 'Beanie']);
    }
}
```

The suite's actor (`AcceptanceTester`, or whatever the suite defines) exposes every library method. Prefer these over raw SQL or hand-rolled setup.

## Support: a Helper, only when needed

If several Cests repeat the same custom setup the library doesn't provide, extract it into a **Codeception Helper** (support code) — `tests/_support/Helper/{Name}.php`, a class extending `\Codeception\Module` that reaches library methods via `getModule()` — then enable that Helper and rebuild. A Helper is support, not the goal; reach for one only to remove duplication across Cests. See [REFERENCE.md](./REFERENCE.md) for an example. Do **not** create Method Traits or Plugin Modules, and do **not** edit the library under `vendor/`; that structure is an override path, used only when explicitly requested.

## Two calling conventions the docblocks assume

The `@example` blocks are self-explanatory, but two library-wide patterns are worth stating so the examples read correctly:

- **`have*MetaInDatabase`** takes **positional** args — `($id, $key, $value)`.
- **`see*MetaInDatabase`** takes a **criteria array** and remaps a friendly id to the underlying column (e.g. `product_id` → `post_id`). Pass **real DB column names**, not abstractions. The exact keys each method accepts are in its `@param` annotation — read them there, don't guess.

## Suite configuration

These tests run in a Codeception **suite** — it may be `acceptance`, `functional`, or any suite the project defines; treat the suite name as a variable. The tests need the library modules `WooCommerceDb` and `WooCommerceWebDriver` (plus any Helper you add) enabled in that suite's config (`tests/{suite}.suite.yml`).

It is desirable that the project already has this configuration; if it does, just confirm the needed modules are enabled. If the suite or the modules are **not** configured, do not invent a config — explore the wp-browser documentation ([wpbrowser.wptestkit.dev](https://wpbrowser.wptestkit.dev/), and the installed README under `vendor/lucatume/wp-browser/`) and set it up per those instructions.

## Workflow

1. List the behaviors to test; group them by domain (one Cest per domain).
2. **Baseline:** run the suite and confirm it is green before changing anything — `vendor/bin/codecept run {suite}`.
3. Confirm the suite enables `WooCommerceDb`/`WooCommerceWebDriver` (see *Suite configuration*).
4. Write the Cests using library actor methods — read each method's `@example` and `@param` in `vendor/aztecweb/aztecweb-wp-browser/src/**/Method/*Methods.php` for its shape; cover success and failure.
5. Only if reusable custom setup is missing, add a Helper method (support), enable it, and run `vendor/bin/codecept build`.
6. **Done** = the new tests pass **and** the previously-green suite is still green — `vendor/bin/codecept run {suite}`.

## Golden rule

Follow the conventions of Codeception, `lucatume/wp-browser`, `WPDb`, and this library — in that order. If a request conflicts with them, flag it and propose the conventional pattern instead.
