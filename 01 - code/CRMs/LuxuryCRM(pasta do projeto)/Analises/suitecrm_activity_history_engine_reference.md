# SuiteCRM Activity & History Engine — Reference & Implementation Plan

This document describes how SuiteCRM's Activity/History subpanel engine works at the code level, and how to replicate it in LuxuryCRM.

---

## Part 1: How SuiteCRM Does It

### 1.1 Core Concept — Collection Subpanels

Activities and History are **not real modules** with their own database tables. They are **virtual "collection" subpanels** — aggregate views that merge records from multiple underlying modules into a single panel.

- **Atividades (Activities)**: Upcoming/open Meetings, Calls, and Tasks
- **Histórico (History)**: Completed Meetings, Calls, Tasks, plus all Notes and Emails

The split is determined **at query time** by filtering on the `status` field. When a user marks a meeting as "Held", it disappears from Activities and appears in History — no data migration, just a different WHERE clause.

### 1.2 Subpanel Definition Structure

Each parent module (Accounts, Contacts, Cases) declares Activities and History in its `metadata/subpaneldefs.php`:

```php
// modules/Accounts/metadata/subpaneldefs.php
$layout_defs['Accounts']['subpanel_setup'] = [
    'activities' => [
        'type' => 'collection',        // <-- marks this as an aggregate subpanel
        'module' => 'Activities',       // virtual module name
        'collection_list' => [
            'tasks'    => ['module' => 'Tasks',    'subpanel_name' => 'ForActivities', 'get_subpanel_data' => 'tasks'],
            'meetings' => ['module' => 'Meetings', 'subpanel_name' => 'ForActivities', 'get_subpanel_data' => 'meetings'],
            'calls'    => ['module' => 'Calls',    'subpanel_name' => 'ForActivities', 'get_subpanel_data' => 'calls'],
        ]
    ],
    'history' => [
        'type' => 'collection',
        'module' => 'History',
        'collection_list' => [
            'tasks'    => ['module' => 'Tasks',    'subpanel_name' => 'ForHistory', 'get_subpanel_data' => 'tasks'],
            'meetings' => ['module' => 'Meetings', 'subpanel_name' => 'ForHistory', 'get_subpanel_data' => 'meetings'],
            'calls'    => ['module' => 'Calls',    'subpanel_name' => 'ForHistory', 'get_subpanel_data' => 'calls'],
            'notes'    => ['module' => 'Notes',    'subpanel_name' => 'ForHistory', 'get_subpanel_data' => 'notes'],
            'emails'   => ['module' => 'Emails',   'subpanel_name' => 'ForHistory', ...],
        ]
    ],
];
```

The engine executes **separate queries per sub-module** (each with its own WHERE clause), then **merges and sorts** the results into a single combined list.

### 1.3 Status-Based WHERE Clauses

Each sub-module has a `ForActivities.php` and `ForHistory.php` subpanel definition file that contains the WHERE filter.

#### Activities (ForActivities) — open/pending items

| Module   | WHERE clause                                                     |
|----------|------------------------------------------------------------------|
| Meetings | `meetings.status != 'Held' AND meetings.status != 'Not Held'`   |
| Calls    | `calls.status != 'Held' AND calls.status != 'Not Held'`         |
| Tasks    | `tasks.status != 'Completed' AND tasks.status != 'Deferred'`    |

#### History (ForHistory) — completed/terminal items

| Module   | WHERE clause                                                     |
|----------|------------------------------------------------------------------|
| Meetings | `meetings.status = 'Held' OR meetings.status = 'Not Held'`      |
| Calls    | `calls.status = 'Held' OR calls.status = 'Not Held'`            |
| Tasks    | `tasks.status = 'Completed' OR tasks.status = 'Deferred'`       |
| Notes    | *(no filter — all notes appear)*                                 |
| Emails   | *(no filter — all emails appear)*                                |

> **Design note**: Activities uses negation (`!= terminal`) rather than enumerating open values. This is future-proof — if a new status is added, it defaults to Activities until explicitly moved to History.

### 1.4 Status Dropdowns — Complete Values

#### `meeting_status_dom` / `call_status_dom`

| Value      | Panel      |
|------------|------------|
| `Planned`  | Activities |
| `Held`     | History    |
| `Not Held` | History    |

#### `task_status_dom`

| Value           | Panel      |
|-----------------|------------|
| `Not Started`   | Activities |
| `In Progress`   | Activities |
| `Pending Input` | Activities |
| `Completed`     | History    |
| `Deferred`      | History    |

### 1.5 Notes & Emails — Always History

Notes and Emails are **only listed in the History `collection_list`**, never in Activities. This is by design:
- Notes have **no `status` field** — they are inherently historical (a note was written, it exists)
- Emails represent sent/received communication — already happened
- Their ForHistory WHERE clause is **empty** (no filtering)

### 1.6 Relationship Patterns — How Records Link to Parents

SuiteCRM uses **two patterns simultaneously**:

#### Pattern A: Polymorphic `parent_type` / `parent_id` (flex relate)

Meetings, Calls, Tasks, Notes, and Emails all have:
```
parent_type  VARCHAR(255)   -- e.g., 'Accounts', 'Contacts', 'Cases'
parent_id    UUID           -- the parent record's ID
```

This allows **one record to link to any module** without needing separate FK columns. The relationship definition adds a role filter:

```php
'account_meetings' => [
    'lhs_module' => 'Accounts', 'lhs_key' => 'id',
    'rhs_module' => 'Meetings', 'rhs_key' => 'parent_id',
    'relationship_type' => 'one-to-many',
    'relationship_role_column' => 'parent_type',
    'relationship_role_column_value' => 'Accounts'
],
```

Effective SQL: `WHERE parent_id = :account_id AND parent_type = 'Accounts'`

Valid `parent_type` values: `Accounts`, `Contacts`, `Tasks`, `Opportunities`, `Cases`, `Leads`, `Project`, `AOS_Contracts`, `AOS_Invoices`, `AOS_Quotes`, etc.

#### Pattern B: Many-to-many join tables (for invitees)

Meetings and Calls also link to **multiple contacts/users** via join tables:

- `meetings_contacts` (`meeting_id`, `contact_id`, `required`, `accept_status`)
- `meetings_users` (`meeting_id`, `user_id`, `required`, `accept_status`)
- `calls_contacts` (`call_id`, `contact_id`, `required`, `accept_status`)
- `calls_users` (`call_id`, `user_id`, `required`, `accept_status`)

This enables a meeting to have multiple attendees while still having one primary `parent_type`/`parent_id` link.

For **Contacts**, the subpanel definition merges both patterns:
```php
'meetings' => ['get_subpanel_data' => 'meetings'],           // via meetings_contacts join table
'meetings_parent' => ['get_subpanel_data' => 'meetings_parent'], // via parent_type/parent_id
```

Tasks and Notes only use `parent_type`/`parent_id` plus an optional direct `contact_id` FK.

### 1.7 Underlying Table Schemas

#### `meetings`

