# aztecweb-wp-browser

Codeception modules and method traits for WordPress + WooCommerce acceptance
testing, layered on top of [`lucatume/wp-browser`](https://github.com/lucatume/wp-browser).

## Running the test suite

The test environment is a single self-contained Docker image published to
GitHub Container Registry (GHCR) — PHP, WordPress, WooCommerce, SQLite,
Chromium and chromedriver all baked in. There is no `docker-compose.yml`,
MySQL service, or separate browser container.

### Quick start

```bash
composer install
bin/test run acceptance
```

`bin/test` is a thin wrapper that runs the image with the right volume mount.
You can also invoke `docker` directly:

```bash
docker run --rm -it \
    -v "$PWD:/var/www/html" \
    -w /var/www/html \
    ghcr.io/aztecweb/aztecweb-wp-browser-test-runner:php8.4 \
    vendor/bin/codecept run acceptance
```

### Image tags

The image is built per PHP variant and per content version:

- `:php8.0`, `:php8.4` — moving pointers to the latest content for that PHP version.
- `:vYYYY.MM-php8.0`, `:vYYYY.MM-php8.4` — explicit content version pins (recommended for CI).

CI workflows should pin to a content-version tag so that image refreshes
don't surprise PR authors.

### Overriding the image

```bash
AZTEC_TEST_IMAGE=ghcr.io/aztecweb/aztecweb-wp-browser-test-runner:v2026.05-php8.0 \
    bin/test run acceptance
```

### Rebuilding the image

The image is rebuilt and republished by the
[`build-test-runner`](.github/workflows/build-test-runner.yml) workflow:

- on every push to `main` that touches the Dockerfile, the Composer manifest, or the WordPress bootstrap files,
- weekly via cron so WordPress and WooCommerce updates land in the image,
- on demand via `workflow_dispatch` (with an optional content-version override).
