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

    /**
     * @param array<string, mixed> $args
     */
    private function getArgsKey(array $args): string
    {
        $json = json_encode($args, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

        if ($json === false) {
            return '';
        }

        if (strlen($json) > 191) {
            $json = substr($json, 0, 191);
        }

        return $json;
    }

    // ==================== CREATE METHODS ====================

    /**
     * Create a scheduled action in the database.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_custom_hook', ['key' => 'value']);
     * $I->seeActionScheduled('my_custom_hook', ['key' => 'value']);
     * ```
     *
     * @param string               $hook       The action hook name
     * @param array<string, mixed> $args       Action arguments passed when the hook is executed
     * @param array<string, mixed> $overrides  Database row overrides (status, scheduled_date_gmt, etc.)
     *
     * @return int The created action ID
     */
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

    /**
     * Create an action group in the database.
     *
     * @example
     * ```php
     * $groupId = $I->haveActionGroupInDatabase('my-group');
     * $I->assertGreaterThan(0, $groupId);
     * ```
     *
     * @param string $slug  Unique identifier for the action group
     *
     * @return int The created group ID
     */
    public function haveActionGroupInDatabase(string $slug): int
    {
        return $this->wpDb()->haveInDatabase($this->groupsTableName(), ['slug' => $slug]);
    }

    // ==================== READ METHODS ====================

    /**
     * Extract an action ID from the database by hook and arguments.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook', ['key' => 'value']);
     * $found = $I->grabActionIdFromDatabase('my_hook', ['key' => 'value']);
     * $I->assertSame($actionId, $found);
     * ```
     *
     * @param string               $hook  The action hook name to search for
     * @param array<string, mixed> $args  Action arguments (must match exactly; if empty, matches any args)
     *
     * @return int|false Action ID if found, false otherwise
     */
    public function grabActionIdFromDatabase(string $hook, array $args = []): int|false
    {
        $criteria = ['hook' => $hook, 'status' => 'pending'];

        if (!empty($args)) {
            $criteria['args'] = $this->getArgsKey($args);
        }

        $result = $this->wpDb()->grabFromDatabase($this->actionsTableName(), 'action_id', $criteria);
        return is_numeric($result) ? (int) $result : false;
    }

    /**
     * Extract the status of an action from the database.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook');
     * $status = $I->grabActionStatusFromDatabase($actionId);
     * $I->assertSame('pending', $status);
     * ```
     *
     * @param int $actionId  Action ID to get status for
     *
     * @return string|false Action status (e.g., 'pending', 'complete', 'canceled'), or false if not found
     */
    public function grabActionStatusFromDatabase(int $actionId): string|false
    {
        $result = $this->wpDb()->grabFromDatabase($this->actionsTableName(), 'status', ['action_id' => $actionId]);
        return is_string($result) ? $result : false;
    }

    /**
     * Extract actions from the database by query criteria.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook');
     * $actions = $I->grabActionsFromDatabase(['status' => 'pending']);
     * $I->assertCount(1, $actions);
     * $I->assertSame('my_hook', $actions[0]['hook']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['status' => 'pending', 'hook' => 'my_hook'])
     *
     * @return array<int, array<string, mixed>> Array of action records matching criteria
     */
    public function grabActionsFromDatabase(array $criteria = []): array
    {
        $actionIds = $this->wpDb()->grabColumnFromDatabase(
            $this->actionsTableName(),
            'action_id',
            $criteria,
        );

        /** @var array<int, array<string, mixed>> $actions */
        $actions = [];
        foreach ($actionIds as $actionId) {
            $row = $this->wpDb()->grabFromDatabase(
                $this->actionsTableName(),
                '*',
                ['action_id' => $actionId],
            );
            if ($row === false || !is_array($row)) {
                continue;
            }

            /** @var array<string, mixed> $row */
            $actions[] = $row;
        }

        return $actions;
    }

    /**
     * Extract execution logs for an action from the database.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook');
     * $I->runScheduledActions('my_hook');
     * $logs = $I->grabActionLogFromDatabase($actionId);
     * $I->assertCount(1, $logs);
     * $I->assertSame('result', $logs[0]['log_entry_type']);
     * ```
     *
     * @param int $actionId  Action ID to get logs for
     *
     * @return array<int, array<string, mixed>> Array of log entries for the action
     */
    public function grabActionLogFromDatabase(int $actionId): array
    {
        $results = $this->wpDb()->grabFromDatabase(
            $this->logsTableName(),
            '*',
            ['action_id' => $actionId],
        );

        if ($results === false || !is_array($results)) {
            return [];
        }

        $firstItem = reset($results);
        /** @var array<int, array<string, mixed>> $return */
        $return = is_array($firstItem) ? $results : [$results];
        return $return;
    }

    // ==================== ASSERTION METHODS ====================

    /**
     * Verify that an action is scheduled in the database with pending status.
     *
     * @example
     * ```php
     * $I->haveActionInDatabase('my_hook', ['id' => 123]);
     * $I->seeActionScheduled('my_hook', ['id' => 123]);
     * ```
     *
     * @param string               $hook  The action hook name to verify
     * @param array<string, mixed> $args  Action arguments (must match exactly; if empty, matches any args)
     *
     * @return void
     */
    public function seeActionScheduled(string $hook, array $args = []): void
    {
        $criteria = ['hook' => $hook, 'status' => 'pending'];

        if (!empty($args)) {
            $criteria['args'] = $this->getArgsKey($args);
        }

        $this->wpDb()->seeInDatabase($this->actionsTableName(), $criteria);
    }

    /**
     * Verify that an action is not scheduled in the database with pending status.
     *
     * @example
     * ```php
     * $I->dontSeeActionScheduled('nonexistent_hook');
     * ```
     *
     * @param string               $hook  The action hook name to verify
     * @param array<string, mixed> $args  Action arguments to match against
     *
     * @return void
     */
    public function dontSeeActionScheduled(string $hook, array $args = []): void
    {
        $criteria = ['hook' => $hook, 'status' => 'pending'];

        if (!empty($args)) {
            $criteria['args'] = $this->getArgsKey($args);
        }

        $this->wpDb()->dontSeeInDatabase($this->actionsTableName(), $criteria);
    }

    /**
     * Verify that an action exists in the database with given criteria.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook');
     * $I->seeActionInDatabase(['action_id' => $actionId, 'status' => 'pending']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria (e.g., ['hook' => 'my_hook', 'status' => 'complete'])
     *
     * @return void
     */
    public function seeActionInDatabase(array $criteria): void
    {
        $this->wpDb()->seeInDatabase($this->actionsTableName(), $criteria);
    }

    /**
     * Verify that an action is assigned to a specific group in the database.
     *
     * @example
     * ```php
     * $groupId = $I->haveActionGroupInDatabase('my-group');
     * $actionId = $I->haveActionInDatabase('my_hook', [], ['group_id' => $groupId]);
     * $I->seeActionInGroupInDatabase($actionId, $groupId);
     * ```
     *
     * @param int $actionId  Action ID to verify
     * @param int $groupId   Group ID the action should be assigned to
     *
     * @return void
     */
    public function seeActionInGroupInDatabase(int $actionId, int $groupId): void
    {
        $this->wpDb()->seeInDatabase(
            $this->actionsTableName(),
            [
                'action_id' => $actionId,
                'group_id' => $groupId,
            ],
        );
    }

    /**
     * Verify that action meta exists in the database.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook');
     * $I->seeActionMetaInDatabase(['action_id' => $actionId, 'meta_key' => '_custom_field']);
     * ```
     *
     * @param array<string, mixed> $criteria Database query criteria. Supports 'action_id' key (internally maps to 'post_id')
     *
     * @return void
     */
    public function seeActionMetaInDatabase(array $criteria): void
    {
        if (isset($criteria['action_id'])) {
            $criteria['post_id'] = $criteria['action_id'];
            unset($criteria['action_id']);
        }

        $this->wpDb()->seePostMetaInDatabase($criteria);
    }

    // ==================== UPDATE/EXECUTE METHODS ====================

    /**
     * Cancel a scheduled action by updating its status to 'canceled'.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook');
     * $I->cancelActionInDatabase($actionId);
     * $status = $I->grabActionStatusFromDatabase($actionId);
     * $I->assertSame('canceled', $status);
     * ```
     *
     * @param int $actionId  Action ID to cancel
     *
     * @return void
     */
    public function cancelActionInDatabase(int $actionId): void
    {
        $this->wpDb()->updateInDatabase(
            $this->actionsTableName(),
            ['status' => 'canceled'],
            ['action_id' => $actionId],
        );
    }

    /**
     * Mark a scheduled action as complete in the database.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook');
     * $I->markActionCompleteInDatabase($actionId);
     * $status = $I->grabActionStatusFromDatabase($actionId);
     * $I->assertSame('complete', $status);
     * ```
     *
     * @param int $actionId  Action ID to mark as complete
     *
     * @return void
     */
    public function markActionCompleteInDatabase(int $actionId): void
    {
        $this->wpDb()->updateInDatabase(
            $this->actionsTableName(),
            [
                'status' => 'complete',
                'last_attempt_gmt' => gmdate('Y-m-d H:i:s'),
            ],
            ['action_id' => $actionId],
        );
    }

    /**
     * Simulate running scheduled actions matching the criteria, marking them complete.
     *
     * @example
     * ```php
     * $actionId = $I->haveActionInDatabase('my_hook');
     * $count = $I->runScheduledActions('my_hook');
     * $I->assertSame(1, $count);
     * $I->seeActionInDatabase(['action_id' => $actionId, 'status' => 'complete']);
     * ```
     *
     * @param string|null          $hook  Action hook to run, or null to run all pending actions
     * @param array<string, mixed> $args  Action arguments to match (only actions with these args will run)
     *
     * @return int Number of actions that were marked as complete
     */
    public function runScheduledActions(?string $hook = null, array $args = []): int
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
            $criteria,
        );

        $count = count($actionIds);

        foreach ($actionIds as $actionId) {
            if (!is_numeric($actionId)) {
                continue;
            }

            $this->markActionCompleteInDatabase((int) $actionId);
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
