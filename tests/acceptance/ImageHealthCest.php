<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Tests\Acceptance;

use Aztec\WPBrowser\Tests\Support\AcceptanceTester;

class ImageHealthCest
{
    public function homepageRendersWithWooCommerceInstalled(AcceptanceTester $I): void
    {
        $I->amOnPage('/');
        $I->seeElement('body');
        $I->dontSee('Error establishing a database connection');
        $I->dontSee('There has been a critical error');
    }

    public function chromedriverRespondsToBasicBrowserInteraction(AcceptanceTester $I): void
    {
        $I->amOnPage('/');
        $title = $I->grabPageSource();

        assert($title !== '', 'Browser session must return a non-empty page source.');
    }

    public function hposRoundTripSucceedsOnSqlite(AcceptanceTester $I): void
    {
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'yes');

        $orderId = $I->haveOrderInDatabase([
            'status' => 'wc-pending',
            'total_amount' => '42.00',
        ]);

        assert(is_int($orderId) && $orderId > 0, 'HPOS order ID should be a positive integer.');

        $I->seeInDatabase('wp_wc_orders', [
            'id' => $orderId,
            'status' => 'wc-pending',
        ]);
    }

    public function legacyOrderRoundTripSucceedsOnSqlite(AcceptanceTester $I): void
    {
        $I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no');

        $orderId = $I->haveOrderInDatabase([
            'post_status' => 'wc-processing',
        ]);

        assert(is_int($orderId) && $orderId > 0, 'Legacy order ID should be a positive integer.');

        $I->seeOrderInDatabase([
            'ID' => $orderId,
            'post_status' => 'wc-processing',
        ]);
    }
}
