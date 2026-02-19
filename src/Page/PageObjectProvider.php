<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\Page;

class PageObjectProvider
{
    private array $pageInstances = [];
    private array $pageObjectsConfig;

    public function __construct(array $pageObjectsConfig)
    {
        $this->pageObjectsConfig = $pageObjectsConfig;
    }

    public function cartPage(): CartPageObject
    {
        if ( ! isset($this->pageInstances['cart'])) {
            $class                       = $this->pageObjectsConfig['cart'] ?? CartPageObject::class;
            $this->pageInstances['cart'] = new $class();
        }

        return $this->pageInstances['cart'];
    }
}
