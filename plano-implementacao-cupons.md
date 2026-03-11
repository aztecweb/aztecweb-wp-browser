# PRD: Coupon Methods para AztecWPBrowser

## 1. Executive Summary

**Problem Statement**: Testes de aceitação do WooCommerce necessitam criar e validar cupons de desconto no banco de dados, mas atualmente não existem métodos helper específicos para isso no módulo AztecWPBrowser.

**Proposed Solution**: Implementar um trait `CouponMethods` seguindo os padrões de wp-browser e Codeception, fornecendo métodos para criar, recuperar e validar cupons de todos os tipos suportados pelo WooCommerce.

**Success Criteria**:
- Todos os tipos de cupom do WooCommerce podem ser criados via métodos helper
- Regras de uso completas (limites, restrições, datas) são suportadas
- Métodos seguem naming conventions de wp-browser/Codeception
- Código passa em testes com cobertura >= 90%
- `vendor/bin/codecept build` regera os actors sem erros

---

## 2. User Experience & Functionality

### User Personas
- **Desenvolvedor de testes WordPress**: Precisa criar fixtures de cupons rapidamente para testar fluxos de checkout
- **QA Engineer**: Precisa validar que cupons são aplicados corretamente em diferentes cenários

### User Stories

#### US1: Criar cupom básico
**As a** desenvolvedor de testes,
**I want to** criar um cupom com código, tipo e valor,
**so that** eu possa testar funcionalidades de desconto.

**Acceptance Criteria**:
- `$I->haveCouponInDatabase(['code' => 'SAVE10', 'discount_type' => 'percent', 'coupon_amount' => 10])` cria cupom
- Retorna o ID do cupom criado
- Define `post_type` como `shop_coupon`
- Define `post_title` com o código do cupom

#### US2: Criar cupom por tipo
**As a** desenvolvedor de testes,
**I want to** usar métodos de conveniência para tipos de cupom comuns,
**so that** eu não precise repetir configurações padrão.

**Acceptance Criteria**:
- `$I->havePercentageCouponInDatabase('SAVE10', 15)` cria cupom de 15%
- `$I->haveFixedCartCouponInDatabase('FIXED5', 5.00)` cria cupom de R$5 no carrinho
- `$I->haveFixedProductCouponInDatabase('PROD10', 10.00)` cria cupom de R$10 por produto
- `$I->haveFreeShippingCouponInDatabase('FREESHIP')` cria cupom de frete grátis

#### US3: Configurar regras de uso
**As a** desenvolvedor de testes,
**I want to** definir limites e restrições do cupom,
**so that** eu possa testar cenários de validação.

**Acceptance Criteria**:
- Suporta `usage_limit`, `usage_limit_per_user`, `limit_usage_to_x_items`
- Suporta `minimum_amount`, `maximum_amount`
- Suporta `product_ids`, `exclude_product_ids`, `product_categories`, `exclude_product_categories`
- Suporta `expiry_date`
- Suporta `free_shipping` (yes/no)
- Suporta `individual_use` (yes/no)

#### US4: Validar cupom no banco
**As a** desenvolvedor de testes,
**I want to** verificar que o cupom foi criado corretamente,
**so that** eu possa afirmar o estado esperado do banco de dados.

**Acceptance Criteria**:
- `$I->seeCouponInDatabase(['code' => 'SAVE10'])` verifica existência
- `$I->dontSeeCouponInDatabase(['code' => 'INVALID'])` verifica ausência
- `$I->seeCouponMetaInDatabase(['coupon_id' => 1, 'meta_key' => 'discount_type', 'meta_value' => 'percent'])` valida meta

#### US5: Recuperar dados do cupom
**As a** desenvolvedor de testes,
**I want to** buscar informações do cupom,
**so that** eu possa fazer assertions customizadas.

**Acceptance Criteria**:
- `$I->grabCouponIdByCode('SAVE10')` retorna ID ou null
- `$I->grabCouponMetaFromDatabase($couponId, 'discount_type')` retorna valor
- `$I->grabCouponStatus($couponId)` retorna status (publish, draft, etc.)

### Non-Goals
- **NÃO** incluir métodos de UI (WebDriver) para aplicar cupom no carrinho
- **NÃO** incluir testes de checkout com cupom (isso é responsabilidade dos Cests de consumo)
- **NÃO** incluir validação complexa de regras de negócio (o WooCommerce faz isso)

