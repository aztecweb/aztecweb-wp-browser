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
}
