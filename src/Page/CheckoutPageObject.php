<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Page;

class CheckoutPageObject
{
    // Billing fields (WooCommerce Block Checkout)
    public const BILLING_FIRST_NAME_SELECTOR = '#billing-first_name';
    public const BILLING_LAST_NAME_SELECTOR = '#billing-last_name';
    public const BILLING_EMAIL_SELECTOR = '#email';
    public const BILLING_PHONE_SELECTOR = '#billing-phone';
    public const BILLING_ADDRESS_1_SELECTOR = '#billing-address_1';
    public const BILLING_ADDRESS_2_SELECTOR = '#billing-address_2';
    public const BILLING_CITY_SELECTOR = '#billing-city';
    public const BILLING_STATE_SELECTOR = '#billing-state';
    public const BILLING_POSTCODE_SELECTOR = '#billing-postcode';
    public const BILLING_COUNTRY_SELECTOR = '#billing-country';

    // Shipping fields (WooCommerce Block Checkout)
    public const SHIPPING_FIRST_NAME_SELECTOR = '#shipping-first_name';
    public const SHIPPING_LAST_NAME_SELECTOR = '#shipping-last_name';
    public const SHIPPING_ADDRESS_1_SELECTOR = '#shipping-address_1';
    public const SHIPPING_ADDRESS_2_SELECTOR = '#shipping-address_2';
    public const SHIPPING_CITY_SELECTOR = '#shipping-city';
    public const SHIPPING_STATE_SELECTOR = '#shipping-state';
    public const SHIPPING_POSTCODE_SELECTOR = '#shipping-postcode';
    public const SHIPPING_COUNTRY_SELECTOR = '#shipping-country';

    // Payment (WooCommerce Block Checkout)
    public const PAYMENT_METHODS_CONTAINER_SELECTOR = '.wc-block-components-checkout-step__container';
    public const PAYMENT_METHOD_RADIO_SELECTOR = 'input[name="payment-method"]';
    public const PLACE_ORDER_BUTTON_SELECTOR = 'button.wc-block-components-checkout-place-order-button';

    // Coupon (WooCommerce Block Checkout)
    public const COUPON_TOGGLE_SELECTOR = '.wc-block-components-totals-coupon .wc-block-components-panel__button';
    public const COUPON_INPUT_SELECTOR = '.wc-block-components-totals-coupon__input input';
    public const COUPON_APPLY_BUTTON_SELECTOR = '.wc-block-components-totals-coupon__button';
    public const COUPON_APPLIED_LIST_SELECTOR = '.wc-block-components-totals-discount__coupon-list-item';
    public const COUPON_ERROR_SELECTOR = '.wc-block-components-validation-error';

    // Messages (WooCommerce Block Checkout)
    public const ERROR_CONTAINER_SELECTOR = '.wc-block-components-validation-error, .wc-block-components-notice-banner';
    public const SUCCESS_MESSAGE_SELECTOR = '.wc-block-components-notice-banner.is-success, .woocommerce-message';
    public const ORDER_RECEIVED_SELECTOR = '.woocommerce-order, .wp-block-woocommerce-order-confirmation-status, .wc-block-order-confirmation';

    // Order confirmation page
    public const ORDER_RECEIVED_URL_PATTERN = '/order-received/';
    public const ORDER_ID_SELECTOR = '.woocommerce-order-overview__order strong, .wc-block-order-confirmation-summary-list-item__value';

    public function getFieldSelector(string $field): string
    {
        $fieldMap = [
            'billing_first_name' => '#billing-first_name',
            'billing_last_name' => '#billing-last_name',
            'billing_email' => '#email',
            'billing_phone' => '#billing-phone',
            'billing_address_1' => '#billing-address_1',
            'billing_address_2' => '#billing-address_2',
            'billing_city' => '#billing-city',
            'billing_state' => '#billing-state',
            'billing_postcode' => '#billing-postcode',
            'billing_country' => '#billing-country',
            'shipping_first_name' => '#shipping-first_name',
            'shipping_last_name' => '#shipping-last_name',
            'shipping_address_1' => '#shipping-address_1',
            'shipping_address_2' => '#shipping-address_2',
            'shipping_city' => '#shipping-city',
            'shipping_state' => '#shipping-state',
            'shipping_postcode' => '#shipping-postcode',
            'shipping_country' => '#shipping-country',
        ];

        return $fieldMap[$field] ?? "#$field";
    }

    public function getPaymentMethodSelector(string $methodId): string
    {
        return sprintf('input[name="radio-control-wc-payment-method-options"][value="%s"]', $methodId);
    }

    public function getPaymentMethodContainerSelector(string $methodId): string
    {
        return sprintf('#radio-control-wc-payment-method-options-%s__content', $methodId);
    }
}
