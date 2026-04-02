# Workflow Engine — Implementation Plan

Comprehensive plan to implement the LuxuryCRM workflow engine, adapted from the SuiteCRM AOW_WorkFlow architecture (see `suitecrm_workflow_engine_reference.md`) and tailored to our NestJS + Kysely + BullMQ + React stack.

---

## Current State

**What exists:**
- Database tables: `workflows`, `workflow_conditions`, `workflow_actions`, `workflow_processed` (migration 001)
- Scheduler tables: `schedulers`, `scheduler_jobs` (migration 001)
- Scheduler admin controller (`apps/api/src/modules/admin/schedulers.controller.ts`)
- Email template system with `type = 'workflow'` support
- BullMQ + ioredis dependencies installed (no workers yet)
- Database types in `database.types.ts` for all workflow tables

**What's missing:**
- Workflow execution engine (condition evaluator, action executor)
- BullMQ worker integration
- NestJS module for workflow management (controller + service)
- After-save hook to trigger workflows on record changes
- Frontend workflow builder UI
- Shared types for workflow entities

---

## Architecture Overview

```
┌──────────────────────────────────────────────────────────────┐
│                        ENTRY POINTS                          │
│                                                              │
│  ┌─────────────────┐         ┌───────────────────────┐       │
│  │  Records Service │         │   BullMQ Scheduler    │       │
│  │  (after save)    │         │   (cron repeatable)   │       │
│  └────────┬────────┘         └───────────┬───────────┘       │
│           │                              │                   │
│           ▼                              ▼                   │
│  ┌──────────────────────────────────────────────────────┐    │
│  │              WorkflowEngine Service                   │    │
│  │                                                       │    │
│  │  1. Load active workflows for module                  │    │
│  │  2. Evaluate conditions against record                │    │
│  │  3. Check processed status (run-once logic)           │    │
│  │  4. Execute actions in order                          │    │
│  │  5. Log results to workflow_processed                 │    │
│  └──────────────────┬───────────────────────────────────┘    │
│                     │                                        │
│    ┌────────────────┼────────────────┐                       │
│    ▼                ▼                ▼                        │
│ ┌──────────┐ ┌───────────┐ ┌──────────────┐ ┌────────────┐  │
│ │  Modify   │ │  Create   │ │  Send Email  │ │  Compute   │  │
│ │  Record   │ │  Record   │ │              │ │  Field     │  │
│ └──────────┘ └───────────┘ └──────────────┘ └────────────┘  │
└──────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Core Engine (Backend)

### Step 1.1 — Shared Types

**File**: `packages/shared/src/types/workflow.types.ts`

Define TypeScript types for the workflow system:

```ts
// Trigger modes
type TriggerType = 'on_save' | 'scheduled' | 'always' | 'on_create';

// Record scope
type RecordSelection = 'all' | 'new_records' | 'modified_records';

// Condition operators
type ConditionOperator =
  | 'equal_to' | 'not_equal_to'
  | 'greater_than' | 'less_than'
  | 'greater_than_or_equal' | 'less_than_or_equal'
  | 'contains' | 'starts_with' | 'ends_with'
  | 'is_null' | 'is_not_null'
  | 'one_of' | 'not_one_of'
  | 'changed' | 'not_changed';

// Value types for conditions
type ConditionValueType =
  | 'value'         // literal comparison
  | 'field'         // compare against another field
  | 'any_change'    // field changed (on-save only)
  | 'date'          // date arithmetic expression
  | 'multi';        // multiple values (for one_of/not_one_of)

// Action types
type WorkflowActionType =
  | 'modify_record'
  | 'create_record'
  | 'send_email'
  | 'compute_field';

// Workflow definition
interface WorkflowDefinition {
  id: string;
  name: string;
  description?: string;
  targetModule: string;
  status: 'active' | 'inactive';
  triggerType: TriggerType;
  recordSelection?: RecordSelection;
  repeatedRuns: boolean;
  conditions: WorkflowConditionDef[];
  actions: WorkflowActionDef[];
}

