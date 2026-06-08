<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use Aztec\WPBrowser\WooCommerce\PageObject\CartPageObject;
use Aztec\WPBrowser\WooCommerce\PageObject\PageObjectProvider;
use Codeception\Util\Locator;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

trait CartMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;

    abstract protected function wpDb(): WPDb;

    abstract protected function wooCommerceConfig(): WooCommerceConfig;

    abstract protected function pageObjectProvider(): PageObjectProvider;

    abstract protected function selector(mixed $value): string;

    /**
     * Navigate to the WooCommerce cart page.
     *
     * @example
     * ```php
     * $I->amOnCartPage();
     * $I->seeElement('.woocommerce-cart');
     * ```
     *
     * @return void
     */
    public function amOnCartPage(): void
    {
        $this->wpWebDriver()->amOnPage($this->wooCommerceConfig()->cartPageSlug());
    }

    /**
     * Add a product to the cart via the add-to-cart query parameter.
     *
     * @example
     * ```php
     * $productId = $I->haveProductInDatabase(['post_title' => 'Test Product']);
     * $I->addProductToCart($productId, 2);
     * $I->seeElement('.woocommerce-message');
     * ```
     *
     * @param int $productId  Product ID to add to the cart
     * @param int $quantity   Quantity to add (default: 1)
     *
     * @return void
     */
    public function addProductToCart(int $productId, int $quantity = 1): void
    {
        $this->wpWebDriver()->amOnPage("/?add-to-cart=$productId&quantity=$quantity");
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();
        $this->wpWebDriver()->waitForElement($this->selector($cartPage::PRODUCT_ADDED_TO_CART_MESSAGE_SELECTOR));
    }

    /**
     * Verify that a product is visible in the cart.
     *
     * @example
     * ```php
     * $productId = $I->haveProductInDatabase(['post_title' => 'Cart Product']);
     * $I->addProductToCart($productId);
     * $I->amOnCartPage();
     * $I->seeProductInCart($productId);
     * ```
     *
     * @param int $productId  Product ID to verify in the cart
     *
     * @return void
     */
    public function seeProductInCart(int $productId): void
    {
        $productName = $this->wpDb()->grabPostFieldFromDatabase($productId, 'post_title');
        $productName = is_string($productName) ? $productName : '';
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();

        $this->wpWebDriver()->see($productName, $this->selector($cartPage::PRODUCT_NAME_SELECTOR));
    }

    /**
     * Verify that a product is not visible in the cart.
     *
     * @example
     * ```php
     * $productId = $I->haveProductInDatabase(['post_title' => 'Missing Product']);
     * $I->amOnCartPage();
     * $I->dontSeeProductInCart($productId);
     * ```
     *
     * @param int $productId  Product ID to verify is not in the cart
     *
     * @return void
     */
    public function dontSeeProductInCart(int $productId): void
    {
        $productName = $this->wpDb()->grabPostFieldFromDatabase($productId, 'post_title');
        $productName = is_string($productName) ? $productName : '';
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();

        $this->wpWebDriver()->dontSee($productName, $this->selector($cartPage::PRODUCT_NAME_SELECTOR));
    }

    /**
     * Verify that a product in the cart has the expected quantity.
     *
     * @example
     * ```php
     * $productId = $I->haveProductInDatabase(['post_title' => 'Quantity Test']);
     * $I->addProductToCart($productId, 3);
     * $I->amOnCartPage();
     * $I->seeCartItemQuantity($productId, 3);
     * ```
     *
     * @param int $productId  Product ID to verify quantity for
     * @param int $quantity   Expected quantity in the cart
     *
     * @return void
     */
    public function seeCartItemQuantity(int $productId, int $quantity): void
    {
        $productName = $this->wpDb()->grabPostFieldFromDatabase($productId, 'post_title');
        $productName = is_string($productName) ? $productName : '';
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();
        $cartItemXpath = Locator::contains($this->selector($cartPage::CART_ITEM_SELECTOR), $productName);
        $cartItemQuantity = $this->wpWebDriver()->grabAttributeFrom(
            $cartPage->cartItemQuantitySelector($cartItemXpath),
            'value',
        );

        $this->assertEquals($quantity, (int)$cartItemQuantity);
    }

    /**
     * Verify that the total quantity of all items in the cart matches the expected value.
     *
     * @example
     * ```php
     * $product1Id = $I->haveProductInDatabase(['post_title' => 'Product 1']);
     * $product2Id = $I->haveProductInDatabase(['post_title' => 'Product 2']);
     * $I->addProductToCart($product1Id, 2);
     * $I->addProductToCart($product2Id, 1);
     * $I->amOnCartPage();
     * $I->seeCartTotalQuantity(3);
     * ```
     *
     * @param int $quantity  Expected total quantity of all items in the cart
     *
     * @return void
     */
    public function seeCartTotalQuantity(int $quantity): void
    {
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();
        $productQtySelector = $this->selector($cartPage::PRODUCT_QUANTITY_SELECTOR);
        $totalQuantity = $this->wpWebDriver()->executeJS(
            'return Array.from(document.querySelectorAll("' . $productQtySelector . '"))'
            . '.reduce((sum, input) => sum + parseInt(input.value), 0)',
        );

        $this->assertEquals($quantity, $totalQuantity);
    }

    /**
     * Remove all items from the cart until it is empty.
     *
     * @example
     * ```php
     * $productId = $I->haveProductInDatabase(['post_title' => 'Clear Test']);
     * $I->addProductToCart($productId);
     * $I->amOnCartPage();
     * $I->clearCart();
     * $I->seeElement('.cart-empty');
     * ```
     *
     * @return void
     */
    public function clearCart(): void
    {
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();
        $removeItemSelector = $this->selector($cartPage::REMOVE_ITEM_SELECTOR);
        $countItemsJs   = sprintf(
            "return document.querySelectorAll('%s').length",
            $removeItemSelector,
        );
        $clickRemoveJs  = sprintf("document.querySelector('%s').click()", $removeItemSelector);
        $remainingItems = $this->wpWebDriver()->executeJS($countItemsJs);
        $remainingItems = is_numeric($remainingItems) ? (int) $remainingItems : 0;

        while ($remainingItems > 0) {
            $this->wpWebDriver()->executeJS($clickRemoveJs);
            $this->wpWebDriver()->waitForJS(
                sprintf(
                    "return document.querySelectorAll('%s').length < %d",
                    $removeItemSelector,
                    $remainingItems,
                ),
            );

            $remainingItems--;
        }

        $this->wpWebDriver()->seeElement($cartPage::EMPTY_CART_SELECTOR);
    }
}
