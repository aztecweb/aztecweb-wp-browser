# PRD: WooCommerce Checkout Methods

## 1. Executive Summary

**Problema**: O módulo atual não oferece helpers para testar o fluxo de checkout do WooCommerce. Testes precisam interagir manualmente com formulários, métodos de pagamento, cupons e validações de checkout, resultando em código duplicado e difícil de manter.

**Solução**: Criar `CheckoutMethods.php` trait com métodos de alto nível para testar o checkout WooCommerce, incluindo navegação, preenchimento de formulários, seleção de pagamento, aplicação de cupons e verificação de erros/confirmação, seguindo os padrões wp-browser/Codeception.

**Critérios de Sucesso**:
- Testes podem completar um fluxo de checkout com chamadas de método expressivas
- Cupons podem ser aplicados e verificados programaticamente
- Erros de validação são facilmente verificáveis
- Métodos seguem convenções de nomenclatura do wp-browser (`amOn*`, `see*`, `dontSee*`, `grab*`, `fill*`)
- Page Objects permitem customização para diferentes temas
- 100% de cobertura dos métodos por testes de aceitação

---

## 2. User Experience & Functionality

### User Personas

- **Desenvolvedor de Testes**: Precisa testar o fluxo completo de compra de forma confiável e rápida
- **QA Engineer**: Precisa de métodos expressivos que espelhem ações reais do usuário no checkout

### User Stories

#### US1: Navegar para página de checkout
> Como desenvolvedor de testes, quero navegar para a página de checkout para iniciar o fluxo de compra.

**Acceptance Criteria**:
- Método `amOnCheckoutPage(): void`
- Usa `WooCommerceConfig` para obter o slug da página de checkout
- Aguarda a página carregar completamente

#### US2: Preencher formulário de checkout
> Como desenvolvedor de testes, quero preencher todos os campos do checkout de uma vez para simular uma compra completa.

**Acceptance Criteria**:
- Método `fillCheckoutForm(array $data): void`
- Suporta campos de billing (first_name, last_name, email, phone, address_1, address_2, city, state, postcode, country)
- Suporta campos de shipping (mesmos campos com prefixo `shipping_`)
- Preenche campos individualmente usando `fillCheckoutField()` internamente
- Aceita estrutura normalizada (ex: `billing_first_name`, `shipping_city`)

#### US3: Preencher campo individual do checkout
> Como desenvolvedor de testes, quero preencher um campo específico do checkout para testar validações individuais.

**Acceptance Criteria**:
- Método `fillCheckoutField(string $field, string $value): void`
- Campo segue padrão WooCommerce (ex: `billing_email`, `shipping_postcode`)
- Usa Page Object para obter seletor CSS do campo

#### US4: Selecionar método de pagamento
> Como desenvolvedor de testes, quero selecionar um método de pagamento para testar diferentes gateways.

**Acceptance Criteria**:
- Método `selectPaymentMethod(string $methodId): void`
- `$methodId` é o ID do gateway WooCommerce (ex: `cod`, `bacs`, `cheque`, `stripe`, `paypal`)
- Aguarda o método ser selecionado visualmente

#### US5: Verificar método de pagamento selecionado
> Como desenvolvedor de testes, quero verificar qual método de pagamento está selecionado.

**Acceptance Criteria**:
- Método `seePaymentMethodSelected(string $methodId): void`
- Verifica se o radio button do método está marcado
- Verifica se o container do método está visível

#### US6: Submeter pedido
> Como desenvolvedor de testes, quero submeter o pedido para completar o checkout.

**Acceptance Criteria**:
- Método `placeOrder(): void`
- Clica no botão de place order
- Aguarda o processamento ser concluído

#### US7: Verificar confirmação do pedido
> Como desenvolvedor de testes, quero verificar se o pedido foi concluído com sucesso.

**Acceptance Criteria**:
- Método `seeOrderReceived(): void`
- Verifica se está na página de "Order Received" / "Thank You"
- Verifica presença de mensagem de confirmação

