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

### Browsing the site from the host

The container's PHP server is only reachable inside the container during a test
run. To open the site in a host browser — for instance to inspect the installed
state or reproduce a failing scenario manually — use `bin/serve`:

```bash
bin/serve          # http://localhost:8080/  (reads WP_SERVER_PORT from .env)
```

`bin/serve` starts WP-CLI's built-in server bound to `0.0.0.0` and publishes
the port to the host. Press Ctrl-C to stop it. The server runs in the
foreground; open a second terminal for any other `bin/test` commands.

> **Note:** `bin/serve` is for manual inspection only. The acceptance suite
> manages its own server via the `BuiltInServerController` extension — do not
> run both at the same time on the same port.

### Overriding the image

```bash
AZTEC_TEST_IMAGE=ghcr.io/aztecweb/aztecweb-wp-browser-runner:php8.0 \
    bin/test codecept run acceptance
```

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

### Running the CI workflow locally with `act`

[`act`](https://github.com/nektos/act) lets you run GitHub Actions workflows on
your machine without pushing to GitHub.

```bash
act push -j acceptance \
    --network bridge \
    -s GITHUB_TOKEN=$(gh auth token)
```

`--network bridge` gives the container its own isolated network namespace,
preventing port conflicts between the host and the PHP server started by
Codeception inside the container.

The workflow matrix covers PHP 8.0 and 8.4. To target a single version:

```bash
act push -j acceptance \
    --matrix php_version:8.0 \
    --network bridge \
    -s GITHUB_TOKEN=$(gh auth token)
```

> **Note:** `GITHUB_TOKEN` is required to pull the runner image from GHCR.
> `$(gh auth token)` uses your existing GitHub CLI session. Alternatively,
> pass a personal access token with `read:packages` scope.
