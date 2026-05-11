# Internal-first, public-ready audience

The library is built for Aztec's internal teams today, but engineered as if it
will be published to Packagist for external consumers. This commits us to
public-library discipline now — backwards-compatibility commitments on the
public surface, full PHPDoc on every actor-facing method, level-max PHPStan,
PSR-12 + curated Slevomat code style, polished README, CI gates from day one,
and semver-tagged releases — even though there is no external consumer yet.
The bet is that internal-only conventions ossify and become expensive to
retrofit later; designing for "public-ready" from day one costs little and
preserves the option to publish.

## Considered options

- **Internal-only.** Cheaper short-term (skip PHPStan, skip PHPDoc, no CHANGELOG discipline), but creates a multi-week retrofit cost the moment external publication becomes desirable.
- **Public-from-day-one.** Would require migration guides, security policy, contribution guide, and external-consumer support commitments before there is an external need to satisfy.

## Consequences

- Every PR must keep CI green (PHPStan max + PHPCS + acceptance suite).
- Every public method on a Plugin Module gets the wp-browser docblock skeleton.
- Backwards-compatibility on the public surface is a review concern even at v0.x.
- 1.0 release is gated on adoption ("two internal projects shipped one cycle without breaking changes from us"), with a 12-month soft review so "internal-first" doesn't become permanent without revisiting.