// Condition definition
interface WorkflowConditionDef {
  id: string;
  fieldName: string;
  modulePath?: string[];      // relationship traversal path
  operator: ConditionOperator;
  valueType: ConditionValueType;
  value: unknown;             // JSON — interpretation depends on valueType
  order: number;
}

// Action definition
interface WorkflowActionDef {
  id: string;
  actionType: WorkflowActionType;
  name: string;
  parameters: Record<string, unknown>;  // JSONB
  order: number;
}

// Action parameter shapes
interface ModifyRecordParams {
  targetRelationship?: string;   // empty = modify trigger record itself
  fields: { name: string; value: unknown; valueType: string }[];
}

interface CreateRecordParams {
  targetModule: string;
  relateToTrigger: boolean;
  fields: { name: string; value: unknown; valueType: string }[];
}

interface SendEmailParams {
  templateId: string;
  individualEmail: boolean;
  recipients: {
    type: 'email' | 'user' | 'related_field' | 'record_email';
    recipientType: 'to' | 'cc' | 'bcc';
    value: string;
  }[];
}

interface ComputeFieldParams {
  parameters: { fieldName: string; type: 'raw' | 'formatted' }[];
  relationParameters: { relationship: string; fieldName: string; type: 'raw' | 'formatted' }[];
  formulas: { targetField: string; expression: string }[];
}

// Processed log
interface WorkflowProcessedLog {
  id: string;
  workflowId: string;
  recordId: string;
  module: string;
  status: 'pending' | 'running' | 'complete' | 'failed';
  errorMessage?: string;
  processedAt: string;
}
```

### Step 1.2 — Database Schema Update

**File**: `apps/api/src/database/migrations/015_workflow_schema_updates.sql`

Extend the existing schema for relationship-path conditions and action-result tracking:

```sql
-- Add module_path to workflow_conditions for relationship traversal
ALTER TABLE workflow_conditions
  ADD COLUMN IF NOT EXISTS module_path JSONB DEFAULT NULL;

-- Add condition_logic column (for future OR support)
ALTER TABLE workflow_conditions
  ADD COLUMN IF NOT EXISTS logic VARCHAR(10) NOT NULL DEFAULT 'AND';

-- Track per-action results within a processed run
CREATE TABLE IF NOT EXISTS workflow_processed_actions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  processed_id UUID NOT NULL REFERENCES workflow_processed(id) ON DELETE CASCADE,
  action_id UUID NOT NULL REFERENCES workflow_actions(id) ON DELETE CASCADE,
  status VARCHAR(20) NOT NULL,           -- 'complete' | 'failed'
  error_message TEXT DEFAULT NULL,
  executed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for fast workflow lookup by module + status
CREATE INDEX IF NOT EXISTS idx_workflows_module_status
  ON workflows(target_module, status) WHERE deleted = FALSE;

-- Index for fast processed lookup
CREATE INDEX IF NOT EXISTS idx_workflow_processed_lookup
  ON workflow_processed(workflow_id, record_id, status);
```

Update `database.types.ts` to include the new table.

### Step 1.3 — Condition Evaluator

**File**: `apps/api/src/modules/workflow/condition-evaluator.ts`

A pure function module (no NestJS dependencies) that evaluates conditions against a record:

```
ConditionEvaluator
├── evaluateAll(conditions, record, previousRecord?) → boolean
├── evaluateCondition(condition, record, previousRecord?) → boolean
├── resolveValue(valueType, value, record) → unknown
├── compareValues(fieldValue, operator, compareValue) → boolean
└── evaluateDateExpression(expr) → Date
```

Key behaviors:
- **All conditions AND** — every condition must pass (matching SuiteCRM)
- **`any_change` detection**: Compare `record[field]` vs `previousRecord[field]`. Only works on-save (when previousRecord is available). Returns true for scheduled triggers (no previous state).
- **`date` value type**: Parse JSON `{ base, operator, amount, unit }` and compute target date. Support: `now`, `today`, field name as base.
- **`field` value type**: Compare field A against field B on the same record.
- **`multi` value type**: Parse JSON array of values for `one_of`/`not_one_of`.
- **Relationship conditions** (`modulePath`): Delegate to a SQL query via Kysely. Build JOINs from `relationship_metadata` to verify related records match.

### Step 1.4 — Action Executors

**Directory**: `apps/api/src/modules/workflow/actions/`

Each action type is a separate class implementing a common interface:

```ts
interface WorkflowAction {
  execute(context: ActionContext): Promise<ActionResult>;
}

