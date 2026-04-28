# PRD: WooCommerce ActionScheduler Methods

## 1. Executive Summary

**Problema**: Testes WooCommerce que utilizam o ActionScheduler precisam verificar, criar e executar ações agendadas de forma programática, mas o módulo atual não oferece helpers específicos para essa finalidade, forçando os testes a usar métodos de baixo nível do WPDb ou executar o processador real de ações (que é lento e não determinístico).

**Solução**: Criar `ActionSchedulerMethods.php` trait com métodos de alto nível para gerenciar ações do ActionScheduler, incluindo métodos de criação (have), consulta (grab), verificação (see) e execução (run), seguindo os padrões wp-browser/WPDb e utilizando as tabelas customizadas do ActionScheduler.

**Critérios de Sucesso**:
- Testes podem verificar se uma ação está agendada com uma chamada de método
- Testes podem criar ações diretamente no banco de dados sem esperar o scheduler real
- Testes podem executar ações programaticamente para validar workflows completos
- Métodos seguem convenções de nomenclatura do wp-browser (have/grab/see)
- 100% de cobertura dos métodos por testes de aceitação

---

## 2. User Experience & Functionality

### User Personas

- **Desenvolvedor de Testes WooCommerce**: Precisa validar workflows que envolvem ações assíncronas (processamento de pedidos, envio de emails, atualização de estoque)
- **QA Engineer**: Precisa de métodos expressivos que espelhem o domínio do ActionScheduler

### User Stories

#### US1: Verificar ação agendada
> Como desenvolvedor de testes, quero verificar se uma ação com determinado hook e argumentos está agendada para confirmar que a aplicação corretamente enfileirou tarefas em background.

**Acceptance Criteria**:
- Método `seeActionScheduled(string $hook, array $args = []): void`
- Verifica se existe ação com status 'pending'
- Usa JSON encoding para comparar argumentos
- Lança falha do teste se ação não for encontrada

#### US2: Verificar ação NÃO agendada
> Como desenvolvedor de testes, quero verificar se uma ação com determinado hook e argumentos NÃO está agendada para confirmar que a aplicação corretamente removeu ou evitou agendamento.

**Acceptance Criteria**:
- Método `dontSeeActionScheduled(string $hook, array $args = []): void`
- Verifica se NÃO existe ação com status 'pending'
- Lança falha do teste se ação for encontrada

#### US3: Executar ações agendadas
> Como desenvolvedor de testes, quero executar ações programaticamente para testar o fluxo completo de processamento de tarefas em background sem esperar o cron real.

**Acceptance Criteria**:
- Método `runScheduledActions(string $hook = null, array $args = []): int`
- Executa ações matching criteria
- Atualiza status de 'pending' para 'complete'
- Cria logs de execução
- Retorna número de ações executadas
- Se $hook é null, executa todas as ações pending

#### US4: Criar ação no banco de dados
> Como desenvolvedor de testes, quero criar uma ação agendada diretamente no banco de dados para configurar cenários de teste sem depender do agendamento real.

**Acceptance Criteria**:
- Método `haveActionInDatabase(string $hook, array $args = [], array $overrides = []): int`
- Retorna `action_id` da ação criada
- Status padrão é 'pending'
- `scheduled_date_gmt` usa data atual UTC como padrão
- Suporta todos os campos de `wp_actionscheduler_actions`
- Argumentos são JSON-encoded

#### US5: Criar grupo de ações
> Como desenvolvedor de testes, quero criar grupos de ações para organizar e categorizar tarefas relacionadas.

**Acceptance Criteria**:
- Método `haveActionGroupInDatabase(string $slug): int`
- Retorna `group_id` do grupo criado
- Usa tabela `wp_actionscheduler_groups`

#### US6: Consultar ID da ação
> Como desenvolvedor de testes, quero recuperar o ID de uma ação pelo hook e argumentos para referenciá-la em testes subsequentes.

**Acceptance Criteria**:
- Método `grabActionIdFromDatabase(string $hook, array $args = []): int|false`
- Retorna `action_id` se encontrado, `false` caso contrário
- Considera apenas ações com status 'pending'

#### US7: Consultar status da ação
> Como desenvolvedor de testes, quero verificar o status de uma ação para confirmar seu estado de processamento.

**Acceptance Criteria**:
- Método `grabActionStatusFromDatabase(int $actionId): string|false`
- Retorna status ('pending', 'in-progress', 'complete', 'failed', 'canceled')
- Retorna `false` se ação não for encontrada

#### US8: Verificar ação existe
> Como desenvolvedor de testes, quero verificar se uma ação existe com critérios específicos.

**Acceptance Criteria**:
- Método `seeActionInDatabase(array $criteria): void`
- Faz assertion em `wp_actionscheduler_actions`
- Lança falha se registro não for encontrado

