<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Method;

use Aztec\WPBrowser\Config\WooCommerceConfig;
use Aztec\WPBrowser\Page\PageObjectProvider;
use Codeception\Util\Locator;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

trait CartMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;

    abstract protected function wpDb(): WPDb;

    abstract protected function wooCommerceConfig(): WooCommerceConfig;

    abstract protected function pageObjectProvider(): PageObjectProvider;

    public function amOnCartPage(): void
    {
        $this->wpWebDriver()->amOnPage($this->wooCommerceConfig()->cartPageSlug());
    }

    public function addProductToCart(int $productId, int $quantity = 1): void
    {
        $this->wpWebDriver()->amOnPage("/?add-to-cart=$productId&quantity=$quantity");
        $this->wpWebDriver()->waitForElement(
            $this->pageObjectProvider()->cartPage()::PRODUCT_ADDED_TO_CART_MESSAGE_SELECTOR
        );
    }

    public function seeProductInCart(int $productId): void
    {
        $productName = $this->wpDb()->grabPostFieldFromDatabase($productId, 'post_title');

        $this->wpWebDriver()->see($productName, $this->pageObjectProvider()->cartPage()::PRODUCT_NAME_SELECTOR);
    }

    public function dontSeeProductInCart(int $productId): void
    {
        $productName = $this->wpDb()->grabPostFieldFromDatabase($productId, 'post_title');

        $this->wpWebDriver()->dontSee($productName, $this->pageObjectProvider()->cartPage()::PRODUCT_NAME_SELECTOR);
    }

    public function seeCartItemQuantity(int $productId, int $quantity): void
    {
        $productName      = $this->wpDb()->grabPostFieldFromDatabase($productId, 'post_title');
        $cartItemXpath         = Locator::contains($this->pageObjectProvider->cartPage()::CART_ITEM_SELECTOR, $productName);
        $cartItemQuantity = $this->wpWebDriver()->grabAttributeFrom(
            $this->pageObjectProvider()->cartPage()->cartItemQuantitySelector($cartItemXpath),
            'value'
        );

        $this->assertEquals($quantity, (int)$cartItemQuantity);
    }

    public function seeCartTotalQuantity(int $quantity): void
    {
        $totalQuantity = $this->wpWebDriver()->executeJS(
            'return Array.from(document.querySelectorAll("' . $this->pageObjectProvider->cartPage()::PRODUCT_QUANTITY_SELECTOR . '"))'
            . '.reduce((sum, input) => sum + parseInt(input.value), 0)'
        );

        $this->assertEquals($quantity, $totalQuantity);
    }

    public function clearCart(): void
    {
        $countItemsJs   = sprintf(
            "return document.querySelectorAll('%s').length",
            $this->pageObjectProvider->cartPage()::REMOVE_ITEM_SELECTOR
        );
        $clickRemoveJs  = sprintf("document.querySelector('%s').click()", $this->pageObjectProvider->cartPage()::REMOVE_ITEM_SELECTOR);
        $remainingItems = $this->wpWebDriver()->executeJS($countItemsJs);

        while ($remainingItems > 0) {
            $this->wpWebDriver()->executeJS($clickRemoveJs);
            $this->wpWebDriver()->waitForJS(
                sprintf(
                    "return document.querySelectorAll('%s').length < %d",
                    $this->pageObjectProvider->cartPage()::REMOVE_ITEM_SELECTOR,
                    $remainingItems
                )
            );

            $remainingItems--;
        }

        $this->wpWebDriver()->seeElement($this->pageObjectProvider()->cartPage()::EMPTY_CART_SELECTOR);
    }
}
