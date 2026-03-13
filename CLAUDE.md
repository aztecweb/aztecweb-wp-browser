# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Codeception module library for WooCommerce acceptance tests. It extends `lucatume/wp-browser` to provide high-level helpers for testing WooCommerce functionality in WordPress.

## Commands

```bash
# Install dependencies
composer install

# Start test environment (required before running tests)
make test-up

# Stop test environment
make test-down

# Run tests (when available)
composer test
# Or directly: vendor/bin/codecept run

# Run tests via Docker Compose
docker compose -f docker-compose.test.yml exec php vendor/bin/codecept run tests/acceptance/{nome-arquivo}.php

# Run a single test file
docker compose -f docker-compose.test.yml exec php vendor/bin/codecept run tests/acceptance/ProductCest.php

# Run specific test method
docker compose -f docker-compose.test.yml exec php vendor/bin/codecept run tests/acceptance/ProductCest.php:testMethodName

# Rebuild Codeception actor classes (required after changing module method signatures)
docker compose -f docker-compose.test.yml exec php vendor/bin/codecept build

# HPOS (High-Performance Order Storage) management
make hpos-enable   # Enable HPOS before running OrderHPOSCest tests
make hpos-disable  # Disable HPOS before running OrderCest (Legacy) tests
```

## Architecture

### Module Pattern (Traits)

The main module `AztecWPBrowser` uses **traits to organize functionality by domain**:

- `src/Method/CartMethods.php` - Cart operations
- `src/Method/CheckoutMethods.php` - Checkout operations
- `src/Method/CouponMethods.php` - Coupon operations
- `src/Method/CustomerMethods.php` - Customer operations
- `src/Method/OrderMethods.php` - Order operations
- `src/Method/ProductMethods.php` - Product operations

Each trait **must declare abstract methods** for the dependencies it needs:
```php
trait CartMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;
    abstract protected function wpDb(): WPDb;
    abstract protected function wooCommerceConfig(): WooCommerceConfig;
    abstract protected function pageObjectProvider(): PageObjectProvider;
    // ... trait methods
}
```

The main module (`AztecWPBrowser`) provides these dependencies via concrete methods.

### Directory Structure

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

### Order Storage (HPOS vs Legacy)

WooCommerce has two order storage modes. The module auto-detects and uses the appropriate storage:

- **HPOS** (`HPOSOrderStorage`): Uses `wc_orders` table (WooCommerce 7.0+)
- **Legacy** (`LegacyOrderStorage`): Uses `wp_posts` table

The storage is selected automatically based on the `woocommerce_custom_orders_table_enabled` option.

#### Key Differences

| Aspect | Legacy | HPOS |
|--------|--------|------|
| Table | `wp_posts` | `wc_orders` |
| Status field | `post_status` | `status` |
| Admin URL | `post.php?post={id}&action=edit` | `admin.php?page=wc-orders&action=edit&id={id}` |
| ID generation | Auto-increment (via `havePostInDatabase`) | Manual (must check max ID from both tables) |

### Page Objects

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

### Adding New Method Traits

1. Create trait in `src/Method/XxxMethods.php`
2. Declare abstract methods for required dependencies
3. Add `use XxxMethods;` to `AztecWPBrowser.php`
4. Create corresponding Page Object in `src/Page/` if needed
5. Add getter method to `PageObjectProvider` if new page object

### Code Style

- PHP 8.0+ compatibility
- `declare(strict_types=1);` in all files
- PSR-4 autoloading: `Aztec\WPBrowser\` namespace
- **Do NOT generate docblocks** - keep code clean without PHPDoc comments

### Testing Method Creation Guidelines

When creating new test methods, follow the WPDb/wp-browser signature patterns:

#### Method Types and Signatures

| Method Type | Naming | Return Type | Notes |
|-------------|---------|-------------|-------|
| **Create** | `have{Entity}InDatabase` | `int` | Returns ID |
| **Retrieve (ID)** | `grab{Entity}IdFromDatabase` | `int|false` | Returns ID or false |
| **Retrieve (Field)** | `grab{Entity}FieldFromDatabase` | `mixed` | Returns field value (use `grabPostFieldFromDatabase`/`grabUserFieldFromDatabase`) |
| **Verify (Entity)** | `see{Entity}InDatabase` | `void` | Calls `seeInDatabase`/`seePostInDatabase`/`seeUserInDatabase` |
| **Verify (Meta)** | `see{Entity}MetaInDatabase` | `void` | Calls `seePostMetaInDatabase`/`seeUserMetaInDatabase` with array criteria |

#### Entity Type to WPDb Method Mapping

| Entity | WP Table | See Method | See Meta Method | Grab Field Method |
|--------|----------|------------|------------------|-------------------|
| Product | wp_posts | `seePostInDatabase` | `seePostMetaInDatabase(array $criteria)` | `grabPostFieldFromDatabase` |
| Coupon | wp_posts | `seePostInDatabase` | `seePostMetaInDatabase(array $criteria)` | `grabPostFieldFromDatabase` |
| Customer | wp_users | `seeUserInDatabase` | `seeUserMetaInDatabase(array $criteria)` | `grabFromDatabase` (no specific method) |
| Order | wc_orders/wp_posts | `seeInDatabase` (direct on table) | `seeInDatabase` (direct on meta table) | `grabFromDatabase` (via OrderStorage) |

#### Meta Method Implementation Pattern

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

#### Key Rules

1. Never manually throw exceptions in `seeXxxInDatabase` - call WPDb/Codeception assertion methods which throw automatically
2. Never use `assertIsNumeric` in `grabXxxIdFromDatabase` - just return the value or `false`
3. Always use `array $criteria` for meta methods - WPDb signatures require array, not separate parameters
4. For posts (Products/Coupons), map `product_id`/`coupon_id` to `post_id`
5. For users (Customers), map `customer_id` to `user_id`
6. For field retrieval, use `grabPostFieldFromDatabase`/`grabUserFieldFromDatabase` when available

### Database Column Naming

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

### Codeception Build

After changing method signatures in module traits (e.g., adding default parameters), you **must** run:

```bash
docker compose -f docker-compose.test.yml exec php vendor/bin/codecept build
```

This regenerates the actor classes in `tests/_support/_generated/`. Without this, tests will fail with `ArgumentCountError` even if the source code is correct.

## CRITICAL: Codeception / wp-browser / WPDb Standards

**This is the most important rule of this project.**

### Mandatory Compliance

You **MUST ALWAYS** follow the signatures, patterns, and conventions from:

1. **Codeception** framework
2. **lucatume/wp-browser** module
3. **WPDb** module

### When User Requests Conflict with Standards

Even if the user explicitly asks for something different:

1. **STOP and question the request** - explain why it deviates from established patterns
2. **Suggest the correct approach** based on Codeception/wp-browser/WPDb conventions
3. **Never implement** code that breaks consistency with these frameworks without explicit acknowledgment

### Pattern Examples

- Method naming follows wp-browser style: `havePostMetaInDatabase`, `grabPostMetaFromDatabase`
- Module configuration follows Codeception conventions
- Database interactions follow WPDb patterns
- Test structure follows Codeception Cest/Cept patterns

### References

Always consult and align with:
- Codeception documentation and source code
- lucatume/wp-browser source code and patterns
- WPDb module conventions

**This rule overrides user preferences when they conflict with framework standards.**