| Column              | Type         | Notes                                    |
|---------------------|--------------|------------------------------------------|
| `id`                | UUID PK      |                                          |
| `name`              | VARCHAR(50)  | Subject                                  |
| `date_start`        | TIMESTAMPTZ  | Start date/time                          |
| `date_end`          | TIMESTAMPTZ  | End date/time                            |
| `duration_hours`    | SMALLINT     |                                          |
| `duration_minutes`  | SMALLINT     |                                          |
| `location`          | VARCHAR(50)  |                                          |
| `status`            | VARCHAR(25)  | `meeting_status_dom`                     |
| `type`              | VARCHAR(25)  | e.g., 'Sugar' (internal)                 |
| `parent_type`       | VARCHAR(100) | Polymorphic module name                  |
| `parent_id`         | UUID         | Polymorphic record ID                    |
| `description`       | TEXT         |                                          |
| `assigned_user_id`  | UUID FK      |                                          |
| `created_by`        | UUID FK      |                                          |
| `modified_user_id`  | UUID FK      |                                          |
| `reminder_time`     | INTEGER      | Minutes before reminder (-1 = none)      |
| `email_reminder_time` | INTEGER    |                                          |
| `email_reminder_sent` | BOOLEAN    |                                          |
| `outlook_id`        | VARCHAR(255) | External calendar sync                   |
| `repeat_type`       | VARCHAR(36)  | Recurrence: Daily, Weekly, Monthly, etc. |
| `repeat_interval`   | SMALLINT     |                                          |
| `repeat_dow`        | VARCHAR(7)   | Days of week bitmask                     |
| `repeat_until`      | DATE         |                                          |
| `repeat_count`      | SMALLINT     |                                          |
| `repeat_parent_id`  | UUID         | Links recurrence instances to parent     |
| `deleted`           | BOOLEAN      |                                          |
| `date_entered`      | TIMESTAMPTZ  |                                          |
| `date_modified`     | TIMESTAMPTZ  |                                          |

#### `calls`

| Column              | Type         | Notes                                    |
|---------------------|--------------|------------------------------------------|
| `id`                | UUID PK      |                                          |
| `name`              | VARCHAR(50)  | Subject                                  |
| `date_start`        | TIMESTAMPTZ  |                                          |
| `date_end`          | TIMESTAMPTZ  |                                          |
| `duration_hours`    | SMALLINT     |                                          |
| `duration_minutes`  | SMALLINT     |                                          |
| `status`            | VARCHAR(25)  | `call_status_dom`                        |
| `direction`         | VARCHAR(25)  | `Inbound` / `Outbound`                  |
| `parent_type`       | VARCHAR(100) |                                          |
| `parent_id`         | UUID         |                                          |
| `description`       | TEXT         |                                          |
| `assigned_user_id`  | UUID FK      |                                          |
| `created_by`        | UUID FK      |                                          |
| `modified_user_id`  | UUID FK      |                                          |
| `reminder_time`     | INTEGER      |                                          |
| `email_reminder_time` | INTEGER    |                                          |
| `email_reminder_sent` | BOOLEAN    |                                          |
| `outlook_id`        | VARCHAR(255) |                                          |
| `repeat_type`       | VARCHAR(36)  |                                          |
| `repeat_interval`   | SMALLINT     |                                          |
| `repeat_dow`        | VARCHAR(7)   |                                          |
| `repeat_until`      | DATE         |                                          |
| `repeat_count`      | SMALLINT     |                                          |
| `repeat_parent_id`  | UUID         |                                          |
| `deleted`           | BOOLEAN      |                                          |
| `date_entered`      | TIMESTAMPTZ  |                                          |
| `date_modified`     | TIMESTAMPTZ  |                                          |

#### `tasks`

| Column              | Type         | Notes                                    |
|---------------------|--------------|------------------------------------------|
| `id`                | UUID PK      |                                          |
| `name`              | VARCHAR(50)  | Subject                                  |
| `date_start`        | TIMESTAMPTZ  |                                          |
| `date_due`          | TIMESTAMPTZ  |                                          |
| `date_start_flag`   | BOOLEAN      | "No start date" flag                     |
| `date_due_flag`     | BOOLEAN      | "No due date" flag                       |
| `status`            | VARCHAR(25)  | `task_status_dom`                        |
| `priority`          | VARCHAR(25)  | `High`, `Medium`, `Low`                  |
| `parent_type`       | VARCHAR(100) |                                          |
| `parent_id`         | UUID         |                                          |
| `contact_id`        | UUID FK      | Direct contact link                      |
| `description`       | TEXT         |                                          |
| `assigned_user_id`  | UUID FK      |                                          |
| `created_by`        | UUID FK      |                                          |
| `modified_user_id`  | UUID FK      |                                          |
| `deleted`           | BOOLEAN      |                                          |
| `date_entered`      | TIMESTAMPTZ  |                                          |
| `date_modified`     | TIMESTAMPTZ  |                                          |

#### `notes`

| Column              | Type         | Notes                                    |
|---------------------|--------------|------------------------------------------|
| `id`                | UUID PK      |                                          |
| `name`              | VARCHAR(255) | Subject/title                            |
| `description`       | TEXT         | Body                                     |
| `parent_type`       | VARCHAR(255) |                                          |
| `parent_id`         | UUID         |                                          |
| `contact_id`        | UUID FK      | Direct contact link                      |
| `filename`          | VARCHAR(255) | Attachment filename                      |
| `file_mime_type`    | VARCHAR(100) |                                          |
| `portal_flag`       | BOOLEAN      |                                          |
| `embed_flag`        | BOOLEAN      |                                          |
| `assigned_user_id`  | UUID FK      |                                          |
| `created_by`        | UUID FK      |                                          |
| `modified_user_id`  | UUID FK      |                                          |
| `deleted`           | BOOLEAN      |                                          |
| `date_entered`      | TIMESTAMPTZ  |                                          |
| `date_modified`     | TIMESTAMPTZ  |                                          |

### 1.8 Which Parent Modules Get Activities/History

| Parent Module  | Activities subpanel | History subpanel |
|----------------|:-------------------:|:----------------:|
| Accounts       | Yes                 | Yes              |
| Contacts       | Yes                 | Yes              |
| Cases          | Yes                 | Yes              |
| Opportunities  | Yes                 | Yes              |
| Leads          | Yes                 | Yes              |
| AOS_Quotes     | Yes (partial*)      | Yes (partial*)   |

> *AOS_Quotes uses direct subpanels for Tarefas, Telefonemas, Reuniões rather than the collection pattern — they show all statuses together.

---

## Part 2: Implementation Plan for LuxuryCRM

### 2.1 What Needs to Be Built

