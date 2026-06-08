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

    public function amOnCartPage(): void
    {
        $this->wpWebDriver()->amOnPage($this->wooCommerceConfig()->cartPageSlug());
    }

    public function addProductToCart(int $productId, int $quantity = 1): void
    {
        $this->wpWebDriver()->amOnPage("/?add-to-cart=$productId&quantity=$quantity");
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();
        $this->wpWebDriver()->waitForElement($this->selector($cartPage::PRODUCT_ADDED_TO_CART_MESSAGE_SELECTOR));
    }

    public function seeProductInCart(int $productId): void
    {
        $productName = $this->wpDb()->grabPostFieldFromDatabase($productId, 'post_title');
        $productName = is_string($productName) ? $productName : '';
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();

        $this->wpWebDriver()->see($productName, $this->selector($cartPage::PRODUCT_NAME_SELECTOR));
    }

    public function dontSeeProductInCart(int $productId): void
    {
        $productName = $this->wpDb()->grabPostFieldFromDatabase($productId, 'post_title');
        $productName = is_string($productName) ? $productName : '';
        /** @var CartPageObject $cartPage */
        $cartPage = $this->pageObjectProvider()->cartPage();

        $this->wpWebDriver()->dontSee($productName, $this->selector($cartPage::PRODUCT_NAME_SELECTOR));
    }

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