#### US9: Verificar metadados da ação
> Como desenvolvedor de testes, quero verificar metadados associados à ação (usando compatibilidade com wp_postmeta).

**Acceptance Criteria**:
- Método `seeActionMetaInDatabase(array $criteria): void`
- Mapeia `action_id` para `post_id` para compatibilidade
- Usa `wp_postmeta` internamente

#### US10: Verificar ação em grupo
> Como desenvolvedor de testes, quero verificar se uma ação pertence a um grupo específico.

**Acceptance Criteria**:
- Método `seeActionInGroupInDatabase(int $actionId, int $groupId): void`
- Verifica campo `group_id` na tabela de ações

#### US11: Consultar múltiplas ações
> Como desenvolvedor de testes, quero obter todas as ações que correspondem a critérios específicos.

**Acceptance Criteria**:
- Método `grabActionsFromDatabase(array $criteria = []): array`
- Retorna array de arrays com dados das ações
- Vazio se nenhum registro encontrado

#### US12: Cancelar ação
> Como desenvolvedor de testes, quero marcar uma ação como cancelada para simular cancelamento de tarefas.

**Acceptance Criteria**:
- Método `cancelActionInDatabase(int $actionId): void`
- Atualiza status para 'canceled'
- Usa `WPDb::updateInDatabase()`

#### US13: Marcar ação como completa
> Como desenvolvedor de testes, quero marcar uma ação como completa para simular execução bem-sucedida.

**Acceptance Criteria**:
- Método `markActionCompleteInDatabase(int $actionId): void`
- Atualiza status para 'complete'
- Atualiza `last_attempt_gmt` com data atual
- Usa `WPDb::updateInDatabase()`

#### US14: Consultar logs da ação
> Como desenvolvedor de testes, quero recuperar todos os logs de execução de uma ação para validar mensagens de erro ou sucesso.

**Acceptance Criteria**:
- Método `grabActionLogFromDatabase(int $actionId): array`
- Retorna array de arrays com dados dos logs
- Campos incluem: log_id, message, log_date_gmt, log_entry_type

### Non-Goals

- Integração com ActionScheduler_Store ou ActionScheduler_Action (classes PHP)
- Execução real de hooks WordPress
- Gestão de recurring actions (agendamentos recorrentes)
- Validação de dados de schedule (interval, cron, timestamp)

---

## 3. Technical Specifications

### Architecture Overview

```
src/
├── Method/
│   └── ActionSchedulerMethods.php  # NOVO - Trait com métodos do ActionScheduler
└── AztecWPBrowser.php              # Adicionar: use ActionSchedulerMethods;
```

### Database Schema (ActionScheduler Tables)

| Tabela | Descrição |
|--------|-----------|
| `wp_actionscheduler_actions` | Ações agendadas (hook, status, args, schedule) |
| `wp_actionscheduler_groups` | Grupos de ações (organização) |
| `wp_actionscheduler_claims` | Claims para processamento (lock) |
| `wp_actionscheduler_logs` | Logs de execução |

### Mapeamento de Tabelas e Colunas

```
wp_actionscheduler_actions:
├── action_id (bigint, PK, auto-increment)
├── hook (varchar 191)        - Nome do hook a executar
├── status (varchar 20)       - 'pending', 'in-progress', 'complete', 'failed', 'canceled'
├── scheduled_date_gmt (datetime)
├── args (longtext)           - JSON serialized arguments
├── schedule (longtext)        - JSON serialized schedule data
├── group_id (bigint)         - FK para wp_actionscheduler_groups
├── attempts (int)
├── last_attempt_gmt (datetime)
├── claim_id (bigint)         - FK para wp_actionscheduler_claims
└── extended_claim_id (varchar 191)

wp_actionscheduler_groups:
├── group_id (bigint, PK, auto-increment)
└── slug (varchar 255, unique)

wp_actionscheduler_claims:
├── claim_id (bigint, PK, auto-increment)
├── date_created_gmt (datetime)
└── extended_claim_id (varchar 191)

wp_actionscheduler_logs:
├── log_id (bigint, PK, auto-increment)
├── action_id (bigint)        - FK para wp_actionscheduler_actions
├── message (text)
├── log_date_gmt (datetime)
└── log_entry_type (varchar 20) - 'action', 'status', 'result'
```

### Integração com WPDb