#### US8: Capturar ID do pedido da página de confirmação
> Como desenvolvedor de testes, quero capturar o ID do pedido da página de agradecimento para verificações posteriores.

**Acceptance Criteria**:
- Método `grabOrderIdFromOrderReceived(): int`
- Extrai o ID do pedido da URL ou do conteúdo da página
- Retorna o ID como inteiro

#### US9: Verificar erro de checkout
> Como desenvolvedor de testes, quero verificar se uma mensagem de erro específica apareceu no checkout, ou se há qualquer erro.

**Acceptance Criteria**:
- Método `seeCheckoutError(?string $message = null): void`
- Se `$message` for informado, verifica presença da mensagem específica no container de erros
- Se `$message` for `null`, verifica se há **qualquer** erro visível no container
- Suporta mensagens parciais
- Verifica dentro do container `.woocommerce-NoticeGroup, .woocommerce-error`

#### US10: Verificar ausência de erro de checkout
> Como desenvolvedor de testes, quero verificar se não há erros no checkout, ou se uma mensagem específica não apareceu.

**Acceptance Criteria**:
- Método `dontSeeCheckoutError(?string $message = null): void`
- Se `$message` for informado, verifica ausência da mensagem específica no container de erros
- Se `$message` for `null`, verifica se **não há nenhum** erro visível no container
- Útil para garantir que validações passaram

#### US11: Aplicar cupom no checkout
> Como desenvolvedor de testes, quero aplicar um cupom no checkout para testar descontos.

**Acceptance Criteria**:
- Método `applyCouponOnCheckout(string $couponCode): void`
- Preenche o campo de cupom
- Clica no botão de aplicar
- Aguarda processamento

#### US12: Verificar cupom aplicado
> Como desenvolvedor de testes, quero verificar se um cupom foi aplicado com sucesso.

**Acceptance Criteria**:
- Método `seeCouponApplied(string $couponCode): void`
- Verifica presença do cupom na lista de descontos aplicados
- Verifica mensagem de sucesso do cupom

#### US13: Verificar cupom removido/não aplicado
> Como desenvolvedor de testes, quero verificar se um cupom não está aplicado.

**Acceptance Criteria**:
- Método `dontSeeCouponApplied(string $couponCode): void`
- Verifica ausência do cupom na lista de descontos

#### US14: Verificar erro de cupom
> Como desenvolvedor de testes, quero verificar se uma mensagem de erro de cupom apareceu, ou se há qualquer erro de cupom.

**Acceptance Criteria**:
- Método `seeCouponError(?string $message = null): void`
- Se `$message` for informado, verifica presença da mensagem de erro específica do cupom
- Se `$message` for `null`, verifica se há **qualquer** erro de cupom visível
- Suporta mensagens parciais
- Verifica dentro do container de erros do cupom (pode ser diferente do container de erros geral)

#### US15: Verificar campo do checkout
> Como desenvolvedor de testes, quero verificar o valor de um campo específico do checkout.

**Acceptance Criteria**:
- Método `seeCheckoutFieldValue(string $field, string $value): void`
- Verifica se o campo contém o valor esperado
- Útil para verificar preenchimento automático ou dados salvos

#### US16: Capturar valor de campo do checkout
> Como desenvolvedor de testes, quero capturar o valor atual de um campo do checkout.

**Acceptance Criteria**:
- Método `grabCheckoutFieldValue(string $field): string`
- Retorna o valor atual do campo
- Útil para verificações de preenchimento automático

#### US17: Verificar se método de pagamento está disponível
> Como desenvolvedor de testes, quero verificar se um método de pagamento está disponível no checkout.

**Acceptance Criteria**:
- Método `seePaymentMethodAvailable(string $methodId): void`
- Verifica se o método de pagamento está visível e selecionável

#### US18: Verificar se método de pagamento NÃO está disponível
> Como desenvolvedor de testes, quero verificar se um método de pagamento não está disponível.

