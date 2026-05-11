# PHPStan at level max without szepeviktor/phpstan-wordpress

The library does not call any WordPress runtime function or import any
WordPress class directly. Every WP-aware operation is routed through
wp-browser's typed methods (`WPDb::havePostInDatabase()`,
`WPDb::grabOptionFromDatabase()`, etc.). Consequently
`szepeviktor/phpstan-wordpress` — which provides type stubs for `wp_*`
functions and `WP_*` classes — has nothing to type-check in this codebase
and is excluded from `require-dev`. PHPStan runs at `level: max` against
`src/` and `tests/` (excluding `tests/_support/_generated`) with no
WordPress-specific extension. Verified at decision time via
`grep -rn "wp_\|WP_\|Automattic\|WC_\|Woo" src/` returning zero hits.

## Considered options

- **Include szepeviktor as defense-in-depth.** Rejected as YAGNI — the dependency adds installation time, lock-file size, and maintenance surface for a codebase that contains nothing it can analyze.
- **PHPStan at level 5 or 8 instead of max.** Considered to reduce friction during initial baseline; rejected once it became clear that the WC-mixed-types noise (the usual reason to back off level max in WP code) doesn't apply here, since the library never touches WC PHP directly.

## Consequences

- A future PR that adds direct WP/WC function calls (e.g., for an optimization that bypasses WPDb) must also add `szepeviktor/phpstan-wordpress` at that time. This is a per-PR concern, not a pre-paid dependency.
- `phpstan.neon.dist` is intentionally minimal: paths (`src`, `tests`), `level: max`, single exclude for the auto-generated actor file. No baseline file at v0.1.0.
