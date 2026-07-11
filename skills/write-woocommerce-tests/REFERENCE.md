# REFERENCE — WooCommerce testing detail

Project-specific detail for `write-woocommerce-tests` that the procedure in [SKILL.md](./SKILL.md) reaches for on demand. It deliberately holds **no method catalog** — method names, signatures, argument keys, and worked calls live in the docblocks (`@example`, `@param` / `@phpstan-type`) of `vendor/aztecweb/aztecweb-wp-browser/src/**/Method/*Methods.php`. Read those; they are the source of truth and cannot drift from your installed version.

## Reading source beyond the Method docblocks

The Method docblocks cover the library's actor methods. For everything they build on, read the source directly:

- **WPDb / WPWebDriver** (what the library delegates to): `vendor/lucatume/wp-browser/src/Module/{WPDb,WPWebDriver}.php`
- **Storage split** (HPOS/Legacy internals): `vendor/aztecweb/aztecweb-wp-browser/src/WooCommerce/{OrderStorage,SubscriptionStorage}/`

## HPOS vs Legacy

Orders and subscriptions have two storage backends; a test touching order/subscription storage must pass under **both**. Toggle storage with a per-suite `WooCommerceWebDriver` `legacyOrderStorage` override, or at runtime from a Helper:

```php
$this->getModule('WooCommerceWebDriver')->_reconfigure(['legacyOrderStorage' => true]);
```

## Helper example (support)

A Helper composes library actor methods to remove duplication across Cests — support code, not the primary deliverable. Read the exact method shapes it calls from their docblocks:

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