interface ActionContext {
  bean: Record<string, unknown>;    // the trigger record
  beanModule: string;
  params: Record<string, unknown>;
  inSave: boolean;                  // true if triggered by after-save
  workflowId: string;
  db: Kysely<Database>;
  metadataService: MetadataService;
  emailService?: EmailService;
}

interface ActionResult {
  success: boolean;
  error?: string;
}
```

**Action implementations:**

#### `modify-record.action.ts`
- If `targetRelationship` is empty: modify the trigger record itself.
- If `targetRelationship` is set: load related records via relationship_metadata JOIN, modify each.
- For each field assignment, resolve value by `valueType`:
  - `value` → literal
  - `field` → copy from trigger record
  - `date` → compute date expression
  - `round_robin` / `least_busy` / `random` → user assignment strategies (query users table)
- Use Kysely `UPDATE` with `RETURNING *` to apply changes.
- Set a `_workflowProcessing` flag on the record module to prevent re-triggering.

#### `create-record.action.ts`
- Create a new record in `targetModule`.
- Resolve fields same as modify-record.
- If `relateToTrigger`: find relationship between trigger module and target module via `relationship_metadata`, insert into join table.
- Use Kysely `INSERT` with `RETURNING *`.

#### `send-email.action.ts`
- Load email template by ID.
- Resolve recipients by type:
  - `email`: literal address
  - `user`: lookup user's email
  - `related_field`: traverse relationship, get email from related record
  - `record_email`: use trigger record's email field
- Parse template variables: replace `{{module.field}}` with record values. Support related record fields via relationship traversal.
- If `individualEmail`: send one email per recipient with per-recipient template parsing.
- Use existing `EmailService` for sending.

#### `compute-field.action.ts`
- Resolve parameters `{P0}`, `{P1}` from trigger record fields.
- Resolve relation parameters `{R0}`, `{R1}` from related records.
- Evaluate formula expression via `FormulaCalculator`.
- Write result back to the trigger record.

### Step 1.5 — Formula Calculator

**File**: `apps/api/src/modules/workflow/formula-calculator.ts`

Port the SuiteCRM `FormulaCalculator` to TypeScript. Curly-brace expression syntax:

```
{add({P0};{multiply({P1};{P2})})}
```

Implement as a recursive descent parser:

```
FormulaCalculator
├── evaluate(expression, variables) → string
├── parseTree(expression) → FormulaNode
├── evaluateNode(node, variables) → string
└── functions:
    ├── Logical: equal, notEqual, greaterThan, lessThan, >=, <=, empty, notEmpty, not, and, or
    ├── Control: ifThenElse
    ├── String: substring, length, replace, position, lowercase, uppercase
    ├── Math: add, subtract, multiply, divide, power, squareRoot, absolute
    └── Date: now, yesterday, tomorrow, date, datediff, addDays, addMonths, addYears, ...
