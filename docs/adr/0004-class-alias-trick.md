# Class alias trick for short-form module references

`src/aliases.php` registers `Codeception\Module\X` aliases for Plugin Module
classes via composer's `files` autoload. This lets consumers reference
modules by short name in suite.yml (`modules.enabled: [WooCommerceDb]`)
instead of by fully-qualified class name
(`\Aztec\WPBrowser\WooCommerce\Module\WooCommerceDb`). Codeception 5's
module resolution hardcodes the `\Codeception\Module\` namespace prefix in
`ModuleContainer::MODULE_NAMESPACE`; there is no `addModuleNamespace` API
or equivalent. Aliasing into the Codeception namespace is the only way to
enable short-form references — the same mechanism wp-browser uses for its
own modules.

## Considered options

- **FQN-only in suite.yml.** Verbose but no autoload-time side effects, no namespace squat. Rejected because the verbosity cost across every consumer outweighs the marginal collision risk.
- **Vendor-prefixed alias (`AztecWooCommerceDb`).** Collision-safe but verbose; rejected because the user judged a competing `Codeception\Module\WooCommerceDb` registration unlikely (no comparable WC-Codeception tooling exists today).

## Consequences

- All Plugin Module aliases live in `src/aliases.php`, loaded eagerly at composer-autoload time via the `files` directive.
- A safeguard checks `class_exists($alias, false)` before each `class_alias()` call. If the alias is already registered by another package, our registration is skipped and a `E_USER_WARNING` is emitted explaining the conflict and recommending the FQN as a workaround.
- The FQN always works in suite.yml as a fallback when the short-form alias is collision-blocked. This is the documented escape hatch.
- New Plugin Modules require an entry in `src/aliases.php`; not adding it leaves the module reachable only via FQN.
