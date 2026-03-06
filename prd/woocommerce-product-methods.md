# PRD: WooCommerce Product Methods

## 1. Executive Summary

**Problema**: O módulo atual possui métodos básicos para produtos em `CartMethods.php`, mas não oferece helpers específicos para criação de categorias de produto e relacionamento produto-categoria, forçando os testes a usar métodos de baixo nível do WPDb. Também faltam métodos de consulta e assertion específicos para produtos.

**Solução**: Criar `ProductMethods.php` trait com métodos de alto nível para gerenciar produtos WooCommerce e suas categorias, incluindo métodos de criação (have), consulta (grab) e verificação (see), seguindo os padrões wp-browser/WPDb.

**Critérios de Sucesso**:
- Testes podem criar categorias de produto com uma chamada de método
- Relacionamento produto-categoria é feito de forma transparente
- Métodos de consulta e assertion permitem verificações expressivas
- Métodos seguem convenções de nomenclatura do wp-browser
- 100% de cobertura dos métodos por testes de aceitação

---

## 2. User Experience & Functionality

### User Personas

- **Desenvolvedor de Testes**: Precisa criar dados de teste (produtos e categorias) de forma rápida e confiável
- **QA Engineer**: Precisa de métodos expressivos que espelhem o domínio WooCommerce

### User Stories

#### US1: Criar categoria de produto
> Como desenvolvedor de testes, quero criar uma categoria de produto com um slug para organizar produtos em testes.

**Acceptance Criteria**:
- Método `haveProductCategoryInDatabase(string $slug, array $overrides = []): int`
- Retorna `term_id` da categoria criada
- Taxonomia `product_cat` é usada automaticamente
- Slug é usado como nome da categoria se não especificado

#### US2: Relacionar produto com categoria
> Como desenvolvedor de testes, quero associar um produto a uma categoria para testar filtros e listagens.

**Acceptance Criteria**:
- Método `haveProductWithCategory(int $productId, int $categoryId): void`
- Usa `wp_term_relationships` internamente
- Atualiza contagem de produtos na categoria (`count` em `wp_term_taxonomy`)

#### US3: Criar produto com dados customizados
> Como desenvolvedor de testes, quero criar um produto com dados específicos para cenários de teste variados.

**Acceptance Criteria**:
- Método `haveProductInDatabase(array $data = []): int`
- Retorna `post_id` do produto
- `post_type = 'product'` e `post_status = 'publish'` são defaults
- Suporta todos os campos de `wp_posts`
- **Nota**: Método já existe em `CartMethods.php` - deve ser movido para `ProductMethods.php`

#### US4: Adicionar meta ao produto
> Como desenvolvedor de testes, quero adicionar metadados a um produto para configurar preço, estoque, SKU, etc.

**Acceptance Criteria**:
- Método `haveProductMetaInDatabase(int $productId, string $key, mixed $value): int`
- Retorna `meta_id`
- Usa `wp_postmeta` (tabela padrão WordPress)
- Wrapper para `WPDb::havePostMetaInDatabase()`

#### US5: Consultar meta do produto
> Como desenvolvedor de testes, quero consultar metadados de um produto para verificar configurações.

**Acceptance Criteria**:
- Método `grabProductMeta(int $productId, string $key, bool $single = false): mixed`
- Retorna valor do metadado
- Wrapper para `get_post_meta()` ou WPDb equivalente

#### US6: Verificar produto em categoria
> Como desenvolvedor de testes, quero verificar se um produto está associado a uma categoria.

**Acceptance Criteria**:
- Método `seeProductInCategory(int $productId, int $categoryId): void`
- Faz assertion verificando `wp_term_relationships`
- Falha o teste se relacionamento não existir

#### US7: Verificar contagem da categoria
> Como desenvolvedor de testes, quero verificar se a contagem de produtos na categoria está correta.

**Acceptance Criteria**:
- Método `seeProductCategoryCount(int $categoryId, int $expectedCount): void`
- Verifica campo `count` em `wp_term_taxonomy`
- Falha o teste se contagem não bater

#### US8: Consultar categorias do produto
> Como desenvolvedor de testes, quero obter todas as categorias de um produto.

**Acceptance Criteria**:
- Método `grabProductCategories(int $productId): array`
- Retorna array de `term_taxonomy_id`
- Consulta `wp_term_relationships`

#### US9: Associar produto a múltiplas categorias
> Como desenvolvedor de testes, quero associar um produto a várias categorias de uma vez.

**Acceptance Criteria**:
- Método `haveProductInCategories(int $productId, array $categoryIds): void`
- Itera sobre array de IDs chamando `haveProductWithCategory()`
- Atualiza contagem de cada categoria

### Non-Goals

- Produtos variáveis, agrupados ou compostos
- Gestão de imagens do produto
- Meta de produto em tabelas customizadas
- Categorias hierárquicas (filhas de categorias)

---

## 3. Technical Specifications

### Architecture Overview

```
src/
├── Method/
│   └── ProductMethods.php     # NOVO - Trait com métodos de produto
└── AztecWPBrowser.php         # Adicionar: use ProductMethods;
```

### Integração com WPDb

