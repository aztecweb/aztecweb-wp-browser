---
name: woocommerce-acceptance-tests-reference
description: Reference materials for WooCommerce acceptance testing
---

# Reference: WooCommerce Acceptance Tests

This skill is frozen at `npx skills add` time and defers to your vendor/ tree for always-current examples, signatures, and vocabulary.

## Canonical worked examples

Inspect real-world test patterns:

```
vendor/aztec/aztecweb-wp-browser/tests/acceptance/*Cest.php
```

These are the authoritative examples showing `have*InDatabase` setups, page interactions, and `see*InDatabase` assertions in context.

## Builder and assertion method signatures

Method names and allowed arguments:

```
vendor/aztec/aztecweb-wp-browser/src/Method/*Methods.php
```

Each file documents its builders via `@phpstan-type` annotations. Example:
- `haveProductInDatabase(array)` — creates a product
- `seeProductInDatabase(array)` — asserts product exists with given attributes

The `@phpstan-type` comment block shows required/optional keys and value types.

## WooCommerce concepts and terminology

Domain glossary for consistent naming:

```
vendor/aztec/aztecweb-wp-browser/CONTEXT.md
```

Defines HPOS, order storage modes, builder conventions, and patterns used throughout the library.

## Why point to vendor/, not embed docs?

The skill is installed frozen — copying a method catalog here would become stale when you upgrade the library. By deferring to vendor/, you always read current docs, signatures, and examples matching your installed version.
