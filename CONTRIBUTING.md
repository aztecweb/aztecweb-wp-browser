# Contributing

Guidelines for working **in** `aztecweb-wp-browser`. New here? Start with
[`AGENTS.md`](AGENTS.md) for the dev workflow, then read [`CONTEXT.md`](CONTEXT.md)
for the shared vocabulary used throughout this document.

This is a [**First-class library**](CONTEXT.md): level-max static analysis,
semver-disciplined releases, and green CI are gates from day one, even though
external adoption is deferred. Hold contributions to that bar.

## Architecture: Plugin Modules & Method Traits

The library favours **composition over inheritance**
([ADR-0002](docs/adr/0002-composition-over-extension.md)): a module assembles its
actor methods from domain-specific traits instead of extending a base module.

### Plugin Module

A Codeception module dedicated to one WordPress plugin's domain (e.g.,
`WooCommerceDb` for the DB layer, `WooCommerceWebDriver` for the browser layer).
It:

- Extends `\Codeception\Module`
- Composes one or more **Method Traits** via `use` statements
- Provides the concrete dependency accessors the traits declare as abstract
  (e.g., `wpDb()`, `wooCommerceConfig()`)
- Reaches **Sibling Modules** (`WPDb`, `WPWebDriver` from wp-browser) through
  `getModule()`

Capabilities are split **one module per plugin concern**
([ADR-0003](docs/adr/0003-module-per-plugin-architecture.md)): a DB-layer module
and a browser-layer module per supported plugin.

### Method Trait

A PHP trait providing public **Actor** methods for one cohesive domain within a
plugin (e.g., `CouponMethods`, `CartMethods`). It:

- Declares abstract methods for the dependencies it needs
- Implements only methods related to its domain
- Is always composed into a Plugin Module via `use`

```php
// Method Trait — one cohesive domain
trait CartMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;
    abstract protected function wpDb(): WPDb;

    public function addProductToCart(int $productId, int $quantity = 1): void
    {
        // Implementation using $this->wpWebDriver() and $this->wpDb()
    }
}

// Plugin Module — composes the traits and supplies their dependencies
class WooCommerceWebDriver extends \Codeception\Module
{
    use CartMethods;

    protected function wpWebDriver(): WPWebDriver
    {
        return $this->getModule('WPWebDriver');
    }

    protected function wpDb(): WPDb
    {
        return $this->getModule('WPDb');
    }
}
```

### Plugin Subnamespace

