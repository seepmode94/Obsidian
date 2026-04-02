# Table Sorting Audit

Date: 2026-03-20

## Scope

This document identifies which CRM tables currently do not allow users to sort values in the UI.

In this project, there are two relevant frontend paths:

1. The active entrypoint, which is still the monolithic app loaded from `apps/web/src/main.tsx`.
2. The newer routed/table-based frontend under `apps/web/src/components/views/list-view.tsx`, which is present in the repo but is not the file booted by `apps/web/index.html`.

Because of that split, this audit is divided into:

- current runtime behavior
- metadata readiness for the newer frontend

The database-backed findings below were taken from the current `luxurycrm` database after all migrations were applied, including `016_seed_workflows.sql`.

## Current Runtime Behavior

The active web app is loaded from `apps/web/index.html`, which imports `apps/web/src/main.tsx`.

- `apps/web/index.html:11` loads `/src/main.tsx`
- `apps/web/src/main.tsx:782-920` renders the main list table
- `apps/web/src/main.tsx:871-875` shows sort arrows in the header
- `apps/web/src/main.tsx:782-920` does not keep sort state, does not bind a header click handler, and does not send `sort` / `sortDir` to the API
- `apps/web/src/main.tsx:1366-1415` does the same for detail subpanels: arrows are rendered, but no sorting is implemented

### Result

In the current running UI, every CRM list table is effectively non-sortable.

That includes all visible module tables:

| Module | Database table |
|---|---|
| Accounts | accounts |
| Attendances | attendances |
| Calls | calls |
| Capabilities | capabilities |
| Cases | cases |
| Contacts | contacts |
| Contracts | contracts |
| EmailTemplates | email_templates |
| IEFPAccesses | iefp_accesses |
| Invoices | invoices |
| Leads | leads |
| Meetings | meetings |
| Notes | notes |
| Opportunities | opportunities |
| ProductCategories | product_categories |
| Products | products |
| Projects | projects |
| Quotes | quotes |
| Renewals | renewals |
| Roles | roles |
| SecurityGroups | security_groups |
| Sessions | sessions |
| Tasks | tasks |
| Trainers | trainers |
| TrainingControls | training_controls |
| Trainings | trainings |
| Users | users |

It also includes the hidden line-item modules if they are ever exposed as standalone lists:

| Module | Database table | Visible |
|---|---|---|
| ContractsLineItems | contracts_line_items | false |
| InvoicesLineItems | invoices_line_items | false |
| QuotesLineItems | quotes_line_items | false |

## Metadata Readiness For The Newer Frontend

The newer React table implementation under `apps/web/src/components/views/list-view.tsx` does support sorting, but only when the list-view metadata contains:

- `columns[].name`
- `columns[].sortable = true`

Relevant code:

- `apps/web/src/components/views/list-view.tsx:38-46` builds `sort` and passes it to the data hook
- `apps/web/src/components/views/list-view.tsx:74-116` enables sorting only when `col.sortable` is true

### Summary From The Current Database

| Category | Count |
|---|---|
| Modules with no list-view metadata | 3 |
| Modules with list columns but zero sortable columns | 3 |
| Modules with at least one sortable list column | 24 |

### Tables With No List-View Metadata

These modules have no `view_metadata` row for `view_type = 'list'`, so the newer table UI has no canonical sortable configuration for them.

| Module | Database table | Notes |
|---|---|---|
| ContractsLineItems | contracts_line_items | Hidden line-item module |
| InvoicesLineItems | invoices_line_items | Hidden line-item module |
| QuotesLineItems | quotes_line_items | Hidden line-item module |

### Tables With Zero Sortable Columns

These modules do have list-view metadata, but the definitions are in an older shape that uses `field` instead of `name` and omits `sortable`. The newer `ListView` therefore treats every column as non-sortable.

