# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
