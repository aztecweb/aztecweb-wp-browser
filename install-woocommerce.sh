#!/bin/bash

# Script to download and extract WooCommerce and Storefront theme

WOOCOMMERCE_VERSION="10.5.3"
WOOCOMMERCE_URL="https://github.com/woocommerce/woocommerce/releases/download/${WOOCOMMERCE_VERSION}/woocommerce.zip"
WOOCOMMERCE_DIR="./woocommerce"

STOREFRONT_VERSION="4.6.0"
STOREFRONT_URL="https://downloads.wordpress.org/theme/storefront.${STOREFRONT_VERSION}.zip"
STOREFRONT_DIR="./storefront"

echo "Downloading WooCommerce ${WOOCOMMERCE_VERSION}..."
echo "URL: ${WOOCOMMERCE_URL}"

curl -L -o /tmp/woocommerce.zip "${WOOCOMMERCE_URL}"

if [ $? -ne 0 ]; then
    echo "Failed to download WooCommerce"
    exit 1
fi

# Check if file is valid
FILE_SIZE=$(stat -c%s /tmp/woocommerce.zip 2>/dev/null || stat -f%z /tmp/woocommerce.zip 2>/dev/null)
echo "Downloaded file size: ${FILE_SIZE} bytes"

if [ "$FILE_SIZE" -lt 1000 ]; then
    echo "Downloaded file is too small, might be an error page"
    cat /tmp/woocommerce.zip
    exit 1
fi

echo "Extracting WooCommerce..."
rm -rf "${WOOCOMMERCE_DIR}"
# Extract to temp dir first, then move (zip contains woocommerce/ folder inside)
unzip -q /tmp/woocommerce.zip -d /tmp/woo-extract
mv /tmp/woo-extract/woocommerce "${WOOCOMMERCE_DIR}"
rm -rf /tmp/woo-extract

if [ $? -ne 0 ]; then
    echo "Failed to extract WooCommerce"
    exit 1
fi

rm /tmp/woocommerce.zip

echo "WooCommerce ${WOOCOMMERCE_VERSION} installed successfully in ${WOOCOMMERCE_DIR}"
ls -la "${WOOCOMMERCE_DIR}"

echo ""
echo "Downloading Storefront ${STOREFRONT_VERSION}..."
echo "URL: ${STOREFRONT_URL}"

curl -L -o /tmp/storefront.zip "${STOREFRONT_URL}"

if [ $? -ne 0 ]; then
    echo "Failed to download Storefront"
    exit 1
fi

FILE_SIZE=$(stat -c%s /tmp/storefront.zip 2>/dev/null || stat -f%z /tmp/storefront.zip 2>/dev/null)
echo "Downloaded file size: ${FILE_SIZE} bytes"

if [ "$FILE_SIZE" -lt 1000 ]; then
    echo "Downloaded file is too small, might be an error page"
    cat /tmp/storefront.zip
    exit 1
fi

echo "Extracting Storefront..."
rm -rf "${STOREFRONT_DIR}"
unzip -q /tmp/storefront.zip -d /tmp/storefront-extract
mv /tmp/storefront-extract/storefront "${STOREFRONT_DIR}"
rm -rf /tmp/storefront-extract

if [ $? -ne 0 ]; then
    echo "Failed to extract Storefront"
    exit 1
fi

rm /tmp/storefront.zip

echo "Storefront ${STOREFRONT_VERSION} installed successfully in ${STOREFRONT_DIR}"
ls -la "${STOREFRONT_DIR}"
