# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Slim test runner image (`Dockerfile`) shipping PHP, Chromium, chromedriver, SQLite and Composer. WordPress, WooCommerce and the library source come from a bind-mount of the repo — the image does not bake any app code, so a rebuild is only needed when the system-level toolchain changes.
- Composer-managed WordPress tree under `public/` (`roots/wordpress-no-content`, WooCommerce, Storefront, sqlite-database-integration, `wp-cli/wp-cli-bundle`) wired through `composer/installers`. `vendor/bin/wp` is the canonical WP-CLI entrypoint.
- `bin/test` wrapper that runs any command inside the image with the repo bind-mounted at `/var/www/html`.
- `resources/install.sh` — idempotent script that bootstraps the SQLite WordPress site (`wp core install`, plugin/theme activation, HPOS sync), with the WP-CLI calls collapsed to four.
- `tests/acceptance/ImageHealthCest.php` smoke test covering HPOS round-trip on SQLite, legacy order round-trip, homepage rendering, and chromedriver liveness.

### Changed

- `codeception.yml` now enables `BuiltInServerController` and `ChromeDriverController` plus the `lucatume/wp-browser` dev commands (`dev:start`, `dev:stop`, `dev:restart`, `dev:info`, `wp:db:import`, `wp:db:export`, `run:original`, `run:all`).
- `tests/acceptance.suite.yml` switched from MySQL/Selenium service hosts to SQLite via the sqlite-database-integration drop-in and chromedriver on `localhost`.
- `public/wp-config.php` defines `DB_ENGINE` (default `sqlite`) so the sqlite-database-integration plugin engages from a single switch.
- `wp-cli.yml` points at the new `public/wp/` core install.

### Removed

- `Dockerfile.test`, `docker-compose.test.yml`, `docker-compose.local.yml`, the docker-compose-driven `Makefile`, and `.env.test`.