| Layer | Component | Description |
|-------|-----------|-------------|
| **Database** | Tables | `meetings`, `calls`, `tasks`, `notes` + join tables |
| **Database** | Metadata | module_metadata, field_metadata, view_metadata, relationship_metadata rows |
| **Database** | Dropdowns | `meeting_status_dom`, `call_status_dom`, `task_status_dom`, `call_direction_dom`, `task_priority_dom` |
| **Database** | Seed data | Sample meetings, calls, tasks, notes |
| **Shared** | Types | Kysely types for new tables |
| **Backend** | Collection subpanel support | New concept in MetadataService — return collection subpanel definitions |
| **Backend** | Filtered related records | Support status-based filtering on the `getRelated` endpoint |
| **Backend** | Polymorphic relations | Support `parent_type`/`parent_id` pattern in RecordsService |
| **Frontend** | Collection subpanel component | New component that queries multiple modules and merges results |
| **Frontend** | Activity/History rendering | Unified table with module-type indicator column |

### 2.2 Database Migration

#### Step 1: Create tables

```sql
-- ─── MEETINGS ───────────────────────────────────────────────────────────────
CREATE TABLE meetings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  date_start TIMESTAMPTZ,
  date_end TIMESTAMPTZ,
  duration_hours SMALLINT DEFAULT 0,
  duration_minutes SMALLINT DEFAULT 0,
  location VARCHAR(255),
  status VARCHAR(25) DEFAULT 'Planned',
  type VARCHAR(25) DEFAULT 'Sugar',
  parent_type VARCHAR(100),
  parent_id UUID,
  description TEXT,
  assigned_user_id UUID REFERENCES users(id),
  created_by UUID REFERENCES users(id),
  modified_user_id UUID REFERENCES users(id),
  reminder_time INTEGER DEFAULT -1,
  deleted BOOLEAN DEFAULT FALSE,
  date_entered TIMESTAMPTZ DEFAULT NOW(),
  date_modified TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_meetings_parent ON meetings(parent_type, parent_id) WHERE deleted = FALSE;
CREATE INDEX idx_meetings_status ON meetings(status) WHERE deleted = FALSE;
CREATE INDEX idx_meetings_assigned ON meetings(assigned_user_id) WHERE deleted = FALSE;
CREATE INDEX idx_meetings_date_start ON meetings(date_start) WHERE deleted = FALSE;

-- ─── CALLS ──────────────────────────────────────────────────────────────────
CREATE TABLE calls (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  date_start TIMESTAMPTZ,
  date_end TIMESTAMPTZ,
  duration_hours SMALLINT DEFAULT 0,
  duration_minutes SMALLINT DEFAULT 0,
  status VARCHAR(25) DEFAULT 'Planned',
  direction VARCHAR(25) DEFAULT 'Outbound',
  parent_type VARCHAR(100),
  parent_id UUID,
  description TEXT,
  assigned_user_id UUID REFERENCES users(id),
  created_by UUID REFERENCES users(id),
  modified_user_id UUID REFERENCES users(id),
  reminder_time INTEGER DEFAULT -1,
  deleted BOOLEAN DEFAULT FALSE,
  date_entered TIMESTAMPTZ DEFAULT NOW(),
  date_modified TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_calls_parent ON calls(parent_type, parent_id) WHERE deleted = FALSE;
CREATE INDEX idx_calls_status ON calls(status) WHERE deleted = FALSE;
CREATE INDEX idx_calls_assigned ON calls(assigned_user_id) WHERE deleted = FALSE;
CREATE INDEX idx_calls_date_start ON calls(date_start) WHERE deleted = FALSE;

-- ─── TASKS ──────────────────────────────────────────────────────────────────
CREATE TABLE tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  date_start TIMESTAMPTZ,
  date_due TIMESTAMPTZ,
  date_start_flag BOOLEAN DEFAULT FALSE,
  date_due_flag BOOLEAN DEFAULT FALSE,
  status VARCHAR(25) DEFAULT 'Not Started',
  priority VARCHAR(25) DEFAULT 'Medium',
  parent_type VARCHAR(100),
  parent_id UUID,
  contact_id UUID REFERENCES contacts(id),
  description TEXT,
  assigned_user_id UUID REFERENCES users(id),
  created_by UUID REFERENCES users(id),
  modified_user_id UUID REFERENCES users(id),
  deleted BOOLEAN DEFAULT FALSE,
  date_entered TIMESTAMPTZ DEFAULT NOW(),
  date_modified TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_tasks_parent ON tasks(parent_type, parent_id) WHERE deleted = FALSE;
CREATE INDEX idx_tasks_status ON tasks(status) WHERE deleted = FALSE;
CREATE INDEX idx_tasks_assigned ON tasks(assigned_user_id) WHERE deleted = FALSE;
CREATE INDEX idx_tasks_date_due ON tasks(date_due) WHERE deleted = FALSE;

-- ─── NOTES ──────────────────────────────────────────────────────────────────
CREATE TABLE notes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  parent_type VARCHAR(100),
  parent_id UUID,
  contact_id UUID REFERENCES contacts(id),
  filename VARCHAR(255),
  file_mime_type VARCHAR(100),
  assigned_user_id UUID REFERENCES users(id),
  created_by UUID REFERENCES users(id),
  modified_user_id UUID REFERENCES users(id),
  deleted BOOLEAN DEFAULT FALSE,
  date_entered TIMESTAMPTZ DEFAULT NOW(),
  date_modified TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_notes_parent ON notes(parent_type, parent_id) WHERE deleted = FALSE;

-- ─── JOIN TABLES (Meeting/Call invitees) ────────────────────────────────────
CREATE TABLE meetings_contacts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  meeting_id UUID NOT NULL REFERENCES meetings(id),
  contact_id UUID NOT NULL REFERENCES contacts(id),
  required VARCHAR(25) DEFAULT 'true',
  accept_status VARCHAR(25) DEFAULT 'none',
  date_modified TIMESTAMPTZ DEFAULT NOW(),
  deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE meetings_users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  meeting_id UUID NOT NULL REFERENCES meetings(id),
  user_id UUID NOT NULL REFERENCES users(id),
  required VARCHAR(25) DEFAULT 'true',
  accept_status VARCHAR(25) DEFAULT 'none',
  date_modified TIMESTAMPTZ DEFAULT NOW(),
  deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE calls_contacts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  call_id UUID NOT NULL REFERENCES calls(id),
  contact_id UUID NOT NULL REFERENCES contacts(id),
  required VARCHAR(25) DEFAULT 'true',
  accept_status VARCHAR(25) DEFAULT 'none',
  date_modified TIMESTAMPTZ DEFAULT NOW(),
  deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE calls_users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  call_id UUID NOT NULL REFERENCES calls(id),
  user_id UUID NOT NULL REFERENCES users(id),
  required VARCHAR(25) DEFAULT 'true',
  accept_status VARCHAR(25) DEFAULT 'none',
  date_modified TIMESTAMPTZ DEFAULT NOW(),
  deleted BOOLEAN DEFAULT FALSE
);
```

#### Step 2: Dropdowns

