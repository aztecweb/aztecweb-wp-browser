---
name: woocommerce-acceptance-tests
description: Write WooCommerce acceptance tests using have*/see* builders and Cest format. Toggle HPOS when testing orders. Use when creating acceptance tests for WooCommerce with the aztecweb-wp-browser library.
---

# WooCommerce Acceptance Tests

## Quick start

1. Create a test file: `tests/acceptance/MyFeatureCest.php`
2. If testing orders, toggle HPOS to match your site:
   ```php
   public function _before(AcceptanceTester $I) {
       $I->setHPOSStorageMode(true); // or false
   }
   ```
3. Use builders to set up state and assert:
   ```php
   public function testOrderFlow(AcceptanceTester $I) {
       $I->haveProductInDatabase(['name' => 'Widget']);
       $I->amOnPage('/shop');
       $I->click('Add to cart');
       $I->seeProductInDatabase(['name' => 'Widget']);
   }
   ```
4. Build and run:
   ```bash
   vendor/bin/codecept build
   vendor/bin/codecept run acceptance
   ```

## Workflows

### Writing a new test

1. Create a new `*Cest.php` file in `tests/acceptance/`
2. Extend `AcceptanceTester` as the `$I` parameter
3. Add `_before()` to set up test prerequisites (HPOS toggle, site state)
4. Use `have*InDatabase()` to create test data without page navigation
5. Interact with the site via page methods (`$I->click()`, `$I->fillField()`, etc.)
6. Assert with `see*InDatabase()` to verify changes persisted

### Toggling HPOS for order tests

```php
public function _before(AcceptanceTester $I) {
    // Set to true for WooCommerce 8.0+ with HPOS enabled
    // Set to false for traditional order tables
    $I->setHPOSStorageMode(true);
}
```

### Rebuilding after method changes

If you see `ArgumentCountError`:
```bash
vendor/bin/codecept build
```
This happens when module method signatures change. Codeception caches the reflection data.

## Common commands

- `vendor/bin/codecept run acceptance` — Run all tests
- `vendor/bin/codecept run acceptance MyTestCest.php` — Run specific file
- `vendor/bin/codecept run acceptance MyTestCest.php:specificTest` — Run specific test method
- `vendor/bin/codecept build` — Rebuild method caches

## Reference

For method signatures, worked examples, and domain vocabulary: see [REFERENCE.md](REFERENCE.md)
