# AGENTS.md

This is a **Codeception module library for WooCommerce acceptance tests**, extending `lucatume/wp-browser` to provide high-level helpers for testing WooCommerce functionality in WordPress.

## Getting Started

See [`tests/acceptance/*Cest.php`](tests/acceptance/) for worked examples of how to use the actor methods.

## Critical Gotchas

### HPOS Toggle

WooCommerce supports two order storage modes: **HPOS** (High-Performance Order Storage, using `wc_orders` table) and **Legacy** (using `wp_posts` table). The module auto-detects which mode is active.

**Important:** Before running `OrderHPOSCest` tests, you must enable HPOS:
```bash
bin/test wp wc hpos enable
```

Before running `OrderCest` (Legacy) tests, disable it:
```bash
bin/test wp wc hpos disable
```

### Codeception Build Required

After **installing dependencies** or **changing method signatures** in module traits, you must rebuild the actor class:

```bash
bin/test codecept build
```

Without this, tests will fail with `ArgumentCountError` even if the source code is correct. This regenerates actor classes in `tests/_support/_generated/`.

## References

- **Vocabulary & Concepts**: See [`CONTEXT.md`](CONTEXT.md) for terminology (Plugin Module, Method Trait, overrides, etc.)
- **Contributing Guidelines**: See [`CONTRIBUTING.md`](CONTRIBUTING.md) for architecture patterns and standards