Each plugin (or shared library) gets a top-level namespace under
`Aztec\WPBrowser\` — e.g. `Aztec\WPBrowser\WooCommerce\`,
`Aztec\WPBrowser\ActionScheduler\` — holding that plugin's Plugin Modules, Method
Traits, and Page Objects. Cross-plugin orchestration does **not** belong in the
library; consumers compose actor methods in their own Cests.

### Class Alias Trick

So suites can enable modules by short name (`WooCommerceDb`) instead of the
fully-qualified class, the composer `files` autoload registers
`Codeception\Module\WooCommerceDb` as an alias for the real class. The mechanism
lives in [`src/aliases.php`](src/aliases.php) and guards against namespace
squatting (it skips the alias, with a warning, on collision). See
[ADR-0004](docs/adr/0004-class-alias-trick.md).

### Adding a new Method Trait

1. Create the trait under the plugin's `Method/` directory (e.g.
   `Aztec\WPBrowser\WooCommerce\Method\XxxMethods`)
2. Declare abstract methods for the dependencies it needs
3. Add `use XxxMethods;` to the relevant Plugin Module
4. Create a corresponding Page Object if the trait needs new selectors
5. Register the Page Object getter on `PageObjectProvider`
6. Rebuild the actor (see [Codeception build](#codeception-build))

## Mandatory standards: Codeception / wp-browser / WPDb

**This is the most important rule of this project.**

You **MUST ALWAYS** follow the signatures, patterns, and conventions of:

1. The **Codeception** framework
2. The **lucatume/wp-browser** module
3. The **WPDb** module

These standards take precedence **even when a different approach seems better, and
even when a request asks for something else**. They keep the library consistent
with the consumer's existing wp-browser test infrastructure. If a request
conflicts with them, stop, explain the deviation, and propose the conventional
approach before writing code.

### When uncertain

1. Check the relevant `wp-browser` source for the precedent pattern
2. Check the `WPDb` module for how similar assertions/operations are named and
   called
3. Consult [`CONTEXT.md`](CONTEXT.md) for our vocabulary before naming new concepts

### Pattern examples

- Method naming follows wp-browser style: `havePostMetaInDatabase`,
  `grabPostMetaFromDatabase`
- Module configuration follows Codeception conventions
- Database interactions follow WPDb patterns
- Test structure follows Codeception Cest/Cept patterns

## Code style

- PHP 8.0+ compatibility
- `declare(strict_types=1);` in all files
- PSR-4 autoloading under the `Aztec\WPBrowser\` namespace
- **Docblocks (audience-driven rule)**:
  - **Required** on every public method of Plugin Modules and Method Traits. Use
    the full wp-browser skeleton in this order: one-line summary → blank line →
    `@example` → `@param` → `@return` → `@throws` (when applicable). These methods
    are consumed by test authors via the generated Actor and must be
    self-documenting.
  - **Optional** on non-public methods (private/protected) and internal classes.
    Add a docblock only when the behavior is non-obvious from the name and
    signature.

## Testing method creation guidelines

When adding test methods (`haveXxxInDatabase`, `grabXxxFromDatabase`, …), follow
the WPDb/wp-browser signature patterns.

### Method types and signatures

| Method Type        | Naming                       | Return Type  | Notes                                                                                         |
| ------------------ | ---------------------------- | ------------ | --------------------------------------------------------------------------------------------- |
| **Create**         | `have{Entity}InDatabase`     | `int`        | Returns ID                                                                                    |
| **Retrieve (ID)**  | `grab{Entity}IdFromDatabase` | `int\|false` | Returns ID or `false`                                                                         |
| **Retrieve (Field)** | `grab{Entity}FieldFromDatabase` | `mixed`  | Returns field value (use `grabPostFieldFromDatabase`/`grabUserFieldFromDatabase`)             |
| **Verify (Entity)** | `see{Entity}InDatabase`     | `void`       | Calls `seeInDatabase`/`seePostInDatabase`/`seeUserInDatabase`                                  |
| **Verify (Meta)**  | `see{Entity}MetaInDatabase`  | `void`       | Calls `seePostMetaInDatabase`/`seeUserMetaInDatabase` with array criteria                     |

### Entity type to WPDb method mapping

| Entity   | WP Table          | See Method                       | See Meta Method                       | Grab Field Method                  |
| -------- | ----------------- | -------------------------------- | ------------------------------------- | ---------------------------------- |
| Product  | `wp_posts`        | `seePostInDatabase`              | `seePostMetaInDatabase(array)`        | `grabPostFieldFromDatabase`        |
| Coupon   | `wp_posts`        | `seePostInDatabase`              | `seePostMetaInDatabase(array)`        | `grabPostFieldFromDatabase`        |
| Customer | `wp_users`        | `seeUserInDatabase`              | `seeUserMetaInDatabase(array)`        | `grabFromDatabase` (no specific method) |
| Order    | `wc_orders`/`wp_posts` | `seeInDatabase` (direct on table) | `seeInDatabase` (direct on meta table) | `grabFromDatabase` (via order storage) |

### Meta method implementation pattern

For posts (Products/Coupons) and users (Customers), use the `array $criteria`
signature:

```php
// Pattern for Products/Coupons (posts)
public function seeProductMetaInDatabase(array $criteria): void
{
    $criteria['post_id'] = $criteria['product_id'];
    unset($criteria['product_id']);
    $this->wpDb()->seePostMetaInDatabase($criteria);
}

