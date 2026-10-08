# WC status inputs are normalized to the `wc-` prefixed form

WooCommerce stores order and subscription statuses in the database with a `wc-`
prefix (`wc-pending`, `wc-active`), but names them without it everywhere a person
reads or writes one — the admin UI, the WC PHP API, the docs. Every actor method
that accepts a **WC status** therefore accepted an ambiguous value: `'processing'`
silently wrote or matched nothing, while `'wc-processing'` worked.

A single helper, `Aztec\WPBrowser\Normalizer\StatusNormalizer`, resolves that
ambiguity: a status on the known WooCommerce allowlist gains the `wc-` prefix,
anything else is returned verbatim. It is applied at **input call sites only** —
the status argument of `have*Status`, the `status`/`post_status` key of
`have*InDatabase`, and the status criterion of the criteria-based methods
(`see*InDatabase`, `dontSee*InDatabase`, `grab*IdFromDatabase`, and
`see*Status`, which delegates to `see*InDatabase`). Output is left alone:
`grabOrderStatus()` and `grabSubscriptionStatus()` return the raw stored value,
still prefixed.

Normalization is deliberately **not validation**. An unknown status is not an
error — WooCommerce's status set is extensible (`wc_register_order_status()`),
and a third-party plugin's status, or a WordPress post status such as `trash`,
must reach the database uncorrupted. The allowlist exists to decide what gets a
prefix, never to decide what is allowed.

## Considered options

- **Validate and reject unknown statuses.** Rejected: it turns the allowlist into
  a gate, so every store running a plugin that registers its own status has to
  wait for a library release before it can write that status in a test.
- **Normalize on output too** (strip `wc-` from `grab*Status`). Rejected: a grab
  method's contract is "what is in the column"; rewriting it hides the storage
  shape from tests that legitimately assert on it, and leaves no way to read the
  raw value at all.
- **Normalize inside each storage class independently.** Rejected: the same
  allowlist would be duplicated across the HPOS and Legacy storages for both
  orders and subscriptions, four places that drift apart.
- **Accept only the prefixed form and document it.** Rejected: it keeps the
  library's vocabulary out of step with every other surface a test author reads,
  for no gain beyond not writing the helper.

## Consequences

- A status argument that previously matched nothing now matches. Tests written
  against the old behavior — asserting that `seeOrderStatus($id, 'processing')`
  fails, or compensating by always passing the prefix — change meaning. This is a
  behavioral break shipped without a feature flag: the project is pre-1.0, and a
  flag would freeze the ambiguity it exists to remove.
- The allowlist is a maintenance surface. A status added by a future WooCommerce
  release passes through unprefixed until it is added here, which reads as a
  silent no-match rather than an error.
- Statuses that are not WC statuses are untouched by design, which includes the
  coupon methods: `haveCouponStatus()`/`seeCouponStatus()` take a WordPress post
  status (`publish`, `draft`) and never go near the normalizer.