```sql
-- meeting_status_dom
INSERT INTO dropdown_lists (id, name, module) VALUES
  (gen_random_uuid(), 'meeting_status_dom', NULL);

INSERT INTO dropdown_items (id, dropdown_list_id, value, label, display_order)
SELECT gen_random_uuid(), dl.id, v.value, v.label, v.ord
FROM dropdown_lists dl,
(VALUES
  ('Planned',  'Planeada',    1),
  ('Held',     'Realizada',   2),
  ('Not Held', 'Não Realizada', 3)
) AS v(value, label, ord)
WHERE dl.name = 'meeting_status_dom';

-- call_status_dom
INSERT INTO dropdown_lists (id, name, module) VALUES
  (gen_random_uuid(), 'call_status_dom', NULL);

INSERT INTO dropdown_items (id, dropdown_list_id, value, label, display_order)
SELECT gen_random_uuid(), dl.id, v.value, v.label, v.ord
FROM dropdown_lists dl,
(VALUES
  ('Planned',  'Planeada',    1),
  ('Held',     'Realizada',   2),
  ('Not Held', 'Não Realizada', 3)
) AS v(value, label, ord)
WHERE dl.name = 'call_status_dom';

-- task_status_dom
INSERT INTO dropdown_lists (id, name, module) VALUES
  (gen_random_uuid(), 'task_status_dom', NULL);

INSERT INTO dropdown_items (id, dropdown_list_id, value, label, display_order)
SELECT gen_random_uuid(), dl.id, v.value, v.label, v.ord
FROM dropdown_lists dl,
(VALUES
  ('Not Started',   'Não Iniciada',   1),
  ('In Progress',   'Em Curso',       2),
  ('Pending Input', 'Aguarda Info',   3),
  ('Completed',     'Concluída',      4),
  ('Deferred',      'Adiada',         5)
) AS v(value, label, ord)
WHERE dl.name = 'task_status_dom';

-- call_direction_dom
INSERT INTO dropdown_lists (id, name, module) VALUES
  (gen_random_uuid(), 'call_direction_dom', NULL);

INSERT INTO dropdown_items (id, dropdown_list_id, value, label, display_order)
SELECT gen_random_uuid(), dl.id, v.value, v.label, v.ord
FROM dropdown_lists dl,
(VALUES
  ('Inbound',  'Recebida',  1),
  ('Outbound', 'Efetuada',  2)
) AS v(value, label, ord)
WHERE dl.name = 'call_direction_dom';

-- task_priority_dom
INSERT INTO dropdown_lists (id, name, module) VALUES
  (gen_random_uuid(), 'task_priority_dom', NULL);

INSERT INTO dropdown_items (id, dropdown_list_id, value, label, display_order)
SELECT gen_random_uuid(), dl.id, v.value, v.label, v.ord
FROM dropdown_lists dl,
(VALUES
  ('High',   'Alta',   1),
  ('Medium', 'Média',  2),
  ('Low',    'Baixa',  3)
) AS v(value, label, ord)
WHERE dl.name = 'task_priority_dom';
```

### 2.3 Backend Changes

#### 2.3.1 Extend `SubpanelDefinition` type

The current `SubpanelDefinition` supports simple one-module subpanels. We need a new `type` field:

```typescript
// packages/shared/src/types/module.types.ts
export interface SubpanelDefinition {
  name: string;
  module: string;
  titleKey: string;
  relationship: string;
  order: number;
  visible: boolean;
  columns: string[];
  type?: 'standard' | 'collection';           // NEW
  collectionList?: CollectionSubpanelEntry[];  // NEW
}

export interface CollectionSubpanelEntry {
  module: string;                              // e.g., 'Meetings'
  relationship: string;                        // relationship name
  statusFilter?: {                             // status-based WHERE
    field: string;                             // 'status'
    operator: 'in' | 'not_in';
    values: string[];                          // e.g., ['Held', 'Not Held']
  };
}
```

#### 2.3.2 Extend `MetadataService` — inject collection subpanels

When building subpanels for Accounts, Contacts, or Cases, the metadata service should inject the Activities and History collection definitions. This can be a hardcoded mapping since the Activity/History pattern is a known, fixed engine behavior:

```typescript
// In metadata.service.ts — after building standard subpanels
const ACTIVITY_HISTORY_PARENTS = ['Accounts', 'Contacts', 'Cases'];

if (ACTIVITY_HISTORY_PARENTS.includes(moduleName)) {
  subpanels.push({
    name: 'activities',
    module: 'Activities',
    titleKey: 'Atividades',
    relationship: '__collection__',
    order: -20,  // show first
    visible: true,
    columns: ['name', 'status', 'date_start', 'assigned_user_name', '__module_type__'],
    type: 'collection',
    collectionList: [
      {
        module: 'Meetings',
        relationship: `${tableName}_meetings`,
        statusFilter: { field: 'status', operator: 'not_in', values: ['Held', 'Not Held'] },
      },
      {
        module: 'Calls',
        relationship: `${tableName}_calls`,
        statusFilter: { field: 'status', operator: 'not_in', values: ['Held', 'Not Held'] },
      },
      {
        module: 'Tasks',
        relationship: `${tableName}_tasks`,
        statusFilter: { field: 'status', operator: 'not_in', values: ['Completed', 'Deferred'] },
      },
    ],
  });

  subpanels.push({
    name: 'history',
    module: 'History',
    titleKey: 'Histórico',
    relationship: '__collection__',
    order: -10,  // show second
    visible: true,
    columns: ['name', 'status', 'date_start', 'assigned_user_name', '__module_type__'],
    type: 'collection',
    collectionList: [
      {
        module: 'Meetings',
        relationship: `${tableName}_meetings`,
        statusFilter: { field: 'status', operator: 'in', values: ['Held', 'Not Held'] },
      },
      {
        module: 'Calls',
        relationship: `${tableName}_calls`,
        statusFilter: { field: 'status', operator: 'in', values: ['Held', 'Not Held'] },
      },
      {
        module: 'Tasks',
        relationship: `${tableName}_tasks`,
        statusFilter: { field: 'status', operator: 'in', values: ['Completed', 'Deferred'] },
      },
      {
        module: 'Notes',
        relationship: `${tableName}_notes`,
        // no statusFilter — all notes are history
      },
    ],
  });
}
```

#### 2.3.3 Extend `RecordsService` — polymorphic relation support

The current `getRelated` method assumes FK-based or join-table relationships. For the `parent_type`/`parent_id` pattern, add a new relationship type:

```typescript
// In records.service.ts — getRelated method
if (relationship.type === 'polymorphic') {
  // Query: SELECT * FROM meetings
  //        WHERE parent_id = :parentId
  //        AND parent_type = :parentModule
  //        AND deleted = false
  let query = this.db
    .selectFrom(relatedTable)
    .selectAll()
    .where('parent_id', '=', parentId)
    .where('parent_type', '=', parentModuleName)
    .where('deleted', '=', false);

  // Apply status filter if provided
  if (statusFilter) {
    if (statusFilter.operator === 'in') {
      query = query.where('status', 'in', statusFilter.values);
    } else {
      query = query.where('status', 'not in', statusFilter.values);
    }
  }

  return query.orderBy('date_start', 'desc').offset(offset).limit(perPage).execute();
}
```

#### 2.3.4 New API endpoint for collection subpanels

Add a dedicated endpoint that queries multiple modules and merges results:

```
GET /api/v1/records/:module/:id/collection/:collectionName
    ?page=1&perPage=10
```