**Acceptance Criteria**:
- Método `dontSeePaymentMethodAvailable(string $methodId): void`
- Verifica se o método de pagamento não está visível

### Non-Goals

- Testes de payment gateways externos (integração real com Stripe, PayPal, etc.)
- Checkout com produtos virtuais vs. físicos (diferenciação de shipping)
- Multi-step checkout (checkout em etapas separadas)
- Checkout como guest vs. logado (autenticação é responsabilidade de outro módulo)
- Order Pay page (página de pagamento de pedido existente)
- Subscriptions/recurring payments

---

## 3. Technical Specifications

### Architecture Overview

```
src/
├── Method/
│   └── CheckoutMethods.php     # NOVO - Trait com métodos de checkout
├── Page/
│   ├── CheckoutPageObject.php  # NOVO - Page Object para checkout
│   └── PageObjectProvider.php  # MODIFICAR - Adicionar checkoutPage()
└── AztecWPBrowser.php          # MODIFICAR - Adicionar: use CheckoutMethods;
```

### Integração com WPWebDriver

| Método | Ação | Observações |
|--------|------|-------------|
| `amOnCheckoutPage` | `amOnPage()` | Navegação |
| `fillCheckoutForm` | `fillField()` | Loop sobre campos |
| `fillCheckoutField` | `fillField()` | Campo individual |
| `selectPaymentMethod` | `click()` + `waitForElement()` | Seleção de gateway |
| `placeOrder` | `click()` + `waitForElement()` | Submissão |
| `seeOrderReceived` | `seeInCurrentUrl()` + `see()` | Verificação |
| `grabOrderIdFromOrderReceived` | `grabFromCurrentUrl()` ou `grabTextFrom()` | Extração |
| `seeCheckoutError` | `see()` | Assertion |
| `dontSeeCheckoutError` | `dontSee()` | Assertion negativo |
| `applyCouponOnCheckout` | `fillField()` + `click()` + `waitForElement()` | Aplicação |
| `seeCouponApplied` | `see()` | Assertion |
| `dontSeeCouponApplied` | `dontSee()` | Assertion negativo |
| `seeCouponError` | `see()` | Assertion |
| `seeCheckoutFieldValue` | `seeInField()` | Assertion |
| `grabCheckoutFieldValue` | `grabValueFrom()` | Captura |
| `seePaymentMethodAvailable` | `seeElement()` | Assertion |
| `dontSeePaymentMethodAvailable` | `dontSeeElement()` | Assertion negativo |
| `seePaymentMethodSelected` | `seeOptionIsSelected()` ou verificações customizadas | Assertion |

### CheckoutPageObject - Seletores

```php
class CheckoutPageObject
{
    // Formulário
    public const BILLING_FIRST_NAME_SELECTOR = '#billing_first_name';
    public const BILLING_LAST_NAME_SELECTOR = '#billing_last_name';
    public const BILLING_EMAIL_SELECTOR = '#billing_email';
    public const BILLING_PHONE_SELECTOR = '#billing_phone';
    public const BILLING_ADDRESS_1_SELECTOR = '#billing_address_1';
    public const BILLING_ADDRESS_2_SELECTOR = '#billing_address_2';
    public const BILLING_CITY_SELECTOR = '#billing_city';
    public const BILLING_STATE_SELECTOR = '#billing_state';
    public const BILLING_POSTCODE_SELECTOR = '#billing_postcode';
    public const BILLING_COUNTRY_SELECTOR = '#billing_country';

    // Shipping (mesma estrutura com prefixo shipping_)
    public const SHIPPING_FIRST_NAME_SELECTOR = '#shipping_first_name';
    // ... demais campos de shipping

    // Pagamento
    public const PAYMENT_METHODS_CONTAINER_SELECTOR = '.wc_payment_methods';
    public const PAYMENT_METHOD_RADIO_SELECTOR = 'input[name="payment_method"]';
    public const PLACE_ORDER_BUTTON_SELECTOR = '#place_order';

    // Cupom
    public const COUPON_TOGGLE_SELECTOR = '.showcoupon';
    public const COUPON_INPUT_SELECTOR = '#coupon_code';
    public const COUPON_APPLY_BUTTON_SELECTOR = 'button[name="apply_coupon"]';
    public const COUPON_APPLIED_LIST_SELECTOR = '.woocommerce-remove-coupon';

    // Mensagens
    public const ERROR_CONTAINER_SELECTOR = '.woocommerce-NoticeGroup, .woocommerce-error';
    public const SUCCESS_MESSAGE_SELECTOR = '.woocommerce-message';
    public const ORDER_RECEIVED_SELECTOR = '.woocommerce-order-received';

    // Página de confirmação
    public const ORDER_RECEIVED_URL_PATTERN = '/order-received/';
    public const ORDER_ID_SELECTOR = '.woocommerce-order-overview__order.order > strong';

    /**
     * Retorna seletor do campo baseado no nome.
     */
    public function getFieldSelector(string $field): string;

    /**
     * Retorna seletor do método de pagamento.
     */
    public function getPaymentMethodSelector(string $methodId): string;
}
```