// Pattern for Customers (users)
public function seeCustomerMetaInDatabase(array $criteria): void
{
    $criteria['user_id'] = $criteria['customer_id'];
    unset($criteria['customer_id']);
    $this->wpDb()->seeUserMetaInDatabase($criteria);
}
```

### Key rules

1. Never manually throw exceptions in `seeXxxInDatabase` — call WPDb/Codeception
   assertion methods, which throw automatically
2. Never use `assertIsNumeric` in `grabXxxIdFromDatabase` — just return the value
   or `false`
3. Always use `array $criteria` for meta methods — WPDb signatures require an
   array, not separate parameters
4. For posts (Products/Coupons), map `product_id`/`coupon_id` to `post_id`
5. For users (Customers), map `customer_id` to `user_id`
6. For field retrieval, use `grabPostFieldFromDatabase`/`grabUserFieldFromDatabase`
   when available

### Database column naming

Follow the WPDb pattern: use the actual database column names, not abstractions.

```php
// ✅ Correct
$I->haveOrderItemInDatabase($orderId, [
    'order_item_name' => 'Product',
    'order_item_type' => 'line_item',
    'meta' => ['_product_id' => 123],
]);

// ❌ Incorrect (abstraction)
$I->haveOrderItemInDatabase($orderId, [
    'name' => 'Product',   // should be order_item_name
    'type' => 'line_item', // should be order_item_type
]);
```

**Exception**: `haveOrderAddressInDatabase` uses abstract field names
(`first_name`, `last_name`) to unify HPOS and Legacy storage. This abstraction is
intentional.

## Order storage: HPOS vs Legacy

WooCommerce persists orders in two ways, and the DB-layer Plugin Module detects
which is active and selects the matching storage strategy — **privately**. Per
[ADR-0005](docs/adr/0005-hpos-detection-encapsulation.md), **HPOS** detection is
encapsulated: no public actor method exposes the state (there is no
`$I->isHposEnabled()`), so tests stay storage-agnostic.

| Aspect        | Legacy                              | HPOS                                              |
| ------------- | ----------------------------------- | ------------------------------------------------- |
| Table         | `wp_posts`                          | `wc_orders`                                       |
| Status field  | `post_status`                       | `status`                                          |
| Admin URL     | `post.php?post={id}&action=edit`    | `admin.php?page=wc-orders&action=edit&id={id}`    |
| ID generation | Auto-increment (via `havePostInDatabase`) | Manual (must check max ID across both tables) |

## Page Objects

Page Objects hold **CSS selectors and page-specific logic** — selector constants
(e.g. `PRODUCT_NAME_SELECTOR`) and methods that build dynamic selectors (e.g.
`cartItemQuantitySelector()`).

`PageObjectProvider` lets consumers **override** Page Objects via config, enabling
customization for different themes:

```yaml
# In codeception.yml / the suite config
modules:
    config:
        WooCommerceWebDriver:
            pageObjects:
                cart: \MyTheme\CustomCartPageObject
```

## Codeception build

After **installing dependencies** or **changing a method signature** in a Plugin
Module or Method Trait, rebuild the actor classes:

```bash
bin/test codecept build
```

Without this, tests fail with `ArgumentCountError` even when the source is
correct — the generated actor in `tests/_support/_generated/` is stale. (`bin/test`
is the contributor wrapper; see [`AGENTS.md`](AGENTS.md) for the full command set.)

## Agent skills

This repo's maintainer workflows are documented for AI agents under
[`docs/agents/`](docs/agents/):

- **Issue tracker** — issues live in GitHub Issues (`aztecweb/aztecweb-wp-browser`).
  See [`docs/agents/issue-tracker.md`](docs/agents/issue-tracker.md).
- **Triage labels** — the default five-role vocabulary (`needs-triage`,
  `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`).
  See [`docs/agents/triage-labels.md`](docs/agents/triage-labels.md).
- **Domain docs** — single-context repo: one `CONTEXT.md` and `docs/adr/` at the
  root. See [`docs/agents/domain.md`](docs/agents/domain.md).

For the design rationale behind the architecture above, read the relevant ADR in
[`docs/adr/`](docs/adr/) before changing behavior in the area it covers.