The handler iterates the `collectionList`, runs parallel queries per sub-module, merges results, sorts by `date_start DESC` (or `date_modified DESC`), paginates the merged set, and adds a `__module_type__` field to each record so the frontend can show an icon/badge.

### 2.4 relationship_metadata Entries

These use the polymorphic pattern. We need to extend `relationship_metadata` with a `role_column` and `role_value` or handle polymorphic relationships differently.

**Option A — Add columns to `relationship_metadata`**:

```sql
ALTER TABLE relationship_metadata
  ADD COLUMN role_column VARCHAR(100),
  ADD COLUMN role_value VARCHAR(100);
```

Then insert:

```sql
INSERT INTO relationship_metadata (id, name, rel_type, lhs_module, lhs_key, rhs_module, rhs_key, role_column, role_value, custom, date_entered) VALUES
  -- Accounts
  (gen_random_uuid(), 'accounts_meetings', 'polymorphic', 'Accounts', 'id', 'Meetings', 'parent_id', 'parent_type', 'Accounts', FALSE, NOW()),
  (gen_random_uuid(), 'accounts_calls',    'polymorphic', 'Accounts', 'id', 'Calls',    'parent_id', 'parent_type', 'Accounts', FALSE, NOW()),
  (gen_random_uuid(), 'accounts_tasks',    'polymorphic', 'Accounts', 'id', 'Tasks',    'parent_id', 'parent_type', 'Accounts', FALSE, NOW()),
  (gen_random_uuid(), 'accounts_notes',    'polymorphic', 'Accounts', 'id', 'Notes',    'parent_id', 'parent_type', 'Accounts', FALSE, NOW()),

  -- Contacts
  (gen_random_uuid(), 'contacts_meetings', 'polymorphic', 'Contacts', 'id', 'Meetings', 'parent_id', 'parent_type', 'Contacts', FALSE, NOW()),
  (gen_random_uuid(), 'contacts_calls',    'polymorphic', 'Contacts', 'id', 'Calls',    'parent_id', 'parent_type', 'Contacts', FALSE, NOW()),
  (gen_random_uuid(), 'contacts_tasks',    'polymorphic', 'Contacts', 'id', 'Tasks',    'parent_id', 'parent_type', 'Contacts', FALSE, NOW()),
  (gen_random_uuid(), 'contacts_notes',    'polymorphic', 'Contacts', 'id', 'Notes',    'parent_id', 'parent_type', 'Contacts', FALSE, NOW()),

  -- Cases
  (gen_random_uuid(), 'cases_meetings',    'polymorphic', 'Cases', 'id', 'Meetings', 'parent_id', 'parent_type', 'Cases', FALSE, NOW()),
  (gen_random_uuid(), 'cases_calls',       'polymorphic', 'Cases', 'id', 'Calls',    'parent_id', 'parent_type', 'Cases', FALSE, NOW()),
  (gen_random_uuid(), 'cases_tasks',       'polymorphic', 'Cases', 'id', 'Tasks',    'parent_id', 'parent_type', 'Cases', FALSE, NOW()),
  (gen_random_uuid(), 'cases_notes',       'polymorphic', 'Cases', 'id', 'Notes',    'parent_id', 'parent_type', 'Cases', FALSE, NOW()),

  -- Contacts many-to-many (invitees)
  (gen_random_uuid(), 'meetings_contacts', 'many-to-many', 'Meetings', 'id', 'Contacts', 'id', NULL, FALSE, NOW()),
  (gen_random_uuid(), 'calls_contacts',    'many-to-many', 'Calls',    'id', 'Contacts', 'id', NULL, FALSE, NOW());
```

Update join_table for the many-to-many ones:
```sql
UPDATE relationship_metadata SET join_table = 'meetings_contacts' WHERE name = 'meetings_contacts';
UPDATE relationship_metadata SET join_table = 'calls_contacts' WHERE name = 'calls_contacts';
```

**Option B — Keep `relationship_metadata` unchanged, handle polymorphic in code**:

Instead of adding columns, treat any relationship where `rhs_key = 'parent_id'` as polymorphic and infer `parent_type` from `lhs_module`. This avoids a schema change but is less explicit.

**Recommendation**: Option A — explicit is better. The schema change is small and makes the pattern first-class.

### 2.5 Frontend Changes

#### 2.5.1 Collection Subpanel Component

Create `apps/web/src/components/views/collection-subpanel.tsx`:

```typescript
// Pseudocode
function CollectionSubpanel({ parentModule, parentId, subpanelDef }) {
  // Query the collection endpoint
  const { data } = useCollectionRecords(parentModule, parentId, subpanelDef.name);

  // Each record has __module_type__ to show icon/badge
  return (
    <SubpanelCard title={subpanelDef.titleKey}>
      <table>
        <thead>
          <tr>
            <th>Tipo</th>        {/* Module icon: 📅 Meeting, 📞 Call, ✅ Task, 📝 Note */}
            <th>Assunto</th>     {/* name */}
            <th>Estado</th>      {/* status */}
            <th>Data</th>        {/* date_start or date_entered */}
            <th>Atribuído a</th> {/* assigned_user_name */}
          </tr>
        </thead>
        <tbody>
          {data.records.map(record => (
            <tr key={record.id}>
              <td><ModuleIcon type={record.__module_type__} /></td>
              <td><Link to={`/${record.__module_type__}/${record.id}`}>{record.name}</Link></td>
              <td>{record.status}</td>
              <td>{formatDate(record.date_start)}</td>
              <td>{record.assigned_user_name}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </SubpanelCard>
  );
}
```

#### 2.5.2 Update Detail View

In `detail-view.tsx`, detect `type: 'collection'` subpanels and render the collection component:

```typescript
{subpanel.type === 'collection'
  ? <CollectionSubpanel ... />
  : <Subpanel ... />
}
```

### 2.6 Implementation Order

1. **Update source-of-truth docs** — add Meetings, Calls, Tasks, Notes to `module_field_nature.md`, `module_relations.md`, `module_views.md`
2. **Migration** — create tables, indexes, dropdowns, module_metadata, field_metadata, view_metadata, relationship_metadata
3. **Shared types** — add Kysely types for new tables, extend `SubpanelDefinition`
4. **Backend — polymorphic support** — extend `RecordsService.getRelated` for `parent_type`/`parent_id`
5. **Backend — collection endpoint** — new endpoint that queries multiple modules with status filters and merges
6. **Backend — metadata injection** — `MetadataService` injects Activities/History collection subpanels for eligible parent modules
7. **Frontend — collection subpanel** — new component that renders merged, sorted results with module-type badges
8. **Frontend — detail view** — conditional rendering for collection vs standard subpanels
9. **Seed data** — sample meetings, calls, tasks, notes linked to existing accounts/contacts
10. **i18n** — Portuguese labels for all new fields and dropdowns

### 2.7 Key Design Decisions to Make

