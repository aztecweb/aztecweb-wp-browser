<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Method;

use Aztec\WPBrowser\Config\WooCommerceConfig;
use Aztec\WPBrowser\Page\PageObjectProvider;
use lucatume\WPBrowser\Module\WPDb;
use lucatume\WPBrowser\Module\WPWebDriver;

trait CheckoutMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;
    abstract protected function wpDb(): WPDb;
    abstract protected function wooCommerceConfig(): WooCommerceConfig;
    abstract protected function pageObjectProvider(): PageObjectProvider;

    public function amOnCheckoutPage(): void
    {
        $this->wpWebDriver()->amOnPage($this->wooCommerceConfig()->checkoutPageSlug());
    }

    public function fillCheckoutField(string $field, string $value): void
    {
        $selector = $this->pageObjectProvider()->checkoutPage()->getFieldSelector($field);

        $isSelect = $this->wpWebDriver()->executeJS(
            'return document.querySelector(arguments[0]) instanceof HTMLSelectElement',
            [$selector]
        );

        if ($isSelect) {
            $this->wpWebDriver()->selectOption($selector, $value);
        } else {
            $this->wpWebDriver()->fillField($selector, $value);
        }
    }

    public function fillCheckoutForm(array $data): void
    {
        foreach ($data as $field => $value) {
            if (is_string($value)) {
                $this->fillCheckoutField($field, $value);
            }
        }
    }

    public function selectPaymentMethod(string $methodId): void
    {
        $labelSelector = sprintf('label[for="radio-control-wc-payment-method-options-%s"]', $methodId);
        $containerSelector = $this->pageObjectProvider()->checkoutPage()->getPaymentMethodContainerSelector($methodId);

        $this->wpWebDriver()->click($labelSelector);
        $this->wpWebDriver()->waitForElementVisible($containerSelector);
    }

    public function seePaymentMethodAvailable(string $methodId): void
    {
        $labelSelector = sprintf('label[for="radio-control-wc-payment-method-options-%s"]', $methodId);
        $this->wpWebDriver()->seeElement($labelSelector);
    }

    public function dontSeePaymentMethodAvailable(string $methodId): void
    {
        $labelSelector = sprintf('label[for="radio-control-wc-payment-method-options-%s"]', $methodId);
        $this->wpWebDriver()->dontSeeElement($labelSelector);
    }

    public function seePaymentMethodSelected(string $methodId): void
    {
        $selector = $this->pageObjectProvider()->checkoutPage()->getPaymentMethodSelector($methodId);
        $containerSelector = $this->pageObjectProvider()->checkoutPage()->getPaymentMethodContainerSelector($methodId);

        $this->wpWebDriver()->seeCheckboxIsChecked($selector);
        $this->wpWebDriver()->seeElement($containerSelector);
    }

    public function placeOrder(): void
    {
        $selector = $this->pageObjectProvider()->checkoutPage()::PLACE_ORDER_BUTTON_SELECTOR;
        $this->wpWebDriver()->click($selector);
    }

    public function applyCouponOnCheckout(string $couponCode): void
    {
        $page = $this->pageObjectProvider()->checkoutPage();

        $this->wpWebDriver()->click($page::COUPON_TOGGLE_SELECTOR);
        $this->wpWebDriver()->waitForElementVisible($page::COUPON_INPUT_SELECTOR);
        $this->wpWebDriver()->fillField($page::COUPON_INPUT_SELECTOR, $couponCode);
        $this->wpWebDriver()->click($page::COUPON_APPLY_BUTTON_SELECTOR);
    }

    public function seeCouponApplied(string $couponCode): void
    {
        $selector = $this->pageObjectProvider()->checkoutPage()::COUPON_APPLIED_LIST_SELECTOR;
        $this->wpWebDriver()->waitForElement($selector);
        $this->wpWebDriver()->see($couponCode, $selector);
    }

    public function dontSeeCouponApplied(string $couponCode): void
    {
        $selector = $this->pageObjectProvider()->checkoutPage()::COUPON_APPLIED_LIST_SELECTOR;
        $this->wpWebDriver()->dontSee($couponCode, $selector);
    }

    public function seeCouponError(?string $message = null): void
    {
        $page = $this->pageObjectProvider()->checkoutPage();
        $container = $page::COUPON_ERROR_SELECTOR;

        $this->wpWebDriver()->waitForElementVisible($container);

        if ($message === null) {
            $this->wpWebDriver()->seeElement($container);
        } else {
            $this->wpWebDriver()->see($message, $container);
        }
    }

    public function seeCheckoutError(?string $message = null): void
    {
        $container = $this->pageObjectProvider()->checkoutPage()::ERROR_CONTAINER_SELECTOR;

        $this->wpWebDriver()->waitForElementVisible($container);

        if ($message === null) {
            $this->wpWebDriver()->seeElement($container);
        } else {
            $checkoutForm = '.wc-block-checkout';
            $this->wpWebDriver()->see($message, $checkoutForm);
        }
    }

    public function dontSeeCheckoutError(?string $message = null): void
    {
        $container = $this->pageObjectProvider()->checkoutPage()::ERROR_CONTAINER_SELECTOR;

        if ($message === null) {
            $this->wpWebDriver()->dontSeeElement($container);
        } else {
            $checkoutForm = '.wc-block-checkout';
            $this->wpWebDriver()->dontSee($message, $checkoutForm);
        }
    }

    public function seeOrderReceived(): void
    {
        $page = $this->pageObjectProvider()->checkoutPage();

        $this->wpWebDriver()->waitForElement($page::ORDER_RECEIVED_SELECTOR);
        $this->wpWebDriver()->seeInCurrentUrl($page::ORDER_RECEIVED_URL_PATTERN);
        $this->wpWebDriver()->seeElement($page::ORDER_RECEIVED_SELECTOR);
    }

    public function grabOrderIdFromOrderReceived(): int
    {
        $selector = $this->pageObjectProvider()->checkoutPage()::ORDER_ID_SELECTOR;
        $orderText = $this->wpWebDriver()->grabTextFrom($selector);

        return (int) $orderText;
    }

    public function seeCheckoutFieldValue(string $field, string $value): void
    {
        $selector = $this->pageObjectProvider()->checkoutPage()->getFieldSelector($field);
        $this->wpWebDriver()->seeInField($selector, $value);
    }

    public function grabCheckoutFieldValue(string $field): string
    {
        $selector = $this->pageObjectProvider()->checkoutPage()->getFieldSelector($field);
        return $this->wpWebDriver()->grabValueFrom($selector);
    }
}
