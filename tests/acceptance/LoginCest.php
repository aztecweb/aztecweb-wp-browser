<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;
use Codeception\Exception\ModuleException;

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

    public function testLoginSettleLeavesARejectedLoginFormWhenAlreadyLoggedIn(AcceptanceTester $I): void
    {
        // A wrong password keeps the earlier session's log-in cookie, so only the error tells the log-in failed.
        $I->fastLoginAsAdmin();
        $I->amOnPage('/wp/wp-login.php');
        $I->fillField('#user_login', 'admin');
        $I->fillField('#user_pass', 'wrong-password');
        $I->click('#wp-submit');
        $I->waitForElement('#login_error');

        $I->expectThrowable(
            ModuleException::class,
            function () use ($I): void {
                $I->settleLoginStep();
            },
        );

        $I->seeElement('#login_error');
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
