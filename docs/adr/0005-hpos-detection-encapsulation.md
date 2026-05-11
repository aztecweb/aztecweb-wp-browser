# HPOS detection is fully internal to WooCommerceDb

WooCommerce's HPOS (High-Performance Order Storage) state is detected
privately within `WooCommerceDb` via a `protected` helper that reads the
`woocommerce_custom_orders_table_enabled` option from `wp_options` through
`getModule('WPDb')->grabOptionFromDatabase(...)`. Every public method that
branches on HPOS handles the branch internally; **no public actor method
exposes HPOS state**, and `WooCommerceWebDriver` has zero HPOS-related
code. This isolates a backend storage detail from the browser layer
entirely. If a Page Object ever needs HPOS-aware behavior, it detects HPOS
itself — it does not ask any Plugin Module.

## Considered options

- **Public `isHposEnabled()` on `WooCommerceDb` accessible cross-module.** Rejected because it leaks a backend storage concern into the browser-side `WooCommerceWebDriver`, violating separation of concerns.
- **WC PHP API call** (`OrderUtil::custom_orders_table_usage_is_enabled()`). Rejected because the test runtime uses `WPDb` + `WPWebDriver` only (no `WPLoader`); WC PHP code is not in-process during DB-only tests.
- **DB table-existence check** (`SELECT EXISTS … wp_wc_orders`). Rejected because it's MySQL-specific (`information_schema.TABLES` doesn't exist on SQLite, our test DB).

## Consequences

- Detection is a single `wp_options` lookup per call — no module-level cache. Tests that toggle the HPOS option mid-run get correct behavior automatically (the next call re-reads).
- Methods that check HPOS multiple times within one execution use a method-local stack variable (`$hpos = $this->isHposEnabled();`) — no special caching infrastructure needed.
- If WooCommerce ever moves the HPOS storage flag away from `woocommerce_custom_orders_table_enabled`, detection breaks loudly. Mitigation: a Cest test specifically validating `isHposEnabled()` returns the expected value in known scenarios (HPOS on, HPOS off, fresh install).
- Default return is `false` when the option is missing or unset — matches WooCommerce's own pre-HPOS default.
