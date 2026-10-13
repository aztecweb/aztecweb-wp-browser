<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;
use Aztec\WPBrowser\WooCommerce\PageObject\CartPageObject;

class CartCest
{
    public function _after(AcceptanceTester $I): void
    {
        $I->restartBuiltInServer();
    }

    public function testAmOnCartPageWaitsForTheCartBlockToRender(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase(['post_title' => 'Rendered Product']);

        $I->addProductToCart($productId);
        $I->throttleBrowserCpu(20);
        $I->amOnCartPage();

        $I->dontSeeElement(CartPageObject::LOADING_CART_SELECTOR);
        $I->seeElement(CartPageObject::PRODUCT_NAME_SELECTOR);
    }

    public function testSeeProductInCart(AcceptanceTester $I): void
    {
        $productName = 'Cart Product';
        $productId = $I->haveProductInDatabase([
            'post_title' => $productName,
        ]);

        $I->addProductToCart($productId);
        $I->amOnCartPage();

        $I->seeProductInCart($productName);
    }

    public function testDontSeeProductInCart(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Present Product',
        ]);

        $I->addProductToCart($productId);
        $I->amOnCartPage();

        $I->dontSeeProductInCart('Missing Product');
    }

    public function testSeeCartItemQuantity(AcceptanceTester $I): void
    {
        $productName = 'Quantity Product';
        $productId = $I->haveProductInDatabase([
            'post_title' => $productName,
        ]);

        $I->addProductToCart($productId, 3);
        $I->amOnCartPage();

        $I->seeCartItemQuantity($productName, 3);
    }
}
