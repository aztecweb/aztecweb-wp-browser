<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class CheckoutCest
{
    // ==================== Phase 1 Tests: Navigation & Form Filling ====================

    public function testAmOnCheckoutPage(AcceptanceTester $I): void
    {
        $I->amOnCheckoutPage();

        $cartSlug = '/' . $I->grabPostFieldFromDatabase(
            (int) $I->grabOptionFromDatabase('woocommerce_cart_page_id'),
            'post_name'
        );
        $I->seeInCurrentUrl($cartSlug);
    }

    public function testFillCheckoutField(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->fillCheckoutField('billing_first_name', 'John');
        $I->seeCheckoutFieldValue('billing_first_name', 'John');

        $I->fillCheckoutField('billing_email', 'john@example.com');
        $I->seeCheckoutFieldValue('billing_email', 'john@example.com');
    }

    public function testFillCheckoutForm(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $checkoutData = [
            'billing_first_name' => 'Jane',
            'billing_last_name' => 'Doe',
            'billing_email' => 'jane@example.com',
            'billing_phone' => '1234567890',
            'billing_address_1' => '123 Main St',
            'billing_city' => 'New York',
            'billing_postcode' => '10001',
        ];

        $I->fillCheckoutForm($checkoutData);

        foreach ($checkoutData as $field => $expectedValue) {
            $I->seeCheckoutFieldValue($field, $expectedValue);
        }
    }

    public function testFillCheckoutFormWithShipping(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $checkoutData = [
            'billing_first_name' => 'Bob',
            'billing_last_name' => 'Builder',
            'billing_email' => 'bob@example.com',
            'billing_address_1' => '456 Oak Ave',
        ];

        $I->fillCheckoutForm($checkoutData);

        $I->seeCheckoutFieldValue('billing_first_name', 'Bob');
        $I->seeCheckoutFieldValue('billing_email', 'bob@example.com');
        $I->seeCheckoutFieldValue('billing_last_name', 'Builder');
        $I->seeCheckoutFieldValue('billing_address_1', '456 Oak Ave');
    }

    // ==================== Phase 2 Tests: Payment Methods ====================

    public function testSelectPaymentMethod(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->selectPaymentMethod('cod');

        $I->seePaymentMethodSelected('cod');
    }

    public function testSeePaymentMethodAvailable(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->seePaymentMethodAvailable('cod');
    }

    public function testDontSeePaymentMethodAvailable(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->dontSeePaymentMethodAvailable('nonexistent_payment_method');
    }

    public function testSeePaymentMethodSelected(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->selectPaymentMethod('cod');

        $I->seePaymentMethodSelected('cod');
    }

    // ==================== Phase 2 Tests: Coupons ====================

    public function testApplyCouponOnCheckout(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $couponId = $I->havePostInDatabase([
            'post_title' => 'test-coupon',
            'post_type' => 'shop_coupon',
            'post_status' => 'publish',
        ]);

        $I->havePostMetaInDatabase($couponId, 'discount_type', 'fixed_cart');
        $I->havePostMetaInDatabase($couponId, 'coupon_amount', '10');
        $I->havePostMetaInDatabase($couponId, 'individual_use', 'no');
        $I->havePostMetaInDatabase($couponId, 'usage_limit', '');
        $I->havePostMetaInDatabase($couponId, 'date_expires', '');

        $I->amOnCheckoutPage();

        $I->applyCouponOnCheckout('test-coupon');

        $I->seeCouponApplied('test-coupon');
    }

    public function testSeeCouponApplied(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $couponId = $I->havePostInDatabase([
            'post_title' => 'applied-coupon',
            'post_type' => 'shop_coupon',
            'post_status' => 'publish',
        ]);

        $I->havePostMetaInDatabase($couponId, 'discount_type', 'fixed_cart');
        $I->havePostMetaInDatabase($couponId, 'coupon_amount', '5');
        $I->havePostMetaInDatabase($couponId, 'individual_use', 'no');
        $I->havePostMetaInDatabase($couponId, 'usage_limit', '');
        $I->havePostMetaInDatabase($couponId, 'date_expires', '');

        $I->amOnCheckoutPage();

        $I->applyCouponOnCheckout('applied-coupon');

        $I->seeCouponApplied('applied-coupon');
    }

    public function testDontSeeCouponApplied(AcceptanceTester $I): void
    {
        $I->amOnCheckoutPage();

        $I->dontSeeCouponApplied('nonexistent-coupon');
    }

    public function testSeeCouponErrorWithMessage(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->applyCouponOnCheckout('invalid-coupon');

        $I->seeCouponError();
    }

    public function testSeeCouponErrorSpecificMessage(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->applyCouponOnCheckout('invalid-coupon');

        $I->seeCouponError('Coupon');
    }

    // ==================== Phase 3 Tests: Errors ====================

    public function testSeeCheckoutErrorAny(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->fillCheckoutField('billing_first_name', 'John');

        $I->placeOrder();

        $I->seeCheckoutError();
    }

    public function testSeeCheckoutErrorSpecificMessage(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->placeOrder();

        $I->seeCheckoutError('Billing');
    }

    public function testDontSeeCheckoutErrorAny(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $checkoutData = [
            'billing_first_name' => 'Valid',
            'billing_last_name' => 'Name',
            'billing_email' => 'valid@example.com',
            'billing_phone' => '1234567890',
            'billing_address_1' => '123 Street',
            'billing_city' => 'City',
            'billing_postcode' => '12345',
        ];

        $I->fillCheckoutForm($checkoutData);

        $I->dontSeeCheckoutError();
    }

    public function testDontSeeCheckoutErrorSpecificMessage(AcceptanceTester $I): void
    {
        $I->amOnCheckoutPage();

        $I->dontSeeCheckoutError('Specific error message');
    }

    // ==================== Phase 3 Tests: Order Confirmation ====================

    public function testSeeOrderReceived(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->amOnPage("/?add-to-cart=$productId");
        $I->waitForElement('.woocommerce-message');

        $I->amOnCheckoutPage();

        $checkoutData = [
            'billing_first_name' => 'Order',
            'billing_last_name' => 'Test',
            'billing_email' => 'order@example.com',
            'billing_phone' => '11987654321',
            'billing_address_1' => '789 Test Road',
            'billing_city' => 'Sao Paulo',
            'billing_postcode' => '01310-100',
        ];

        $I->fillCheckoutForm($checkoutData);
        $I->selectPaymentMethod('cod');
        $I->placeOrder();

        $I->waitForElement('.woocommerce-order, .wp-block-woocommerce-order-confirmation-status', 30);
        $I->seeOrderReceived();
    }

    public function testGrabOrderIdFromOrderReceived(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Order ID Test Product',
            'meta' => [
                '_price' => '15.00',
                '_regular_price' => '15.00',
            ],
        ]);

        $I->amOnPage("/?add-to-cart=$productId");
        $I->waitForElement('.woocommerce-message');

        $I->amOnCheckoutPage();

        $checkoutData = [
            'billing_first_name' => 'Grab',
            'billing_last_name' => 'Order',
            'billing_email' => 'grab@example.com',
            'billing_phone' => '11955555555',
            'billing_address_1' => '999 Grab Ave',
            'billing_city' => 'Sao Paulo',
            'billing_postcode' => '01311-000',
        ];

        $I->fillCheckoutForm($checkoutData);
        $I->selectPaymentMethod('cod');
        $I->placeOrder();

        $I->waitForElement('.woocommerce-order, .wp-block-woocommerce-order-confirmation-status', 30);
        $orderId = $I->grabOrderIdFromOrderReceived();

        assert(is_int($orderId) && $orderId > 0, 'Order ID should be a positive integer');
    }

    // ==================== Phase 3 Tests: Field Verification ====================

    public function testSeeCheckoutFieldValue(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->fillCheckoutField('billing_first_name', 'TestValue');
        $I->seeCheckoutFieldValue('billing_first_name', 'TestValue');

        $I->fillCheckoutField('billing_email', 'test@example.com');
        $I->seeCheckoutFieldValue('billing_email', 'test@example.com');
    }

    public function testGrabCheckoutFieldValue(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->fillCheckoutField('billing_first_name', 'GrabbedValue');

        $value = $I->grabCheckoutFieldValue('billing_first_name');

        assert($value === 'GrabbedValue', 'Grabbed value should match');
    }

    public function testGrabCheckoutFieldValueEmpty(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $value = $I->grabCheckoutFieldValue('billing_first_name');

        assert($value === '', 'Empty field should return empty string');
    }

    public function testGrabCheckoutFieldValueMultipleFields(AcceptanceTester $I): void
    {
        $productId = $I->haveProductInDatabase([
            'post_title' => 'Test Product',
        ]);

        $I->addProductToCart($productId);

        $I->amOnCheckoutPage();

        $I->fillCheckoutField('billing_first_name', 'First');
        $I->fillCheckoutField('billing_last_name', 'Last');
        $I->fillCheckoutField('billing_email', 'multi@example.com');

        $firstName = $I->grabCheckoutFieldValue('billing_first_name');
        $lastName = $I->grabCheckoutFieldValue('billing_last_name');
        $email = $I->grabCheckoutFieldValue('billing_email');

        assert($firstName === 'First', 'First name should match');
        assert($lastName === 'Last', 'Last name should match');
        assert($email === 'multi@example.com', 'Email should match');
    }
}
