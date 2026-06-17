# aztecweb/aztecweb-wp-browser

High-level Codeception modules for writing WooCommerce acceptance tests on top of
[`lucatume/wp-browser`](https://github.com/lucatume/wp-browser).

This library gives test authors a vocabulary of WooCommerce-aware actor methods —
`haveCouponInDatabase`, `addProductToCart`, `seeOrderStatus` — so you can express
store behaviour directly instead of hand-rolling SQL and CSS selectors. Order
storage (HPOS vs. legacy) is detected and encapsulated for you, so the same test
runs unchanged in both modes.

## Installation

```bash
composer require --dev aztecweb/aztecweb-wp-browser:^0.1.0
```

Then enable the modules in your acceptance suite (e.g. `tests/acceptance.suite.yml`).
`WPDb` and `WPWebDriver` must come first, since the Aztec modules build on top of
them:

```yaml
# Default — short form via the Class Alias Trick
modules:
    enabled:
        - WPDb
        - WPWebDriver
        - WooCommerceDb
        - WooCommerceWebDriver
    config:
        WPDb:
            # ...your WPDb config
        WPWebDriver:
            # ...your WPWebDriver config
```

The short names `WooCommerceDb` and `WooCommerceWebDriver` are registered at load
time via `class_alias` (the **Class Alias Trick**, see
[ADR-0004](docs/adr/0004-class-alias-trick.md)). If another package already owns
`Codeception\Module\WooCommerceDb`, the alias is skipped (with a warning) and you
should reference the modules by their fully-qualified class names instead:

```yaml
# Fallback if a class_alias collision is detected (rare)
modules:
    enabled:
        - WPDb
        - WPWebDriver
        - \Aztec\WPBrowser\WooCommerce\Module\WooCommerceDb
        - \Aztec\WPBrowser\WooCommerce\Module\WooCommerceWebDriver
```

After enabling the modules, rebuild the actor classes:

```bash
vendor/bin/codecept build
```

## Quick start

```php
public function customerCheckoutWithCoupon(AcceptanceTester $I): void
{
    $productId = $I->haveProductInDatabase(['post_title' => 'Test Product']);
    $I->havePercentageCouponInDatabase('SAVE10', 10.0);

    $I->amOnCartPage();
    $I->addProductToCart($productId);
    $I->seeProductInCart($productId);

    $I->amOnCheckoutPage();
    $I->applyCouponOnCheckout('SAVE10');
    $I->seeCouponApplied('SAVE10');
}
```

## HPOS support

HPOS (High-Performance Order Storage) is **auto-detected** from the
`woocommerce_custom_orders_table_enabled` option; no consumer configuration is
needed. The same order and subscription methods work whether your site uses the
`wc_orders` tables or the legacy `wp_posts` storage. See
[ADR-0005](docs/adr/0005-hpos-detection-encapsulation.md) for details.

## Architecture

The library favours **composition over inheritance**: each WooCommerce module
composes domain-specific method traits rather than extending a base module
([ADR-0002](docs/adr/0002-composition-over-extension.md)). Capabilities are split
**one module per plugin concern** — `WooCommerceDb`, `WooCommerceWebDriver`, and
the Action Scheduler subnamespace
([ADR-0003](docs/adr/0003-module-per-plugin-architecture.md)) — and HPOS detection
is encapsulated behind the order storage interfaces so tests stay storage-agnostic.
See [`CONTEXT.md`](CONTEXT.md) for shared vocabulary and [`docs/adr/`](docs/adr/)
for the full design rationale.

## Agent support

This library is agent-ready. [`AGENTS.md`](AGENTS.md) is the entry-point index for AI agents working in this repo: it covers vocabulary, standards, commands, and design rationale.

## Local development

This repo runs its own test suite inside a self-contained Docker image via the
`bin/test` wrapper, which bind-mounts the repo at `/var/www/html`.

```bash
bin/test composer install                    # install deps (also installs the pre-push hook)
bin/test bash resources/install.sh           # bootstrap the SQLite WordPress site (idempotent)
bin/test codecept build                      # rebuild actor classes after method signature changes
bin/test codecept run                        # run all suites
bin/test codecept run acceptance CouponCest  # run a single Cest
bin/serve                                    # start WP-CLI server at http://localhost:8080/ for manual browsing
composer check                               # validate composer.json, run PHPStan and PHPCS
```

The port defaults to `8080` and can be overridden by setting `WP_SERVER_PORT` in a `.env` file.

`composer install` wires up the pre-push hook by running
`git config core.hooksPath .githooks` (the `post-install-cmd` script). The hook
([`.githooks/pre-push`](.githooks/pre-push)) runs only the tests impacted by your
changed files, and falls back to the full acceptance suite when shared
infrastructure changes. In an emergency you can bypass it with
`git push --no-verify` — but CI is the authoritative gate.

### Running against PHP 8.0

The default image ships PHP 8.4 and the committed `composer.lock` is resolved
against PHP 8.4. Running against the PHP 8.0 image requires resolving
dependencies fresh inside that image, because some packages locked for 8.4 do
not support 8.0.

```bash
# Remove the vendor directory so Composer starts clean
rm -rf vendor

# Resolve dependencies for PHP 8.0 (rewrites composer.lock)
AZTEC_TEST_IMAGE=ghcr.io/aztecweb/aztecweb-wp-browser-runner:php8.0 \
    bin/test composer update

# Bootstrap the site (required after a clean vendor install)
AZTEC_TEST_IMAGE=ghcr.io/aztecweb/aztecweb-wp-browser-runner:php8.0 \
    bin/test bash resources/install.sh

# Run the suite
AZTEC_TEST_IMAGE=ghcr.io/aztecweb/aztecweb-wp-browser-runner:php8.0 \
    bin/test
```

> **Note:** `composer update` rewrites `composer.lock` with PHP-8.0-compatible
> package versions (Symfony 6.x, older Codeception 5.x releases). Do not commit
> the rewritten lock file — restore it afterwards with `git checkout composer.lock`
> and reinstall for your usual image: `bin/test composer install`.

## Image tags

The image is published per PHP variant (`:php8.0`, `:php8.4`), plus an
immutable per-build content tag (`:vYYYYMMDDThhmmssZ-php{N}`) generated from
the workflow's UTC build timestamp.

## Building and publishing

The [`build-test-runner`](.github/workflows/build-test-runner.yml) workflow
builds and publishes the image automatically every Monday at 06:00 UTC to pick
up upstream security patches (Alpine packages, Chromium). A maintainer can also
trigger a rebuild manually from the GitHub Actions UI or via:

```bash
gh workflow run build-test-runner.yml
```

The workflow enforces a **test gate**: the acceptance suite must pass before any
image is published. If tests fail, no image is pushed — neither the floating
`:phpN` tag nor the immutable `:vYYYYMMDDThhmmssZ-phpN` tag.

**Chromium versioning:**
- **PHP 8.0**: Chromium is permanently pinned to `102.0.5005.182-r0` (Alpine
  3.16 is EOL with no upstream updates)
- **PHP 8.4**: Chromium floats — the latest version is picked up from Alpine
  on each weekly rebuild

### Running the CI workflow locally with `act`

[`act`](https://github.com/nektos/act) lets you run GitHub Actions workflows on
your machine without pushing to GitHub.

```bash
act workflow_dispatch -j build \
    --network bridge \
    -s GITHUB_TOKEN=$(gh auth token)
```

`--network bridge` gives the container its own isolated network namespace,
preventing port conflicts between the host and the PHP server started by
Codeception inside the container.

The workflow matrix covers PHP 8.0 and 8.4. To target a single version:

```bash
act workflow_dispatch -j build \
    --matrix php_version:8.0 \
    --network bridge \
    -s GITHUB_TOKEN=$(gh auth token)
```

> **Note:** `GITHUB_TOKEN` is required to pull the runner image from GHCR.
> `$(gh auth token)` uses your existing GitHub CLI session. Alternatively,
> pass a personal access token with `read:packages` scope.

**Caching across local runs.** GitHub's cache service is unavailable under
`act`, so the buildx `gha` cache backend errors out
([nektos/act#1916](https://github.com/nektos/act/issues/1916)). The workflow
detects `act` (via `$ACT`) and disables that backend, skipping the buildx
container builder so the image builds on the default docker driver — layer
reuse then comes for free from the host daemon's own build cache. Composer
downloads are cached in the per-version named volume
`aztec-wp-browser-composer-php<version>`. Both persist between runs with no
extra flags. To force a clean rebuild, prune the daemon cache
(`docker builder prune`) or drop the volume
(`docker volume rm aztec-wp-browser-composer-php8.4`).

## Contributing

Contributions go through pull request: review is required, CI must be green, and
new public methods on the modules and method traits must carry the full PHPDoc
skeleton (see the docblock convention in [`CONTRIBUTING.md`](CONTRIBUTING.md)).
[`AGENTS.md`](AGENTS.md) is the entry point for working in this repo, including
guidelines for AI coding assistants.

## License

[MIT](LICENSE).

## Changelog

See [`CHANGELOG.md`](CHANGELOG.md).
