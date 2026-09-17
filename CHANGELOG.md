# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- The weekly build of the test runner image, which had been failing since the schedule was introduced: `resources/install.sh` ran before Composer, so the SQLite drop-in the script copies had not been installed yet and every run died at *Bootstrap WordPress* with `cp: can't stat '…/sqlite-database-integration/db.copy'`. No image had been published since 2026-06-09, leaving continuous integration and every developer machine on that build. Dependencies are now installed first, and the acceptance suite runs against the freshly built image before the multi-architecture pass pushes it ([#71](https://github.com/aztecweb/aztecweb-wp-browser/issues/71)).
- `.githooks/pre-push` now runs every container command through `bin/test`, which forwards the calling user and group. It invoked `docker` directly before, so the image's uid 1001 met a checkout owned by the host user and the hook died on `fatal: detected dubious ownership`, then on `composer.lock: Permission denied`. Its dependency step also moved from `composer update` to `composer install`: a verification gate has to run against the locked versions and leave `composer.lock` untouched in the working tree of whoever is pushing ([#71](https://github.com/aztecweb/aztecweb-wp-browser/issues/71)).
- Impacted-test selection in `.githooks/pre-push`, which had stopped selecting anything. The file-to-Cest map still pointed at the pre-Plugin-Subnamespace layout (`src/Method/…`), so after the refactor no changed file resolved to a Cest and every push quietly ran the full suite instead. Two or more impacted Cests are now passed as a `--filter` anchored at the class boundary rather than positionally, which `codecept run` rejects beyond the first test; a mapped Cest missing from disk and a filter that selects no test both fail the push, where the latter used to be reported as a pass; and a changed file under `src/` that no rule claims widens the run to the full suite rather than leaving the selection untouched ([#71](https://github.com/aztecweb/aztecweb-wp-browser/issues/71)).

### Changed

- `CartMethods::addProductToCart()` no longer waits for the "product added to cart" notice: it issues the add-to-cart request and returns. The notice is a one-shot session notice — cleared on print, and lost whenever anything rewrites the WooCommerce session between the add-to-cart request and the render (async loopbacks, a persistent object cache, a plugin touching the session) — so the wait timed out on runs where the product had in fact been added. There was nothing left to synchronize: `amOnPage()` returns only once the add-to-cart request has been served, and no other element is guaranteed to exist on every landing page a store can choose. Tests that assert on cart contents must navigate first, with `amOnCartPage()` or `amOnCheckoutPage()`; the method itself stays agnostic to the store's "Add to cart behaviour" setting and to the `woocommerce_add_to_cart_redirect` filter ([#66](https://github.com/aztecweb/aztecweb-wp-browser/issues/66)).

### Removed

- `CartPageObject::PRODUCT_ADDED_TO_CART_MESSAGE_SELECTOR` — the notice it targeted is no longer waited on by any method in the package. Projects that overrode it to point at cart state can drop the override ([#66](https://github.com/aztecweb/aztecweb-wp-browser/issues/66)).

### Added

- A `notify` job on the runner image workflow that opens — or comments on, once it exists — an issue when a *scheduled* build fails. Thirteen silent failures accumulated before anyone noticed the image had stopped being refreshed; manual runs are excluded, since whoever dispatched one is already watching it ([#71](https://github.com/aztecweb/aztecweb-wp-browser/issues/71)).
- `composer test:hooks`, running the file-to-Cest map tests in `.githooks/test-pre-push.sh`, wired into the static-analysis workflow. Nothing executed them before, which is precisely how the map drifted out of the tree unnoticed ([#71](https://github.com/aztecweb/aztecweb-wp-browser/issues/71)).
- `@phpstan-type` shape aliases (unsealed, with enum literals for status/stock/discount values) for the high-arity `overrides`/`criteria` params on `ProductMethods::haveProductInDatabase`/`haveManyProductsInDatabase`, `CouponMethods::haveCouponInDatabase` and its percentage/fixed-cart/fixed-product/free-shipping wrappers, and `OrderMethods::haveOrderInDatabase`/`haveManyOrdersInDatabase`/`haveOrderAddressInDatabase`/`seeOrderAddressInDatabase`/`haveOrderItemInDatabase` — so PHPStan (already at level max over `src` and `tests`) flags hallucinated keys/values in any Cest ([#37](https://github.com/aztecweb/aztecweb-wp-browser/issues/37)).

## [0.1.0] - 2026-06-09

### Added

- `LICENSE` — MIT license (copyright 2026 Aztec Online) ([#2](https://github.com/aztecweb/aztecweb-wp-browser/issues/2)).
- Expanded `composer.json` distribution metadata: richer `description`, `keywords`, `homepage`, `authors`, `support.issues`/`support.source`, and `config.sort-packages` ([#2](https://github.com/aztecweb/aztecweb-wp-browser/issues/2)).
- Static-analysis baseline: PHPStan at level max and PHPCS (PSR-12 plus a curated Slevomat ruleset), exposed via a `composer check` script ([#3](https://github.com/aztecweb/aztecweb-wp-browser/issues/3)).
- Custom PHPCS sniff `RequirePublicMethodDocBlockSniff` (`src/CodeSniffer/Sniffs/`) enforcing wp-browser-style docblocks with an `@example` tag on every public method of Plugin Modules (`*\Module\`) and Method Traits (`*\Method\`) ([#7](https://github.com/aztecweb/aztecweb-wp-browser/issues/7)).
- PHPDoc backfill across all public methods of the Plugin Modules and Method Traits using the full wp-browser skeleton (summary → `@example` → `@param` → `@return` → `@throws`) ([#7](https://github.com/aztecweb/aztecweb-wp-browser/issues/7)).
- `src/aliases.php` — Class Alias Trick so consumers can reference the Plugin Modules by short name (`WooCommerceDb`, `WooCommerceWebDriver`) in `suite.yml` ([#6](https://github.com/aztecweb/aztecweb-wp-browser/issues/6)).
- `.githooks/pre-push` — pre-push hook that runs the impacted acceptance tests before pushing, mapping changed traits to their Cest classes and falling back to the full suite for shared-infrastructure changes ([#5](https://github.com/aztecweb/aztecweb-wp-browser/issues/5)).
- Slim test runner image (`Dockerfile`) shipping PHP, Chromium, chromedriver, SQLite and Composer. WordPress, WooCommerce and the library source come from a bind-mount of the repo — the image does not bake any app code, so a rebuild is only needed when the system-level toolchain changes.
- Composer-managed WordPress tree under `public/` (`roots/wordpress-no-content`, WooCommerce, Storefront, sqlite-database-integration, `wp-cli/wp-cli-bundle`) wired through `composer/installers`. `vendor/bin/wp` is the canonical WP-CLI entrypoint.
- `bin/test` wrapper that runs any command inside the image with the repo bind-mounted at `/var/www/html`.
- `bin/serve` wrapper for launching the site in a browser during manual inspection.
- `resources/install.sh` — idempotent script that bootstraps the SQLite WordPress site (`wp core install`, plugin/theme activation, HPOS sync), with the WP-CLI calls collapsed to four.
- `.github/workflows/acceptance.yml` — CI workflow that runs the acceptance suite against PHP 8.0 and 8.4 on every push and pull request, using the published GHCR runner image.
- `.github/workflows/build-test-runner.yml` — manual-trigger workflow (`workflow_dispatch` only) that builds the image for both PHP variants and pushes to GHCR as `${repo}-runner:php{N}` plus an immutable `:vYYYYMMDDThhmmssZ-php{N}` content tag. Automatic triggers (push, cron) are deferred to [#13](https://github.com/aztecweb/aztecweb-wp-browser/issues/13).
- Consumer-facing `README.md`: requirements, installation with the `suite.yml` snippet (short-form and FQN fallback), quick-start Cest, a per-domain method index across `WooCommerceDb` and `WooCommerceWebDriver`, an HPOS note, an architecture paragraph linking the ADRs, and local-development/contributing sections ([#8](https://github.com/aztecweb/aztecweb-wp-browser/issues/8)).
- Two Plugin Modules — `WooCommerceDb` (database helpers) and `WooCommerceWebDriver` (browser helpers) — with every WooCommerce concern organised under the `Aztec\WPBrowser\WooCommerce\` subnamespace, and Action Scheduler under its own `Aztec\WPBrowser\ActionScheduler\` subnamespace with the `ActionMethods` trait ([#6](https://github.com/aztecweb/aztecweb-wp-browser/issues/6)).
- PSR-4 autoloading for the `Aztec\WPBrowser\` namespace, including the `Aztec\WPBrowser\Tests\Support\` → `tests/_support/` prefix so `dump-autoload --strict-psr` is clean ([#2](https://github.com/aztecweb/aztecweb-wp-browser/issues/2)).
- `composer.json` pins `config.platform.php` to `8.0.0` so dependency resolution targets the minimum supported PHP version, and caps `symfony/filesystem`/`symfony/process` to `<8.0` so `composer update` resolves Symfony 6.x under PHP 8.0 (matching `lucatume/wp-browser` constraints). The acceptance CI uses `composer update` instead of `install` so each PHP variant resolves packages compatible with its runtime.
- `codeception.yml` enables `BuiltInServerController` and `ChromeDriverController` plus the `lucatume/wp-browser` dev commands (`dev:start`, `dev:stop`, `dev:restart`, `dev:info`, `wp:db:import`, `wp:db:export`, `run:original`, `run:all`).
- SQLite-backed acceptance suite: `tests/acceptance.suite.yml` runs against the sqlite-database-integration drop-in with chromedriver on `localhost`, `public/wp-config.php` defines `DB_ENGINE` (default `sqlite`) to engage the plugin from a single switch, and `wp-cli.yml` points at the `public/wp/` core install.

[Unreleased]: https://github.com/aztecweb/aztecweb-wp-browser/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/aztecweb/aztecweb-wp-browser/releases/tag/v0.1.0
