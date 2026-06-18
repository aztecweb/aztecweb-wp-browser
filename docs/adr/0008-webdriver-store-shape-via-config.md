# WebDriver learns the store's shape from config, not the database

`WooCommerceWebDriver` must do only what a browser sees, so it may not query the
database. Anything it previously read from the DB to drive the browser — page
slugs and the order-storage mode (HPOS vs legacy) — is now **declared in the
module's suite config** instead of detected. The order-storage mode is a single
flag, `legacyOrderStorage` (default `false`, i.e. HPOS), that governs every
HPOS-dependent browser behavior (admin order URLs, and any future variants).

## Considered Options

- **Detect HPOS in the browser layer** (read the rendered admin menu, or query
  the DB) — rejected: re-introduces storage awareness sourced from the system
  under test, the coupling we set out to remove.
- **Per-screen config flags** (`ordersAdminScreen`, etc.) — rejected: HPOS is one
  store-wide setting; per-screen flags denormalize one fact into many and make an
  impossible mixed state (one screen HPOS, another legacy) representable.
- **Pure UI navigation** (follow store-rendered links, never build URLs) —
  rejected: brittle row-finding and an implicit "order ID == displayed number"
  assumption.

## Consequences

- `WooCommerceWebDriver` requires only `WPWebDriver`, never `WPDb`.
- `WooCommerceDb` still **detects** HPOS from the database; the two layers reach
  the same fact by different means. A misdeclared `legacyOrderStorage` is not
  validated against the live store and will fail tests with no auto-correction —
  the accepted cost of keeping the browser layer DB-free.
- HPOS remains off the public actor API in both layers.
