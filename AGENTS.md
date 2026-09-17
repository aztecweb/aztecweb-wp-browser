# AGENTS.md

Entry point for AI agents working in this repository.

## Working in this repo

- **Vocabulary** — read [`CONTEXT.md`](CONTEXT.md) before naming anything. Match its terminology.
- **Standards** — see [`CONTRIBUTING.md`](CONTRIBUTING.md) for architecture patterns, Codeception / wp-browser / WPDb conventions, the docblock rule, and agent workflows.
- **Design rationale** — read the relevant ADR in [`docs/adr/`](docs/adr/) before changing behavior in that area.

## Commands

```bash
# One-time: authenticate to the registry — the runner image is a private
# package, and the CLI does not request read:packages when it first logs in.
# Without this every bin/test command below is denied by the registry.
gh auth refresh -s read:packages
gh auth token | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin

# One-time: suite parameters — codeception.yml reads .env, which is gitignored,
# so a fresh clone has none and Codeception refuses to start without it
cp .env.example .env

# One-time: install PHP dependencies (also wires up the pre-push hook)
bin/test composer install

# One-time: bootstrap the SQLite WordPress site (idempotent)
bin/test bash resources/install.sh

# Run the full suite / a single suite / a single Cest
bin/test
bin/test codecept run acceptance
bin/test codecept run acceptance CouponCest
bin/test codecept run acceptance CouponCest:testMethodName

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
