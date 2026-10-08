# Log-in steps settle their redirect through the module's `_afterStep` hook

wp-browser's `WPWebDriver::loginAs()`/`loginAsAdmin()` return once the auth
cookies are readable, which can be before the browser commits the redirected
page: the test's next navigation then races the pending one and can be
overwritten (the test ends on the post-login landing page, not the requested
one). That race is invisible while the login redirect target is slow, and
surfaces as soon as a suite gets fast.

`WooCommerceWebDriver` cannot fix it by overloading the method: a Plugin Module
that declared `loginAs`/`loginAsAdmin` would collide with `WPWebDriver`'s own
action, and Codeception resolves duplicate actions by **silent last-module-wins**
in `suite.yml` order
(`Codeception\Lib\ModuleContainer::create()` → `actions[$action] = $module`,
consumed by `moduleForAction()`), not with an error. The behavior would depend on
the order consumers happen to list their modules in — a failure mode worse than
the race.

Instead the module intercepts the step after it runs: `_afterStep()` sees the
just-executed action (still `loginAs`/`loginAsAdmin` for `tryTo`/`retry`
variants) and calls a private `waitForLoginToSettle()`, which polls the browser
until the login form is gone, the document is complete and two consecutive
polls see the same document (a marker on `window` is wiped by any navigation,
so a chained redirect such as `profile.php` to the account page restarts the
count). The step stays
wp-browser's; the module only waits behind it.

## Considered options

- **Same-named method on the Plugin Module** — rejected: silent, order-dependent
  shadowing (see above), and it breaks the "each module exports only its own
  additions" invariant the composition architecture rests on.
- **A separately named wrapper step** (`amLoggedInAsAdmin()` wrapping
  wp-browser's login) — rejected: consumers must change every call, and the
  library carries a second login API that can drift from wp-browser's.
- **Consumer-level Actor override** — viable but consumer-side: every project
  copies the wait, cannot be covered by this library's tests, and breaks on
  wp-browser signature changes.
- **Cookie pre-authentication (mint WP auth cookies, or POST to `wp-login.php`
  directly)** — rejected: minting needs `wp-config` salts/CLI/DB access, crosses
  the browser layer's DB-free boundary (ADR-0008), and adds an authentication
  bypass to test code.
- **Upstream fix in wp-browser** — the correct long-term home; until it lands,
  this hook is the library-level workaround.

## Consequences

- Consumers keep writing `$I->loginAsAdmin();` — no API change and no migration.
- Only actor steps are intercepted. A direct `$this->wpWebDriver()->loginAs()`
  call inside a Method Trait bypasses the hook and must settle explicitly.
- A failed log-in step is skipped (`Step::hasFailed()`): the hook runs in
  Scenario's `finally`, so without the guard a timeout would mask the real error.
- The wait is implicit, so the module emits no step of its own; it is bounded by
  `LOGIN_SETTLE_TIMEOUT` (10 s) and ends once the landing document is
  complete, the login form is gone and the page stayed put between two polls.
- When wp-browser settles the redirect itself, this hook and ADR should be
  removed.