```

Counters (`GlobalCounter`, `DailyCounter`, etc.) store state in a `workflow_counters` table:

```sql
CREATE TABLE IF NOT EXISTS workflow_counters (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  counter_name VARCHAR(255) NOT NULL,
  scope_type VARCHAR(50) NOT NULL DEFAULT 'global',  -- global, user, module, user_module, daily_*
  scope_key VARCHAR(255) DEFAULT NULL,
  current_value BIGINT NOT NULL DEFAULT 0,
  last_reset_date DATE DEFAULT NULL,
  UNIQUE(counter_name, scope_type, scope_key)
);
```

### Step 1.6 — Workflow Engine Service

**File**: `apps/api/src/modules/workflow/workflow-engine.service.ts`

The orchestrator that ties conditions and actions together:

```
WorkflowEngineService
├── triggerOnSave(moduleName, record, previousRecord) → void
│   1. Query active workflows WHERE target_module = moduleName
│      AND trigger_type IN ('on_save', 'always', 'on_create')
│   2. For each workflow:
│      a. Check run-once: query workflow_processed for (workflow_id, record_id, 'complete')
│      b. Check record_selection (new/modified filters)
│      c. Evaluate conditions via ConditionEvaluator
│      d. If all pass: executeActions()
│
├── triggerScheduled() → void
│   1. Query active workflows WHERE trigger_type IN ('scheduled', 'always')
│   2. For each workflow:
│      a. Build Kysely query from conditions (SQL WHERE)
│      b. Add NOT EXISTS processed check if !repeated_runs
│      c. Execute query to get matching record IDs
│      d. For each record: executeActions()
│
├── executeActions(workflow, record, inSave) → void
│   1. Insert workflow_processed row with status='running'
│   2. Load workflow_actions ordered by display_order
│   3. For each action:
│      a. Instantiate action executor by action_type
│      b. Call execute(context)
│      c. Insert workflow_processed_actions row
│   4. Update workflow_processed status to 'complete' or 'failed'
│
└── reentrantGuard: Set<string>   // prevent infinite loops
```

**Re-entrant save prevention:**
- Use a `Set<string>` of `${workflowId}:${recordId}` keys to track in-progress executions.
- When an action modifies/creates a record and triggers a save, the engine checks this set and skips if already processing.
- Clear the set after the top-level execution completes.

### Step 1.7 — Records Service Integration (After-Save Hook)

**File**: Modify `apps/api/src/modules/records/records.service.ts`

After a record is created or updated, call the workflow engine:

```ts
// In create/update methods, after the DB write:
const previousRecord = /* fetched before update, null for create */;
await this.workflowEngine.triggerOnSave(moduleName, savedRecord, previousRecord);
```

Key points:
- Fetch the record BEFORE the update to capture `previousRecord` for change detection.
- `triggerOnSave` should be fire-and-forget (don't block the response). Use `setImmediate()` or queue to BullMQ.
- For creates, `previousRecord` is `null` — `any_change` conditions will evaluate as "changed" for all fields.

### Step 1.8 — BullMQ Scheduler Worker

**File**: `apps/api/src/modules/workflow/workflow-scheduler.worker.ts`

Set up a BullMQ repeatable job that runs `triggerScheduled()`:

```ts
// Queue setup
const workflowQueue = new Queue('workflow-scheduler', { connection: redis });

// Add repeatable job (every 1 minute)
await workflowQueue.add('process-workflows', {}, {
  repeat: { every: 60_000 },
  removeOnComplete: 100,
  removeOnFail: 500,
});