| Método | Chama WPDb | Observações |
|--------|-----------|-------------|
| `haveProductCategoryInDatabase` | `haveTermInDatabase()` | Retorna apenas `term_id` (não array) |
| `haveProductWithCategory` | `haveTermRelationshipInDatabase()` + `updateInDatabase()` | Incrementa `count` na taxonomy |
| `haveProductInDatabase` | `havePostInDatabase()` | Move de CartMethods |
| `haveProductMetaInDatabase` | `havePostMetaInDatabase()` | Wrapper direto |
| `grabProductMeta` | `grabPostMetaFromDatabase()` ou `get_post_meta()` | Retorna valor(es) do meta |
| `seeProductInCategory` | `seeInDatabase()` | Assertion em `wp_term_relationships` |
| `seeProductCategoryCount` | `grabFromDatabase()` + `assertEquals()` | Verifica campo `count` |
| `grabProductCategories` | `grabColumnFromDatabase()` | Retorna array de IDs |
| `haveProductInCategories` | `haveProductWithCategory()` (loop) | Atualiza contagem de cada categoria |

### Mapeamento de Tabelas

```
wp_terms                    → Categoria (name, slug)
wp_term_taxonomy            → Taxonomia product_cat
wp_term_relationships       → Produto ↔ Categoria
wp_posts (post_type=product)→ Produto
wp_postmeta                 → Meta do produto (_price, _stock, _sku...)
```

### Assinaturas dos Métodos

```php
trait ProductMethods
{
    abstract protected function wpDb(): WPDb;

    // ==================== CREATE METHODS ====================

    /**
     * Cria uma categoria de produto WooCommerce.
     */
    public function haveProductCategoryInDatabase(string $slug, array $overrides = []): int;

    /**
     * Associa um produto a uma categoria.
     */
    public function haveProductWithCategory(int $productId, int $categoryId): void;

    /**
     * Associa um produto a múltiplas categorias.
     */
    public function haveProductInCategories(int $productId, array $categoryIds): void;

    /**
     * Cria um produto WooCommerce no banco de dados.
     */
    public function haveProductInDatabase(array $data = []): int;

    /**
     * Adiciona metadados a um produto.
     */
    public function haveProductMetaInDatabase(int $productId, string $key, mixed $value): int;

    // ==================== READ METHODS ====================

    /**
     * Consulta metadados de um produto.
     */
    public function grabProductMeta(int $productId, string $key, bool $single = false): mixed;

    /**
     * Retorna todas as categorias de um produto.
     */
    public function grabProductCategories(int $productId): array;

    // ==================== ASSERTION METHODS ====================

    /**
     * Verifica se produto está associado a uma categoria.
     */
    public function seeProductInCategory(int $productId, int $categoryId): void;

    /**
     * Verifica contagem de produtos na categoria.
     */
    public function seeProductCategoryCount(int $categoryId, int $expectedCount): void;
}
```

---

## 4. Implementation Notes

### Migration de CartMethods

O método `haveProductInDatabase()` atual em `CartMethods.php:97-105` deve ser:
1. **Movido** para `ProductMethods.php`
2. **Removido** de `CartMethods.php`
3. CartMethods deve usar `ProductMethods` se necessário, ou chamar via WPDb

**Código atual (CartMethods.php)**:
```php
public function haveProductInDatabase(array $data): int
{
    $productData = array_merge(['post_type' => 'product', 'post_status' => 'publish'], $data);
    $productId   = $this->wpDb()->havePostInDatabase($productData);

    $this->wpDb()->havePostMetaInDatabase($productId, '_price', '100');

    return $productId;
}
```

**Problema**: Adiciona `_price` hardcoded como '100'. Deve ser responsabilidade do teste adicionar meta específica.

### Product Category Count

Ao usar `haveProductWithCategory()`, o campo `count` em `wp_term_taxonomy` deve ser incrementado. WPDb pode não fazer isso automaticamente - verificar comportamento.

---

## 5. Risks & Roadmap

### Technical Risks

| Risco | Probabilidade | Mitigação |
|-------|--------------|-----------|
| WPDb não atualiza `count` da taxonomy | Média | Incrementar manualmente ou verificar documentação |
| Conflito de nomenclatura com WPDb existente | Baixa | Nomes são específicos: `haveProductCategoryInDatabase` vs `haveTermInDatabase` |

### Phased Rollout

**Fase 1 - MVP** (Implementado):
- `ProductMethods.php` trait
- 4 métodos básicos de criação
- Testes de aceitação

**Fase 2 - Consulta e Assertion** (Esta implementação):
- `grabProductMeta()`
- `grabProductCategories()`
- `seeProductInCategory()`
- `seeProductCategoryCount()`
- `haveProductInCategories()`
- Testes de aceitação para novos métodos

**Fase 3 - Melhorias Futuras**:
- `haveVariableProductInDatabase()`
- `haveProductTagInDatabase()`
- Suporte a categorias hierárquicas

---

## 6. Files to Create/Modify

### Fase 1 - MVP (Concluído)

| Arquivo | Ação | Descrição |
|---------|------|-----------|
| `src/Method/ProductMethods.php` | **CRIAR** | Nova trait com métodos de produto |
| `src/AztecWPBrowser.php` | **MODIFICAR** | Adicionar `use ProductMethods;` |
| `src/Method/CartMethods.php` | **MODIFICAR** | Remover `haveProductInDatabase()` |
| `tests/acceptance/ProductCest.php` | **CRIAR** | Testes de aceitação para os métodos |

### Fase 2 - Consulta e Assertion

| Arquivo | Ação | Descrição |
|---------|------|-----------|
| `src/Method/ProductMethods.php` | **MODIFICAR** | Adicionar 5 novos métodos à trait existente |
| `tests/acceptance/ProductCest.php` | **MODIFICAR** | Adicionar testes para novos métodos |
