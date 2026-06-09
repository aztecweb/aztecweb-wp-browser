<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use Aztec\WPBrowser\WooCommerce\Config\WooCommerceConfig;
use Aztec\WPBrowser\WooCommerce\PageObject\CheckoutPageObject;
use Aztec\WPBrowser\WooCommerce\PageObject\PageObjectProvider;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

trait CheckoutMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;
    abstract protected function wpDb(): WPDb;
    abstract protected function wooCommerceConfig(): WooCommerceConfig;
    abstract protected function pageObjectProvider(): PageObjectProvider;
    abstract protected function selector(mixed $value): string;

    /**
     * Navigate to the WooCommerce checkout page and wait for the checkout form to load.
     *
     * @example
     * ```php
     * $productId = $I->haveProductInDatabase(['post_title' => 'Test Product']);
     * $I->addProductToCart($productId);
     * $I->amOnCheckoutPage();
     * $I->seeElement('.wc-block-checkout');
     * ```
     *
     * @return void
     */
    public function amOnCheckoutPage(): void
    {
        $this->wpWebDriver()->amOnPage($this->wooCommerceConfig()->checkoutPageSlug());
        $this->wpWebDriver()->waitForElement('.wc-block-checkout');
    }

    /**
     * Fill a single checkout field by name, supporting both text inputs and select elements.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->fillCheckoutField('billing_first_name', 'John');
     * $I->fillCheckoutField('billing_email', 'john@example.com');
     * ```
     *
     * @param string $field  Checkout field name (e.g., 'billing_first_name', 'billing_country')
     * @param string $value  Value to fill in the field
     *
     * @return void
     */
    public function fillCheckoutField(string $field, string $value): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $page->getFieldSelector($field);

        $isSelect = $this->wpWebDriver()->executeJS(
            'return document.querySelector(arguments[0]) instanceof HTMLSelectElement',
            [$selector],
        );

        if ($isSelect) {
            $this->wpWebDriver()->selectOption($selector, $value);
        } else {
            $this->wpWebDriver()->fillField($selector, $value);
        }
    }

    /**
     * Fill the checkout form with the given data.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $checkoutData = [
     *     'billing_first_name' => 'John',
     *     'billing_last_name' => 'Doe',
     *     'billing_email' => 'john@example.com',
     *     'billing_address_1' => '123 Main St',
     *     'billing_city' => 'New York',
     *     'billing_postcode' => '10001',
     * ];
     * $I->fillCheckoutForm($checkoutData);
     * ```
     *
     * @param array<string, mixed> $data Field names and string values to fill
     *
     * @return void
     */
    public function fillCheckoutForm(array $data): void
    {
        foreach ($data as $field => $value) {
            if (!is_string($value)) {
                continue;
            }

            $this->fillCheckoutField($field, $value);
        }
    }

    /**
     * Select a payment method on the checkout page by its method ID.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->selectPaymentMethod('cod');
     * $I->seePaymentMethodSelected('cod');
     * ```
     *
     * @param string $methodId  Payment method ID (e.g., 'cod', 'bacs')
     *
     * @return void
     */
    public function selectPaymentMethod(string $methodId): void
    {
        $labelSelector = sprintf('label[for="radio-control-wc-payment-method-options-%s"]', $methodId);
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $containerSelector = $page->getPaymentMethodContainerSelector($methodId);

        $this->wpWebDriver()->click($labelSelector);
        $this->wpWebDriver()->waitForElementVisible($containerSelector);
    }

    /**
     * Verify that a payment method is available on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->seePaymentMethodAvailable('cod');
     * ```
     *
     * @param string $methodId  Payment method ID to verify is available
     *
     * @return void
     */
    public function seePaymentMethodAvailable(string $methodId): void
    {
        $labelSelector = sprintf('label[for="radio-control-wc-payment-method-options-%s"]', $methodId);
        $this->wpWebDriver()->waitForElement($labelSelector);
        $this->wpWebDriver()->seeElement($labelSelector);
    }

    /**
     * Verify that a payment method is not available on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->dontSeePaymentMethodAvailable('nonexistent_payment');
     * ```
     *
     * @param string $methodId  Payment method ID to verify is not available
     *
     * @return void
     */
    public function dontSeePaymentMethodAvailable(string $methodId): void
    {
        $labelSelector = sprintf('label[for="radio-control-wc-payment-method-options-%s"]', $methodId);
        $this->wpWebDriver()->dontSeeElement($labelSelector);
    }

    /**
     * Verify that a payment method is currently selected on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->selectPaymentMethod('cod');
     * $I->seePaymentMethodSelected('cod');
     * ```
     *
     * @param string $methodId  Payment method ID to verify is selected
     *
     * @return void
     */
    public function seePaymentMethodSelected(string $methodId): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $page->getPaymentMethodSelector($methodId);
        $containerSelector = $page->getPaymentMethodContainerSelector($methodId);

        $this->wpWebDriver()->seeCheckboxIsChecked($selector);
        $this->wpWebDriver()->seeElement($containerSelector);
    }

    /**
     * Click the "Place Order" button on the checkout page to submit the order.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->fillCheckoutForm([
     *     'billing_first_name' => 'John',
     *     'billing_email' => 'john@example.com',
     * ]);
     * $I->selectPaymentMethod('cod');
     * $I->placeOrder();
     * ```
     *
     * @return void
     */
    public function placeOrder(): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $this->selector($page::PLACE_ORDER_BUTTON_SELECTOR);

        $this->wpWebDriver()->waitForElement($selector);
        $this->wpWebDriver()->waitForElementClickable($selector);

        $this->wpWebDriver()->executeJS('document.querySelector(arguments[0]).click()', [$selector]);
    }

    /**
     * Apply a coupon code on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->applyCouponOnCheckout('discount-10');
     * $I->seeCouponApplied('discount-10');
     * ```
     *
     * @param string $couponCode  Coupon code to apply
     *
     * @return void
     */
    public function applyCouponOnCheckout(string $couponCode): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();

        $this->wpWebDriver()->click($this->selector($page::COUPON_TOGGLE_SELECTOR));
        $this->wpWebDriver()->waitForElementVisible($this->selector($page::COUPON_INPUT_SELECTOR));
        $this->wpWebDriver()->fillField($this->selector($page::COUPON_INPUT_SELECTOR), $couponCode);
        $this->wpWebDriver()->click($this->selector($page::COUPON_APPLY_BUTTON_SELECTOR));
    }

    /**
     * Verify that a coupon code has been successfully applied on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->applyCouponOnCheckout('discount-10');
     * $I->seeCouponApplied('discount-10');
     * ```
     *
     * @param string $couponCode  Coupon code to verify was applied
     *
     * @return void
     */
    public function seeCouponApplied(string $couponCode): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $this->selector($page::COUPON_APPLIED_LIST_SELECTOR);
        $this->wpWebDriver()->waitForElement($selector);
        $this->wpWebDriver()->see($couponCode, $selector);
    }

    /**
     * Verify that a coupon code has not been applied on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->dontSeeCouponApplied('invalid-coupon');
     * ```
     *
     * @param string $couponCode  Coupon code to verify was not applied
     *
     * @return void
     */
    public function dontSeeCouponApplied(string $couponCode): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $this->selector($page::COUPON_APPLIED_LIST_SELECTOR);
        $this->wpWebDriver()->dontSee($couponCode, $selector);
    }

    /**
     * Verify that a coupon error message is displayed on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->applyCouponOnCheckout('invalid-coupon');
     * $I->seeCouponError();
     * $I->seeCouponError('Coupon');
     * ```
     *
     * @param string|null $message  Optional error message text to verify (if null, just checks error container is visible)
     *
     * @return void
     */
    public function seeCouponError(?string $message = null): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $container = $this->selector($page::COUPON_ERROR_SELECTOR);

        $this->wpWebDriver()->waitForElementVisible($container);

        if ($message === null) {
            $this->wpWebDriver()->seeElement($container);
        } else {
            $this->wpWebDriver()->see($message, $container);
        }
    }

    /**
     * Verify that a checkout error message is displayed on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->placeOrder();
     * $I->seeCheckoutError();
     * $I->seeCheckoutError('Billing');
     * ```
     *
     * @param string|null $message  Optional error message text to verify (if null, just checks error container is visible)
     *
     * @return void
     */
    public function seeCheckoutError(?string $message = null): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $container = $this->selector($page::ERROR_CONTAINER_SELECTOR);
        $checkoutForm = '.wc-block-checkout';

        if ($message === null) {
            $this->wpWebDriver()->waitForElement($container);
            $this->wpWebDriver()->seeElement($container);
        } else {
            $this->wpWebDriver()->see($message, $checkoutForm);
        }
    }

    /**
     * Verify that a checkout error message is not displayed on the checkout page.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $checkoutData = [
     *     'billing_first_name' => 'John',
     *     'billing_email' => 'john@example.com',
     * ];
     * $I->fillCheckoutForm($checkoutData);
     * $I->dontSeeCheckoutError();
     * ```
     *
     * @param string|null $message  Optional error message text to verify is not shown (if null, checks error container is not visible)
     *
     * @return void
     */
    public function dontSeeCheckoutError(?string $message = null): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $container = $this->selector($page::ERROR_CONTAINER_SELECTOR);

        if ($message === null) {
            $this->wpWebDriver()->dontSeeElement($container);
        } else {
            $checkoutForm = '.wc-block-checkout';
            $this->wpWebDriver()->dontSee($message, $checkoutForm);
        }
    }

    /**
     * Verify that the order confirmation page (order received) is displayed.
     *
     * @example
     * ```php
     * $I->placeOrder();
     * $I->waitForElement('.woocommerce-order, .wp-block-woocommerce-order-confirmation-status', 30);
     * $I->seeOrderReceived();
     * ```
     *
     * @return void
     */
    public function seeOrderReceived(): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();

        $this->wpWebDriver()->waitForElement($this->selector($page::ORDER_RECEIVED_SELECTOR));
        $this->wpWebDriver()->seeInCurrentUrl($this->selector($page::ORDER_RECEIVED_URL_PATTERN));
        $this->wpWebDriver()->seeElement($this->selector($page::ORDER_RECEIVED_SELECTOR));
    }

    /**
     * Extract the order ID from the order confirmation page.
     *
     * @example
     * ```php
     * $I->placeOrder();
     * $I->seeOrderReceived();
     * $orderId = $I->grabOrderIdFromOrderReceived();
     * $I->assertGreaterThan(0, $orderId);
     * ```
     *
     * @return int Order ID from the confirmation page
     */
    public function grabOrderIdFromOrderReceived(): int
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $this->selector($page::ORDER_ID_SELECTOR);
        $orderText = $this->wpWebDriver()->grabTextFrom($selector);
        $orderText = is_string($orderText) ? $orderText : '';

        return (int) $orderText;
    }

    /**
     * Verify that a checkout field contains the expected value.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->fillCheckoutField('billing_first_name', 'John');
     * $I->seeCheckoutFieldValue('billing_first_name', 'John');
     * ```
     *
     * @param string $field  Checkout field name to verify
     * @param string $value  Expected field value
     *
     * @return void
     */
    public function seeCheckoutFieldValue(string $field, string $value): void
    {
        $selector = $this->pageObjectProvider()->checkoutPage()->getFieldSelector($field);
        $this->wpWebDriver()->seeInField($selector, $value);
    }

    /**
     * Extract the current value from a checkout field.
     *
     * @example
     * ```php
     * $I->amOnCheckoutPage();
     * $I->fillCheckoutField('billing_first_name', 'Jane');
     * $value = $I->grabCheckoutFieldValue('billing_first_name');
     * $I->assertSame('Jane', $value);
     * ```
     *
     * @param string $field  Checkout field name to extract value from
     *
     * @return string Field value (empty string if field is empty)
     */
    public function grabCheckoutFieldValue(string $field): string
    {
        $selector = $this->pageObjectProvider()->checkoutPage()->getFieldSelector($field);
        $value = $this->wpWebDriver()->grabValueFrom($selector);
        return is_string($value) ? $value : '';
    }
}
