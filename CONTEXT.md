# aztecweb-wp-browser

Plugin-aware Codeception modules for WordPress acceptance testing, built as
composition extensions over wp-browser. One pair of modules per supported
WordPress plugin (one for the DB layer, one for the browser layer); modules
compose Method Traits to assemble actor methods.

## Language

**Plugin Module**:
A Codeception module dedicated to one WordPress plugin's domain (e.g., `WooCommerceDb`, `WooCommerceWebDriver`); always extends `\Codeception\Module` and reaches wp-browser via `getModule()`.
_Avoid_: WP module, plugin extension, aztec module.

**Method Trait**:
A PHP trait providing public actor methods for one cohesive domain within a plugin (e.g., `CouponMethods`); composed into a Plugin Module via `use`.
_Avoid_: Helper trait, trait module.

**Plugin Subnamespace**:
A top-level namespace under `Aztec\WPBrowser\` dedicated to one WordPress plugin or shared library (e.g., `Aztec\WPBrowser\WooCommerce\`, `Aztec\WPBrowser\ActionScheduler\`); contains that plugin's Plugin Modules, Method Traits, and Page Objects.
_Avoid_: Plugin folder, plugin namespace (ambiguous with raw PHP namespaces).

**Class Alias Trick**:
The composer files-autoload mechanism that registers `Codeception\Module\X` as an alias for a Plugin Module's real class, so suite.yml can reference it by short name; lives in `src/aliases.php` with a safeguard against namespace squatting.
_Avoid_: Module shim, alias bridge.

**Sibling Module**:
A Codeception module enabled in the same suite, accessed by a Plugin Module via `$this->getModule()`; for this library, the relevant siblings are `WPDb` and `WPWebDriver` from wp-browser.
_Avoid_: Dependency module, parent module.

**Actor**:
The test pseudo-user (`$I` in Cest files), assembled by Codeception from the public methods of all enabled modules — including the library's Plugin Modules and their composed Method Traits.
_Avoid_: Tester (reserved for the concrete class name `AcceptanceTester`).

**HPOS**:
WooCommerce's High-Performance Order Storage feature — orders persisted in custom tables (`wp_wc_orders` family) rather than `wp_posts`/`wp_postmeta`; **detected privately inside `WooCommerceDb`** with no public actor method exposing the state.
_Avoid_: Custom orders table, COT, HPOS mode.

**First-class library**:
The project's stated quality target — equipped with level-max static analysis, semver-disciplined releases, polished README, and CI gates from day one, even though external adoption is deferred.
_Avoid_: Production-ready (vague), enterprise-grade (marketing).

## Relationships

- A **Plugin Subnamespace** contains one or more **Plugin Modules** plus all their **Method Traits** and any Page Objects.
- A **Plugin Module** is composed of one or more **Method Traits** via `use` statements.
- A **Plugin Module** declares **Sibling Module** requirements in `_initialize()` and accesses them via `getModule()`.
- The **Class Alias Trick** maps `\Codeception\Module\X` to a **Plugin Module**'s real class so consumers reference it by short name.
- **HPOS** is internal to the WooCommerce **Plugin Subnamespace**; the WebDriver **Plugin Module** has no awareness of it.

## Example dialogue

> **Contributor:** "I want to add Easy Digital Downloads (EDD) support. Should I add traits to `WooCommerceDb`?"
>
> **Maintainer:** "No — separate plugin, separate **Plugin Subnamespace**. Create `Aztec\WPBrowser\Edd\` containing an `EddDb` and `EddWebDriver` **Plugin Module**, with **Method Traits** under `Aztec\WPBrowser\Edd\Method\`. Both `EddDb` and `WooCommerceDb` independently use `getModule('WPDb')` for the **Sibling** wp-browser module."
>
> **Contributor:** "What if I need a method that creates a WooCommerce order *and* an EDD download in one shot?"
>
> **Maintainer:** "Don't. Cross-plugin orchestration belongs in the consumer's Cest, not in the library. Compose `$I->haveOrderInDatabase(...)` followed by `$I->haveDownloadInDatabase(...)` in the test. Each **Plugin Module** stays focused on its plugin's concern."
>
> **Contributor:** "Why is there no `$I->isHposEnabled()`?"
>
> **Maintainer:** "**HPOS** is a backend storage detail; the browser layer has no business knowing about it. Methods that need HPOS-aware behavior handle it internally. If a page object ever needs the answer, it detects HPOS itself — it doesn't ask a Plugin Module."

## Flagged ambiguities

- "Module" (generic Codeception term) vs. **Plugin Module** (this library's plugin-flavored modules) — when ambiguous, default to **Plugin Module**.
- "Trait" (generic PHP construct) vs. **Method Trait** (this library's actor-method-providing traits in `src/{Plugin}/Method/`) — default to the qualified term.
- "HPOS detection" — implementation detail; never expose as part of the actor or any module's public API.
