<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Page;

class CartPageObject
{
    public const PRODUCT_NAME_SELECTOR = '.wc-block-components-product-name';
    public const PRODUCT_QUANTITY_SELECTOR = '.wc-block-components-quantity-selector__input';
    public const PRODUCT_ADDED_TO_CART_MESSAGE_SELECTOR = '.woocommerce-message a.wc-forward';
    public const EMPTY_CART_SELECTOR = '.wp-block-woocommerce-empty-cart-block';
    public const CART_ITEM_SELECTOR = '.wc-block-cart-item__wrap';
    public const REMOVE_ITEM_SELECTOR = 'button.wc-block-cart-item__remove-link';

    public function cartItemQuantitySelector(string $cartItemXpath): string
    {
        $quantityClass = ltrim(self::PRODUCT_QUANTITY_SELECTOR, '.');

        return sprintf('%s//*[contains(@class, "%s")]', $cartItemXpath, $quantityClass);
    }
}