| Decision | Options | Recommendation |
|----------|---------|----------------|
| Polymorphic support in schema | (A) Add `role_column`/`role_value` to relationship_metadata, (B) Infer from `rhs_key = 'parent_id'` | **A** — explicit, avoids ambiguity |
| Collection subpanel definition | (A) Hardcoded in MetadataService, (B) Stored in DB | **A first, B later** — start simple, the set of collection subpanels is small and stable |
| Merge/sort strategy | (A) Backend merges all sub-queries, (B) Frontend merges parallel API calls | **A** — backend merge gives correct pagination and total counts |
| Emails module | Include now or defer | **Defer** — Emails are complex (threading, IMAP sync). Meetings, Calls, Tasks, Notes are sufficient for MVP |
| Recurrence fields on meetings/calls | Include full repeat_* columns or simplify | **Include** — schema cost is low, enables future calendar features |

---

## Part 3: Quick Reference — The Activity/History Rule

```
┌─────────────────────────────────────────────────────┐
│                   ATIVIDADES                         │
│  Meetings  WHERE status NOT IN ('Held','Not Held')  │
│  Calls     WHERE status NOT IN ('Held','Not Held')  │
│  Tasks     WHERE status NOT IN ('Completed','Deferred') │
├─────────────────────────────────────────────────────┤
│                    HISTÓRICO                         │
│  Meetings  WHERE status IN ('Held','Not Held')      │
│  Calls     WHERE status IN ('Held','Not Held')      │
│  Tasks     WHERE status IN ('Completed','Deferred') │
│  Notes     (all — no filter)                         │
│  Emails    (all — no filter)                         │
└─────────────────────────────────────────────────────┘

Status change on a record → automatic shift between panels.
No data migration. Query-time filter only.
```

---

## Part 4: Calendar Module — SuiteCRM Reference

### 4.1 Architecture — Virtual Module, No Table

The Calendar is a **virtual module with no database table**. It reads from `meetings`, `calls`, and `tasks` and renders them on a time grid. Key source files in SuiteCRM:

| File | Purpose |
|------|---------|
| `modules/Calendar/Calendar.php` | Core class — holds `activityList`, date range, `load_activities()` / `add_activities()` |
| `modules/Calendar/CalendarActivity.php` | Normalizes a Meeting/Call/Task bean into a unified event with `start_time` and `end_time` |
| `modules/Calendar/CalendarUtils.php` | Date helpers, recurring event expansion, save/delete of repeat sequences |
| `modules/Calendar/CalendarDisplay.php` | Rendering engine — assigns module-specific colors, feeds FullCalendar.js |
| `modules/Calendar/controller.php` | AJAX actions: `getActivities`, `saveactivity`, `reschedule` (drag-drop), `resize`, `remove` |
| `modules/Calendar/fullcalendar/` | Bundled FullCalendar.js library |

### 4.2 Data Sources — The `activityList`

The Calendar class defines which modules provide events:

```php
public $activityList = [
    "FP_events" => ["showCompleted" => true, "start" => "date_start", "end" => "date_end"],
    "Meetings"  => ["showCompleted" => true, "start" => "date_start", "end" => "date_end"],
    "Calls"     => ["showCompleted" => true, "start" => "date_start", "end" => "date_end"],
    "Tasks"     => ["showCompleted" => true, "start" => "date_due",   "end" => "date_due"],
];
```

Each entry maps a module to its start/end date fields and a `showCompleted` flag (user-configurable).

### 4.3 How Events Are Fetched

The data flow:

1. `CalendarController::action_getActivities()` → creates `Calendar`, calls `add_activities($user)` → `load_activities()`
2. `Calendar::add_activities()` delegates to `CalendarActivity::get_activities()` which iterates `activityList`
3. For each module, it calls `build_related_list_by_user_id()` from `include/utils/activity_utils.php`

**The SQL differs by module:**

#### Meetings & Calls — queried via join table by user

```sql
SELECT meetings.* FROM meetings_users, meetings
WHERE (meetings.date_start >= :range_start AND meetings.date_start < :range_end)
   OR (meetings.date_start < :range_start AND meetings.date_end > :range_start)
  AND meetings_users.accept_status != 'decline'
  AND meetings_users.meeting_id = meetings.id
  AND meetings_users.user_id = :user_id
  AND meetings.deleted = 0
  AND meetings_users.deleted = 0
```

The OR clause handles **multi-day events** that started before the visible range but extend into it.

#### Tasks — queried by `assigned_user_id` (no join table)

```sql
SELECT tasks.* FROM tasks
WHERE tasks.date_due >= :range_start AND tasks.date_due < :range_end
  AND tasks.assigned_user_id = :user_id
  AND tasks.deleted = 0
```

### 4.4 Which Records Appear on the Calendar

| Module   | Fields used for time                    | Default visibility | "Hide completed" filter                        |
|----------|-----------------------------------------|-------------------|------------------------------------------------|
| Meetings | `date_start` → `date_end`              | All statuses      | `AND meetings.status = 'Planned'`              |
| Calls    | `date_start` → `date_end`              | All statuses      | `AND calls.status = 'Planned'`                 |
| Tasks    | `date_due` (point-in-time, no range)   | All statuses      | `AND tasks.status != 'Completed'`              |

- **By default, ALL records show** (including Held meetings, Completed tasks)
- User preference `show_completed` (defaults `true`) controls the filter
- User preferences `show_calls` and `show_tasks` toggle entire modules on/off
- Meetings/Calls where user's `accept_status = 'decline'` are **always hidden**

### 4.5 CalendarActivity — The Normalization Layer

`CalendarActivity` wraps any SugarBean into a uniform `{ start_time, end_time }` structure:

```php
class CalendarActivity {
    public $sugar_bean;   // the original Meeting/Call/Task bean
    public $start_time;   // SugarDateTime
    public $end_time;     // SugarDateTime
}
```

Normalization rules:
- **Meetings/Calls**: `start_time = date_start`, `end_time = date_start + duration_hours + duration_minutes`
- **Tasks**: `start_time = date_start (if set) or date_due`, `end_time = date_due` (point event)

After normalization, `Calendar::load_activities()` flattens each `CalendarActivity` into a JSON-ready structure with: `module_name`, `type`, `record` (id), `name`, `description`, `duration_hours`, `duration_minutes`, `timestamp`, `time_start`, `ts_start`, `ts_end`, `days`, `related_to`, `detail` (url), `edit` (url).

### 4.6 Calendar Views

| View | Description |
|------|-------------|
| `agendaDay` | Single day with timeslots |
| `basicDay` | Compact single day |
| `agendaWeek` | Week with timeslots (default) |
| `basicWeek` | Compact week |
| `month` | Full month grid |
| `sharedWeek` | Multi-user week view |
| `sharedMonth` | Multi-user month view |

Time slot granularity: Day = 15min, Week = 30min, Month = 60min (configurable).

All views rendered by **FullCalendar.js** on the client. The server provides JSON data via the `getActivities` AJAX action.

### 4.7 Shared Calendar / Multi-User

SuiteCRM supports viewing other users' calendars:

```php
public $shared_ids = array(); // IDs of users for shared view

// In action_getActivities:
if ($cal->view == 'shared') {
    $cal->init_shared();
    foreach ($cal->shared_ids as $member) {
        $sharedUser->retrieve($member);
        $cal->add_activities($sharedUser);  // fetch each user's events
    }
}
```