### Mapeamento de Campos

| Nome do Campo | Seletor CSS | Observações |
|---------------|-------------|-------------|
| `billing_first_name` | `#billing_first_name` | Nome do cliente |
| `billing_last_name` | `#billing_last_name` | Sobrenome |
| `billing_email` | `#billing_email` | Email |
| `billing_phone` | `#billing_phone` | Telefone |
| `billing_address_1` | `#billing_address_1` | Endereço |
| `billing_address_2` | `#billing_address_2` | Complemento |
| `billing_city` | `#billing_city` | Cidade |
| `billing_state` | `#billing_state` | Estado (pode ser select) |
| `billing_postcode` | `#billing_postcode` | CEP |
| `billing_country` | `#billing_country` | País (select) |
| `shipping_*` | `#shipping_*` | Mesmos campos de shipping |

### Assinaturas dos Métodos

```php
trait CheckoutMethods
{
    abstract protected function wpWebDriver(): WPWebDriver;
    abstract protected function wooCommerceConfig(): WooCommerceConfig;
    abstract protected function pageObjectProvider(): PageObjectProvider;

    // ==================== NAVIGATION ====================

    /**
     * Navega para a página de checkout.
     */
    public function amOnCheckoutPage(): void;

    // ==================== FORM FILLING ====================

    /**
     * Preenche um campo específico do checkout.
     */
    public function fillCheckoutField(string $field, string $value): void;

    /**
     * Preenche múltiplos campos do checkout.
     */
    public function fillCheckoutForm(array $data): void;

    // ==================== PAYMENT ====================

    /**
     * Seleciona um método de pagamento.
     */
    public function selectPaymentMethod(string $methodId): void;

    /**
     * Verifica se um método de pagamento está disponível.
     */
    public function seePaymentMethodAvailable(string $methodId): void;

    /**
     * Verifica se um método de pagamento NÃO está disponível.
     */
    public function dontSeePaymentMethodAvailable(string $methodId): void;

    /**
     * Verifica se um método de pagamento está selecionado.
     */
    public function seePaymentMethodSelected(string $methodId): void;

    /**
     * Submete o pedido.
     */
    public function placeOrder(): void;

    // ==================== COUPONS ====================

    /**
     * Aplica um cupom no checkout.
     */
    public function applyCouponOnCheckout(string $couponCode): void;

    /**
     * Verifica se um cupom foi aplicado.
     */
    public function seeCouponApplied(string $couponCode): void;

    /**
     * Verifica se um cupom NÃO foi aplicado.
     */
    public function dontSeeCouponApplied(string $couponCode): void;

    /**
     * Verifica se há uma mensagem de erro de cupom.
     * Se $message for null, verifica se há qualquer erro de cupom.
     */
    public function seeCouponError(?string $message = null): void;

    // ==================== ERRORS ====================

    /**
     * Verifica se há uma mensagem de erro no checkout.
     * Se $message for null, verifica se há qualquer erro.
     */
    public function seeCheckoutError(?string $message = null): void;

    /**
     * Verifica se NÃO há uma mensagem de erro no checkout.
     * Se $message for null, verifica se não há nenhum erro.
     */
    public function dontSeeCheckoutError(?string $message = null): void;

    // ==================== ORDER CONFIRMATION ====================

    /**
     * Verifica se o pedido foi recebido com sucesso.
     */
    public function seeOrderReceived(): void;

    /**
     * Captura o ID do pedido da página de confirmação.
     */
    public function grabOrderIdFromOrderReceived(): int;

    // ==================== FIELD VERIFICATION ====================

    /**
     * Verifica o valor de um campo do checkout.
     */
    public function seeCheckoutFieldValue(string $field, string $value): void;

    /**
     * Captura o valor de um campo do checkout.
     */
    public function grabCheckoutFieldValue(string $field): string;
}
```

