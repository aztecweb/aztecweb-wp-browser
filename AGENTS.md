# AGENTS.md

Entry point for anyone — human or AI agent — working **in** this repository.

`aztecweb-wp-browser` is a library of **Plugin Modules** for WordPress acceptance
testing, built as composition extensions over
[`lucatume/wp-browser`](https://github.com/lucatume/wp-browser). For how the
library is *used* by test authors, see [`README.md`](README.md); consumer-facing
orientation ships separately as an installable skill, not here.

## Working in this repo

- **Vocabulary** — read [`CONTEXT.md`](CONTEXT.md) first. It defines the shared
  language (Plugin Module, Method Trait, Plugin Subnamespace, Sibling Module,
  Actor, Class Alias Trick, HPOS) used everywhere. Match it before naming new
  concepts.
- **Architecture, standards & process** — see [`CONTRIBUTING.md`](CONTRIBUTING.md)
  for the Plugin Module / Method Trait composition pattern, the mandatory
  Codeception / wp-browser / WPDb standards, the docblock convention, the
  build-after-signature-change rule, and the maintainer agent workflows.
- **Design rationale** — see [`docs/adr/`](docs/adr/). Read the relevant ADR
  before changing behavior in the area it covers.

## Commands

This repo runs its own suite inside a self-contained Docker test runner via the
`bin/test` wrapper, which bind-mounts the repo at `/var/www/html`. (`bin/test` is
library-internal; consumers run their own tests with `vendor/bin/codecept`.) See
[`README.md`](README.md) § "Local development" for the full reference and the
`act` workflow.

```bash
# One-time: install PHP dependencies (also wires up the pre-push hook)
bin/test composer install

# One-time: bootstrap the SQLite WordPress site (idempotent)
bin/test bash resources/install.sh

# Run the full suite / a single suite / a single Cest
bin/test
bin/test codecept run acceptance
bin/test codecept run acceptance CouponCest

# Rebuild actor classes — required after changing a module/trait method signature
bin/test codecept build

# Toggle order storage before running the matching suites
bin/test wp wc hpos enable    # before OrderHPOSCest / SubscriptionHPOSCest
bin/test wp wc hpos disable   # before OrderCest / SubscriptionCest (Legacy)

# Validate composer.json + run PHPStan and PHPCS
bin/test composer check

# Start a WP-CLI server for manual browsing, or drop into a shell in the image
bin/serve
bin/test bash
```

## References

- [`CONTEXT.md`](CONTEXT.md) — domain glossary and shared vocabulary
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — architecture patterns, standards, and
  contribution workflow
- [`README.md`](README.md) — consumer documentation and full local-dev setup
- [`docs/adr/`](docs/adr/) — Architecture Decision Records
