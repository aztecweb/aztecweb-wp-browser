<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class CustomerNewMethodsCest
{
    public function testGrabCustomerIdFromDatabase(AcceptanceTester $I): void
    {
        // Create a customer first
        $userId = $I->haveCustomerInDatabase([
            'user_login' => 'testcustomer',
            'user_email' => 'test@example.com',
        ]);

        // Test finding existing customer by user_login
        $grabbedId = $I->grabCustomerIdFromDatabase('testcustomer');
        assert($userId === $grabbedId);

        // Test non-existent customer
        $notFound = $I->grabCustomerIdFromDatabase('nonexistent');
        assert($notFound === false);
    }

    public function testSeeCustomerInDatabase(AcceptanceTester $I): void
    {
        // Create a customer
        $userId = $I->haveCustomerInDatabase([
            'user_login' => 'visible',
            'user_email' => 'visible@example.com',
        ]);

        // Should see the customer
        $I->seeCustomerInDatabase(['user_login' => 'visible']);
        $I->seeCustomerInDatabase(['user_email' => 'visible@example.com']);

        // Multiple criteria
        $I->seeCustomerInDatabase([
            'user_login' => 'visible',
            'user_email' => 'visible@example.com',
        ]);

        // Create another customer with different login
        try {
            $userId2 = $I->haveCustomerInDatabase([
                'user_login' => 'visible2',
                'user_email' => 'different@example.com',
            ]);
        } catch (\Exception $e) {
            // Se falhar porque o login já existe, use um login diferente
            $userId2 = $I->haveCustomerInDatabase([
                'user_login' => 'visible3',
                'user_email' => 'different@example.com',
            ]);
        }

        // Should see only the specific customer
        $I->seeCustomerInDatabase([
            'user_login' => 'visible',
            'user_email' => 'visible@example.com',
        ]);

        // Should not see the other one
        $I->dontSeeCustomerInDatabase([
            'user_login' => 'visible3',
            'user_email' => 'different@example.com',
        ]);
    }

    public function testSeeCustomerMetaInDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'meta-customer',
            'billing' => [
                'first_name' => 'John',
                'last_name' => 'Doe',
            ],
        ]);

        // Test with user_id, meta_key, and meta_value
        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'billing_first_name',
            'meta_value' => 'John',
        ]);

        // Test with just user_id and meta_key
        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'billing_last_name',
        ]);

        // Test with non-existent meta
        $I->dontSeeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'nonexistent_key',
        ]);
    }
}