- Selected user IDs persist in user preferences between sessions
- `calendar_display_shared_separate` preference: show in separate columns or merged
- User picker rendered via `get_user_array()`

### 4.8 Recurring Events

Recurring meetings/calls are **expanded into individual database records at creation time** — no on-the-fly expansion.

Recurrence fields (on `meetings` and `calls`):

| Field | Type | Description |
|-------|------|-------------|
| `repeat_type` | VARCHAR(36) | `Daily`, `Weekly`, `Monthly`, `Yearly` |
| `repeat_interval` | SMALLINT | e.g., every 2 weeks |
| `repeat_dow` | VARCHAR(7) | Day-of-week bitmask for Weekly (e.g., `"024"` = Sun, Tue, Thu) |
| `repeat_until` | DATE | End date |
| `repeat_count` | SMALLINT | Number of occurrences |
| `repeat_parent_id` | UUID | Links child instances to the parent meeting |
| `recurring_source` | VARCHAR(36) | `"Sugar"` for internally created |

The flow:
1. `CalendarUtils::build_repeat_sequence()` generates datetime array from recurrence rule
2. `CalendarUtils::save_repeat_activities()` clones the parent bean for each occurrence, sets `repeat_parent_id`, adjusts dates, bulk-copies invitees
3. Max limit: `calendar.max_repeat_count` config (default 1000)
4. "Edit all recurrences" deletes all children and recreates them
5. Deleting the parent promotes the next child via `CalendarUtils::correctRecurrences()`

**Tasks do NOT support recurrence** — only Meetings and Calls.

### 4.9 External Calendar Sync (iCal / vCal)

SuiteCRM exposes three integration layers:

#### a) vCal Free/Busy Server

- Endpoint: `vcal_server.php` (WebDAV protocol)
- Publishes RFC-compliant `FREEBUSY` data for Outlook/Exchange
- Queries Meetings and Calls via `CalendarActivity::get_activities()`
- Caches results in the `vcals` database table

#### b) iCal Server

- Endpoint: `ical_server.php`
- Generates full `VCALENDAR` with:
  - `VEVENT` for Meetings and Calls (includes `LOCATION`, `ATTENDEE` with `PARTSTAT`)
  - `VTODO` for Tasks (includes `DUE`, `PRIORITY` mapping: High=1, Medium=5, Low=9, `PERCENT-COMPLETE`)
  - `VTIMEZONE` with daylight/standard transitions
- Query params: `?hide_calls=true`, `?show_tasks_as_events=true`
- Used for one-way subscribe from external calendars

#### c) CalendarSync Framework (modern)

- Provider-based design: `CalendarProviderRegistry` → `AbstractCalendarProvider`
- `MeetingCalendarSyncLogicHook` fires on Meeting save/delete
- Uses `gsync_id` and `gsync_lastsync` fields for bidirectional Google Calendar sync
- Sync jobs processed via scheduler queue

### 4.10 Calendar vs Activities Subpanel — No Shared Code

These are **completely separate systems** that query the same underlying tables:

| Aspect | Calendar | Activities Subpanel |
|--------|----------|---------------------|
| Query scope | By **user** + **date range** | By **parent record** (Account, Contact, etc.) |
| Data source | `meetings_users`/`calls_users` join tables + `tasks.assigned_user_id` | `parent_type`/`parent_id` polymorphic relation |
| Status filter | Optional "hide completed" preference | Mandatory Activity vs History split |
| Display | Time grid (FullCalendar.js) | Table rows in a subpanel |
| Purpose | "What do I have scheduled?" | "What activity is linked to this record?" |

---

## Part 5: Calendar Implementation Plan for LuxuryCRM

### 5.1 What the Calendar Needs

The Calendar consumes the same `meetings`, `calls`, and `tasks` tables proposed in Part 2. No additional database tables are required — the Calendar is a **read-only view layer** over existing data.

### 5.2 Backend — Calendar API Endpoint

Add a new endpoint that returns events for a user within a date range:

```
GET /api/v1/calendar?start=2026-03-01&end=2026-03-31&userId=:id
    &showCompleted=true&showCalls=true&showTasks=true
```

Response: array of normalized calendar events:

```typescript
interface CalendarEvent {
  id: string;
  moduleType: 'Meetings' | 'Calls' | 'Tasks';
  title: string;                    // name field
  start: string;                    // ISO 8601
  end: string;                      // ISO 8601
  allDay: boolean;                  // true for tasks with no time
  status: string;
  parentType?: string;              // related module
  parentId?: string;                // related record
  parentName?: string;              // related record name
  assignedUserId: string;
  assignedUserName: string;
  // Module-specific extras
  location?: string;                // meetings only
  direction?: string;               // calls only
  priority?: string;                // tasks only
  color?: string;                   // module-specific color
}
```

#### Backend query logic (Kysely pseudocode)

```typescript
async getCalendarEvents(userId: string, start: Date, end: Date, options: CalendarOptions) {
  const events: CalendarEvent[] = [];

  // Meetings — via meetings_users join table
  let meetingsQuery = this.db
    .selectFrom('meetings')
    .innerJoin('meetings_users', 'meetings_users.meeting_id', 'meetings.id')
    .selectAll('meetings')
    .where('meetings_users.user_id', '=', userId)
    .where('meetings_users.accept_status', '!=', 'decline')
    .where('meetings_users.deleted', '=', false)
    .where('meetings.deleted', '=', false)
    .where((eb) => eb.or([
      // Starts within range
      eb.and([
        eb('meetings.date_start', '>=', start),
        eb('meetings.date_start', '<', end),
      ]),
      // Started before but extends into range (multi-day)
      eb.and([
        eb('meetings.date_start', '<', start),
        eb('meetings.date_end', '>', start),
      ]),
    ]));

  if (!options.showCompleted) {
    meetingsQuery = meetingsQuery.where('meetings.status', '=', 'Planned');
  }

  // Calls — same pattern via calls_users
  // ...

  // Tasks — via assigned_user_id (no join table)
  let tasksQuery = this.db
    .selectFrom('tasks')
    .selectAll()
    .where('assigned_user_id', '=', userId)
    .where('deleted', '=', false)
    .where('date_due', '>=', start)
    .where('date_due', '<', end);

  if (!options.showCompleted) {
    tasksQuery = tasksQuery.where('status', '!=', 'Completed');
  }

  // Execute all in parallel, normalize, merge, sort by start
  const [meetings, calls, tasks] = await Promise.all([...]);

  return [
    ...meetings.map(m => normalizeEvent(m, 'Meetings')),
    ...calls.map(c => normalizeEvent(c, 'Calls')),
    ...(options.showTasks ? tasks.map(t => normalizeEvent(t, 'Tasks')) : []),
  ].sort((a, b) => a.start.localeCompare(b.start));
}
```

#### Normalization rules

