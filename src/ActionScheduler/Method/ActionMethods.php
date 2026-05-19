<?php

declare(strict_types=1);

namespace Aztec\WPBrowser\ActionScheduler\Method;

use lucatume\WPBrowser\Module\WPDb;

trait ActionMethods
{
    abstract protected function wpDb(): WPDb;

    // ==================== PRIVATE HELPERS ====================

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

    private function getArgsKey(array $args): string
    {
        $json = json_encode($args, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

        if (strlen($json) > 191) {
            $json = substr($json, 0, 191);
        }

        return $json;
    }

    // ==================== CREATE METHODS ====================

    public function haveActionInDatabase(string $hook, array $args = [], array $overrides = []): int
    {
        $now = gmdate('Y-m-d H:i:s');

        $actionData = array_merge([
            'hook' => $hook,
            'status' => 'pending',
            'scheduled_date_gmt' => $now,
            'args' => $this->getArgsKey($args),
            'schedule' => json_encode(['schedule' => 'once', 'args' => []]),
            'group_id' => 0,
            'attempts' => 0,
            'last_attempt_gmt' => null,
            'claim_id' => 0,
            'extended_claim_id' => '',
        ], $overrides);

        return $this->wpDb()->haveInDatabase($this->actionsTableName(), $actionData);
    }

    public function haveActionGroupInDatabase(string $slug): int
    {
        return $this->wpDb()->haveInDatabase($this->groupsTableName(), ['slug' => $slug]);
    }

    // ==================== READ METHODS ====================

    public function grabActionIdFromDatabase(string $hook, array $args = []): int|false
    {
        $criteria = ['hook' => $hook, 'status' => 'pending'];

        if (!empty($args)) {
            $criteria['args'] = $this->getArgsKey($args);
        }

        return $this->wpDb()->grabFromDatabase($this->actionsTableName(), 'action_id', $criteria);
    }

    public function grabActionStatusFromDatabase(int $actionId): string|false
    {
        return $this->wpDb()->grabFromDatabase($this->actionsTableName(), 'status', ['action_id' => $actionId]);
    }

    public function grabActionsFromDatabase(array $criteria = []): array
    {
        $actionIds = $this->wpDb()->grabColumnFromDatabase(
            $this->actionsTableName(),
            'action_id',
            $criteria
        );

        $actions = [];
        foreach ($actionIds as $actionId) {
            $actions[] = $this->wpDb()->grabRowFromDatabase(
                $this->actionsTableName(),
                ['action_id' => $actionId]
            );
        }

        return $actions;
    }

    public function grabActionLogFromDatabase(int $actionId): array
    {
        return $this->wpDb()->grabRowsFromDatabase(
            $this->logsTableName(),
            ['action_id' => $actionId],
            ['log_date_gmt' => 'ASC']
        );
    }

    // ==================== ASSERTION METHODS ====================

    public function seeActionScheduled(string $hook, array $args = []): void
    {
        $criteria = ['hook' => $hook, 'status' => 'pending'];

        if (!empty($args)) {
            $criteria['args'] = $this->getArgsKey($args);
        }

        $this->wpDb()->seeInDatabase($this->actionsTableName(), $criteria);
    }

    public function dontSeeActionScheduled(string $hook, array $args = []): void
    {
        $criteria = ['hook' => $hook, 'status' => 'pending'];

        if (!empty($args)) {
            $criteria['args'] = $this->getArgsKey($args);
        }

        $this->wpDb()->dontSeeInDatabase($this->actionsTableName(), $criteria);
    }

    public function seeActionInDatabase(array $criteria): void
    {
        $this->wpDb()->seeInDatabase($this->actionsTableName(), $criteria);
    }

    public function seeActionInGroupInDatabase(int $actionId, int $groupId): void
    {
        $this->wpDb()->seeInDatabase(
            $this->actionsTableName(),
            [
                'action_id' => $actionId,
                'group_id' => $groupId,
            ]
        );
    }

    public function seeActionMetaInDatabase(array $criteria): void
    {
        if (isset($criteria['action_id'])) {
            $criteria['post_id'] = $criteria['action_id'];
            unset($criteria['action_id']);
        }

        $this->wpDb()->seePostMetaInDatabase($criteria);
    }

    // ==================== UPDATE/EXECUTE METHODS ====================

    public function cancelActionInDatabase(int $actionId): void
    {
        $this->wpDb()->updateInDatabase(
            $this->actionsTableName(),
            ['status' => 'canceled'],
            ['action_id' => $actionId]
        );
    }

    public function markActionCompleteInDatabase(int $actionId): void
    {
        $this->wpDb()->updateInDatabase(
            $this->actionsTableName(),
            [
                'status' => 'complete',
                'last_attempt_gmt' => gmdate('Y-m-d H:i:s'),
            ],
            ['action_id' => $actionId]
        );
    }

    public function runScheduledActions(string $hook = null, array $args = []): int
    {
        $criteria = ['status' => 'pending'];

        if ($hook !== null) {
            $criteria['hook'] = $hook;
        }

        if (!empty($args)) {
            $criteria['args'] = $this->getArgsKey($args);
        }

        $actionIds = $this->wpDb()->grabColumnFromDatabase(
            $this->actionsTableName(),
            'action_id',
            $criteria
        );

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
}
