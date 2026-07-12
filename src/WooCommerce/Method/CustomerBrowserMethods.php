<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\WooCommerce\Method;

use lucatume\WPBrowser\Module\WPWebDriver;

trait CustomerBrowserMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;

    abstract protected function myAccountPageSlug(): string;

    /**
     * Navigate to the WooCommerce My Account page.
     *
     * @example
     * ```php
     * $I->amOnMyAccountPage();
     * $I->seeElement('.woocommerce-account');
     * ```
     *
     * @return void
     */
    public function amOnMyAccountPage(): void
    {
        $this->wpWebDriver()->amOnPage($this->myAccountPageSlug());
    }
}
