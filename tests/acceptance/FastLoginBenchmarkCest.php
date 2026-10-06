<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class FastLoginBenchmarkCest
{
    public function testFastLoginAsAdminLandsOnTheDashboard(AcceptanceTester $I): void
    {
        $I->fastLoginAsAdmin();

        $I->amOnAdminPage('/');
        $I->see('Dashboard');
    }

    public function testFastLoginAsCustomerLandsAuthenticated(AcceptanceTester $I): void
    {
        $I->haveCustomerInDatabase([
            'user_login' => 'customer',
            'user_pass' => 'pw',
        ]);

        $I->fastLoginAs('customer', 'pw');

        $I->amOnMyAccountPage();
        $I->seeElement('body.logged-in');
    }
}
