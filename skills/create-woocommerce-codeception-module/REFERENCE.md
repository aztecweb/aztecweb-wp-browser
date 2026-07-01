# Analysis: Codeception and lucatume/wp-browser

## Context

This analysis documents the structure, method patterns, and architecture of the Codeception and lucatume/wp-browser packages, serving as a reference for WordPress/WooCommerce test development.

---

## 1. Method Naming Patterns

### 1.1 Method Prefixes (Codeception Convention)

| Prefix | Purpose | Return |
|--------|---------|---------|
| `have` | Create/insert data in database | `int` (ID) or `array` |
| `grab` | Retrieve data from database/DOM elements | `mixed`, `string`, `array` |
| `see` | Verify/assert that something exists | `void` |
| `dontSee` | Verify/assert that something does NOT exist | `void` |
| `am` | Navigate/change state | `void` |
| `cant` | Negative verification (less common) | `void` |

### 1.2 Naming Conventions

**Database Methods:**
- `{have|grab|see}{Entity}{In|From}Database(...)`
- `{have|grab|see}{Entity}Meta{In|From}Database(...)`
- `grab{TableName}(): string` - returns table name

**WPDb Examples:**
```php
// Create
$I->havePostInDatabase(['post_title' => 'Test']);
$I->haveUserInDatabase('login', 'subscriber');
$I->haveTermInDatabase('name', 'taxonomy');

// Retrieve
$I->grabPostIdFromDatabase('Title');
$I->grabPostMetaFromDatabase($postId, '_price', true);
$I->grabColumnFromDatabase($table, 'column', $criteria);

// Verify
$I->seePostInDatabase(['post_title' => 'Test']);
$I->seeUserInDatabase(['user_login' => 'admin']);
$I->seeInDatabase($table, $criteria);
```

**Navigation/Interaction Methods:**
- `am{Page}(): void` - navigate to specific page
- `amOn{Page}Page(): void` - navigate to specific page
- `fill{Form}Field($field, $value): void` - fill field

**WPWebDriver Examples:**
```php
// Navigation
$I->amOnPage('/my-page');
$I->amOnAdminPage('/plugins.php');
$I->amEditingPostWithId($postId);

// Interaction
$I->loginAsAdmin();
$I->fillField('#email', 'test@example.com');
$I->click('#submit-button');
$I->waitForElement('.loaded');
```

---

## 2. Codeception Architecture

### 2.1 Module Structure

```
Codeception\Module
├── Db.php              # Base database module
├── Asserts.php          # Assertion module (wraps PHPUnit)
├── WebDriver.php          # Browser automation module
├── PhpBrowser.php         # Headless browser
├── Filesystem.php         # Filesystem operations
└── Cli.php               # CLI operations
```

### 2.2 Inheritance and Traits Pattern

```php
namespace Codeception\Module;

use Codeception\Module;  // Abstract base class

class MyModule extends Module
{
    // Module-specific methods
}
```

**Organization traits:**
```php
trait MyMethods
{
    abstract protected function wpDb(): WPDb;
    abstract protected function wpWebDriver(): WPWebDriver;

    public function myCustomMethod(): void
    {
        // Implementation using abstract methods
    }
}

class MainModule extends Module
{
    use MyMethods;

    // Implementation of abstract methods
    protected function wpDb(): WPDb { ... }
    protected function wpWebDriver(): WPWebDriver { ... }
}
```

### 2.3 Module Lifecycle

```php
class Module
{
    // 1. Configuration
    protected $config = [...];
    protected $requiredFields = [...];

    protected function _initialize(): void { /* Configured */ }
    protected function _beforeSuite(): void { /* Before suite */ }
    protected function _before(\Codeception\TestInterface $test): void { /* Before test */ }
    protected function _after(\Codeception\TestInterface $test): void { /* After test */ }
    protected function _afterSuite(): void { /* After suite */ }
}
```

---

## 3. lucatume/wp-browser Architecture

### 3.1 Main Modules

```
lucatume\WPBrowser\Module
├── WPDb.php             # Extends Codeception\Db - WordPress DB operations
├── WPWebDriver.php       # Extends Codeception\WebDriver - browser + WordPress
├── WPBrowser.php        # Browser without WebDriver (headless)
├── WPFilesystem.php     # WordPress filesystem operations
├── WPCLI.php            # WP-CLI integration
└── WPLoader.php          # Loads WordPress for unit tests
```

### 3.2 WPDb - Methods by Entity

