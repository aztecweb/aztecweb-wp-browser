# Plano de Análise: Conformidade com Padrões Codeception/wp-browser

## Contexto

Este plano analisa os métodos implementados em `src/Method/` e `src/OrderStorage/` comparando com os padrões estabelecidos pelo Codeception e lucatume/wp-browser, conforme documentado em `plans/analise-codeception-wp-browser.md`.

O objetivo é:
1. Verificar conformidade com padrões de nomes e estruturas
2. Identificar cenários não cobertos
3. Apontar inconsistências com WPDb/wp-browser conventions
4. Sugerir melhorias e adiciones necessárias

---

## Análise por Trait/Módulo

### 1. ProductMethods

#### Métodos Implementados

| Método | Tipo | Status |
|--------|------|--------|
| `haveProductInDatabase` | Create | ✅ Implementado |
| `haveProductCategoryInDatabase` | Create | ✅ Implementado |
| `haveProductCategoryRelationshipInDatabase` | Create | ✅ Implementado |
| `haveProductInCategoriesInDatabase` | Create | ✅ Implementado |
| `haveProductMetaInDatabase` | Create | ✅ Implementado |
| `grabProductMetaFromDatabase` | Read | ✅ Implementado |
| `grabProductCategoriesFromDatabase` | Read | ✅ Implementado |
| `seeProductInCategoryInDatabase` | Verify | ✅ Implementado |

#### Conformidade com Padrões

✅ **Nomes de métodos**: Segue padrão wp-browser (`have`, `grab`, `see`)
✅ **Colunas de banco**: Usa `post_type`, `post_status`, `post_title` corretamente
✅ **Meta**: Usa `_price`, `_stock_status`, etc. (com underscore prefix padrão WooCommerce)

#### Cenários Faltantes (Comparado com 3.2 WPDb)

| Categoria | Método Esperado | Status |
|-----------|-----------------|--------|
| **Retrieve** | `grabProductIdFromDatabase(criteria)` | ❌ Faltando |
| **Retrieve** | `grabProductFieldFromDatabase(id, field)` | ❌ Faltando |
| **Verify** | `seeProductInDatabase(criteria)` | ❌ Faltando |
| **Verify** | `seeProductMetaInDatabase(criteria)` | ❌ Faltando |
| **Retrieve** | `grabProductsTableName()` | ❌ Faltando |
| **Multiple** | `haveManyProductsInDatabase(count, overrides)` | ❌ Faltando |

---

### 2. OrderMethods

#### Métodos Implementados

| Método | Tipo | Status |
|--------|------|--------|
| `haveOrderInDatabase` | Create | ✅ Implementado |
| `haveOrderMetaInDatabase` | Create | ✅ Implementado |
| `haveOrderAddressInDatabase` | Create | ✅ Implementado |
| `haveOrderItemInDatabase` | Create | ✅ Implementado |
| `haveOrderItemMetaInDatabase` | Create | ✅ Implementado |
| `haveOrderStatus` | Update | ✅ Implementado |
| `grabOrderMeta` | Read | ✅ Implementado |
| `grabOrderStatus` | Read | ✅ Implementado |
| `seeOrderStatus` | Verify | ✅ Implementado |
| `amOnAdminOrderPage` | Navigate | ✅ Implementado |

#### Conformidade com Padrões

✅ **Nomes de métodos**: Segue padrão wp-browser
✅ **Abstração HPOS/Legacy**: Usa OrderStorageInterface corretamente
✅ **Colunas de banco**:
   - HPOS: `status`, `id` corretos
   - Legacy: `post_status`, `ID` corretos
✅ **Order items**: `order_item_name`, `order_item_type` corretos
✅ **Order itemmeta**: `order_item_id`, `meta_key`, `meta_value` corretos

#### Cenários Faltantes

| Categoria | Método Esperado | Status |
|-----------|-----------------|--------|
| **Retrieve** | `grabOrderIdFromDatabase(criteria)` | ❌ Faltando |
| **Retrieve** | `grabOrderItemFromDatabase(criteria)` | ❌ Faltando |
| **Verify** | `seeOrderInDatabase(criteria)` | ❌ Faltando |
| **Verify** | `seeOrderMetaInDatabase(criteria)` | ❌ Faltando |
| **Verify** | `seeOrderItemInDatabase(criteria)` | ❌ Faltando |
| **Verify** | `seeOrderItemMetaInDatabase(criteria)` | ❌ Faltando |
| **Verify** | `seeOrderAddressInDatabase(criteria)` | ❌ Faltando |
| **Retrieve** | `grabOrderItemsTableName()` | ❌ Faltando |
| **Multiple** | `haveManyOrdersInDatabase(count, overrides)` | ❌ Faltando |

