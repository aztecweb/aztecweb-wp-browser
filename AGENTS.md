# AGENTS.md

Entry point for AI agents working in this repository.

## Working in this repo

- **Vocabulary** — read [`CONTEXT.md`](CONTEXT.md) before naming anything. Match its terminology.
- **Standards** — see [`CONTRIBUTING.md`](CONTRIBUTING.md) for architecture patterns, Codeception / wp-browser / WPDb conventions, the docblock rule, and agent workflows.
- **Design rationale** — read the relevant ADR in [`docs/adr/`](docs/adr/) before changing behavior in that area.

## Commands

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