**Posts (articles/pages/products):**
```php
// Create
havePostInDatabase(array $data): int
havePageInDatabase(array $overrides): int
haveManyPostsInDatabase(int $count, array $overrides): array
havePostmetaInDatabase(int $postId, string $meta_key, mixed $meta_value): int

// Retrieve
grabPostIdFromDatabase(array $criteria): int|false
grabPostFieldFromDatabase(int $postId, string $field): mixed
grabPostMetaFromDatabase(int $postId, string $metaKey, bool $single = false): mixed
grabPostsTableName(): string
grabPostmetaTableName(): string

// Verify
seePostInDatabase(array $criteria): void
seePageInDatabase(array $criteria): void
seePostMetaInDatabase(array $criteria): void
```

**Users:**
```php
// Create
haveUserInDatabase(string $userLogin, string $role, array $data = []): int
haveManyUsersInDatabase(int $count, array $overrides): array
haveUserMetaInDatabase(int $userId, string $meta_key, mixed $meta_value): array
haveUserCapabilitiesInDatabase(int $userId, string|array $role): array
haveUserLevelsInDatabase(int $userId, array|string $role): array

// Retrieve
grabUserIdFromDatabase(string $userLogin): int|false
grabUserMetaFromDatabase(int $userId, string $meta_key, bool $single = false): mixed
grabUsersTableName(): string
grabUsermetaTableName(): string

// Verify
seeUserInDatabase(array $criteria): void
seeUserMetaInDatabase(array $criteria): void
```

**Terms (categories/tags):**
```php
// Create
haveTermInDatabase(string $name, string $taxonomy, array $overrides = []): array
haveManyTermsInDatabase(int $count, string $name, string $taxonomy, array $overrides = []): array
haveTermMetaInDatabase(int $term_id, string $meta_key, mixed $meta_value): int
haveTermRelationshipInDatabase(int $object_id, int $term_taxonomy_id, int $term_order = 0): void

// Retrieve
grabTermIdFromDatabase(array $criteria): int|false
grabTermTaxonomyIdFromDatabase(array $criteria): int|false
grabTermsTableName(): string
grabTermTaxonomyTableName(): string
grabTermRelationshipsTableName(): string

// Verify
seeTermInDatabase(array $criteria): void
seeTermTaxonomyInDatabase(array $criteria): void
seeTermMetaInDatabase(array $criteria): void
seeTermRelationshipInDatabase(array $criteria): void
```

**Comments:**
```php
// Create
haveCommentInDatabase(int $comment_post_ID, array $data = []): int
haveManyCommentsInDatabase(int $count, int $comment_post_ID, array $overrides = []): array
haveCommentMetaInDatabase(int $comment_id, string $meta_key, mixed $meta_value): int

// Retrieve
grabCommentsTableName(): string
grabCommentmetaTableName(): string

// Verify
seeCommentInDatabase(array $criteria): void
seeCommentMetaInDatabase(array $criteria): void
```

**Options/Transients:**
```php
// Create
haveOptionInDatabase(string $option_name, mixed $option_value, string $autoload = 'yes'): int
haveSiteOptionInDatabase(string $key, mixed $value): int
haveTransientInDatabase(string $transient, mixed $value): int
haveSiteTransientInDatabase(string $key, mixed $value): int

// Retrieve
grabOptionFromDatabase(string $option_name): mixed
grabSiteOptionFromDatabase(string $key): mixed
grabTransientFromDatabase(string $transient): mixed

// Verify
seeOptionInDatabase(array|string $criteriaOrName, mixed $value = null): void
seeSiteOptionInDatabase(array|string $criteriaOrName, mixed $value = null): void
seeTransientInDatabase(string $name, mixed $value = null): void
```

**Multisite:**
```php
// Blogs
haveBlogInDatabase(string $domainOrPath, array $overrides = [], bool $subdomain = true): int
haveManyBlogsInDatabase(int $count, array $overrides = [], bool $subdomain = true): array
grabBlogsTableName(): string
grabBlogTableName(int $blogId, string $table): string
seeBlogInDatabase(array $criteria): void

// Site Meta
haveSiteMetaInDatabase(int $blogId, string $key, mixed $value): int
grabSiteMetaFromDatabase(int $blogId, string $key, bool $single): mixed
```

**Attachments/Menus:**
```php
// Attachments
haveAttachmentInDatabase(array $overrides = []): int
seeAttachmentInDatabase(array $criteria): void
grabAttachmentAttachedFile(int $attachmentPostId): string
grabAttachmentMetadata(int $attachmentPostId): array

// Menus
haveMenuInDatabase(string $slug, string $location, array $overrides = []): array
haveMenuItemInDatabase(array $overrides = []): int

// Post Thumbnail
havePostThumbnailInDatabase(int $postId, int $thumbnailId): int
```

