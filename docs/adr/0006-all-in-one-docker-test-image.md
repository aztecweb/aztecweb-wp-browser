# All-in-one Docker test image with SQLite

The test environment is a single self-contained Docker image — PHP +
WordPress + WooCommerce + SQLite + Chromium + chromedriver — published to
GitHub Container Registry (GHCR) and tagged per PHP variant
(`:php8.0`, `:php8.4`). There is no `docker-compose.yml`, no service
orchestration, no separate MySQL/browser containers. CI uses the image via
GitHub Actions' `container:` directive; local dev and the pre-push hook use
it via `docker run -v $PWD:/var/www/html`. WordPress runs against SQLite
(via the `sqlite-database-integration` plugin) instead of MySQL.

## Considered options

- **`docker-compose.yml` with services** (the previous state). Drift between local and CI infrastructure; service-startup overhead in CI; multiple containers to coordinate.
- **`shivammathur/setup-php` + ad-hoc service install in CI.** Faster setup but loses parity with local dev; the test environment is reconstructed differently each time.
- **MySQL inside the all-in-one image.** Closer to production, but requires a process supervisor (mysqld + chromedriver + web server inside one container) and slower image startup.

## Consequences

- One source of truth for the test environment (the image's Dockerfile).
- WordPress runs against SQLite, which is not the production DB — passing tests on SQLite but failing on MySQL is a known risk class. Mitigation: a smoke test that an HPOS order round-trips correctly on SQLite is a Phase 3 acceptance criterion; periodic MySQL-target validation runs are recommended before tagging stable releases.
- `Dockerfile.test`, `docker-compose.test.yml`, `docker-compose.local.yml`, and Makefile docker targets are removed when this image lands.
- A separate workflow (`.github/workflows/build-test-runner.yml`) builds and publishes the image to GHCR. The workflow:
  - Triggers on a weekly cron schedule (Monday 06:00 UTC) to pick up upstream security patches, plus manual dispatch for on-demand rebuilds.
  - Enforces a test gate: the acceptance suite must pass before any image is published. On test failure, no image is pushed.
  - Splits the build into two passes: a local test build (amd64 only with `load: true`) followed by a conditional multi-platform push (amd64 + arm64) only if tests pass. The GHA layer cache from the first pass makes the amd64 re-build in the second pass fast.
  - PHP 8.0 Chromium is permanently pinned (`102.0.5005.182-r0`; Alpine 3.16 is EOL). PHP 8.4 Chromium floats to pick the latest version from Alpine on each weekly rebuild.
- The pre-push hook and a `bin/test` wrapper script invoke the image locally so contributors don't have to memorize the `docker run` invocation.
