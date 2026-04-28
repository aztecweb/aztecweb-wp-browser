# Plano: Consolidar Testes de Aceitação

## Contexto

Atualmente existem arquivos de teste separados com `NewMethodsCest` no nome (ex: `CouponNewMethodsCest.php`) que contêm métodos de teste que deveriam estar nos arquivos de teste originais correspondentes. O objetivo é consolidar todos os testes em um único arquivo por entidade e remover os arquivos `NewMethodsCest`.

## Arquivos a serem consolidados

| NewMethodsCest | Arquivo Original | Métodos a mover |
|----------------|-----------------|-----------------|
| `CouponNewMethodsCest.php` | `CouponCest.php` | 3 métodos |
| `ProductNewMethodsCest.php` | `ProductCest.php` | 9 métodos |
| `CustomerNewMethodsCest.php` | `CustomerCest.php` | 3 métodos |
| `OrderNewMethodsCest.php` | `OrderCest.php` | 14 métodos |
| `OrderHPOSNewMethodsCest.php` | `OrderHPOSCest.php` | 13 métodos |

## Análise de conflitos e ações

### 1. CouponNewMethodsCest → CouponCest.php

**Métodos em CouponNewMethodsCest:**
- `testGrabCouponIdFromDatabase`
- `testSeeCouponInDatabase`
- `testSeeCouponMetaInDatabase`

**Conflito:** O método `testGrabCouponIdFromDatabase` em `CouponNewMethodsCest` faz exatamente o mesmo que `testGrabCouponIdByCode` em `CouponCest`. Ambos testam a mesma funcionalidade.

**Ação:**
1. Adicionar `testSeeCouponInDatabase` e `testSeeCouponMetaInDatabase` ao `CouponCest.php`
2. **Remover** o método `testGrabCouponIdByCode` do `CouponCest.php` (pois o `testGrabCouponIdFromDatabase` é mais completo - testa por código, status e não-existente)
3. Adicionar `testGrabCouponIdFromDatabase` ao `CouponCest.php`
4. Remover `CouponNewMethodsCest.php`

### 2. ProductNewMethodsCest → ProductCest.php

**Métodos em ProductNewMethodsCest:**
- `testGrabProductIdFromDatabase`
- `testGrabProductFieldFromDatabase`
- `testSeeProductInDatabase`
- `testSeeProductMetaInDatabase`
- `testGrabProductsTableName`
- `testHaveManyProductsInDatabase`
- `testGrabProductCategoryIdsFromDatabase`
- `testDontSeeProductInDatabase`
- `testDontSeeProductMetaInDatabase`

**Sem conflitos diretos** - todos os métodos são novos para o `ProductCest.php`.

**Ação:**
1. Adicionar todos os 9 métodos ao `ProductCest.php`
2. Remover `ProductNewMethodsCest.php`

### 3. CustomerNewMethodsCest → CustomerCest.php

**Métodos em CustomerNewMethodsCest:**
- `testGrabCustomerIdFromDatabase`
- `testSeeCustomerInDatabase`
- `testSeeCustomerMetaInDatabase`

**Conflitos parciais:**
- `testSeeCustomerInDatabase` já existe em `CustomerCest.php` mas com implementação diferente
- `testSeeCustomerMetaInDatabase` já existe em `CustomerCest.php` mas com implementação diferente

**Análise:**
- O `testSeeCustomerInDatabase` de `CustomerNewMethodsCest` é mais abrangente (testa múltiplos critérios)
- O `testSeeCustomerMetaInDatabase` de `CustomerNewMethodsCest` usa o novo método `seeCustomerMetaInDatabase` com array de critérios

**Ação:**
1. Renomear os métodos existentes em `CustomerCest.php` para evitar duplicação:
   - `testSeeCustomerInDatabase` → `testSeeCustomerInDatabaseById`
   - `testSeeCustomerMetaInDatabase` → `testSeeCustomerMetaInDatabaseDirect`
2. Adicionar `testGrabCustomerIdFromDatabase` ao `CustomerCest.php`
3. Adicionar `testSeeCustomerInDatabase` (do NewMethods) ao `CustomerCest.php`
4. Adicionar `testSeeCustomerMetaInDatabase` (do NewMethods) ao `CustomerCest.php`
5. Remover `CustomerNewMethodsCest.php`

### 4. OrderNewMethodsCest → OrderCest.php

**Métodos em OrderNewMethodsCest:**
- `testGrabOrderIdFromDatabase`
- `testGrabOrderItemFromDatabase`
- `testGrabOrderItemByType`
- `testSeeOrderInDatabase`
- `testSeeOrderMetaInDatabase`
- `testSeeOrderItemInDatabase`
- `testDontSeeOrderItemInDatabase`
- `testSeeOrderItemMetaInDatabase`
- `testDontSeeOrderItemMetaInDatabase`
- `testSeeOrderAddressInDatabase`
- `testSeeShippingOrderAddressInDatabase`
- `testGrabOrderItemsTableName`
- `testHaveManyOrdersInDatabase`
- `testHaveManyOrdersWithDefaults`
- `testSeeOrderItemMetaWithOrderId`

**Sem conflitos diretos** - todos os métodos são novos para o `OrderCest.php`.

**Nota:** O `OrderNewMethodsCest` usa `$I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no')` em alguns métodos. Como o `OrderCest` já tem um método `_before` que define essa opção, essas chamadas podem ser removidas ao mover os métodos.

**Ação:**
1. Adicionar todos os métodos ao `OrderCest.php` **removendo** as chamadas de `$I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'no')` (o `_before` já configura isso)
2. Remover `OrderNewMethodsCest.php`

### 5. OrderHPOSNewMethodsCest → OrderHPOSCest.php

**Métodos em OrderHPOSNewMethodsCest:**
- Mesmos métodos que `OrderNewMethodsCest` mas para HPOS
- Usa `$I->haveOptionInDatabase('woocommerce_custom_orders_table_enabled', 'yes')` no `_before`

**Nota:** O `OrderHPOSCest` já tem um método `_before` que define a opção HPOS, então não precisa adicionar essas chamadas nos métodos individuais.

**Ação:**
1. Adicionar todos os métodos ao `OrderHPOSCest.php` **removendo** as chamadas de `$I->haveOptionInDatabase` se existirem (o `_before` já configura isso)
2. Remover `OrderHPOSNewMethodsCest.php`

## Arquivos a serem modificados

### Modificações:
1. `tests/acceptance/CouponCest.php` - Adicionar 3 métodos, remover 1, reorganizar
2. `tests/acceptance/ProductCest.php` - Adicionar 9 métodos
3. `tests/acceptance/CustomerCest.php` - Adicionar 3 métodos, renomear 2 existentes
4. `tests/acceptance/OrderCest.php` - Adicionar 14 métodos
5. `tests/acceptance/OrderHPOSCest.php` - Adicionar 13 métodos

### Arquivos a serem removidos:
1. `tests/acceptance/CouponNewMethodsCest.php`
2. `tests/acceptance/ProductNewMethodsCest.php`
3. `tests/acceptance/CustomerNewMethodsCest.php`
4. `tests/acceptance/OrderNewMethodsCest.php`
5. `tests/acceptance/OrderHPOSNewMethodsCest.php`

## Verificação

Após consolidar os testes, executar:

```bash
# Reconstruir o Codeception (caso necessário)
docker compose -f docker-compose.test.yml exec php vendor/bin/codecept build

# Executar todos os testes de aceitação
docker compose -f docker-compose.test.yml exec php vendor/bin/codecept run tests/acceptance/
```

Todos os testes devem passar sem erros.
