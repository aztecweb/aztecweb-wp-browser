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

        assert(is_int($customerId) && $customerId > 0, 'Customer ID should be a positive integer');

        $I->seeUserInDatabase([
            'ID' => $customerId,
            'user_login' => 'john_doe',
            'user_email' => 'john.doe@example.com',
        ]);
    }

    public function testHaveCustomerInDatabaseWithDefaults(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase();

        assert(is_int($customerId) && $customerId > 0, 'Customer ID should be a positive integer');

        $I->seeUserInDatabase([
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

        $I->seeUserMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'custom_field_1',
            'meta_value' => 'value_1',
        ]);

        $I->seeUserMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'custom_field_2',
            'meta_value' => 'value_2',
        ]);

        $I->seeUserMetaInDatabase([
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
            assert($unserialized['customer'] === true, 'User should have customer role');
        } else {
            assert(isset($userCaps['customer']) && $userCaps['customer'] === true, 'User should have customer role');
        }
    }

    public function testGrabCustomerFieldFromDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'grab_field_user',
            'user_email' => 'grab@example.com',
        ]);

        $email = $I->grabCustomerFieldFromDatabase($customerId, 'user_email');

        assert($email === 'grab@example.com', "Email should be 'grab@example.com', got '$email'");
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

        assert($meta === 'custom_meta_value', "Meta value should be 'custom_meta_value'");
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

        assert($meta1 === 'value_1', "First meta should be 'value_1'");
        assert($meta2 === 'value_2', "Second meta should be 'value_2'");
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

        assert($billingAddress['first_name'] === 'Test', 'Billing first name should be Test');
        assert($billingAddress['last_name'] === 'User', 'Billing last name should be User');
        assert($billingAddress['company'] === 'Test Company', 'Billing company should match');
        assert($billingAddress['address_1'] === '123 Test St', 'Billing address 1 should match');
        assert($billingAddress['address_2'] === 'Apt 4B', 'Billing address 2 should match');
        assert($billingAddress['city'] === 'Test City', 'Billing city should match');
        assert($billingAddress['state'] === 'TS', 'Billing state should match');
        assert($billingAddress['postcode'] === '12345', 'Billing postcode should match');
        assert($billingAddress['country'] === 'US', 'Billing country should match');
        assert($billingAddress['email'] === 'test@billing.com', 'Billing email should match');
        assert($billingAddress['phone'] === '555-TEST', 'Billing phone should match');
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

        assert(count($billingAddress) === 2, 'Should return only populated fields');
        assert($billingAddress['first_name'] === 'Partial', 'First name should be present');
        assert($billingAddress['city'] === 'Partial City', 'City should be present');
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

        assert($shippingAddress['first_name'] === 'Ship', 'Shipping first name should be Ship');
        assert($shippingAddress['last_name'] === 'Recipient', 'Shipping last name should be Recipient');
        assert($shippingAddress['company'] === 'Ship Company', 'Shipping company should match');
        assert($shippingAddress['address_1'] === '456 Ship Blvd', 'Shipping address 1 should match');
        assert($shippingAddress['address_2'] === 'Suite 200', 'Shipping address 2 should match');
        assert($shippingAddress['city'] === 'Ship City', 'Shipping city should match');
        assert($shippingAddress['state'] === 'SC', 'Shipping state should match');
        assert($shippingAddress['postcode'] === '54321', 'Shipping postcode should match');
        assert($shippingAddress['country'] === 'CA', 'Shipping country should match');
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

        assert(count($shippingAddress) === 2, 'Should return only populated fields');
        assert($shippingAddress['city'] === 'Ship Town', 'City should be present');
        assert($shippingAddress['postcode'] === '60000', 'Postcode should be present');
    }

    public function testSeeCustomerInDatabase(AcceptanceTester $I): void
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
        assert(is_int($metaId) && $metaId > 0, 'Meta ID should be a positive integer');

        $metaId = $I->haveCustomerBillingFieldInDatabase($customerId, 'email', 'jane@example.com');
        assert(is_int($metaId) && $metaId > 0, 'Meta ID should be a positive integer');

        $I->seeCustomerBillingFieldInDatabase($customerId, 'first_name', 'Jane');
        $I->seeCustomerBillingFieldInDatabase($customerId, 'email', 'jane@example.com');
    }

    public function testHaveCustomerShippingFieldInDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'shipping_field_user',
        ]);

        $metaId = $I->haveCustomerShippingFieldInDatabase($customerId, 'city', 'Rio de Janeiro');
        assert(is_int($metaId) && $metaId > 0, 'Meta ID should be a positive integer');

        $metaId = $I->haveCustomerShippingFieldInDatabase($customerId, 'postcode', '20000-000');
        assert(is_int($metaId) && $metaId > 0, 'Meta ID should be a positive integer');

        $I->seeCustomerShippingFieldInDatabase($customerId, 'city', 'Rio de Janeiro');
        $I->seeCustomerShippingFieldInDatabase($customerId, 'postcode', '20000-000');
    }

    public function testHaveCustomerMetaInDatabase(AcceptanceTester $I): void
    {
        $customerId = $I->haveCustomerInDatabase([
            'user_login' => 'meta_db_user',
        ]);

        $metaId = $I->haveCustomerMetaInDatabase($customerId, 'custom_meta', 'custom_value');

        assert(is_int($metaId) && $metaId > 0, 'Meta ID should be a positive integer');

        $I->seeUserMetaInDatabase([
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

        $I->seeUserMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'meta_1',
            'meta_value' => 'value_1',
        ]);

        $I->seeUserMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'meta_2',
            'meta_value' => 'value_2',
        ]);

        $I->seeUserMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'meta_3',
            'meta_value' => 'value_3',
        ]);
    }

    public function testSeeCustomerMetaInDatabase(AcceptanceTester $I): void
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
        assert($billingAddress['first_name'] === 'Workflow');

        $shippingAddress = $I->grabCustomerShippingAddress($customerId);
        assert($shippingAddress['city'] === 'Workflow City');

        $vipStatus = $I->grabCustomerMeta($customerId, 'vip_status', true);
        assert($vipStatus === 'gold');

        $I->seeCustomerMetaInDatabase([
            'user_id' => $customerId,
            'meta_key' => 'customer_since',
        ]);
    }
}
