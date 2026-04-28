# Plano: Correção de Testes Falhos do WooCommerce Codeception Module

## Contexto

Três testes estão falhando no módulo AztecWPBrowser:

1. `OrderHPOSNewMethodsCest::testGrabOrderIdFromDatabase` - AssertionError: O ID retornado não bate com o ID criado
2. `OrderNewMethodsCest::testSeeOrderAddressInDatabase` - PDOException: Coluna `_billing_first_name` não encontrada
3. `OrderNewMethodsCest::testSeeShippingOrderAddressInDatabase` - PDOException: Coluna `_shipping_first_name` não encontrada

## Diagnóstico

### Problema 1: HPOS Order ID Grab

**Arquivo**: `src/OrderStorage/HPOSOrderStorage.php` (linhas 61-70)

O método `generateOrderId()` usa `grabLatestEntryByFromDatabase()` que retorna `false` quando a tabela está vazia. Isso causa erro no cálculo do próximo ID.

### Problema 2 e 3: Legacy Order Address Verification

**Arquivo**: `src/Method/OrderMethods.php` (linhas 145-150)

Para Legacy storage, endereços são armazenados como **post meta** na tabela `wp_postmeta`. O método `seeOrderAddressInDatabase()` está tentando consultar diretamente com os nomes dos campos (ex: `_billing_first_name`), mas essa tabela tem apenas colunas `meta_id`, `post_id`, `meta_key`, `meta_value`.

## Arquivos a Modificar

1. `src/OrderStorage/HPOSOrderStorage.php` - Linhas 61-70
2. `src/Method/OrderMethods.php` - Topo e linhas 145-150

## Implementação

### Modificação 1: HPOSOrderStorage.php

```php
private function generateOrderId(): int
{
    $ordersTable = $this->grabOrdersTableName();
    $postsTable = $this->wpDb->grabPostsTableName();

    $maxOrderId = $this->wpDb->grabLatestEntryByFromDatabase($ordersTable, 'id');
    $maxPostId = $this->wpDb->grabLatestEntryByFromDatabase($postsTable, 'ID');

    // Handle empty tables
    $maxOrderId = $maxOrderId === false ? 0 : (int)$maxOrderId;
    $maxPostId = $maxPostId === false ? 0 : (int)$maxPostId;

    return max($maxOrderId, $maxPostId) + 1;
}
```

### Modificação 2: OrderMethods.php - Adicionar use statement

No topo do arquivo, adicionar:
```php
use Aztec\WPBrowser\OrderStorage\LegacyOrderStorage;
```

### Modificação 3: OrderMethods.php - Atualizar seeOrderAddressInDatabase

Substituir o método `seeOrderAddressInDatabase()` (linhas 145-150) por:

```php
public function seeOrderAddressInDatabase(string $type, array $criteria): void
{
    // Legacy storage stores addresses as post meta - need different verification
    if ($this->orderStorage() instanceof LegacyOrderStorage) {
        $mapped = $this->orderStorage()->mapAddressCriteria($type, $criteria);

        // For each criterion, verify the corresponding meta entry exists
        foreach ($mapped as $metaKey => $metaValue) {
            $this->wpDb()->seeInDatabase(
                $this->orderStorage()->getMetaTableName(),
                [
                    'meta_key' => $metaKey,
                    'meta_value' => $metaValue,
                ]
            );
        }
        return;
    }

    // HPOS uses the addresses table directly
    $tableName = $this->orderStorage()->getOrderAddressTableName();
    $mappedCriteria = $this->orderStorage()->mapAddressCriteria($type, $criteria);
    $this->wpDb()->seeInDatabase($tableName, $mappedCriteria);
}
```

## Verificação

1. Rebuildar o Codeception (obrigatório após mudanças nas assinaturas):
   ```bash
   docker compose -f docker-compose.test.yml exec php vendor/bin/codecept build
   ```

2. Executar os testes falhos:
   ```bash
   docker compose -f docker-compose.test.yml exec php vendor/bin/codecept run -g failed
   ```

3. Verificar que todos os 3 testes passem:
   - `OrderHPOSNewMethodsCest::testGrabOrderIdFromDatabase`
   - `OrderNewMethodsCest::testSeeOrderAddressInDatabase`
   - `OrderNewMethodsCest::testSeeShippingOrderAddressInDatabase`