**Tables Info:**
```php
// Table names
grabPostsTableName(): string
grabPostmetaTableName(): string
grabUsersTableName(): string
grabUsermetaTableName(): string
grabTermsTableName(): string
grabTermTaxonomyTableName(): string
grabTermRelationshipsTableName(): string
grabTermMetaTableName(): string
grabCommentsTableName(): string
grabCommentmetaTableName(): string
grabLinksTableName(): string
grabBlogsTableName(): string
grabBlogMetaTableName(): string
grabSignupsTableName(): string
grabRegistrationLogTableName(): string
grabSiteTableName(): string
grabBlogVersionsTableName(): string

// Prefixed
grabPrefixedTableNameFor(string $tableName = ''): string
grabTablePrefix(): string
```

### 3.3 WPWebDriver - Specific Methods

```php
// Login
loginAs(string $username, string $password, int $timeout = 10, int $maxAttempts = 5): void
loginAsAdmin(): void
logOut(bool|string $redirectTo = false): void

// WordPress Navigation
amOnAdminPage(string $page): void
amOnPluginsPage(): void
amOnPagesPage(): void
amOnAdminAjaxPage(string|array|null $queryVars = null): void
amOnCronPage(string|array|null $queryVars = null): void
amEditingPostWithId(int $id): void
amEditingUserWithId(int $id): void

// Plugin Verification
seePluginInstalled(string $pluginSlug): void
seePluginActivated(string $pluginSlug): void
seePluginDeactivated(string $pluginSlug): void
dontSeePluginInstalled(string $pluginSlug): void
activatePlugin(string|array $pluginSlug): void
deactivatePlugin(string|array $pluginSlug): void

// Message Verification
seeErrorMessage(string|array $classes = ''): void
seeMessage(array|string $classes = ''): void
seeWpDiePage(): void

// Cookies
grabCookiesWithPattern(string $cookiePattern): ?array
grabWordPressTestCookie(?string $name = null): ?Cookie
waitForJqueryAjax(int $time = 10): void
grabFullUrl(): string
```

### 3.4 WPBrowserMethods - Shared Trait

This trait is used by WPBrowser and WPWebDriver, containing WordPress-specific methods:

```php
trait WPBrowserMethods
{
    // Navigation
    logOut(bool|string $redirectTo = false): void
    loginAsAdmin(): void
    loginAs(string $username, string $password): void

    // Pages
    amOnAdminPage(string $page): void
    amOnPluginsPage(): void
    amOnPagesPage(): void
    amOnAdminAjaxPage(string|array|null $queryVars = null): void
    amOnCronPage(string|array|null $queryVars = null): void
    amEditingPostWithId(int $id): void
    amEditingUserWithId(int $id): void

    // Plugins
    seePluginInstalled(string $pluginSlug): void
    seePluginActivated(string $pluginSlug): void
    seePluginDeactivated(string $pluginSlug): void
    dontSeePluginInstalled(string $pluginSlug): void

    // Messages
    seeErrorMessage(string|array $classes = ''): void
    seeMessage(array|string $classes = ''): void
    seeWpDiePage(): void

    // Cookies
    grabWordPressTestCookie(?string $name = null): ?Cookie
}
```

### 3.5 ThemeMethods - Theme Trait

```php
trait ThemeMethods
{
    public function amOnThemeCustomizerPage(): void
    public function seeThemeActive(string $slug): void
    public function activateTheme(string $slug): void
}
```

---

## 4. Critical Referenced Files

### 4.1 Codeception
- `/vendor/codeception/module-db/src/Codeception/Module/Db.php`
- `/vendor/codeception/module-asserts/src/Codeception/Module/Asserts.php`
- `/vendor/codeception/module-asserts/src/Codeception/Module/AbstractAsserts.php`
- `/vendor/codeception/module-webdriver/src/Codeception/Module/WebDriver.php`
- `/vendor/codeception/lib-web/src/Codeception/Lib/Interfaces/Web.php`
- `/vendor/codeception/codeception/src/Codeception/Module.php`

### 4.2 lucatume/wp-browser
- `/vendor/lucatume/wp-browser/src/Module/WPDb.php`
- `/vendor/lucatume/wp-browser/src/Module/WPWebDriver.php`
- `/vendor/lucatume/wp-browser/src/Module/WPBrowserMethods.php`
- `/vendor/lucatume/wp-browser/src/Module/WPBrowser.php`
- `/vendor/lucatume/wp-browser/src/Module/WPFilesystem.php`
- `/vendor/lucatume/wp-browser/src/Module/WPCLI.php`
- `/vendor/lucatume/wp-browser/src/Module/WPLoader.php`
- `/vendor/lucatume/wp-browser/src/Module/ThemeMethods.php`