| Module | Database table | Why sorting is unavailable |
|---|---|---|
| Users | users | Legacy list-view JSON uses `field`, no `sortable` flags |
| Leads | leads | Legacy list-view JSON uses `field`, no `sortable` flags |
| Opportunities | opportunities | Legacy list-view JSON uses `field`, no `sortable` flags |

Example of the legacy shape currently stored in the database:

```json
{
  "columns": [
    { "field": "username", "width": 20 },
    { "field": "first_name", "width": 15 }
  ]
}
```

That format is compatible with the old monolith, but not with the newer `apps/web/src/components/views/list-view.tsx`, which expects:

```json
{
  "type": "list",
  "columns": [
    { "name": "username", "label": "Username", "sortable": true, "default": true }
  ]
}
```

### Tables With Specific Non-Sortable Columns

These modules are sortable overall, but some individual columns are explicitly configured as non-sortable.

| Module | Database table | Column | Label |
|---|---|---|---|
| EmailTemplates | email_templates | description | Description |
| Roles | roles | description | Description |
| SecurityGroups | security_groups | description | Description |

## Practical Interpretation

If the question is "which tables cannot be sorted by the user today in the running app", the answer is:

- all module list tables are currently non-sortable in the active UI

If the question is "which tables are not ready for sorting in the newer table implementation", the exceptions are:

- Users
- Leads
- Opportunities
- ContractsLineItems
- InvoicesLineItems
- QuotesLineItems

And these modules have one non-sortable column each:

- EmailTemplates.description
- Roles.description
- SecurityGroups.description

## SQL Used For The Audit

### 1. Summary per module

```sql
WITH list_views AS (
  SELECT vm.module_name, mm.table_name, vm.definition::jsonb AS def
  FROM view_metadata vm
  JOIN module_metadata mm ON mm.name = vm.module_name
  WHERE vm.view_type = 'list'
),
cols AS (
  SELECT module_name, table_name, jsonb_array_elements(def->'columns') AS col
  FROM list_views
)
SELECT
  module_name,
  table_name,
  COUNT(*) FILTER (WHERE COALESCE((col->>'sortable')::boolean, false)) AS sortable_columns,
  COUNT(*) FILTER (WHERE NOT COALESCE((col->>'sortable')::boolean, false)) AS non_sortable_columns
FROM cols
GROUP BY module_name, table_name
ORDER BY module_name;
```

### 2. Modules without a list view

```sql
WITH modules AS (
  SELECT name AS module_name, table_name
  FROM module_metadata
),
list_modules AS (
  SELECT DISTINCT module_name
  FROM view_metadata
  WHERE view_type = 'list'
)
SELECT m.module_name, m.table_name
FROM modules m
LEFT JOIN list_modules lv ON lv.module_name = m.module_name
WHERE lv.module_name IS NULL
ORDER BY m.module_name;
```

### 3. Explicitly non-sortable columns

```sql
WITH list_views AS (
  SELECT vm.module_name, mm.table_name, vm.definition::jsonb AS def
  FROM view_metadata vm
  JOIN module_metadata mm ON mm.name = vm.module_name
  WHERE vm.view_type = 'list'
),
cols AS (
  SELECT
    module_name,
    table_name,
    col->>'name' AS column_name,
    col->>'label' AS label,
    COALESCE((col->>'sortable')::boolean, false) AS sortable
  FROM list_views,
  jsonb_array_elements(COALESCE(def->'columns', '[]'::jsonb)) AS col
)
SELECT module_name, table_name, column_name, label
FROM cols
WHERE sortable = false
ORDER BY module_name, column_name;
```

## Recommended Next Fixes

1. If the current monolithic UI is still the supported UI, implement real sort state and API requests in `apps/web/src/main.tsx`.
2. Normalize `Users`, `Leads`, and `Opportunities` list metadata to the newer `{ name, label, sortable, default }` shape.
3. Add list views for the three line-item modules if they are expected to be navigable outside parent detail pages.
