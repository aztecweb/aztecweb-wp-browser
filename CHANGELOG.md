# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Slim test runner image (`Dockerfile`) shipping PHP, Chromium, chromedriver, SQLite and Composer. WordPress, WooCommerce and the library source come from a bind-mount of the repo — the image does not bake any app code, so a rebuild is only needed when the system-level toolchain changes.
- Composer-managed WordPress tree under `public/` (`roots/wordpress-no-content`, WooCommerce, Storefront, sqlite-database-integration, `wp-cli/wp-cli-bundle`) wired through `composer/installers`. `vendor/bin/wp` is the canonical WP-CLI entrypoint.
- `bin/test` wrapper that runs any command inside the image with the repo bind-mounted at `/var/www/html`.
- `bin/serve` wrapper for launching the site in a browser during manual inspection.
- `resources/install.sh` — idempotent script that bootstraps the SQLite WordPress site (`wp core install`, plugin/theme activation, HPOS sync), with the WP-CLI calls collapsed to four.
- `.github/workflows/acceptance.yml` — CI workflow that runs the acceptance suite against PHP 8.0 and 8.4 on every push and pull request, using the published GHCR runner image.
- `.github/workflows/build-test-runner.yml` — manual-trigger workflow (`workflow_dispatch` only) that builds the image for both PHP variants and pushes to GHCR as `${repo}-runner:php{N}` plus an immutable `:vYYYYMMDDThhmmssZ-php{N}` content tag. Automatic triggers (push, cron) are deferred to [#13](https://github.com/aztecweb/aztecweb-wp-browser/issues/13).
- Consumer-facing `README.md`: requirements, installation with the `suite.yml` snippet (short-form and FQN fallback), quick-start Cest, a per-domain method index across `WooCommerceDb` and `WooCommerceWebDriver`, an HPOS note, an architecture paragraph linking the ADRs, and local-development/contributing sections ([#8](https://github.com/aztecweb/aztecweb-wp-browser/issues/8)).

### Changed

- `codeception.yml` now enables `BuiltInServerController` and `ChromeDriverController` plus the `lucatume/wp-browser` dev commands (`dev:start`, `dev:stop`, `dev:restart`, `dev:info`, `wp:db:import`, `wp:db:export`, `run:original`, `run:all`).
- `tests/acceptance.suite.yml` switched from MySQL/Selenium service hosts to SQLite via the sqlite-database-integration drop-in and chromedriver on `localhost`.
- `public/wp-config.php` defines `DB_ENGINE` (default `sqlite`) so the sqlite-database-integration plugin engages from a single switch.
- `wp-cli.yml` points at the new `public/wp/` core install.
- `composer.json` caps `symfony/filesystem` and `symfony/process` to `<8.0` so `composer update` resolves Symfony 6.x under PHP 8.0 (matching `lucatume/wp-browser` constraints). The acceptance CI uses `composer update` instead of `install` so each PHP variant resolves packages compatible with its runtime.

### Removed

- `Dockerfile.test`, `docker-compose.test.yml`, `docker-compose.local.yml`, the docker-compose-driven `Makefile`, and `.env.test`.
- `install-woocommerce.sh` and `install-woocommerce-subscriptions.sh` shell scripts superseded by `resources/install.sh`.
- `tests/_support/_generated/` and `tests/_data/dump.sql` removed from version control (added to `.gitignore`); both are regenerated locally by the test bootstrap.
- `@plugins/` directory and `@setup-wordpress.sh` script removed in favor of `resources/install.sh`.
