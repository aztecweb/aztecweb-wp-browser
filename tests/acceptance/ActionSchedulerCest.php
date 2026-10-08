<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class ActionSchedulerCest
{
    public function testHaveActionInDatabase(AcceptanceTester $I): void
    {
        $actionId = $I->haveActionInDatabase('aztec_test_hook', ['key' => 'value']);

        $I->assertGreaterThan(0, $actionId, 'Action ID should be a positive integer');
        $I->assertSame('pending', $I->grabActionStatusFromDatabase($actionId));
    }

    public function testGrabActionsFromDatabaseReturnsMatchingRows(AcceptanceTester $I): void
    {
        $actionId = $I->haveActionInDatabase('aztec_test_hook_rows');
        $I->haveActionInDatabase('aztec_test_other_hook');

        $actions = $I->grabActionsFromDatabase(['hook' => 'aztec_test_hook_rows']);

        $I->assertCount(1, $actions);
        $I->assertSame('aztec_test_hook_rows', $actions[0]['hook']);
        $I->assertEquals($actionId, $actions[0]['action_id']);
    }

    public function testGrabActionsFromDatabaseReturnsEmptyWhenNothingMatches(AcceptanceTester $I): void
    {
        $I->haveActionInDatabase('aztec_test_hook_present');

        $I->assertCount(0, $I->grabActionsFromDatabase(['hook' => 'aztec_test_hook_missing']));
    }
}
