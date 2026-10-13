#!/usr/bin/env bash
#
# Bootstrap the WordPress test site on the mounted source tree.
#
# Every run rebuilds the site from an empty database, so the dump the suite
# restores before each test never carries what the last test left behind.
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
DB_FILE=public/packages/database/.ht.sqlite

if [ ! -f public/packages/db.php ]; then
    cp public/packages/plugins/sqlite-database-integration/db.copy \
        public/packages/db.php
fi

# Install the test-only mu-plugin that quiesces background admin traffic
# (Action Scheduler async runner, heartbeat, etc.) which otherwise deadlocks the
# single-worker PHP server. Always overwrite: the repo's copy is authoritative
# and updates must reach existing checkouts.
mkdir -p public/packages/mu-plugins
cp resources/mu-plugins/00-test-quiesce.php public/packages/mu-plugins/00-test-quiesce.php

# The acceptance suite leaves the database in the state of its last test, such
# as Action Scheduler actions a wp-admin page queued. Start from an empty one.
rm -f "$DB_FILE" "$DB_FILE-journal"

wp core install \
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

# WooCommerce ships a fresh install in "coming soon" mode, which serves the
# placeholder page instead of the cart and checkout blocks to logged-out
# visitors. Acceptance tests browse logged out, so leave the store public.
wp option update woocommerce_coming_soon no

# Activating WooCommerce sends the next wp-admin page to the setup wizard for
# 30 seconds, so an admin test run that soon after this script landed there.
wp transient delete _wc_activation_redirect

mkdir -p tests/_data
# Keep DELETE journal mode (SQLite's default). WPDb resets the database between
# tests by copying a snapshot file directly over the live SQLite file; WAL's
# separate -wal/-shm sidecars are orphaned by that raw copy and corrupt the DB
# ("database disk image is malformed"). DELETE keeps all state in the single
# main file, which is safe to swap. synchronous=FULL maximises journal durability.
sqlite3 "$DB_FILE" "PRAGMA journal_mode=DELETE; PRAGMA synchronous=FULL;"

# sqlite3's .dump cuts a text value at its first NUL byte, and PHP serializes
# protected and private properties with NUL bytes, such as the schedule of an
# Action Scheduler action. A cut value no longer unserializes, and WooCommerce
# then loops on the broken action until PHP times the request out. Refuse to
# write such a dump.
nul_columns="$(sqlite3 "$DB_FILE" "
    SELECT 'SELECT ''' || m.name || '.' || p.name || ''' FROM \"' || m.name || '\"'
        || ' WHERE instr(CAST(\"' || p.name || '\" AS BLOB), X''00'') LIMIT 1;'
    FROM sqlite_master AS m JOIN pragma_table_info(m.name) AS p
    WHERE m.type = 'table'
" | sqlite3 "$DB_FILE")"
if [ -n "$nul_columns" ]; then
    echo "Cannot dump the database: sqlite3 .dump would cut the NUL bytes in these columns:" >&2
    echo "$nul_columns" >&2
    exit 1
fi

sqlite3 "$DB_FILE" .dump > tests/_data/dump.sql

echo "WordPress test site ready at ${WP_HOME}."
