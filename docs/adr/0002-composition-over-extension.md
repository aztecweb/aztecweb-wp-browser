# Composition over extension for Plugin Modules

Plugin Modules (`WooCommerceDb`, `WooCommerceWebDriver`) extend
`\Codeception\Module` and access wp-browser's modules via
`$this->getModule('WPDb')` / `$this->getModule('WPWebDriver')`. They do
**not** directly extend wp-browser's `WPDb` or `WPWebDriver`. This decision
is forced by the library's multi-plugin architecture: a future `EddDb`
Plugin Module also needs DB access, and Codeception forbids two enabled
modules from re-exporting the same inherited methods on the actor — which
would happen if both `WooCommerceDb` and `EddDb` extended `WPDb`.

## Considered options

- **Extension** (`AztecWooCommerceDb extends WPDb`) — was the original choice and is cleaner for a single-plugin architecture; rejected because two plugin modules each extending `WPDb` causes a fatal duplicate-method-registration error at suite-init time.
- **Hybrid** (one plugin extends `WPDb`, others compose) — politically awkward (which plugin is "primary"?) and asymmetric across the codebase; rejected.

## Consequences

- Method Traits declare abstract dependency-getters (`abstract protected function wpDb(): WPDb`) so composition works through them.
- Consumers' suite.yml must enable wp-browser's modules (`WPDb`, `WPWebDriver`) **and** the Plugin Modules — three or more entries instead of two under extension.
- Method-name collisions between Plugin Modules are impossible by construction (each module exports only its own additions).
- The "extension is more upstream-aligned" intuition (mirroring how `WPDb extends Db`) doesn't apply because wp-browser's modules each extend a different parent; we can't.
