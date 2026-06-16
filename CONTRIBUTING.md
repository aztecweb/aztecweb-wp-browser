# CONTRIBUTING.md

Guidelines for contributing to `aztecweb-wp-browser`.

## Architecture: Plugin Modules & Method Traits

The library organizes functionality using a **Plugin Module** + **Method Trait** composition pattern.

### Plugin Module

A Codeception module dedicated to one WordPress plugin's domain (e.g., `AztecWPBrowser`). It:
- Extends `\Codeception\Module`
- Uses one or more **Method Traits** via `use` statements
- Provides abstract methods that Method Traits depend on (e.g., `wpDb()`, `wooCommerceConfig()`)
- Accesses sibling wp-browser modules via `getModule()` (e.g., `WPDb`, `WPWebDriver`)

### Method Trait

A PHP trait providing public actor methods for one cohesive domain (e.g., `CartMethods`, `CheckoutMethods`). It:
- Declares abstract methods for dependencies it needs
- Implements only methods related to its domain
- Is always composed into a Plugin Module via `use`

### Example

```php
// src/Method/CartMethods.php
trait CartMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;
    abstract protected function wpDb(): WPDb;
    
    public function addToCart(int $productId, int $quantity = 1): void
    {
        // Implementation using $this->wpWebDriver() and $this->wpDb()
    }
}

// src/AztecWPBrowser.php
class AztecWPBrowser extends \Codeception\Module
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

### Adding New Method Traits

1. Create trait in `src/Method/XxxMethods.php`
2. Declare abstract methods for required dependencies
3. Add `use XxxMethods;` to `src/AztecWPBrowser.php`
4. Create corresponding Page Object in `src/Page/` if needed
5. Add getter method to `PageObjectProvider` if new page object

## Directory Structure

```
src/
├── AztecWPBrowser.php       # Main Codeception module (uses traits)
├── Method/                   # Domain-specific method traits
│   ├── CartMethods.php
│   ├── CheckoutMethods.php
│   ├── CouponMethods.php
│   ├── CustomerMethods.php
│   ├── OrderMethods.php
│   └── ProductMethods.php
├── OrderStorage/             # Order storage strategies (HPOS vs Legacy)
│   ├── OrderStorageInterface.php
│   ├── AbstractOrderStorage.php
│   ├── HPOSOrderStorage.php   # WooCommerce HPOS (wc_orders table)
│   └── LegacyOrderStorage.php # Legacy (wp_posts table)
├── Page/                     # Page Objects for DOM selectors
│   ├── PageObjectProvider.php
│   └── CartPageObject.php
└── Config/                   # Configuration helpers
    └── WooCommerceConfig.php