---

## 3. Technical Specifications

### Architecture Overview

```
src/Method/
└── CouponMethods.php          # Novo trait com métodos de cupom

src/AztecWPBrowser.php         # Atualizar para use CouponMethods
```

**Data Flow**:
1. Test chama método (ex: `$I->havePercentageCouponInDatabase('SAVE10', 15)`)
2. `CouponMethods` delega para `WPDb` do wp-browser
3. WPDb cria registro em `wp_posts` (post_type=shop_coupon) e metadados em `wp_postmeta`

### Integration Points

| Integration | Details |
|-------------|---------|
| **WPDb** | Usa `havePostInDatabase()`, `havePostMetaInDatabase()`, `grabPostMetaFromDatabase()` |
| **WooCommerce** | Cupons são `shop_coupon` post type com metadados específicos |
| **Codeception** | Segue padrão `have*InDatabase()`, `grab*FromDatabase()`, `see*InDatabase()` |

### Database Schema

**wp_posts table** (cupom principal):
- `ID`: coupon ID
- `post_type`: 'shop_coupon'
- `post_title`: coupon code
- `post_status`: 'publish', 'draft', 'trash'
- `post_excerpt`: description

**wp_postmeta table** (metadados do cupom):
| Meta Key | Description | Values |
|----------|-------------|--------|
| `discount_type` | Type of discount | percent, fixed_cart, fixed_product |
| `coupon_amount` | Discount value | numeric (10, 5.50) |
| `free_shipping` | Free shipping? | yes, no |
| `minimum_amount` | Minimum order value | numeric |
| `maximum_amount` | Maximum order value | numeric |
| `usage_limit` | Total usage limit | integer |
| `usage_limit_per_user` | Per user limit | integer |
| `limit_usage_to_x_items` | Items limit | integer |
| `product_ids` | Allowed products | comma-separated IDs |
| `exclude_product_ids` | Excluded products | comma-separated IDs |
| `product_categories` | Allowed categories | comma-separated IDs |
| `exclude_product_categories` | Excluded categories | comma-separated IDs |
| `expiry_date` | Expiration date | YYYY-MM-DD |
| `individual_use` | Individual use only? | yes, no |
| `usage_count` | Current usage count | integer |
| `date_expires` | Expiration timestamp | Unix timestamp |

### Security & Privacy
- N/A (apenas métodos de teste de banco de dados)
- Dados de teste isolados em ambiente de teste

---

## 4. Method Signatures

### Core Methods

```php
trait CouponMethods
{
    // Criação principal - aceita array completo de dados
    public function haveCouponInDatabase(array $data = []): int;

    // Busca ID pelo código do cupom
    public function grabCouponIdByCode(string $code): ?int;

    // Assertions de existência
    public function seeCouponInDatabase(array $criteria): void;
    public function dontSeeCouponInDatabase(array $criteria): void;

    // Métodos de meta
    public function haveCouponMetaInDatabase(int $couponId, string $metaKey, mixed $metaValue): int;
    public function grabCouponMetaFromDatabase(int $couponId, string $key, bool $single = false): mixed;
    public function seeCouponMetaInDatabase(array $criteria): void;
    public function dontSeeCouponMetaInDatabase(array $criteria): void;

    // Métodos de status
    public function grabCouponStatus(int $couponId): string;
    public function haveCouponStatus(int $couponId, string $status): void;
    public function seeCouponStatus(int $couponId, string $status): void;

    // Métodos de conveniência por tipo
    public function havePercentageCouponInDatabase(string $code, float $percentage, array $overrides = []): int;
    public function haveFixedCartCouponInDatabase(string $code, float $amount, array $overrides = []): int;
    public function haveFixedProductCouponInDatabase(string $code, float $amount, array $overrides = []): int;
    public function haveFreeShippingCouponInDatabase(string $code, array $overrides = []): int;
}
```

### Parameter Details

**`haveCouponInDatabase(array $data = []): int`**