---

### 3. CouponMethods

#### Métodos Implementados

| Método | Tipo | Status |
|--------|------|--------|
| `haveCouponInDatabase` | Create | ✅ Implementado |
| `havePercentageCouponInDatabase` | Create | ✅ Implementado (convenience) |
| `haveFixedCartCouponInDatabase` | Create | ✅ Implementado (convenience) |
| `haveFixedProductCouponInDatabase` | Create | ✅ Implementado (convenience) |
| `haveFreeShippingCouponInDatabase` | Create | ✅ Implementado (convenience) |
| `haveCouponMetaInDatabase` | Create | ✅ Implementado |
| `haveCouponStatus` | Update | ✅ Implementado |
| `grabCouponIdByCode` | Read | ✅ Implementado |
| `grabCouponMetaFromDatabase` | Read | ✅ Implementado |
| `grabCouponStatus` | Read | ✅ Implementado |
| `seeCouponInDatabase` | Verify | ✅ Implementado |
| `dontSeeCouponInDatabase` | Verify | ✅ Implementado |
| `seeCouponMetaInDatabase` | Verify | ✅ Implementado |
| `dontSeeCouponMetaInDatabase` | Verify | ✅ Implementado |
| `seeCouponStatus` | Verify | ✅ Implementado |

#### Conformidade com Padrões

✅ **Nomes de métodos**: Segue padrão wp-browser
✅ **Colunas de banco**: Usa `post_type = 'shop_coupon'`, `post_status`, `post_title` corretamente
✅ **Meta**: Usa `discount_type`, `coupon_amount`, `free_shipping`, etc. corretamente
✅ **Convenience methods**: `havePercentageCouponInDatabase`, etc. são padrões úteis

#### Cenários Faltantes

| Categoria | Método Esperado | Status |
|-----------|-----------------|--------|
| **Retrieve** | `grabCouponIdFromDatabase(criteria)` | ❌ Faltando (só por code existe) |
| **Multiple** | `haveManyCouponsInDatabase(count, overrides)` | ❌ Faltando |

---

### 4. CustomerMethods

#### Métodos Implementados

| Método | Tipo | Status |
|--------|------|--------|
| `haveCustomerInDatabase` | Create | ✅ Implementado |
| `haveCustomerMetaInDatabase` | Create | ✅ Implementado |
| `haveCustomerBillingFieldInDatabase` | Create | ✅ Implementado |
| `haveCustomerShippingFieldInDatabase` | Create | ✅ Implementado |
| `grabCustomerFieldFromDatabase` | Read | ✅ Implementado |
| `grabCustomerMeta` | Read | ✅ Implementado |
| `grabCustomerBillingAddress` | Read | ✅ Implementado |
| `grabCustomerShippingAddress` | Read | ✅ Implementado |
| `seeCustomerInDatabase` | Verify | ✅ Implementado |
| `dontSeeCustomerInDatabase` | Verify | ✅ Implementado |
| `seeCustomerMetaInDatabase` | Verify | ✅ Implementado |
| `dontSeeCustomerMetaInDatabase` | Verify | ✅ Implementado |
| `seeCustomerBillingFieldInDatabase` | Verify | ✅ Implementado |
| `seeCustomerShippingFieldInDatabase` | Verify | ✅ Implementado |
| `amOnMyAccountPage` | Navigate | ✅ Implementado |

#### Conformidade com Padrões

✅ **Nomes de métodos**: Segue padrão wp-browser
✅ **Colunas de banco**: Usa `user_login`, `user_email`, `role` corretamente
✅ **Meta**: Usa `billing_`, `shipping_` prefixo corretamente
✅ **Convenience methods**: Métodos para billing/shipping são bem projetados

#### Cenários Faltantes

