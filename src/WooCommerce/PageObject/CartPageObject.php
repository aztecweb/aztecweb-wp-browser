<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\PageObject;

class CartPageObject
{
    public const PRODUCT_NAME_SELECTOR = '.wc-block-components-product-name';
    public const PRODUCT_QUANTITY_SELECTOR = '.wc-block-components-quantity-selector__input';
    public const EMPTY_CART_SELECTOR = '.wp-block-woocommerce-empty-cart-block';
    public const CART_ITEM_SELECTOR = '.wc-block-cart-item__wrap';
    public const REMOVE_ITEM_SELECTOR = 'button.wc-block-cart-item__remove-link';
    /**
     * Matches while the Cart block is still rendering in the browser.
     *
     * The block carries `is-loading` until it mounts, then shows a
     * `wc-block-placeholder` for each inner block still being loaded.
     */
    public const LOADING_CART_SELECTOR = '.wp-block-woocommerce-cart.is-loading, '
        . '.wp-block-woocommerce-cart .wc-block-placeholder';

    public function cartItemQuantitySelector(string $cartItemXpath): string
    {
        $quantityClass = ltrim(self::PRODUCT_QUANTITY_SELECTOR, '.');

        return sprintf('%s//*[contains(@class, "%s")]', $cartItemXpath, $quantityClass);
    }
}
