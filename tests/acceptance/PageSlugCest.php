<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class PageSlugCest
{
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
}