| Categoria | Método Esperado | Status |
|-----------|-----------------|--------|
| **Retrieve** | `grabCustomerIdFromDatabase(userLogin)` | ❌ Faltando (pode usar WPDb direto) |
| **Multiple** | `haveManyCustomersInDatabase(count, overrides)` | ❌ Faltando |

---

### 5. CartMethods

#### Métodos Implementados

| Método | Tipo | Status |
|--------|------|--------|
| `amOnCartPage` | Navigate | ✅ Implementado |
| `addProductToCart` | Action | ✅ Implementado |
| `seeProductInCart` | Verify | ✅ Implementado |
| `dontSeeProductInCart` | Verify | ✅ Implementado |
| `seeCartItemQuantity` | Verify | ✅ Implementado |
| `seeCartTotalQuantity` | Verify | ✅ Implementado |
| `clearCart` | Action | ✅ Implementado |

#### Conformidade com Padrões

✅ **Navegação**: Usa `amOnPage` corretamente
✅ **Page Objects**: Usa PageObjectProvider para seletores
✅ **WooCommerce Config**: Usa `cartPageSlug()` dinamicamente

#### Cenários Faltantes

| Categoria | Método Esperado | Status |
|-----------|-----------------|--------|
| **DB Methods** | `haveCartItemInDatabase` | ❌ Faltando (session-based) |
| **DB Methods** | `grabCartItemFromDatabase` | ❌ Faltando (session-based) |

> **Nota**: Métodos de cart são baseados em session, não banco de dados, então métodos DB podem não ser necessários.

---

### 6. CheckoutMethods

#### Métodos Implementados

| Método | Tipo | Status |
|--------|------|--------|
| `amOnCheckoutPage` | Navigate | ✅ Implementado |
| `fillCheckoutField` | Action | ✅ Implementado |
| `fillCheckoutForm` | Action | ✅ Implementado |
| `selectPaymentMethod` | Action | ✅ Implementado |
| `seePaymentMethodAvailable` | Verify | ✅ Implementado |
| `dontSeePaymentMethodAvailable` | Verify | ✅ Implementado |
| `seePaymentMethodSelected` | Verify | ✅ Implementado |
| `placeOrder` | Action | ✅ Implementado |
| `applyCouponOnCheckout` | Action | ✅ Implementado |
| `seeCouponApplied` | Verify | ✅ Implementado |
| `dontSeeCouponApplied` | Verify | ✅ Implementado |
| `seeCouponError` | Verify | ✅ Implementado |
| `seeCheckoutError` | Verify | ✅ Implementado |
| `dontSeeCheckoutError` | Verify | ✅ Implementado |
| `seeOrderReceived` | Verify | ✅ Implementado |
| `grabOrderIdFromOrderReceived` | Read | ✅ Implementado |
| `seeCheckoutFieldValue` | Verify | ✅ Implementado |
| `grabCheckoutFieldValue` | Read | ✅ Implementado |

#### Conformidade com Padrões

✅ **Navegação**: Usa `amOnPage` corretamente
✅ **Page Objects**: Usa PageObjectProvider para seletores
✅ **WooCommerce Config**: Usa `checkoutPageSlug()` dinamicamente
✅ **Interactions**: Usa `fillField`, `selectOption`, `click` corretamente

---

## Problemas Identificados

### 1. Inconsistências de Nomenclatura

**Produto**:
- `grabProductCategoriesFromDatabase` → Nome correto, mas poderia ser `grabProductCategoryIdsFromDatabase` para ser mais claro

**Coupon**:
- `grabCouponIdByCode` → Deveria ser `grabCouponIdFromDatabase` para consistência com WPDb
---

## Resumo de Conformidade

| Trait | Create | Read | Verify | Update | Delete | Navigate | Score |
|-------|--------|------|--------|--------|--------|----------|-------|
| ProductMethods | ✅ | ⚠️ 50% | ⚠️ 25% | ❌ | ❌ | ❌ | **6/10** |
| OrderMethods | ✅ | ⚠️ 50% | ⚠️ 33% | ✅ | ❌ | ✅ | **7/10** |
| CouponMethods | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | **8/10** |
| CustomerMethods | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | **8/10** |
| CartMethods | ✅ | ❌ | ✅ | ❌ | ❌ | ✅ | **7/10** |
| CheckoutMethods | ❌ | ✅ | ✅ | ❌ | ❌ | ✅ | **7/10** |