```

## Mandatory Standards: Codeception / wp-browser / WPDb

**This is the most important rule of this project.**

You **MUST ALWAYS** follow the signatures, patterns, and conventions from:

1. **Codeception** framework
2. **lucatume/wp-browser** module
3. **WPDb** module

Even if you believe a different approach would be better, these standards take precedence. They ensure consistency with the consumer's existing test infrastructure.

### When Uncertain

1. Check the relevant `wp-browser` source code for the precedent pattern
2. Check the `WPDb` module for how similar assertions/operations are named and called
3. Consult [`CONTEXT.md`](CONTEXT.md) for our vocabulary before naming new concepts

### Pattern Examples

- Method naming follows wp-browser style: `havePostMetaInDatabase`, `grabPostMetaFromDatabase`
- Module configuration follows Codeception conventions
- Database interactions follow WPDb patterns
- Test structure follows Codeception Cest/Cept patterns

## Code Style

- PHP 8.0+ compatibility
- `declare(strict_types=1);` in all files
- PSR-4 autoloading: `Aztec\WPBrowser\` namespace
- **Docblocks (audience-driven rule)**:
  - **Required** on every public method of Plugin Modules (`AztecWPBrowser`) and Method Traits (`src/Method/*Methods.php`). Use the full wp-browser skeleton in this order: one-line summary → blank line → `@example` → `@param` → `@return` → `@throws` (when applicable). These methods are consumed by test authors via the generated `AcceptanceTester` actor and must be self-documenting.
  - **Optional** on non-public methods (private/protected) and on internal classes. Add a docblock only when the behavior is non-obvious from the name and signature.

## Testing Method Creation Guidelines

When creating new test methods (e.g., `haveXxxInDatabase`, `grabXxxFromDatabase`), follow the WPDb/wp-browser signature patterns.

### Method Types and Signatures

| Method Type | Naming | Return Type | Notes |
|-------------|---------|-------------|-------|
| **Create** | `have{Entity}InDatabase` | `int` | Returns ID |
| **Retrieve (ID)** | `grab{Entity}IdFromDatabase` | `int\|false` | Returns ID or false |
| **Retrieve (Field)** | `grab{Entity}FieldFromDatabase` | `mixed` | Returns field value (use `grabPostFieldFromDatabase`/`grabUserFieldFromDatabase`) |
| **Verify (Entity)** | `see{Entity}InDatabase` | `void` | Calls `seeInDatabase`/`seePostInDatabase`/`seeUserInDatabase` |
| **Verify (Meta)** | `see{Entity}MetaInDatabase` | `void` | Calls `seePostMetaInDatabase`/`seeUserMetaInDatabase` with array criteria |

### Entity Type to WPDb Method Mapping

| Entity | WP Table | See Method | See Meta Method | Grab Field Method |
|--------|----------|------------|------------------|-------------------|
| Product | wp_posts | `seePostInDatabase` | `seePostMetaInDatabase(array $criteria)` | `grabPostFieldFromDatabase` |
| Coupon | wp_posts | `seePostInDatabase` | `seePostMetaInDatabase(array $criteria)` | `grabPostFieldFromDatabase` |
| Customer | wp_users | `seeUserInDatabase` | `seeUserMetaInDatabase(array $criteria)` | `grabFromDatabase` (no specific method) |
| Order | wc_orders/wp_posts | `seeInDatabase` (direct on table) | `seeInDatabase` (direct on meta table) | `grabFromDatabase` (via OrderStorage) |

### Meta Method Implementation Pattern

For posts (Products/Coupons) and users (Customers), use `array $criteria` signature:

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

### Key Rules

1. Never manually throw exceptions in `seeXxxInDatabase` — call WPDb/Codeception assertion methods which throw automatically
2. Never use `assertIsNumeric` in `grabXxxIdFromDatabase` — just return the value or `false`
3. Always use `array $criteria` for meta methods — WPDb signatures require array, not separate parameters
4. For posts (Products/Coupons), map `product_id`/`coupon_id` to `post_id`
5. For users (Customers), map `customer_id` to `user_id`
6. For field retrieval, use `grabPostFieldFromDatabase`/`grabUserFieldFromDatabase` when available

## Database Column Naming

Follow WPDb pattern: use actual database column names, not abstractions.

```php
// ✅ Correct
$I->haveOrderItemInDatabase($orderId, [
    'order_item_name' => 'Product',
    'order_item_type' => 'line_item',
    'meta' => ['_product_id' => 123],
]);

// ❌ Incorrect (abstraction)
$I->haveOrderItemInDatabase($orderId, [
    'name' => 'Product',      // should be order_item_name
    'type' => 'line_item',    // should be order_item_type
]);
```

**Exception**: `haveOrderAddressInDatabase` uses abstract field names (`first_name`, `last_name`) to unify HPOS and Legacy storage. This abstraction is intentional.

## Order Storage: HPOS vs Legacy

WooCommerce supports two order storage modes. The module auto-detects and uses the appropriate storage via `OrderStorageInterface`.

### Storage Strategies

- **HPOS** (`HPOSOrderStorage`): Uses `wc_orders` table (WooCommerce 7.0+)
- **Legacy** (`LegacyOrderStorage`): Uses `wp_posts` table

### Key Differences

| Aspect | Legacy | HPOS |
|--------|--------|------|
| Table | `wp_posts` | `wc_orders` |
| Status field | `post_status` | `status` |
| Admin URL | `post.php?post={id}&action=edit` | `admin.php?page=wc-orders&action=edit&id={id}` |
| ID generation | Auto-increment (via `havePostInDatabase`) | Manual (must check max ID from both tables) |

Internal methods in `OrderMethods` handle storage detection automatically — no public actor method exposes HPOS state.

## Page Objects

Page objects hold **CSS selectors and page-specific logic**:

- Constants for CSS selectors (e.g., `PRODUCT_NAME_SELECTOR`)
- Methods that generate dynamic selectors (e.g., `cartItemQuantitySelector()`)

The `PageObjectProvider` allows **overriding page objects via config**, enabling customization for different themes:

```php
// In codeception.yml
modules:
    config:
        Aztec\WPBrowser\AztecWPBrowser:
            pageObjects:
                cart: \MyTheme\CustomCartPageObject
```

## Commands

All commands run inside the self-contained test runner image via the `bin/test` wrapper, which bind-mounts the repo at `/var/www/html`. See `README.md` for details on the image and GHCR tag scheme.

```bash
# One-time: install PHP dependencies (creates vendor/)
bin/test composer install

# One-time: bootstrap the SQLite WordPress site (idempotent)
bin/test bash resources/install.sh

# Run the full default suite
bin/test

# Run only the acceptance suite
bin/test codecept run acceptance

# Run a single test file
bin/test codecept run acceptance ProductCest

# Run a specific test method
bin/test codecept run acceptance ProductCest:testMethodName

# Rebuild Codeception actor classes (required after changing module method signatures)
bin/test codecept build

# HPOS (High-Performance Order Storage) management
bin/test wp wc hpos enable    # Enable HPOS before running OrderHPOSCest tests
bin/test wp wc hpos disable   # Disable HPOS before running OrderCest (Legacy) tests

# Drop into an interactive shell inside the image
bin/test bash
```

**Building and publishing the test runner image:** See `README.md` § "Building and publishing" and [#13](https://github.com/aztecweb/aztecweb-wp-browser/issues/13) for image build and CI workflow details. The image is published to GHCR per PHP variant; `bin/test` always uses the published image via the `AZTEC_TEST_IMAGE` environment variable (defaults to `php8.4`).