| Método | Chama WPDb | Observações |
|--------|-----------|-------------|
| `seeActionScheduled` | `seeInDatabase()` | Verifica status='pending' |
| `dontSeeActionScheduled` | `dontSeeInDatabase()` | Verifica status='pending' |
| `runScheduledActions` | `updateInDatabase()`, `haveInDatabase()` | Atualiza status para 'complete', cria logs |
| `haveActionInDatabase` | `haveInDatabase()` | Insere em wp_actionscheduler_actions |
| `haveActionGroupInDatabase` | `haveInDatabase()` | Insere em wp_actionscheduler_groups |
| `grabActionIdFromDatabase` | `grabFromDatabase()` | Retorna action_id ou false |
| `grabActionStatusFromDatabase` | `grabFromDatabase()` | Retorna status |
| `seeActionInDatabase` | `seeInDatabase()` | Assertion genérico |
| `seeActionMetaInDatabase` | `seePostMetaInDatabase()` | Mapeia action_id → post_id |
| `seeActionInGroupInDatabase` | `seeInDatabase()` | Verifica group_id |
| `grabActionsFromDatabase` | `grabColumnFromDatabase()` | Retorna array de IDs |
| `cancelActionInDatabase` | `updateInDatabase()` | Atualiza status para 'canceled' |
| `markActionCompleteInDatabase` | `updateInDatabase()` | Atualiza status e last_attempt_gmt |
| `grabActionLogFromDatabase` | `grabFromDatabase()` | Consulta wp_actionscheduler_logs |

### Assinaturas dos Métodos

```php
trait ActionSchedulerMethods
{
    abstract protected function wpDb(): WPDb;

    // ==================== CREATE METHODS ====================

    /**
     * Cria uma ação agendada no banco de dados.
     */
    public function haveActionInDatabase(string $hook, array $args = [], array $overrides = []): int;

    /**
     * Cria um grupo de ações.
     */
    public function haveActionGroupInDatabase(string $slug): int;

    // ==================== READ METHODS ====================

    /**
     * Recupera o ID de uma ação pelo hook e argumentos.
     */
    public function grabActionIdFromDatabase(string $hook, array $args = []): int|false;

    /**
     * Recupera o status de uma ação.
     */
    public function grabActionStatusFromDatabase(int $actionId): string|false;

    /**
     * Recupera todas as ações que correspondem aos critérios.
     */
    public function grabActionsFromDatabase(array $criteria = []): array;

    /**
     * Recupera logs de execução de uma ação.
     */
    public function grabActionLogFromDatabase(int $actionId): array;

    // ==================== ASSERTION METHODS ====================

    /**
     * Verifica se uma ação está agendada (status = pending).
     */
    public function seeActionScheduled(string $hook, array $args = []): void;

    /**
     * Verifica se uma ação NÃO está agendada (status = pending).
     */
    public function dontSeeActionScheduled(string $hook, array $args = []): void;

    /**
     * Verifica se uma ação existe com os critérios fornecidos.
     */
    public function seeActionInDatabase(array $criteria): void;

    /**
     * Verifica se uma ação pertence a um grupo.
     */
    public function seeActionInGroupInDatabase(int $actionId, int $groupId): void;

    /**
     * Verifica metadados de uma ação (compatibilidade wp_postmeta).
     */
    public function seeActionMetaInDatabase(array $criteria): void;

    // ==================== UPDATE/EXECUTE METHODS ====================

    /**
     * Marca uma ação como cancelada.
     */
    public function cancelActionInDatabase(int $actionId): void;

    /**
     * Marca uma ação como completa.
     */
    public function markActionCompleteInDatabase(int $actionId): void;

    /**
     * Executa ações agendadas.
     */
    public function runScheduledActions(string $hook = null, array $args = []): int;
}
```

### Detalhes de Implementação - JSON Args

ActionScheduler usa JSON encoding para argumentos com uma restrição importante: **o JSON encoded pode ter no máximo 191 caracteres** quando usado em índices do banco de dados.

Para métodos que buscam por argumentos (`seeActionScheduled`, `dontSeeActionScheduled`, `grabActionIdFromDatabase`, `runScheduledActions`), implementar:

```php
private function getArgsKey(array $args): string
{
    // ActionScheduler usa json_encode com flags específicas
    // e truncamento se necessário para manter <= 191 chars
    $json = json_encode($args, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

    if (strlen($json) > 191) {
        // Truncar mantendo JSON válido
        // Implementação baseada em ActionScheduler_DBStore::get_args_for_query()
        $json = substr($json, 0, 191);
    }

    return $json;
}
```

---

## 4. Implementation Notes

### Nomes de Tabelas

As tabelas do ActionScheduler são criadas com o prefixo do WordPress (`wp_` por padrão). Para obter o nome correto:

```php
private function actionsTableName(): string
{
    return $this->wpDb()->grabPrefixedTableNameFor('actionscheduler_actions');
}

private function groupsTableName(): string
{
    return $this->wpDb()->grabPrefixedTableNameFor('actionscheduler_groups');
}

private function claimsTableName(): string
{
    return $this->wpDb()->grabPrefixedTableNameFor('actionscheduler_claims');
}

private function logsTableName(): string
{
    return $this->wpDb()->grabPrefixedTableNameFor('actionscheduler_logs');
}
```

