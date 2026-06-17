# Writing WooCommerce Acceptance Tests

## Procedure

1. **If your test touches orders**, toggle HPOS (High-Performance Order Storage) to the correct storage mode first. This ensures your test assertions match your site's order backend.

2. **Write your test using Cest builders** that set up state and assert results:
   - Use `have*InDatabase` methods to create test data (customers, orders, products, etc.)
   - Use the companion `see*InDatabase` methods to verify expected state after your test runs

3. **Rebuild Codeception when needed**:
   ```bash
   vendor/bin/codecept build
   ```
   Run this after installing a new module or changing any method/trait signature. Codeception caches method definitions, so skipping this step will cause `ArgumentCountError`.

4. **Run your test suite**:
   ```bash
   vendor/bin/codecept run acceptance
   ```

## Key commands

- `vendor/bin/codecept run acceptance` — Run all acceptance tests
- `vendor/bin/codecept run acceptance SomeTest.php` — Run a specific test file
- `vendor/bin/codecept build` — Rebuild method caches after adding/changing modules
