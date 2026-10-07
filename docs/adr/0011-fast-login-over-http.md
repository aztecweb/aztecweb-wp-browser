# Fast log-in authenticates over HTTP and transfers the cookies

Driving the `wp-login.php` form in the browser (`WPWebDriver::loginAs`/
`loginAsAdmin`) costs ~2–3 s per test: the module loads the login page, waits for
three elements, fills the form, clicks submit, and returns as soon as the auth
cookies are readable — with the post-login redirect still in flight (the race
ADR-0010 settles). The site's own speed is a separate problem: every wp-admin
load targets update checks against api.wordpress.org, which stall the login for
tens of seconds when the environment does not block outgoing HTTP. That stall is
the **consumer's** to fix (a per-environment network policy), not the library's:
a versioned mu-plugin that forced `WP_HTTP_BLOCK_EXTERNAL` would break consumer
suites that legitimately talk to external services (payment sandboxes, mail
traps).

To remove the log-in flow cost, `fastLoginAs(string $username, string $password)`
and `fastLoginAsAdmin()` authenticate over the **HTTP layer** and hand the
resulting cookies to the browser:

1. A Guzzle `Client` (`allow_redirects => false`, `http_errors => false`) POSTs
   `log`/`pwd`/`redirect_to` to `wp-login.php` in a single request. The
   `testcookie` field is omitted on purpose: WordPress only checks for the
   `wordpress_test_cookie` when that field is posted, so no preliminary GET is
   needed — the same request WordPress core's own Playwright utilities send
   (`@wordpress/e2e-test-utils-playwright`, `request-utils/login.ts`).
   WordPress authenticates the credentials and registers the session token
   itself; the response is a 302 carrying the auth cookies.
2. The redirect is **not** followed — that is what skips the slow wp-admin load.
3. The browser is sent to `wp-includes/images/blank.gif` (resolved from
   `adminPath`, so subdirectory installs work) to land on the site's domain
   without bootstrapping WordPress, and the auth cookies are copied into it with
   `WPWebDriver::setCookie()`. Over HTTP these are `wordpress_{hash}` and
   `wordpress_logged_in_{hash}`; over HTTPS, `wordpress_sec_{hash}` and
   `wordpress_logged_in_{hash}`, keeping the `Secure` flag.

The cookie hash is read from the `Set-Cookie` headers, never computed, so the
method is correct regardless of the site URL/scheme. WordPress does the
authenticating, so the library needs no wp-config salts and no database access —
the browser layer stays DB-free (ADR-0008). `guzzlehttp/guzzle` is guaranteed to
consumers: this package requires `lucatume/wp-browser`, which requires
`codeception/module-phpbrowser`, which requires Guzzle.

This supersedes the "cookie pre-authentication" rejection recorded in ADR-0010.
That option bundled two different approaches; only the *minting* one is
unworkable, and the measurement that settled it is below.

## Considered Options

- **Mint the auth cookies in-process** (the scratch implementation) — rejected,
  and verified broken rather than merely disliked: it needs wp-config salts and
  the `session_tokens` DB row. The test config's salts are duplicated, so
  `wp_salt('auth')` ignores `wp-config.php` and falls back to salts WordPress
  generates into the database (`auth_key`, `auth_salt`), making the minted cookie
  invalid (`reauth=1`). In Bedrock (`Config::define('AUTH_KEY', env('AUTH_KEY'))`)
  the wp-config parser would read the literal string `'AUTH_KEY'` as the salt.
  No wp-config parsing fixes this. It also crosses the DB-free boundary
  (ADR-0008).
- **Replay a captured session** (the Asaas pattern) — rejected: shared session,
  expires in two days, needs `WPDb` to re-insert `session_tokens`, and adds a
  slow capture phase to the first log-in of a run.
- **Authenticate over HTTP and transfer the cookies** — chosen: fresh session
  per test, no database writes, no wp-config access, ~0.25 s steady-state, and
  WordPress is the only thing doing the authenticating.
- **Keep only browser-driven `loginAs` and settle it** (ADR-0010) — kept as the
  wp-browser behavior; the settle remains for consumers who call it. The fast
  methods are additive and never override it (ADR-0002).

## Consequences

- The log-in flow cost (~2–3 s/test) is gone for callers of the fast methods.
  The update-check stall is **not** solved here; document it as an environment
  concern in the consumer's config (the OneLearning MR 379 pattern: constants per
  environment in `config/application.php`).
- Custom login forms (2FA/SSO/reCAPTCHA) are out of scope, exactly as they are
  for `loginAs` — not a regression.
- Cookies are re-attached with `path=/`, `httpOnly` and their original
  `Secure` flag; the narrower WordPress paths (`/wp-admin`, `/wp-content/plugins`)
  and any `COOKIE_DOMAIN` are not reproduced. Acceptable for a test origin.
- The first log-in of a run pays a cold-bootstrap cost (~1 s); steady-state is
  ~0.25 s.
