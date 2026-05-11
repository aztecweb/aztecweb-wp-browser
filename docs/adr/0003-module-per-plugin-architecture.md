# Module-per-Plugin architecture

Each WordPress plugin gets its own pair of Plugin Modules — one per
Codeception layer (DB, WebDriver). Today's catalog: `WooCommerceDb` +
`WooCommerceWebDriver`. Future plugins (e.g., EDD, MemberPress) would add
their own pairs (`EddDb`, `EddWebDriver`, etc.) — never composed into a
single "kitchen-sink" module. This scoping is what lets a WooCommerce-only
consumer enable only the WC modules; their actor's autocomplete shows only
WC methods; calling EDD-only methods (which their environment can't satisfy)
is impossible by construction.

## Considered options

- **Single module composing all plugin Method Traits (α).** One `AztecWPDb` with WC + EDD + MemberPress traits; consumers always get every method. Rejected because of actor-autocomplete pollution and runtime errors when methods are called without their plugin installed.
- **Package-per-plugin (γ).** Separate `aztecweb/aztec-edd-wp-browser` packages. Maximum isolation, but maintenance overhead from multiple repos, multiple release cadences, and cross-package version pinning. Rejected; revisit only if release cadences need to diverge.

## Consequences

- Adding a new plugin is a 0.x minor bump (introduce new Plugin Modules; existing consumers unaffected).
- Cross-plugin orchestration methods are deliberately not provided — consumers compose calls themselves in their Cests.
- Each Plugin Module pair lives in its own Plugin Subnamespace (e.g., `Aztec\WPBrowser\WooCommerce\Module\`), keeping plugin code physically grouped.
- ActionScheduler, which is a standalone library used by multiple plugins, gets its own subnamespace (`Aztec\WPBrowser\ActionScheduler\`) and its Method Trait is composed into Plugin Modules that need it.