```php
$data = [
    // Campos do post (opcionais) → wp_posts columns
    'code' => 'SAVE10',              // Usado como post_title e post_name (slug)
    'post_status' => 'publish',      // publish, draft, trash
    'post_excerpt' => 'Description',// Descrição do cupom

    // Metadados do cupom (opcionais) → wp_postmeta (SEM underscore prefix)
    'meta' => [
        'discount_type' => 'percent',      // percent, fixed_cart, fixed_product
        'coupon_amount' => '10.00',        // Valor do desconto
        'free_shipping' => 'no',
        'minimum_amount' => '0',
        'maximum_amount' => '',
        'usage_limit' => '',
        'usage_limit_per_user' => '',
        'limit_usage_to_x_items' => '',
        'product_ids' => '',                // IDs separados por vírgula
        'exclude_product_ids' => '',
        'product_categories' => '',         // Taxonomy IDs
        'exclude_product_categories' => '',
        'expiry_date' => '',                // YYYY-MM-DD
        'date_expires' => '',               // Timestamp Unix
        'individual_use' => 'no',
        'usage_count' => '0',
    ],
];
```

**Valores padrão:**
- `code`: 'TESTCOUPON'
- `post_status`: 'publish'
- `meta['discount_type']`: 'percent'
- `meta['coupon_amount']`: '10.00'
- Todos os outros meta: valores vazios (vazio = sem restrição)

**Nota**: Diferente de produtos (`_price`, `'_sku'`), cupons não usam underscore prefix nas meta keys.

---

## 5. Risks & Roadmap

### Phased Rollout

**Phase 1: MVP (v1.0)**
- `haveCouponInDatabase()` básico
- `havePercentageCouponInDatabase()`, `haveFixedCartCouponInDatabase()`
- `grabCouponIdByCode()`, `seeCouponInDatabase()`
- Métodos de meta básicos
- Testes unitários

**Phase 2: Complete Types (v1.1)**
- `haveFixedProductCouponInDatabase()`, `haveFreeShippingCouponInDatabase()`
- Métodos de status
- Testes adicionais de cenários

**Phase 3: Full Rule Support (v1.2)**
- Documentação completa de todos os metadados
- Testes de edge cases
- Exemplos na README

### Technical Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Mudanças no schema de cupom do WooCommerce | Alta | Usar WPDb como abstração; seguir metadados atuais do WC 8.x+ |
| Conflito de nomes com métodos existentes | Baixa | Prefixar com "Coupon" consistentemente |
| Falta ao executar `codecept build` | Média | Documentar como step obrigatório após mudanças |

### Dependencies
- WooCommerce 7.0+ (cupom como shop_coupon post type)
- lucatume/wp-browser (para WPDb)
- Codeception 5.x

---

## 6. Implementation Notes

### Code Style
- PHP 8.0+ com `declare(strict_types=1);`
- PSR-4 namespace: `Aztec\WPBrowser\Method`
- Sem docblocks (seguindo convenção do projeto)
- Seguir padrões de naming do wp-browser

### Testing Strategy
```php
// tests/acceptance/CouponCest.php

class CouponCest
{
    public function testHaveCouponInDatabase(AcceptanceTester $I): void
    {
        $couponId = $I->haveCouponInDatabase([
            'code' => 'SAVE10',
            'discount_type' => 'percent',
            'coupon_amount' => '10.00',
        ]);

        $I->seeCouponInDatabase(['code' => 'SAVE10']);
        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'discount_type',
            'meta_value' => 'percent',
        ]);
    }

    public function testPercentageCoupon(AcceptanceTester $I): void
    {
        $couponId = $I->havePercentageCouponInDatabase('PCT20', 20.0);

        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'discount_type',
            'meta_value' => 'percent',
        ]);
        $I->seeCouponMetaInDatabase([
            'post_id' => $couponId,
            'meta_key' => 'coupon_amount',
            'meta_value' => '20.00',
        ]);
    }
}
```

### Default Values Reference

```php
// Defaults em haveCouponInDatabase()
private const DEFAULTS = [
    'post_type' => 'shop_coupon',
    'post_status' => 'publish',
    'discount_type' => 'percent',
    'coupon_amount' => '10.00',
    'free_shipping' => 'no',
    'minimum_amount' => '0',
    'maximum_amount' => '',
    'usage_limit' => '',
    'usage_limit_per_user' => '',
    'limit_usage_to_x_items' => '',
    'product_ids' => '',
    'exclude_product_ids' => '',
    'product_categories' => '',
    'exclude_product_categories' => '',
    'expiry_date' => '',
    'date_expires' => '',
    'individual_use' => 'no',
    'usage_count' => '0',
];
```