---

## 5. Rules and Conventions

### 5.1 Database Column Names

**ALWAYS use real database column names, not abstractions:**

```php
// ✅ CORRECT
$I->havePostInDatabase([
    'post_title' => 'Test',      // real column
    'post_status' => 'publish',     // real column
]);
$I->havePostMetaInDatabase($postId, '_price', '10.00');

// ❌ INCORRECT
$I->havePostInDatabase([
    'title' => 'Test',             // abstraction
    'status' => 'publish',         // abstraction
]);
```

### 5.2 PHP Code

- `declare(strict_types=1);` in all files
- Type hints on all parameters and returns
- Namespace names following PSR-4

### 5.3 Default Configuration

**codeception.yml:**
```yaml
namespace: My\Namespace
support_namespace: Support
paths:
    tests: tests
    output: tests/_output
    data: tests/_data
    support: tests/_support
actor_suffix: Tester
```

**Suite configuration:**
```yaml
actor: AcceptanceTester
modules:
    enabled:
        - WPDb
        - WPWebDriver
    config:
        WPDb:
            dsn: 'mysql:host=%HOST%;dbname=%DB_NAME%'
            user: '%USER%'
            password: '%PASS%'
            tablePrefix: '%PREFIX%'
            url: '%URL%'
        WPWebDriver:
            url: '%URL%'
            browser: chrome
            host: '%CHROME_HOST%'
            port: '%CHROME_PORT%'
            adminUsername: '%WP_ADMIN_USER%'
            adminPassword: '%WP_ADMIN_PASSWORD%'
            adminPath: /wp-admin
```

---

## 6. Summary Table of Methods

| Category | Typical Methods |
|----------|---|
| **Create (DB)** | `have{Entity}InDatabase`, `have{Entity}MetaInDatabase`, `haveMany{Entity}InDatabase` |
| **Read (DB)** | `grab{Entity}{Id|Field|Meta}FromDatabase`, `grab{Column|Entry|Entries}FromDatabase`, `grab{TableName}()` |
| **Verify (DB)** | `see{Entity|Meta}InDatabase`, `seeInDatabase`, `seeNumRecords`, `dontSee{Entity}InDatabase` |
| **Navigate** | `amOn{Page}Page`, `amOnPage`, `amEditing{Entity}WithId` |
| **Fill/Action** | `fill{Form}Field`, `fill{Form}Form`, `click`, `select{Option}` |
| **Wait** | `waitForElement`, `waitForJS`, `waitForJqueryAjax`, `waitForElementVisible` |
| **Login/Auth** | `loginAs`, `loginAsAdmin`, `logOut` |
| **Cookies** | `grabCookiesWithPattern`, `grabWordPressTestCookie` |
| **WordPress** | `activatePlugin`, `deactivatePlugin`, `seePluginActivated`, `seeMessage`, `seeErrorMessage` |
| **Assert** | `assertEquals`, `assertTrue`, `assertFalse`, `assertContains`, `assertArrayHasKey` |
| **Table Info** | `grab{TableName}()`, `grabPrefixedTableNameFor()`, `grabTablePrefix()` |

---

## 7. Query Builder Conventions

The Db module (and by extension WPDb) uses arrays to automatically build WHERE clauses:

```php
// Generates: WHERE post_title = 'Test' AND post_status = 'publish'
$I->seeInDatabase('wp_posts', [
    'post_title' => 'Test',
    'post_status' => 'publish',
]);

// Supports implicit operators
$I->seeInDatabase('wp_posts', ['post_title LIKE' => '%Test%']);
```

---

## 8. Typical Usage Scenarios

### 8.1 Post Creation and Verification

```php
public function testPostCreation(AcceptanceTester $I): void
{
    // 1. Create post in database
    $postId = $I->havePostInDatabase([
        'post_title' => 'Test Post',
        'post_status' => 'publish',
    ]);

    // 2. Add meta
    $I->havePostMetaInDatabase($postId, '_custom_key', 'custom_value');

    // 3. Verify it exists in database
    $I->seePostInDatabase([
        'ID' => $postId,
        'post_title' => 'Test Post',
    ]);

    // 4. Verify meta
    $I->seePostMetaInDatabase([
        'post_id' => $postId,
        'meta_key' => '_custom_key',
        'meta_value' => 'custom_value',
    ]);

    // 5. Grab for use in other tests
    $title = $I->grabPostFieldFromDatabase($postId, 'post_title');
    $meta = $I->grabPostMetaFromDatabase($postId, '_custom_key', true);
}
```

