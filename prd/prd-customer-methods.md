# PRD: Customer Methods for AztecWPBrowser

## 1. Executive Summary

**Problem Statement**: A biblioteca AztecWPBrowser atualmente não possui métodos para criar e manipular customers em testes de aceitação WooCommerce, o que força os testadores a usar diretamente métodos do WPDb, resultando em código verboso e menos legível.

**Proposed Solution**: Implementar um trait `CustomerMethods` seguindo os padrões existentes (CartMethods, OrderMethods, CouponMethods) que forneça métodos de alto nível para criar customers, manipular metadados e navegar para páginas relacionadas.

**Success Criteria**:
1. Trait `CustomerMethods` implementado com métodos CRUD seguindo convenções WPDb
2. Extensão de `WooCommerceConfig` para obter slug da página My Account
3. Métodos de navegação `amOnLoginPage()` e `amOnMyAccountPage()` (mesma página)
4. Total conformidade com Codeception, wp-browser e WPDb

---

## 2. User Experience & Functionality

### User Personas

- **Desenvolvedor de Testes**: Profissional que escreve testes de aceitação para plugins/temas WooCommerce usando Codeception
- **QA Engineer**: Testador que precisa validar funcionalidades de customer em fluxos completos

### User Stories

#### US-1: Criar Customer no Banco de Dados
**As a test writer**, I want to create customers with billing/shipping addresses so that I can test customer-related functionality.

**Acceptance Criteria**:
- `haveCustomerInDatabase(array $data = []): int` - cria customer e retorna user_id
- Suporta estrutura de dados compatível com WordPress user + metadados WooCommerce
- Parâmetro `$data` aceita:
  - `user_login` (obrigatório)
  - `user_email` (opcional, padrão `${user_login}@example.com`)
  - `role` (opcional, padrão 'subscriber')
  - `billing` - array com campos de endereço de cobrança (serão prefixados com `billing_`)
  - `shipping` - array com campos de endereço de entrega (serão prefixados com `shipping_`)
  - `meta` - array com metadados customizados
- Retorna o ID do customer criado

#### US-2: Navegar para Páginas de Customer
**As a test writer**, I want to navigate to customer-related pages so that I can test customer account functionality.

**Acceptance Criteria**:
- `amOnLoginPage(): void` - navega para página de login/My Account
- `amOnMyAccountPage(): void` - navega para página Minha Conta (mesma página do login)
- Nota: No WooCommerce, Login e My Account usam a mesma página base (`woocommerce_myaccount_page_id`)

#### US-3: Ler Customer Data
**As a test writer**, I want to retrieve customer data from database so that I can assert customer information.

**Acceptance Criteria**:
- `grabCustomerFieldFromDatabase(int $customerId, string $field): mixed` - retorna campo da tabela wp_users (ex: user_email, user_login)
- `grabCustomerMeta(int $customerId, string $key, bool $single = false): mixed` - retorna metadado
- `grabCustomerBillingAddress(int $customerId): array` - retorna array com dados de cobrança
- `grabCustomerShippingAddress(int $customerId): array` - retorna array com dados de entrega

#### US-4: Verificar Customer Data
**As a test writer**, I want to verify customer data in database so that I can assert test conditions.

**Acceptance Criteria**:
- `seeCustomerInDatabase(array $criteria): void` - verifica customer existe
- `dontSeeCustomerInDatabase(array $criteria): void` - verifica customer NÃO existe
- `seeCustomerInDatabaseByEmail(string $email): void` - conveniência para busca por email

#### US-5: Manipular Customer Meta
**As a test writer**, I want to manipulate customer metadata so that I can test custom customer properties.

**Acceptance Criteria**:
- `haveCustomerMetaInDatabase(int $customerId, string $metaKey, mixed $metaValue): int` - cria metadado
- `seeCustomerMetaInDatabase(array $criteria): void` - verifica metadado existe
- `dontSeeCustomerMetaInDatabase(array $criteria): void` - verifica metadado NÃO existe

### Non-Goals

- Autenticação/autorização de usuários (delegar para métodos existentes do WPWebDriver)
- Gerenciamento de senhas (delegar para WPDb que usa `WP::passwordHash()`)
- Integração com plugins de terceiros de customer management

---

## 3. Technical Specifications

### Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    AztecWPBrowser                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐  │
│  │ CartMethods  │  │OrderMethods  │  │ CustomerMethods  │  │
│  │              │  │              │  │                  │  │
│  │ amOnCartPage │  │ haveOrderIn  │  │ haveCustomerIn   │  │
│  │ addProduct   │  │ amOnOrder    │  │ amOnLoginPage    │  │
│  └──────────────┘  └──────────────┘  └──────────────────┘  │
│         │                 │                 │              │
│         └─────────────────┼─────────────────┘              │
│                           │                                │
│  ┌────────────────────────▼──────────────────────────┐    │
│  │              Dependencies                          │    │
│  │  • WPDb (para operações de banco)                 │    │
│  │  • WPWebDriver (para navegação)                   │    │
│  │  • WooCommerceConfig (slug da página My Account)  │    │
│  └──────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

### Data Structure

**haveCustomerInDatabase($data) suporta:**

```php
[
    'user_login' => 'customer',                // obrigatório
    'user_email' => 'customer@example.com',   // opcional
    'role' => 'customer',                     // opcional (padrão 'subscriber')
    'billing' => [
        'first_name' => 'John',               // prefixado como billing_first_name
        'last_name' => 'Doe',
        'company' => 'Acme Inc',
        'address_1' => '123 Main St',
        'address_2' => 'Apt 4',
        'city' => 'New York',
        'state' => 'NY',
        'postcode' => '10001',
        'country' => 'US',
        'email' => 'john@example.com',
        'phone' => '555-1234',
    ],
    'shipping' => [/* mesma estrutura de billing */],
    'meta' => [
        '_some_custom_field' => 'value',
    ],
]
```

### Integration Points

| Component | Integration Method |
|-----------|-------------------|
| **WordPress Users** | `wpDb->haveUserInDatabase()` + `wpDb->haveUserMetaInDatabase()` |
| **WooCommerce Meta** | `wpDb->haveUserMetaInDatabase()` com prefixo `billing_` e `shipping_` |
| **Page Slugs** | `woocommerce_myaccount_page_id` via `wpDb->grabOptionFromDatabase()` |

### Security & Privacy

- Email deve ser único (validação via WPDb)
- Senhas são gerenciadas pelo método `haveUserInDatabase()` do WPDb
- Metadados são armazenados via `wpDb->haveUserMetaInDatabase()`

---

## 4. Implementation Plan

### Phase 1: WooCommerceConfig Extension

1. Adicionar `myAccountPageSlug(): string` em `WooCommerceConfig.php`

### Phase 2: CustomerMethods Trait

1. Criar `src/Method/CustomerMethods.php`
2. Implementar métodos de criação: `haveCustomerInDatabase()`
3. Implementar métodos de leitura: `grab*()` methods
4. Implementar métodos de verificação: `see*()`, `dontSee*()`
5. Implementar métodos de navegação: `amOnLoginPage()`, `amOnMyAccountPage()`
6. Adicionar `use CustomerMethods` em `AztecWPBrowser.php`

---

## 5. Risks & Roadmap

### Technical Risks

| Risk | Mitigation |
|------|------------|
| WooCommerce pages slugs podem variar por tema | Usar `WooCommerceConfig` com fallback padrão |
| Customer meta prefix pode mudar em futuras versões | Documentar e manter compatibilidade |

### Phased Rollout

**Phase 1 (v1.0)**: MVP - CustomerMethods básico
- `haveCustomerInDatabase()`
- `amOnLoginPage()`, `amOnMyAccountPage()` (mesma página)
- `grabCustomerFieldFromDatabase()`

**Phase 2 (v1.1)**: CRUD completo
- `see*()`, `dontSee*()` methods
- `grabCustomerMeta()`
- `haveCustomerMetaInDatabase()`

**Phase 3 (v2.0)**: Funcionalidades avançadas
- `amOnCustomerOrdersPage()`
- `amOnCustomerDownloadsPage()`
- `amOnCustomerAddressesPage()`

---

## Appendix: Reference Patterns

### Codeception Naming Convention

```php
// WPDb-style (data operations)
haveCustomerInDatabase($data)
grabCustomerFieldFromDatabase($customerId, $field)
seeCustomerInDatabase($criteria)
dontSeeCustomerInDatabase($criteria)

// WPWebDriver-style (navigation)
amOnLoginPage()
amOnMyAccountPage()
```

### Database Column Naming (WPDb Pattern)

```php
// ✅ Use nomes de coluna explícitos da tabela wp_users
$I->haveCustomerInDatabase([
    'user_login' => 'customer',
    'user_email' => 'customer@example.com',
    'billing' => [
        'first_name' => 'John',        // prefixado como billing_first_name meta
    ],
]);
```

**Nota**: `billing` e `shipping` são arrays que serão prefixados com `billing_` e `shipping_` ao criar usermeta.
