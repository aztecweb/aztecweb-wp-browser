# Reference: WooCommerce Acceptance Tests

This skill is a frozen snapshot created at `npx skills add` time. It defers at runtime to the consumer's always-current `vendor/` tree for examples, argument shapes, and domain vocabulary.

## Canonical worked examples

See your installed library's acceptance tests:

```
vendor/aztec/aztecweb-wp-browser/tests/acceptance/*Cest.php
```

These are the authoritative examples of how to use `have*InDatabase` and `see*InDatabase` builders in real tests.

## Available builders and assertion methods

The allowed keys, values, and optional parameters for each builder are defined in:

```
vendor/aztec/aztecweb-wp-browser/src/Method/*Methods.php
```

Look for `@phpstan-type` annotations that document the argument shapes. Each builder (e.g., `haveProductInDatabase`) has a corresponding assertion method (e.g., `seeProductInDatabase`).

## Domain vocabulary and context

For definitions of WooCommerce concepts, site configuration, and testing patterns used in this library:

```
vendor/aztec/aztecweb-wp-browser/CONTEXT.md
```

This glossary ensures consistent terminology across your test suite.

## Why defer to vendor/

The skill was authored once and shipped frozen — it cannot be updated after installation. By pointing to your `vendor/` tree, you always get the latest method signatures, examples, and documentation when you install a newer version of the library, without requiring the skill itself to be republished.