// Worker
const worker = new Worker('workflow-scheduler', async (job) => {
  await workflowEngineService.triggerScheduled();
}, { connection: redis, concurrency: 1 });
```

Use concurrency 1 to prevent overlapping runs.

---

## Phase 2: Workflow Admin API

### Step 2.1 — Workflow CRUD Controller

**File**: `apps/api/src/modules/workflow/workflow.controller.ts`

REST endpoints:

| Method | Path | Description |
|---|---|---|
| `GET` | `/api/v1/workflows` | List all workflows (with pagination, filters) |
| `GET` | `/api/v1/workflows/:id` | Get workflow with conditions + actions |
| `POST` | `/api/v1/workflows` | Create workflow |
| `PUT` | `/api/v1/workflows/:id` | Update workflow |
| `DELETE` | `/api/v1/workflows/:id` | Soft-delete workflow |
| `POST` | `/api/v1/workflows/:id/test` | Dry-run against a specific record ID |
| `GET` | `/api/v1/workflows/:id/logs` | Get processed logs for a workflow |
| `GET` | `/api/v1/workflows/modules` | List modules available for workflows |
| `GET` | `/api/v1/workflows/modules/:name/fields` | List fields for a module (for condition/action builder) |

### Step 2.2 — Workflow Service

**File**: `apps/api/src/modules/workflow/workflow.service.ts`

CRUD operations using Kysely. When saving a workflow:
1. Validate target_module exists in module_metadata
2. Validate condition field_names exist in field_metadata for the target module
3. Validate action parameters reference valid modules/fields
4. Use a transaction for workflow + conditions + actions (insert/update/delete in bulk)

### Step 2.3 — Workflow Module

**File**: `apps/api/src/modules/workflow/workflow.module.ts`

```ts
@Global()
@Module({
  controllers: [WorkflowController],
  providers: [
    WorkflowService,
    WorkflowEngineService,
    ConditionEvaluator,
    FormulaCalculator,
    ModifyRecordAction,
    CreateRecordAction,
    SendEmailAction,
    ComputeFieldAction,
  ],
  exports: [WorkflowEngineService],
})
export class WorkflowModule {}
```

Register in `app.module.ts` and inject `WorkflowEngineService` into `RecordsModule`.

---

## Phase 3: Frontend — Workflow Builder UI

### Step 3.1 — Workflow List Page

**File**: `apps/web/src/pages/admin/workflows.tsx`

- Table listing all workflows: name, target module, trigger type, status, last run.
- Toggle active/inactive status.
- Create / Edit / Delete buttons.
- Link from admin sidebar.

### Step 3.2 — Workflow Builder Page

**File**: `apps/web/src/pages/admin/workflow-builder.tsx`

A form-based builder with three sections:

#### Header Section
- Workflow name (text input)
- Target module (dropdown from `/workflows/modules`)
- Trigger type (radio: On Save, Scheduled, Always, On Create)
- Record selection (radio: All, New Records, Modified Records)
- Repeated runs (toggle)

#### Conditions Section
A dynamic list of condition rows. Each row:
- Module path (optional — dropdown to select relationship traversal)
- Field (dropdown from module fields, filtered by module path)
- Operator (dropdown, filtered by field type — numeric gets >/</>=, text gets contains/starts/ends)
- Value type (dropdown: Value, Field, Any Change, Date)
- Value (dynamic input based on value type):
  - `Value`: appropriate input for field type (text, number, date picker, enum dropdown)
  - `Field`: dropdown of same-module fields
  - `Any Change`: no value input
  - `Date`: sub-form with base/operator/amount/unit
  - `Multi`: multi-select for enum values
- Add/remove buttons

#### Actions Section
A dynamic list of action rows. Each row:
- Action type (dropdown: Modify Record, Create Record, Send Email, Compute Field)
- Action name (text input)
- Parameters (dynamic sub-form based on action type):

**Modify Record sub-form:**
- Target: "This Record" or select relationship
- Field assignments: repeatable rows of [field, value_type, value]

**Create Record sub-form:**
- Target module (dropdown)
- Relate to trigger record (toggle)
- Field assignments: repeatable rows of [field, value_type, value]

**Send Email sub-form:**
- Email template (dropdown from templates)
- Individual emails (toggle)
- Recipients: repeatable rows of [type, to/cc/bcc, value]

**Compute Field sub-form:**
- Parameters: repeatable rows of [field, raw/formatted]
- Relation parameters: repeatable rows of [relationship, field, raw/formatted]
- Formulas: repeatable rows of [target field, expression]
- Expression helper (show available functions + {P0}/{R0} variables)

### Step 3.3 — Workflow Logs Page

**File**: `apps/web/src/pages/admin/workflow-logs.tsx`

- Table of workflow_processed entries for a workflow.
- Columns: record ID (link to record), status, processed_at, error_message.
- Expandable rows showing per-action results from workflow_processed_actions.

### Step 3.4 — Hooks and State

- `useWorkflows()` — list hook with pagination
- `useWorkflow(id)` — single workflow with conditions/actions
- `useWorkflowLogs(id)` — processed logs
- `useModuleFieldsForWorkflow(module)` — fields with type info for building conditions

### Step 3.5 — Routing

Add to router:
```
/admin/workflows                → WorkflowListPage
/admin/workflows/create         → WorkflowBuilderPage
/admin/workflows/:id            → WorkflowBuilderPage (edit mode)
/admin/workflows/:id/logs       → WorkflowLogsPage
```

Add "Workflows" to admin sidebar navigation.

---

## Phase 4: Advanced Features

### Step 4.1 — OR Condition Groups

Extend condition logic beyond AND-only:
- Add `condition_group` column to `workflow_conditions` (integer, default 0)
- Conditions within the same group are AND'd
- Groups are OR'd together
- UI: "Add Condition Group" button separates groups visually

### Step 4.2 — Business Hours Support

- Create `business_hours` table: day_of_week, start_time, end_time, timezone
- Admin UI to configure business hours schedule
- Date arithmetic `business_hours` unit calculates elapsed business time

### Step 4.3 — Workflow Versioning

- Track version number on workflows
- When editing an active workflow, create a new version
- Keep history of changes for audit

### Step 4.4 — Webhook Action

Add a `webhook` action type:
- Parameters: URL, HTTP method, headers, body template
- Template variables parsed like email templates
- Timeout, retry configuration

---

## File Structure Summary

```
apps/api/src/modules/workflow/
├── workflow.module.ts
├── workflow.controller.ts          # CRUD API
├── workflow.service.ts             # CRUD operations
├── workflow-engine.service.ts      # Orchestrator
├── condition-evaluator.ts          # Condition logic
├── formula-calculator.ts           # Formula engine
├── workflow-scheduler.worker.ts    # BullMQ scheduled trigger
├── actions/
│   ├── action.interface.ts         # Common interface
│   ├── modify-record.action.ts
│   ├── create-record.action.ts
│   ├── send-email.action.ts
│   └── compute-field.action.ts
└── dto/
    ├── create-workflow.dto.ts
    ├── update-workflow.dto.ts
    └── workflow-response.dto.ts

