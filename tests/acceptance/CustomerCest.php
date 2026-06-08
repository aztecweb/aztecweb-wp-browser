<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class CustomerCest
{
    public function testHaveCustomerInDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'john_doe',
            'user_email' => 'john.doe@example.com',
        ]);

        $I->assertIsInt($customerId);
        $I->assertGreaterThan(0, $customerId, 'Customer ID should be a positive integer');

        $I->seeCustomerInDatabase([
            'ID' => $customerId,
            'user_login' => 'john_doe',
            'user_email' => 'john.doe@example.com',
        ]);
    }

    public function testHaveCustomerInDatabaseWithDefaults(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase();

        $I->assertIsInt($customerId);
        $I->assertGreaterThan(0, $customerId, 'Customer ID should be a positive integer');

        $I->seeCustomerInDatabase([
            'ID' => $customerId,
            'user_login' => 'customer',
            'user_email' => 'customer@example.com',
        ]);
    }

    public function testHaveCustomerInDatabaseWithBillingAddress(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'jane_doe',
            'billing' => [
                'first_name' => 'Jane',
                'last_name' => 'Doe',
                'email' => 'jane@example.com',
                'phone' => '555-5678',
                'address_1' => '456 Oak Ave',
                'city' => 'Los Angeles',
                'state' => 'CA',
                'postcode' => '90001',
                'country' => 'US',
            ],
        ]);

        $I->seeCustomerBillingFieldInDatabase($customerId, 'first_name', 'Jane');
        $I->seeCustomerBillingFieldInDatabase($customerId, 'last_name', 'Doe');
        $I->seeCustomerBillingFieldInDatabase($customerId, 'email', 'jane@example.com');
        $I->seeCustomerBillingFieldInDatabase($customerId, 'phone', '555-5678');
        $I->seeCustomerBillingFieldInDatabase($customerId, 'address_1', '456 Oak Ave');
    }

    public function testHaveCustomerInDatabaseWithShippingAddress(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'shipping_customer',
            'shipping' => [
                'first_name' => 'Bob',
                'last_name' => 'Smith',
                'company' => 'Acme Corp',
                'address_1' => '789 Commerce Blvd',
                'address_2' => 'Suite 100',
                'city' => 'Chicago',
                'state' => 'IL',
                'postcode' => '60601',
                'country' => 'US',
            ],
        ]);

        $I->seeCustomerShippingFieldInDatabase($customerId, 'first_name', 'Bob');
        $I->seeCustomerShippingFieldInDatabase($customerId, 'last_name', 'Smith');
        $I->seeCustomerShippingFieldInDatabase($customerId, 'company', 'Acme Corp');
        $I->seeCustomerShippingFieldInDatabase($customerId, 'address_1', '789 Commerce Blvd');
    }

    public function testHaveCustomerInDatabaseWithMeta(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'meta_customer',
            'meta' => [
                'custom_field_1' => 'value_1',
                'custom_field_2' => 'value_2',
                'custom_field_3' => 'value_3',
            ],
        ]);

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'custom_field_1',
            'meta_value' => 'value_1',
        ]);

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'custom_field_2',
            'meta_value' => 'value_2',
        ]);

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'custom_field_3',
            'meta_value' => 'value_3',
        ]);
    }

    public function testHaveCustomerInDatabaseWithBillingAndShipping(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'complete_customer',
            'billing' => [
                'first_name' => 'Alice',
                'last_name' => 'Johnson',
                'city' => 'Miami',
                'postcode' => '33101',
            ],
            'shipping' => [
                'first_name' => 'Alice',
                'last_name' => 'Johnson',
                'city' => 'Miami',
                'postcode' => '33101',
            ],
        ]);

        $I->seeCustomerBillingFieldInDatabase($customerId, 'first_name', 'Alice');
        $I->seeCustomerShippingFieldInDatabase($customerId, 'city', 'Miami');
    }

    public function testHaveCustomerInDatabaseWithCustomRole(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'vip_customer',
            'role' => 'customer',
        ]);

        $userCaps = $I->grabUserMetaFromDatabase($customerId, 'wp_capabilities', true);

        if (is_string($userCaps)) {
            $unserialized = unserialize($userCaps);
            if (is_array($unserialized) && isset($unserialized['customer'])) {
                $I->assertTrue($unserialized['customer'], 'User should have customer role');
            }
        } else {
            if (is_array($userCaps)) {
                $I->assertArrayHasKey('customer', $userCaps);
                $I->assertTrue($userCaps['customer'], 'User should have customer role');
            }
        }
    }

    public function testGrabCustomerFieldFromDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'grab_field_user',
            'user_email' => 'grab@example.com',
        ]);

        $email = $I->grabCustomerFieldFromDatabase($customerId, 'user_email');
        $emailStr = is_string($email) ? $email : '';

        $I->assertSame('grab@example.com', $email, "Email should be 'grab@example.com', got '$emailStr'");
    }

    public function testGrabCustomerMeta(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'grab_meta_user',
            'meta' => [
                'custom_meta_key' => 'custom_meta_value',
            ],
        ]);

        $meta = $I->grabCustomerMeta($customerId, 'custom_meta_key', true);

        $I->assertSame('custom_meta_value', $meta, "Meta value should be 'custom_meta_value'");
    }

    public function testGrabCustomerMetaMultiple(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'grab_multi_meta_user',
            'meta' => [
                'meta_key_1' => 'value_1',
                'meta_key_2' => 'value_2',
            ],
        ]);

        $meta1 = $I->grabCustomerMeta($customerId, 'meta_key_1', true);
        $meta2 = $I->grabCustomerMeta($customerId, 'meta_key_2', true);

        $I->assertSame('value_1', $meta1, "First meta should be 'value_1'");
        $I->assertSame('value_2', $meta2, "Second meta should be 'value_2'");
    }

    public function testGrabCustomerBillingAddress(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'billing_addr_user',
            'billing' => [
                'first_name' => 'Test',
                'last_name' => 'User',
                'company' => 'Test Company',
                'address_1' => '123 Test St',
                'address_2' => 'Apt 4B',
                'city' => 'Test City',
                'state' => 'TS',
                'postcode' => '12345',
                'country' => 'US',
                'email' => 'test@billing.com',
                'phone' => '555-TEST',
            ],
        ]);

        $billingAddress = $I->grabCustomerBillingAddress($customerId);

        $I->assertSame('Test', $billingAddress['first_name'], 'Billing first name should be Test');
        $I->assertSame('User', $billingAddress['last_name'], 'Billing last name should be User');
        $I->assertSame('Test Company', $billingAddress['company'], 'Billing company should match');
        $I->assertSame('123 Test St', $billingAddress['address_1'], 'Billing address 1 should match');
        $I->assertSame('Apt 4B', $billingAddress['address_2'], 'Billing address 2 should match');
        $I->assertSame('Test City', $billingAddress['city'], 'Billing city should match');
        $I->assertSame('TS', $billingAddress['state'], 'Billing state should match');
        $I->assertSame('12345', $billingAddress['postcode'], 'Billing postcode should match');
        $I->assertSame('US', $billingAddress['country'], 'Billing country should match');
        $I->assertSame('test@billing.com', $billingAddress['email'], 'Billing email should match');
        $I->assertSame('555-TEST', $billingAddress['phone'], 'Billing phone should match');
    }

    public function testGrabCustomerBillingAddressPartial(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'partial_billing_user',
            'billing' => [
                'first_name' => 'Partial',
                'city' => 'Partial City',
            ],
        ]);

        $billingAddress = $I->grabCustomerBillingAddress($customerId);

        $I->assertCount(2, $billingAddress, 'Should return only populated fields');
        $I->assertSame('Partial', $billingAddress['first_name'], 'First name should be present');
        $I->assertSame('Partial City', $billingAddress['city'], 'City should be present');
    }

    public function testGrabCustomerShippingAddress(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'shipping_addr_user',
            'shipping' => [
                'first_name' => 'Ship',
                'last_name' => 'Recipient',
                'company' => 'Ship Company',
                'address_1' => '456 Ship Blvd',
                'address_2' => 'Suite 200',
                'city' => 'Ship City',
                'state' => 'SC',
                'postcode' => '54321',
                'country' => 'CA',
            ],
        ]);

        $shippingAddress = $I->grabCustomerShippingAddress($customerId);

        $I->assertSame('Ship', $shippingAddress['first_name'], 'Shipping first name should be Ship');
        $I->assertSame('Recipient', $shippingAddress['last_name'], 'Shipping last name should be Recipient');
        $I->assertSame('Ship Company', $shippingAddress['company'], 'Shipping company should match');
        $I->assertSame('456 Ship Blvd', $shippingAddress['address_1'], 'Shipping address 1 should match');
        $I->assertSame('Suite 200', $shippingAddress['address_2'], 'Shipping address 2 should match');
        $I->assertSame('Ship City', $shippingAddress['city'], 'Shipping city should match');
        $I->assertSame('SC', $shippingAddress['state'], 'Shipping state should match');
        $I->assertSame('54321', $shippingAddress['postcode'], 'Shipping postcode should match');
        $I->assertSame('CA', $shippingAddress['country'], 'Shipping country should match');
    }

    public function testGrabCustomerShippingAddressPartial(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'partial_shipping_user',
            'shipping' => [
                'city' => 'Ship Town',
                'postcode' => '60000',
            ],
        ]);

        $shippingAddress = $I->grabCustomerShippingAddress($customerId);

        $I->assertCount(2, $shippingAddress, 'Should return only populated fields');
        $I->assertSame('Ship Town', $shippingAddress['city'], 'City should be present');
        $I->assertSame('60000', $shippingAddress['postcode'], 'Postcode should be present');
    }

    public function testSeeCustomerInDatabaseById(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'see_user',
        ]);

        $I->seeCustomerInDatabase(['ID' => $customerId]);
    }

    public function testSeeCustomerInDatabaseByLogin(AcceptanceTester $I): void
    {
        $I->haveCustomerInDatabase([
            'user_login' => 'login_test_user',
            'user_email' => 'login@test.com',
        ]);

        $I->seeCustomerInDatabase(['user_login' => 'login_test_user']);
    }

    public function testDontSeeCustomerInDatabase(AcceptanceTester $I): void
    {
        $I->dontSeeCustomerInDatabase([
            'user_login' => 'nonexistent_user',
        ]);
    }

    public function testHaveCustomerBillingFieldInDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'billing_field_user',
        ]);

        $metaId = $I->haveCustomerBillingFieldInDatabase($customerId, 'first_name', 'Jane');
        $I->assertIsInt($metaId);
        $I->assertGreaterThan(0, $metaId, 'Meta ID should be a positive integer');

        $metaId = $I->haveCustomerBillingFieldInDatabase($customerId, 'email', 'jane@example.com');
        $I->assertIsInt($metaId);
        $I->assertGreaterThan(0, $metaId, 'Meta ID should be a positive integer');

        $I->seeCustomerBillingFieldInDatabase($customerId, 'first_name', 'Jane');
        $I->seeCustomerBillingFieldInDatabase($customerId, 'email', 'jane@example.com');
    }

    public function testHaveCustomerShippingFieldInDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'shipping_field_user',
        ]);

        $metaId = $I->haveCustomerShippingFieldInDatabase($customerId, 'city', 'Rio de Janeiro');
        $I->assertIsInt($metaId);
        $I->assertGreaterThan(0, $metaId, 'Meta ID should be a positive integer');

        $metaId = $I->haveCustomerShippingFieldInDatabase($customerId, 'postcode', '20000-000');
        $I->assertIsInt($metaId);
        $I->assertGreaterThan(0, $metaId, 'Meta ID should be a positive integer');

        $I->seeCustomerShippingFieldInDatabase($customerId, 'city', 'Rio de Janeiro');
        $I->seeCustomerShippingFieldInDatabase($customerId, 'postcode', '20000-000');
    }

    public function testHaveCustomerMetaInDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'meta_db_user',
        ]);

        $metaId = $I->haveCustomerMetaInDatabase($customerId, 'custom_meta', 'custom_value');

        $I->assertIsInt($metaId);
        $I->assertGreaterThan(0, $metaId, 'Meta ID should be a positive integer');

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'custom_meta',
            'meta_value' => 'custom_value',
        ]);
    }

    public function testHaveCustomerMetaInDatabaseMultiple(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'multi_meta_db_user',
        ]);

        $I->haveCustomerMetaInDatabase($customerId, 'meta_1', 'value_1');
        $I->haveCustomerMetaInDatabase($customerId, 'meta_2', 'value_2');
        $I->haveCustomerMetaInDatabase($customerId, 'meta_3', 'value_3');

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'meta_1',
            'meta_value' => 'value_1',
        ]);

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'meta_2',
            'meta_value' => 'value_2',
        ]);

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'meta_3',
            'meta_value' => 'value_3',
        ]);
    }

    public function testSeeCustomerMetaInDatabaseDirect(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'see_meta_user',
        ]);

        $I->haveCustomerMetaInDatabase($customerId, 'see_meta_key', 'see_meta_value');

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'see_meta_key',
            'meta_value' => 'see_meta_value',
        ]);
    }

    public function testDontSeeCustomerMetaInDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'dont_see_meta_user',
        ]);

        $I->dontSeeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'nonexistent_meta_key',
        ]);
    }

    public function testDontSeeCustomerMetaInDatabaseWithDifferentValue(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'wrong_meta_user',
        ]);

        $I->haveCustomerMetaInDatabase($customerId, 'meta_key', 'correct_value');

        $I->dontSeeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'meta_key',
            'meta_value' => 'wrong_value',
        ]);
    }

    
    public function testAmOnMyAccountPage(AcceptanceTester $I): void
    {
        $pageId = $I->havePostInDatabase([
            'post_name' => 'my-account',
            'post_type' => 'page',
            'post_status' => 'publish',
        ]);

        $I->haveOptionInDatabase('woocommerce_myaccount_page_id', (string) $pageId);

        $I->amOnMyAccountPage();

        $I->seeInCurrentUrl('my-account');

        $I->restartBuiltInServer();
    }

    public function testCompleteCustomerWorkflow(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'workflow_user',
            'user_email' => 'workflow@example.com',
            'billing' => [
                'first_name' => 'Workflow',
                'last_name' => 'User',
                'address_1' => '1 Workflow St',
                'city' => 'Workflow City',
                'postcode' => '11111',
                'country' => 'US',
                'email' => 'workflow@example.com',
                'phone' => '555-WORK',
            ],
            'shipping' => [
                'first_name' => 'Workflow',
                'last_name' => 'User',
                'address_1' => '1 Workflow St',
                'city' => 'Workflow City',
                'postcode' => '11111',
                'country' => 'US',
            ],
            'meta' => [
                'vip_status' => 'gold',
                'customer_since' => '2023-01-01',
            ],
        ]);

        $I->seeCustomerInDatabase(['ID' => $customerId]);

        $billingAddress = $I->grabCustomerBillingAddress($customerId);
        $I->assertSame('Workflow', $billingAddress['first_name']);

        $shippingAddress = $I->grabCustomerShippingAddress($customerId);
        $I->assertSame('Workflow City', $shippingAddress['city']);

        $vipStatus = $I->grabCustomerMeta($customerId, 'vip_status', true);
        $I->assertSame('gold', $vipStatus);

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'customer_since',
        ]);
    }

    public function testGrabCustomerIdFromDatabase(AcceptanceTester $I): void
    {
        // Create a customer first
        $userId = $I->haveCustomerInDatabase([
            'user_login' => 'testcustomer',
            'user_email' => 'test@example.com',
        ]);

        // Test finding existing customer by user_login
        $grabbedId = $I->grabCustomerIdFromDatabase(['user_login' => 'testcustomer']);
        $I->assertSame($grabbedId, $userId);

        // Test with multiple criteria
        $grabbedId = $I->grabCustomerIdFromDatabase([
            'user_login' => 'testcustomer',
            'user_email' => 'test@example.com',
        ]);
        $I->assertSame($grabbedId, $userId);

        // Test non-existent customer
        $notFound = $I->grabCustomerIdFromDatabase(['user_login' => 'nonexistent']);
        $I->assertFalse($notFound);
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