### Valores Padrão

Para `haveActionInDatabase`:
- `status`: 'pending'
- `scheduled_date_gmt`: gmdate('Y-m-d H:i:s')
- `args`: json_encode($args) com truncamento se necessário
- `schedule`: '{"schedule":"once","args":[]}' (schedule padrão)
- `group_id`: 0 (nenhum grupo)
- `attempts`: 0
- `last_attempt_gmt`: null
- `claim_id`: 0
- `extended_claim_id`: ''

### runScheduledActions Implementation

Este método deve:
1. Buscar ações que correspondem aos critérios ($hook e $args)
2. Para cada ação encontrada:
   - Atualizar status para 'complete'
   - Atualizar `last_attempt_gmt`
   - Criar log de execução em `wp_actionscheduler_logs`
3. Retornar contagem de ações executadas

```php
public function runScheduledActions(string $hook = null, array $args = []): int
{
    $criteria = ['status' => 'pending'];

    if ($hook !== null) {
        $criteria['hook'] = $hook;
    }

    if (!empty($args)) {
        $criteria['args'] = $this->getArgsKey($args);
    }

    $actionIds = $this->grabActionsFromDatabase($criteria);
    $count = count($actionIds);

    foreach ($actionIds as $actionId) {
        $this->markActionCompleteInDatabase($actionId);
        $this->wpDb()->haveInDatabase($this->logsTableName(), [
            'action_id' => $actionId,
            'message' => 'Action executed via runScheduledActions',
            'log_date_gmt' => gmdate('Y-m-d H:i:s'),
            'log_entry_type' => 'result',
        ]);
    }

    return $count;
}
```

---

## 5. Risks & Roadmap

### Technical Risks

| Risco | Probabilidade | Mitigação |
|-------|--------------|-----------|
| Tabelas do ActionScheduler não existem no ambiente de teste | Média | Testes devem verificar se as tabelas existem antes de executar |
| Encoding de argumentos difere do ActionScheduler original | Baixa | Usar mesma lógica de encoding/truncamento do ActionScheduler_DBStore |
| Concorrência com processador real de ações | Baixa | Em ambiente de teste, geralmente o cron não está ativo |

### Phased Rollout

**Fase 1 - MVP**:
- `ActionSchedulerMethods.php` trait
- 3 métodos principais solicitados:
  - `seeActionScheduled()`
  - `dontSeeActionScheduled()`
  - `runScheduledActions()`
- Testes de aceitação para métodos principais

**Fase 2 - Métodos Auxiliares**:
- `haveActionInDatabase()`
- `haveActionGroupInDatabase()`
- `grabActionIdFromDatabase()`
- `grabActionStatusFromDatabase()`
- `grabActionsFromDatabase()`
- `cancelActionInDatabase()`
- `markActionCompleteInDatabase()`
- Testes de aceitação para novos métodos

**Fase 3 - Methods Completos**:
- `seeActionInDatabase()`
- `seeActionMetaInDatabase()`
- `seeActionInGroupInDatabase()`
- `grabActionLogFromDatabase()`
- Testes de aceitação para métodos restantes

**Fase 4 - Melhorias Futuras**:
- Suporte a recurring actions (agendamentos recorrentes)
- Validação de schedule (cron, interval, timestamp)
- Integração com Page Objects para UI do ActionScheduler

---

## 6. Files to Create/Modify

### Fase 1 - MVP

| Arquivo | Ação | Descrição |
|---------|------|-----------|
| `src/Method/ActionSchedulerMethods.php` | **CRIAR** | Nova trait com métodos do ActionScheduler |
| `src/AztecWPBrowser.php` | **MODIFICAR** | Adicionar `use ActionSchedulerMethods;` |
| `tests/acceptance/ActionSchedulerCest.php` | **CRIAR** | Testes de aceitação para métodos principais |

### Fase 2 - Métodos Auxiliares

| Arquivo | Ação | Descrição |
|---------|------|-----------|
| `src/Method/ActionSchedulerMethods.php` | **MODIFICAR** | Adicionar 8 métodos auxiliares |
| `tests/acceptance/ActionSchedulerCest.php` | **MODIFICAR** | Adicionar testes para métodos auxiliares |

### Fase 3 - Methods Completos

| Arquivo | Ação | Descrição |
|---------|------|-----------|
| `src/Method/ActionSchedulerMethods.php` | **MODIFICAR** | Adicionar 4 métodos restantes |
| `tests/acceptance/ActionSchedulerCest.php` | **MODIFICAR** | Adicionar testes para métodos restantes |
