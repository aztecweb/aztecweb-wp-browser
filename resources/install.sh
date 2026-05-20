#!/usr/bin/env bash
#
# Bootstrap the WordPress test site on the mounted source tree.
#
# Idempotent: re-running is a no-op once the SQLite database is in place.
# Expects vendor/bin/wp to be on PATH (the Dockerfile exports it; on the host,
# the wrapper at bin/test ensures it).

set -euo pipefail

WP_HOME="${WP_HOME:-http://localhost:8080}"
WP_TITLE="${WP_TITLE:-AztecWP Browser Test Site}"
WP_ADMIN_USER="${WP_ADMIN_USER:-admin}"
WP_ADMIN_PASSWORD="${WP_ADMIN_PASSWORD:-password}"
WP_ADMIN_EMAIL="${WP_ADMIN_EMAIL:-admin@example.com}"

if wp core is-installed --quiet 2>/dev/null; then
    echo "WordPress already installed — nothing to do."
    exit 0
fi

if [ ! -f public/packages/db.php ]; then
    cp public/packages/plugins/sqlite-database-integration/db.copy \
        public/packages/db.php
fi

wp core install \
    --url="${WP_HOME}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email

wp plugin activate woocommerce sqlite-database-integration
wp theme activate storefront
wp wc hpos sync

echo "WordPress test site ready at ${WP_HOME}."
