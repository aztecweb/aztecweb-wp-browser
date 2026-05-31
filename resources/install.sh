#!/usr/bin/env bash
#
# Bootstrap the WordPress test site on the mounted source tree.
#
# Idempotent: re-running is a no-op once the SQLite database is in place.
# WP-CLI is invoked via `composer exec -- wp` so it resolves from vendor/bin
# regardless of PATH or working directory. This keeps the script portable
# across the bind-mounted image (bin/test) and CI containers, where the repo
# is checked out outside the image's baked PATH.

set -euo pipefail

# Resolve WP-CLI through Composer so it works wherever the script is run from.
wp() {
    composer exec --quiet -- wp "$@"
}

WP_HOME="${WP_HOME:-http://localhost:8080}"
WP_TITLE="${WP_TITLE:-AztecWP Browser Test Site}"
WP_ADMIN_USER="${WP_ADMIN_USER:-admin}"
WP_ADMIN_PASSWORD="${WP_ADMIN_PASSWORD:-password}"
WP_ADMIN_EMAIL="${WP_ADMIN_EMAIL:-admin@example.com}"

if [ ! -f public/packages/db.php ]; then
    cp public/packages/plugins/sqlite-database-integration/db.copy \
        public/packages/db.php
fi

# Install the test-only mu-plugin that quiesces background admin traffic
# (Action Scheduler async runner, heartbeat, etc.) which otherwise deadlocks the
# single-worker PHP server.
if [ ! -f public/packages/mu-plugins/00-test-quiesce.php ]; then
    mkdir -p public/packages/mu-plugins
    cp resources/mu-plugins/00-test-quiesce.php public/packages/mu-plugins/00-test-quiesce.php
fi

wp core is-installed --quiet || wp core install \
    --url="${WP_HOME}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email

wp plugin activate woocommerce sqlite-database-integration
wp theme activate storefront
wp rewrite structure '/%postname%/' --hard
wp wc payment_gateway update cod --user=admin --enabled=true
wp wc hpos sync

mkdir -p tests/_data
# Keep DELETE journal mode (SQLite's default). WPDb resets the database between
# tests by copying a snapshot file directly over the live SQLite file; WAL's
# separate -wal/-shm sidecars are orphaned by that raw copy and corrupt the DB
# ("database disk image is malformed"). DELETE keeps all state in the single
# main file, which is safe to swap. synchronous=FULL maximises journal durability.
sqlite3 public/packages/database/.ht.sqlite "PRAGMA journal_mode=DELETE; PRAGMA synchronous=FULL;"
sqlite3 public/packages/database/.ht.sqlite .dump > tests/_data/dump.sql

echo "WordPress test site ready at ${WP_HOME}."
