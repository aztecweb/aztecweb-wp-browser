---
name: create-woocommerce-codeception-module
description: Guide for creating WooCommerce test methods following AztecWPBrowser conventions
---

# SKILL.md - Test Methods Guide for WooCommerce

This document serves as a quick guide for creating test methods following the AztecWPBrowser project conventions.

## Related Documentation
- **[REFERENCE.md](./REFERENCE.md)**: Detailed analysis of Codeception and lucatume/wp-browser architecture, method patterns, and conventions

## Implementation Standards
Test methods MUST follow the patterns of the `lucatume/wp-browser` and Codeception architecture, naming, method objectives, method usage, etc.

## Execution Instructions
1. Identify, in the prompt, the entities (whether they are post types, meta, taxonomies, etc.) and methods that will be created. 
2. Create a complete list of methods to be created. If there are methods not in the prompt but follow the `Implementation Standards`, they should be listed for creation.
3. Create a PRD file in the `/prd/` directory using the `/prd` skill with detailed implementation
4. Review the created PRD file and validate all user stories and methods to be created according to the `Implementation Standards`.
5. Implement the methods within the `src/{entity}Methods.php` file. Update existing file if the entity already exists, otherwise create new.
6. Create acceptance tests to test the created methods within the `tests/acceptance` directory. Create a `{entity}Cest.php` file if the entity doesn't exist, update if it does.
7. Ensure these tests pass according to `Testing Philosophy`

## Method Structure

### Method Types and Signatures

| Type | Naming | Return | Notes |
|------|-------------|---------|-------|
| **Create** | `have{Entity}InDatabase` | `int` | Returns the ID |
| **Retrieve (ID)** | `grab{Entity}IdFromDatabase` | `int\|false` | Returns ID or false |
| **Retrieve (Field)** | `grab{Entity}FieldFromDatabase` | `mixed` | Returns field value |
| **Verify (Entity)** | `see{Entity}InDatabase` | `void` | Calls WPDb methods |
| **Verify (Meta)** | `see{Entity}MetaInDatabase` | `void` | With array of criteria |

## Entity Mapping

| Entity | WP Table | See Method | See Meta Method | Grab Field Method |
|--------|----------|------------|-----------------|-------------------|
| Product | wp_posts | `seePostInDatabase` | `seePostMetaInDatabase(array $criteria)` | `grabPostFieldFromDatabase` |
| Coupon | wp_posts | `seePostInDatabase` | `seePostMetaInDatabase(array $criteria)` | `grabPostFieldFromDatabase` |
| Customer | wp_users | `seeUserInDatabase` | `seeUserMetaInDatabase(array $criteria)` | `grabFromDatabase` |
| Order | wc_orders/wp_posts | `seeInDatabase` | `seeInDatabase` | `grabFromDatabase` |

## Testing Philosophy

### Acceptance Test Coverage Requirements

**All acceptance tests must cover ALL methods** in the module. When creating new tests:

1. **Comprehensive Coverage**: Ensure every public method in the module has at least one test
2. **Domain Testing**: Test each method trait separately:
    - Cart methods in `tests/acceptance/CartCest.php`
    - Checkout methods in `tests/acceptance/CheckoutCest.php`
    - Coupon methods in `tests/acceptance/CouponCest.php`
    - Customer methods in `tests/acceptance/CustomerCest.php`
    - Order methods in `tests/acceptance/OrderCest.php`
    - Product methods in `tests/acceptance/ProductCest.php`

3. **Test Requirements**:
    - Test both success and failure scenarios
    - Test edge cases and boundary conditions
    - Test method combinations that work together
    - Include tests for HPOS and Legacy storage modes where applicable

4. **Test Naming**: Use descriptive test method names that clearly indicate what's being tested

## WooCommerce References

For WooCommerce-specific documentation and method references, always consult:
- `vendor/woocommerce/src` - WooCommerce source code
- WooCommerce developer documentation: [WooCommerce Docs](https://woocommerce.github.io/code-reference/)
- WooCommerce hooks, filters, and database tables documentation

## Implementation Standards

### Meta Methods

```php
// For products/coupons (posts)
public function seeProductMetaInDatabase(array $criteria): void
{
    $criteria['post_id'] = $criteria['product_id'];
    unset($criteria['product_id']);
    $this->wpDb()->seePostMetaInDatabase($criteria);
}

// For customers (users)
public function seeCustomerMetaInDatabase(array $criteria): void
{
    $criteria['user_id'] = $criteria['customer_id'];
    unset($criteria['customer_id']);
    $this->wpDb()->seeUserMetaInDatabase($criteria);
}
```

### Essential Rules

1. **NEVER** manually throw exceptions in `seeXxxInDatabase` - use WPDb/Codeception methods
2. **NEVER** use `assertIsNumeric` in `grabXxxIdFromDatabase` - return the value or `false`
3. **ALWAYS** use `array $criteria` for meta methods
4. For posts: map `product_id`/`coupon_id` to `post_id`
5. For users: map `customer_id` to `user_id`
6. For fields: use `grabPostFieldFromDatabase`/`grabUserFieldFromDatabase`

## Database Column Naming

Use actual database column names, not abstractions:

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

**Exception**: `haveOrderAddressInDatabase` uses abstract field names (`first_name`, `last_name`) to unify HPOS and Legacy.

## Trait Structure

Every new trait must follow the pattern:

```php
trait XxxMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;
    abstract protected function wpDb(): WPDb;
    abstract protected function wooCommerceConfig(): WooCommerceConfig;
    abstract protected function pageObjectProvider(): PageObjectProvider;

    // ... trait methods
}
```

## Codeception Build

After changing method signatures, **ALWAYS** execute:

```bash
docker compose -f docker-compose.test.yml exec php vendor/bin/codecept build
```

This regenerates the actor classes in `tests/_support/_generated/`.

## Golden Rule

**ALWAYS** follow the conventions of:
1. Codeception framework
2. lucatume/wp-browser module
3. WPDb module

Even if the user asks for something different, question it and suggest the correct pattern.