#!/bin/bash

# Script to install WooCommerce Subscriptions (premium plugin)
# Usage:
#   ./install-woocommerce-subscriptions.sh                  # Looks for woocommerce-subscriptions.zip in current dir
#   ./install-woocommerce-subscriptions.sh /path/to/wcs.zip # Explicit path to zip file

set -e

PLUGIN_DIR="./woocommerce-subscriptions"
ZIP_PATH="${1:-./plugins/woocommerce-subscriptions.zip}"

if [ -d "$PLUGIN_DIR" ]; then
    echo "WooCommerce Subscriptions directory already exists at $PLUGIN_DIR"
    echo "Skipping installation. Remove the directory to reinstall."
    exit 0
fi

if [ ! -f "$ZIP_PATH" ]; then
    echo "Error: WooCommerce Subscriptions ZIP not found at $ZIP_PATH"
    echo ""
    echo "WooCommerce Subscriptions is a premium plugin available at:"
    echo "  https://woocommerce.com/products/woocommerce-subscriptions/"
    echo ""
    echo "Once you have the ZIP file, run:"
    echo "  ./install-woocommerce-subscriptions.sh /path/to/woocommerce-subscriptions.zip"
    exit 1
fi

FILE_SIZE=$(stat -c%s "$ZIP_PATH" 2>/dev/null || stat -f%z "$ZIP_PATH" 2>/dev/null)
echo "Found WooCommerce Subscriptions ZIP (${FILE_SIZE} bytes)"

if [ "$FILE_SIZE" -lt 1000 ]; then
    echo "Error: ZIP file is too small, likely invalid"
    exit 1
fi

echo "Extracting WooCommerce Subscriptions..."
unzip -q "$ZIP_PATH" -d /tmp/wcs-extract

if [ -d "/tmp/wcs-extract/woocommerce-subscriptions" ]; then
    mv /tmp/wcs-extract/woocommerce-subscriptions "$PLUGIN_DIR"
else
    EXTRACTED_DIR=$(ls /tmp/wcs-extract | head -1)
    mv "/tmp/wcs-extract/$EXTRACTED_DIR" "$PLUGIN_DIR"
fi

rm -rf /tmp/wcs-extract

echo "WooCommerce Subscriptions installed at $PLUGIN_DIR"
ls -la "$PLUGIN_DIR"
