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

    public function amOnCheckoutPage(): void
    {
        $this->wpWebDriver()->amOnPage($this->wooCommerceConfig()->checkoutPageSlug());
        $this->wpWebDriver()->waitForElement('.wc-block-checkout');
    }

    public function fillCheckoutField(string $field, string $value): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $page->getFieldSelector($field);

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

    /**
     * Fill the checkout form with the given data.
     *
     * @param array<string, mixed> $data Field names and values.
     */
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
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $containerSelector = $page->getPaymentMethodContainerSelector($methodId);

        $this->wpWebDriver()->click($labelSelector);
        $this->wpWebDriver()->waitForElementVisible($containerSelector);
    }

    public function seePaymentMethodAvailable(string $methodId): void
    {
        $labelSelector = sprintf('label[for="radio-control-wc-payment-method-options-%s"]', $methodId);
        $this->wpWebDriver()->waitForElement($labelSelector);
        $this->wpWebDriver()->seeElement($labelSelector);
    }

    public function dontSeePaymentMethodAvailable(string $methodId): void
    {
        $labelSelector = sprintf('label[for="radio-control-wc-payment-method-options-%s"]', $methodId);
        $this->wpWebDriver()->dontSeeElement($labelSelector);
    }

    public function seePaymentMethodSelected(string $methodId): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $page->getPaymentMethodSelector($methodId);
        $containerSelector = $page->getPaymentMethodContainerSelector($methodId);

        $this->wpWebDriver()->seeCheckboxIsChecked($selector);
        $this->wpWebDriver()->seeElement($containerSelector);
    }

    public function placeOrder(): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $this->selector($page::PLACE_ORDER_BUTTON_SELECTOR);

        $this->wpWebDriver()->waitForElement($selector);
        $this->wpWebDriver()->waitForElementClickable($selector);

        $this->wpWebDriver()->executeJS('document.querySelector(arguments[0]).click()', [$selector]);
    }

    public function applyCouponOnCheckout(string $couponCode): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();

        $this->wpWebDriver()->click($this->selector($page::COUPON_TOGGLE_SELECTOR));
        $this->wpWebDriver()->waitForElementVisible($this->selector($page::COUPON_INPUT_SELECTOR));
        $this->wpWebDriver()->fillField($this->selector($page::COUPON_INPUT_SELECTOR), $couponCode);
        $this->wpWebDriver()->click($this->selector($page::COUPON_APPLY_BUTTON_SELECTOR));
    }

    public function seeCouponApplied(string $couponCode): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $this->selector($page::COUPON_APPLIED_LIST_SELECTOR);
        $this->wpWebDriver()->waitForElement($selector);
        $this->wpWebDriver()->see($couponCode, $selector);
    }

    public function dontSeeCouponApplied(string $couponCode): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $this->selector($page::COUPON_APPLIED_LIST_SELECTOR);
        $this->wpWebDriver()->dontSee($couponCode, $selector);
    }

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

    public function seeOrderReceived(): void
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();

        $this->wpWebDriver()->waitForElement($this->selector($page::ORDER_RECEIVED_SELECTOR));
        $this->wpWebDriver()->seeInCurrentUrl($this->selector($page::ORDER_RECEIVED_URL_PATTERN));
        $this->wpWebDriver()->seeElement($this->selector($page::ORDER_RECEIVED_SELECTOR));
    }

    public function grabOrderIdFromOrderReceived(): int
    {
        /** @var CheckoutPageObject $page */
        $page = $this->pageObjectProvider()->checkoutPage();
        $selector = $this->selector($page::ORDER_ID_SELECTOR);
        $orderText = $this->wpWebDriver()->grabTextFrom($selector);
        $orderText = is_string($orderText) ? $orderText : '';

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
        $value = $this->wpWebDriver()->grabValueFrom($selector);
        return is_string($value) ? $value : '';
    }
}
