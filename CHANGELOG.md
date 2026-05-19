# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- All-in-one test image (`Dockerfile`) bundling PHP, WordPress, WooCommerce, SQLite, Chromium and chromedriver, published to GHCR per PHP variant (`:php8.0`, `:php8.4`) and per content version (`:vYYYY.MM-php{N}`).
- Composer-managed WordPress tree under `public/` (`roots/wordpress-no-content`, WooCommerce, Storefront, sqlite-database-integration) wired through `composer/installers`.
- `bin/test` wrapper that runs the published image with the conventional `docker run -v "$PWD:/var/www/html"` mount.
- `tests/acceptance/ImageHealthCest.php` smoke test covering HPOS round-trip on SQLite, legacy order round-trip, homepage rendering, and chromedriver liveness.
- `.github/workflows/build-test-runner.yml` workflow building and pushing the test image to GHCR on Dockerfile changes, weekly cron, and manual dispatch.

### Changed

- `codeception.yml` now enables `BuiltInServerController` and `ChromeDriverController` plus the `lucatume/wp-browser` dev commands (`dev:start`, `dev:stop`, `dev:restart`, `dev:info`, `wp:db:import`, `wp:db:export`, `run:original`, `run:all`).
- `tests/acceptance.suite.yml` switched from MySQL/Selenium service hosts to SQLite via the sqlite-database-integration drop-in and chromedriver on `localhost`.
- `wp-cli.yml` points at the new `public/wp/` core install.

### Removed

- `Dockerfile.test`, `docker-compose.test.yml`, `docker-compose.local.yml`, the docker-compose-driven `Makefile`, and `.env.test`.
