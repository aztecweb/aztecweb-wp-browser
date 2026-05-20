# aztecweb-wp-browser

Codeception modules and method traits for WordPress + WooCommerce acceptance
testing, layered on top of [`lucatume/wp-browser`](https://github.com/lucatume/wp-browser).

## Running the test suite

The test environment is a slim Docker image published to GitHub Container
Registry (GHCR) — PHP, Chromium, chromedriver, SQLite and Composer. WordPress,
WooCommerce and the library source come from a bind-mount of the repository, so
the image does not need to rebuild every time the code changes.

### Quick start

```bash
bin/test composer install              # one-time: install PHP dependencies
bin/test bash resources/install.sh     # one-time: bootstrap the SQLite WP site
bin/test                               # codecept run
```

`bin/test` is a thin wrapper that runs any command inside the image with the
repo bind-mounted at `/var/www/html`. With no arguments, it runs the default
test suite. You can also invoke `docker` directly:

```bash
docker run --rm -it \
    -v "$PWD:/var/www/html" \
    -w /var/www/html \
    ghcr.io/aztecweb/aztecweb-wp-browser-runner:php8.4 \
    codecept run acceptance
```

### Image tags

The image is published per PHP variant (`:php8.0`, `:php8.4`), plus an
immutable per-build content tag (`:vYYYYMMDDThhmmssZ-php{N}`) generated from
the workflow's UTC build timestamp.

### Building and publishing

A maintainer fires the
[`build-test-runner`](.github/workflows/build-test-runner.yml) workflow by
hand from the GitHub Actions UI (or `gh workflow run build-test-runner.yml`).
There is no push trigger or cron schedule yet — automatic rebuilds are being
designed separately in
[#13](https://github.com/aztecweb/aztecweb-wp-browser/issues/13).

### Overriding the image

```bash
AZTEC_TEST_IMAGE=ghcr.io/aztecweb/aztecweb-wp-browser-runner:php8.0 \
    bin/test codecept run acceptance
```