---

## 4. Implementation Notes

### Padrão de Nomenclatura

Seguir rigorosamente os padrões Codeception/wp-browser:

| Prefixo | Uso | Exemplos |
|---------|-----|----------|
| `amOn*` | Navegação | `amOnCheckoutPage()` |
| `fill*` | Preenchimento | `fillCheckoutForm()`, `fillCheckoutField()` |
| `select*` | Seleção | `selectPaymentMethod()` |
| `see*` | Assertion positivo | `seeCheckoutError()`, `seeCouponApplied()` |
| `dontSee*` | Assertion negativo | `dontSeeCheckoutError()`, `dontSeeCouponApplied()` |
| `grab*` | Captura de valor | `grabOrderIdFromOrderReceived()`, `grabCheckoutFieldValue()` |
| `apply*` | Ação de aplicação | `applyCouponOnCheckout()` |

### Campo vs Container de Erro

- `seeCheckoutError()`:
  - Com `$message`: verifica se a mensagem específica existe no container `.woocommerce-NoticeGroup, .woocommerce-error`
  - Sem `$message` (null): verifica se o container de erros está visível/presente
- `dontSeeCheckoutError()`:
  - Com `$message`: verifica se a mensagem específica NÃO existe no container
  - Sem `$message` (null): verifica se o container de erros NÃO está visível/presente
- `seeCouponError()`:
  - Com `$message`: verifica se a mensagem específica existe no container de erros de cupom
  - Sem `$message` (null): verifica se há qualquer erro de cupom visível

### Suporte a Temas Customizados

O `CheckoutPageObject` pode ser sobrescrito via configuração:

```yaml
# codeception.yml
modules:
    config:
        Aztec\WPBrowser\AztecWPBrowser:
            pageObjects:
                checkout: \MyTheme\CustomCheckoutPageObject
```

### Tratamento de Campos Select

Campos como `billing_country`, `billing_state` e `shipping_country`, `shipping_state` podem ser `<select>` ou `<input>`. O método `fillCheckoutField()` deve detectar o tipo e usar `selectOption()` ou `fillField()` conforme apropriado.

---

## 5. Risks & Roadmap

### Technical Risks

| Risco | Probabilidade | Mitigação |
|-------|--------------|-----------|
| Seletores variam entre temas WooCommerce | Alta | Page Objects configuráveis via config |
| Checkout blocks vs classic checkout | Média | Priorizar classic checkout; blocks pode ser fase futura |
| Campos condicionais (ex: shipping diferente de billing) | Média | Documentar comportamento esperado |
| AJAX no checkout pode causar race conditions | Média | Usar `waitForElement()` e `waitForJS()` adequadamente |

### Phased Rollout

**Fase 1 - MVP**:
- `CheckoutMethods.php` trait
- `CheckoutPageObject.php` com seletores básicos
- Métodos de navegação e preenchimento de formulário
- Métodos de submissão e confirmação
- Testes de aceitação básicos