### 8.2 User Creation with Capabilities

```php
public function testUserWithCapabilities(AcceptanceTester $I): void
{
    // 1. Create user
    $userId = $I->haveUserInDatabase('testuser', 'editor');

    // 2. Add capabilities
    $I->haveUserCapabilitiesInDatabase($userId, 'edit_posts');
    $I->haveUserCapabilitiesInDatabase($userId, 'publish_posts');

    // 3. Add meta
    $I->haveUserMetaInDatabase($userId, 'billing_email', 'test@example.com');

    // 4. Verify
    $I->seeUserInDatabase(['user_login' => 'testuser']);
    $I->seeUserMetaInDatabase([
        'user_id' => $userId,
        'meta_key' => 'billing_email',
        'meta_value' => 'test@example.com',
    ]);
}
```

### 8.3 Term and Taxonomy Tests

```php
public function testTermAndTaxonomy(AcceptanceTester $I): void
{
    // 1. Create term in taxonomy
    $termIds = $I->haveTermInDatabase('Electronics', 'product_cat', [
        'description' => 'Electronic products',
        'slug' => 'electronics',
    ]);

    // 2. Create relationship with post
    $postId = $I->havePostInDatabase(['post_type' => 'product']);
    $I->haveTermRelationshipInDatabase($postId, $termIds[0]);

    // 3. Verify term
    $I->seeTermInDatabase([
        'name' => 'Electronics',
        'slug' => 'electronics',
    ]);

    // 4. Verify taxonomy
    $I->seeTermTaxonomyInDatabase([
        'taxonomy' => 'product_cat',
        'term_id' => $termIds[0],
    ]);

    // 5. Verify relationship
    $I->seeTermRelationshipInDatabase([
        'object_id' => $postId,
        'term_taxonomy_id' => $termIds[0],
    ]);
}
```

### 8.4 Options and Transients Tests

```php
public function testOptionsAndTransients(AcceptanceTester $I): void
{
    // 1. Create option
    $I->haveOptionInDatabase('my_option', 'option_value');

    // 2. Create transient
    $I->haveTransientInDatabase('my_transient', ['key' => 'value']);

    // 3. Verify option
    $I->seeOptionInDatabase(['option_name' => 'my_option']);

    // 4. Grab option
    $value = $I->grabOptionFromDatabase('my_option');

    // 5. Grab transient
    $transient = $I->grabTransientFromDatabase('my_transient');
}
```

### 8.5 Navigation and Login

```php
public function testAdminNavigation(AcceptanceTester $I): void
{
    // 1. Login as admin
    $I->loginAsAdmin();

    // 2. Navigate to plugins page
    $I->amOnPluginsPage();

    // 3. Verify plugin installed
    $I->seePluginInstalled('hello-dolly');

    // 4. Verify plugin activated
    $I->seePluginActivated('my-plugin');

    // 5. Navigate to post editing
    $postId = $I->havePostInDatabase();
    $I->amEditingPostWithId($postId);

    // 6. Fill and save
    $I->fillField('post_title', 'Updated Title');
    $I->click('#publish');

    // 7. Verify error
    $I->seeErrorMessage();
}
```

---

## 9. WebDriver Utility Methods (inherited)

In addition to WordPress-specific methods, WPWebDriver inherits all methods from Codeception\WebDriver:

```php
// Wait for elements
$I->waitForElement('.loaded', 10);
$I->waitForElementVisible('.modal', 5);
$I->waitForJS('return document.readyState === "complete"', 10);

// Verify DOM elements
$I->see('Text', '.selector');
$I->dontSee('Hidden', '.hidden');
$I->seeElement('.element');
$I->seeNumberOfElements(3, '.list-item');

// Interaction
$I->click('.button');
$I->doubleClick('.link');
$I->fillField('#input', 'value');
$I->selectOption('select', 'value');

// Capture values
$value = $I->grabTextFrom('.output');
$url = $I->grabCurrentUrl();
$attr = $I->grabAttributeFrom('.element', 'href');
```

---

## 10. Verification and Testing

To validate new methods implemented following these patterns:

1. **Codeception Build** (after signature changes):
   ```bash
   vendor/bin/codecept build
   ```

2. **Run specific tests**:
   ```bash
   vendor/bin/codecept run tests/acceptance/MyCest.php
   ```

3. **Verify compliance**:
   - Type hints present?
   - `declare(strict_types=1);` at the beginning?
   - Real database column names?
   - Methods use correct prefixes?
   - Abstract dependencies declared?
