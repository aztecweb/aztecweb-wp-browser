<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class PageSlugCest
{
    public function _after(AcceptanceTester $I): void
    {
        $I->resetWooCommerceWebDriverConfig();
        $I->restartBuiltInServer();
    }

    public function testNavigatesToDefaultCartSlug(AcceptanceTester $I): void
    {
        $I->amOnCartPage();

        $I->seeInCurrentUrl('/cart');
    }

    public function testNavigatesToDefaultMyAccountSlug(AcceptanceTester $I): void
    {
        $I->amOnMyAccountPage();

        $I->seeInCurrentUrl('/my-account');
    }

    public function testNavigatesToOverriddenCartSlug(AcceptanceTester $I): void
    {
        $I->havePostInDatabase([
            'post_name' => 'warenkorb',
            'post_type' => 'page',
            'post_status' => 'publish',
        ]);

        $I->overrideWooCommerceWebDriverConfig(['cartPageSlug' => '/warenkorb']);

        $I->amOnCartPage();

        $I->seeInCurrentUrl('/warenkorb');
    }
}