**Fase 2 - Pagamento e Cupons**:
- Métodos de seleção de pagamento
- Métodos de cupom
- Testes para novos métodos

**Fase 3 - Assertions e Capturas**:
- Métodos de verificação de campo
- Métodos de captura de valor
- Assertions de disponibilidade de pagamento

**Fase 4 - Melhorias Futuras**:
- Suporte a Checkout Blocks (WooCommerce Blocks)
- Suporte a Order Pay page
- Suporte a multi-step checkout

---

## 6. Files to Create/Modify

### Fase 1 - MVP

| Arquivo | Ação | Descrição |
|---------|------|-----------|
| `src/Method/CheckoutMethods.php` | **CRIAR** | Nova trait com métodos de checkout |
| `src/Page/CheckoutPageObject.php` | **CRIAR** | Page Object para seletores do checkout |
| `src/Page/PageObjectProvider.php` | **MODIFICAR** | Adicionar método `checkoutPage()` |
| `src/AztecWPBrowser.php` | **MODIFICAR** | Adicionar `use CheckoutMethods;` |
| `tests/acceptance/CheckoutCest.php` | **CRIAR** | Testes de aceitação para os métodos |

### Fase 2 - Pagamento e Cupons

| Arquivo | Ação | Descrição |
|---------|------|-----------|
| `src/Method/CheckoutMethods.php` | **MODIFICAR** | Adicionar métodos de pagamento e cupom |
| `tests/acceptance/CheckoutCest.php` | **MODIFICAR** | Adicionar testes para novos métodos |

### Fase 3 - Assertions e Capturas

| Arquivo | Ação | Descrição |
|---------|------|-----------|
| `src/Method/CheckoutMethods.php` | **MODIFICAR** | Adicionar métodos de verificação/captura |
| `tests/acceptance/CheckoutCest.php` | **MODIFICAR** | Adicionar testes para novos métodos |

---

## 7. Comparison: User Request vs Proposed

| Método Solicitado | Método Proposto | Diferença |
|-------------------|-----------------|-----------|
| `fillCheckoutFullForm($data)` | `fillCheckoutForm(array $data)` | Nome mais conciso |
| `selectPaymentMethod($method)` | `selectPaymentMethod(string $methodId)` | Parâmetro tipado |
| `placeOrder()` | `placeOrder()` | Mantido |
| `seeCheckoutError($message)` | `seeCheckoutError(?string $message = null)` | Parâmetro opcional - verifica qualquer erro se null |
| `dontSeeCheckoutError($message)` | `dontSeeCheckoutError(?string $message = null)` | Parâmetro opcional - verifica ausência de qualquer erro se null |
| `seeOrderConfirmation()` | `seeOrderReceived()` | Nome mais alinhado com WooCommerce |
| `grabOrderIdFromThankYouPage()` | `grabOrderIdFromOrderReceived()` | Nome mais alinhado com WooCommerce |
| `haveCouponCodeApplied($code)` | `applyCouponOnCheckout(string $couponCode)` | `apply*` é mais semântico que `have*` |
| `seeCouponApplied($code)` | `seeCouponApplied(string $couponCode)` | Mantido |
| `dontSeeCouponApplied($code)` | `dontSeeCouponApplied(string $couponCode)` | Mantido |
| `seeCouponError($message)` | `seeCouponError(?string $message = null)` | Parâmetro opcional - verifica qualquer erro de cupom se null |
| - | `amOnCheckoutPage()` | **NOVO** - Navegação |
| - | `fillCheckoutField()` | **NOVO** - Preenchimento individual |
| - | `seePaymentMethodAvailable()` | **NOVO** - Verificar disponibilidade |
| - | `dontSeePaymentMethodAvailable()` | **NOVO** - Verificar indisponibilidade |
| - | `seePaymentMethodSelected()` | **NOVO** - Verificar seleção |
| - | `seeCheckoutFieldValue()` | **NOVO** - Verificar valor de campo |
| - | `grabCheckoutFieldValue()` | **NOVO** - Capturar valor de campo |