apps/web/src/pages/admin/
├── workflows.tsx                   # List page
├── workflow-builder.tsx            # Create/edit page
└── workflow-logs.tsx               # Execution logs

apps/web/src/hooks/
├── use-workflows.ts
├── use-workflow.ts
└── use-workflow-logs.ts

packages/shared/src/types/
└── workflow.types.ts               # Shared types

apps/api/src/database/migrations/
├── 015_workflow_schema_updates.sql # Schema additions
└── 016_workflow_counters.sql       # Counter table for formulas
```

---

## Implementation Order

| # | Task | Dependencies | Effort |
|---|---|---|---|
| 1 | Shared types (`workflow.types.ts`) | None | S |
| 2 | Migration 015 (schema updates) | None | S |
| 3 | Condition evaluator | Types | M |
| 4 | Formula calculator | None | L |
| 5 | Action interface + Modify Record action | Condition evaluator | M |
| 6 | Create Record action | Action interface | M |
| 7 | Send Email action | Action interface, Email service | M |
| 8 | Compute Field action | Formula calculator, Action interface | M |
| 9 | Workflow engine service | Conditions, Actions | L |
| 10 | Records service integration (after-save) | Engine service | S |
| 11 | BullMQ scheduler worker | Engine service | S |
| 12 | Workflow CRUD controller + service | Types | M |
| 13 | Workflow module registration | Controller, Engine | S |
| 14 | Frontend: list page | CRUD API | M |
| 15 | Frontend: builder page | CRUD API, module fields API | XL |
| 16 | Frontend: logs page | Logs API | S |
| 17 | Phase 4: OR groups, business hours, versioning | Core engine | L |

**S** = small (< half day), **M** = medium (1 day), **L** = large (2-3 days), **XL** = extra large (3-5 days)

**Critical path**: 1 → 3 → 5 → 9 → 10 → 13 (core engine working end-to-end)

**Parallelizable**: Steps 3-4 can run in parallel. Steps 5-8 can be partially parallelized. Steps 12-13 can run alongside 14-16.