```typescript
function normalizeEvent(row: any, moduleType: string): CalendarEvent {
  if (moduleType === 'Tasks') {
    return {
      id: row.id,
      moduleType: 'Tasks',
      title: row.name,
      start: row.date_start || row.date_due,  // fallback to date_due
      end: row.date_due,
      allDay: !row.date_start,                 // task without start time = all-day marker
      status: row.status,
      priority: row.priority,
      // ...
    };
  }
  // Meetings/Calls: end = date_end, or compute from duration
  const end = row.date_end || addMinutes(row.date_start, row.duration_hours * 60 + row.duration_minutes);
  return {
    id: row.id,
    moduleType,
    title: row.name,
    start: row.date_start,
    end,
    allDay: false,
    status: row.status,
    location: row.location,    // meetings
    direction: row.direction,  // calls
    // ...
  };
}
```

### 5.3 Shared Calendar Support

Add an optional `userIds` query param to fetch events for multiple users:

```
GET /api/v1/calendar?start=...&end=...&userIds=id1,id2,id3
```

Each event in the response includes `assignedUserId` and `assignedUserName`, so the frontend can color-code or group by user. No additional backend logic beyond iterating the user list.

### 5.4 Frontend — Calendar Page

Use **FullCalendar React** (`@fullcalendar/react`) — the same library SuiteCRM uses, but with the modern React wrapper.

```
pnpm add @fullcalendar/react @fullcalendar/daygrid @fullcalendar/timegrid @fullcalendar/interaction
```

#### Calendar page component (pseudocode)

```tsx
// apps/web/src/pages/calendar.tsx
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';

function CalendarPage() {
  const { user } = useAuth();
  const [dateRange, setDateRange] = useState({ start: ..., end: ... });
  const [options, setOptions] = useState({
    showCompleted: true, showCalls: true, showTasks: true,
  });

  const { data: events } = useCalendarEvents(user.id, dateRange, options);

  // Map to FullCalendar event format
  const fcEvents = events?.map(e => ({
    id: e.id,
    title: e.title,
    start: e.start,
    end: e.end,
    allDay: e.allDay,
    color: MODULE_COLORS[e.moduleType],  // e.g., Meetings=#3174ad, Calls=#51a351, Tasks=#f0ad4e
    extendedProps: { moduleType: e.moduleType, status: e.status, ...e },
  }));

  return (
    <div>
      <CalendarToolbar options={options} onOptionsChange={setOptions} />
      <FullCalendar
        plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
        initialView="timeGridWeek"
        headerToolbar={{
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay',
        }}
        events={fcEvents}
        datesSet={(info) => setDateRange({ start: info.startStr, end: info.endStr })}
        eventClick={(info) => navigateToRecord(info.event.extendedProps)}
        editable={true}                    // enable drag-drop
        eventDrop={(info) => reschedule(info)}   // PATCH meeting/call date
        eventResize={(info) => resize(info)}     // PATCH duration
        slotMinTime="07:00:00"
        slotMaxTime="20:00:00"
        locale="pt"
      />
    </div>
  );
}
```

#### Module color coding

| Module   | Color   | Label        |
|----------|---------|--------------|
| Meetings | Blue    | Reuniões     |
| Calls    | Green   | Telefonemas  |
| Tasks    | Orange  | Tarefas      |

#### Toolbar options

- Toggle visibility: Reuniões / Telefonemas / Tarefas (checkboxes)
- Toggle "Mostrar concluídos" (show completed)
- User picker for shared calendar view

### 5.5 Drag-and-Drop Reschedule

When a user drags an event to a new time slot, call:

```
PATCH /api/v1/records/:moduleType/:id
Body: { date_start: "...", date_end: "..." }
```

The existing `RecordsService.update()` handles this — no new endpoint needed.

For event resize (changing duration):

```
PATCH /api/v1/records/:moduleType/:id
Body: { date_end: "...", duration_hours: N, duration_minutes: N }
```

### 5.6 Quick Create from Calendar

Clicking an empty time slot should open a quick-create dialog pre-filled with:
- `date_start` = clicked time
- `date_end` = clicked time + default duration (1h for meetings, 15min for calls)
- Module selector: Reunião / Telefonema / Tarefa

This uses the existing `RecordsService.create()` endpoint.

### 5.7 iCal Export (Future)

Add an endpoint for external calendar subscription:

```
GET /api/v1/calendar/ical/:userId/:token
```

Returns a `VCALENDAR` document with:
- `VEVENT` for Meetings and Calls
- `VTODO` for Tasks
- `VTIMEZONE` for the user's timezone

The `:token` is a per-user calendar token (not the JWT) so the URL can be pasted into Google Calendar / Outlook without auth headers.

### 5.8 Implementation Order (Calendar-Specific)

The Calendar depends on the Meetings/Calls/Tasks tables from Part 2. After those are in place:

1. **Backend — calendar endpoint** (`GET /api/v1/calendar`) with user + date range query
2. **Frontend — install FullCalendar** React packages
3. **Frontend — CalendarPage component** with day/week/month views
4. **Frontend — route** — add `/calendar` route in TanStack Router
5. **Frontend — nav** — add "Calendário" to sidebar navigation
6. **Frontend — event click** — navigate to Meeting/Call/Task detail view
7. **Frontend — drag-drop** — reschedule via PATCH
8. **Frontend — quick create** — click empty slot to create new event
9. **Shared calendar** — user picker + multi-user query
10. **iCal export** — future phase

### 5.9 Key Difference: Calendar vs Activities Subpanel

These are **independent systems** that read the same tables with different query strategies:

| Aspect | Calendar | Activities Subpanel |
|--------|----------|---------------------|
| **Query dimension** | By **user** + **date range** | By **parent record** (Account, Contact) |
| **Data source** | `meetings_users`/`calls_users` join tables + `tasks.assigned_user_id` | `parent_type`/`parent_id` polymorphic FK |
| **Status filter** | Optional "hide completed" toggle | Mandatory Activity vs History split |
| **Display** | Time grid (FullCalendar.js) | Table rows in a subpanel |
| **User question** | "What do I have scheduled?" | "What activity is linked to this record?" |
| **Shared code** | None in SuiteCRM | None in SuiteCRM |

In LuxuryCRM, both the Calendar endpoint and the collection subpanel endpoint will query the same `meetings`, `calls`, `tasks` tables — but through **different access patterns** (user-based vs record-based). The `meetings_users`/`calls_users` join tables are used **only by the Calendar** (and invitee management). The `parent_type`/`parent_id` columns are used **only by subpanels**.

```
┌──────────────────────────────────────────────────────────────────┐
│                   SHARED TABLES                                  │
│         meetings  ·  calls  ·  tasks  ·  notes                   │
├──────────────────────┬───────────────────────────────────────────┤
│   CALENDAR           │   ACTIVITIES / HISTORY SUBPANELS          │
│                      │                                           │
│  Query by:           │  Query by:                                │
│  · user (join table) │  · parent_type + parent_id                │
│  · date range        │  · status IN / NOT IN                     │
│                      │                                           │
│  "My schedule"       │  "This record's linked activity"          │
└──────────────────────┴───────────────────────────────────────────┘
```
