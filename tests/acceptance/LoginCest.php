<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class LoginCest
{
    public function testLoginAsAdminDoesNotClobberTheNextNavigation(AcceptanceTester $I): void
    {
        $I->loginAsAdmin();
        $I->amOnPage('/');
        $I->dontSeeInCurrentUrl('/wp-admin/');
    }

    public function testLoginSettleLeavesAnIdleLoginFormWhenAlreadyLoggedIn(AcceptanceTester $I): void
    {
        // The state wp-browser's loginAs() retry can leave: logged in, back on the form, nothing pending.
        $I->fastLoginAsAdmin();
        $I->amOnPage('/wp/wp-login.php');
        $I->seeElement('#loginform');

        $I->settleLoginStep();

        $I->seeInCurrentUrl('/wp-admin/');
        $I->dontSeeElement('#loginform');
    }

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
