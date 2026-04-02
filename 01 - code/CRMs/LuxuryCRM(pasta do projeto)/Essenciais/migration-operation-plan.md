# SuiteCRM To LuxuryCRM Migration Operation Plan

Date: 2026-03-22

## Objective

Migrate the business data represented by the SuiteCRM production schema listed in [tables.md](/home/guilherme/Documents/Work/IT/LuxuryCRM/documentation/suitecrm/tables.md) into LuxuryCRM with controlled loss, explicit gap handling, and repeatable tooling.

This plan assumes:

- SuiteCRM production runs at `/var/www/html/seepmode`
- SuiteCRM data lives in MySQL
- LuxuryCRM data lives in PostgreSQL
- schema changes belong in SQL migrations
- large data moves belong in idempotent `tsx` loaders, not checked-in SQL seed dumps

## Readiness Verdict

LuxuryCRM is ready for a phased migration of current operational data.

LuxuryCRM is not yet ready for a full-fidelity migration of every SuiteCRM table because the following production areas still need explicit product or migration decisions:

- lossy multi-parent joins such as `contacts_project_1_c`, `contacts_sdmod_capability_1_c`, and `aos_invoices_sdmod_training_1_c`
- raw audit/history tables such as `*_audit`
- full tracker history
- action-level ACL fidelity from `acl_actions` and `acl_roles_actions`
- full relationship metadata parity
- `project_sdmod_capability_1_c` needs a `project_id` column on `capabilities` or a dedicated join table
- `sdmod_operations_center_documents_1_c` needs an `operations_centers_documents` join table

## Guiding Rules

1. Do not import production data as giant SQL seed files, except for very small catalog-style tables.
2. Treat schema readiness and data loading as separate tracks.
3. Preserve source IDs whenever possible so reruns can be idempotent.
4. Load principal entities first, then joins, then derived/history data.
5. Produce reconciliation artifacts on every run.
6. Never depend on the full repo migration chain being healthy until the unrelated blocker in [021_google_calendar_sync.sql](/home/guilherme/Documents/Work/IT/LuxuryCRM/apps/api/src/database/migrations/021_google_calendar_sync.sql) is fixed.

## Execution Model

### Schema Readiness

Use SQL migrations under [apps/api/src/database/migrations](/home/guilherme/Documents/Work/IT/LuxuryCRM/apps/api/src/database/migrations) for:

- missing target tables
- missing target columns
- missing join tables
- missing relationship metadata
- missing indexes needed for imports or reconciliation

Do not use schema migrations to embed large operational payloads.

### Data Loading

Use `tsx` loaders under a dedicated migration harness. Recommended structure:

- `apps/api/src/database/suitecrm/config.ts`
- `apps/api/src/database/suitecrm/table-map.ts`
- `apps/api/src/database/suitecrm/staging.ts`
- `apps/api/src/database/suitecrm/load/10-users-security.ts`
- `apps/api/src/database/suitecrm/load/20-accounts-contacts.ts`
- `apps/api/src/database/suitecrm/load/30-products-sales.ts`
- `apps/api/src/database/suitecrm/load/40-support-training.ts`
- `apps/api/src/database/suitecrm/load/50-documents-emails.ts`
- `apps/api/src/database/suitecrm/load/60-history-metadata.ts`
- `apps/api/src/database/suitecrm/reconcile/10-counts.ts`
- `apps/api/src/database/suitecrm/reconcile/20-foreign-keys.ts`
- `apps/api/src/database/suitecrm/reconcile/30-samples.ts`
- `apps/api/src/database/suitecrm/run.ts`

### Staging Layout

Keep extracted production data outside git in a dated staging root:

- `tmp/suitecrm-export/<date>/raw/*.tsv`
- `tmp/suitecrm-export/<date>/normalized/*.ndjson`
- `tmp/suitecrm-export/<date>/reports/*.json`

Use lossless exports for text-heavy tables:

- TSV with hex-encoded large text fields
- NDJSON for normalized relation payloads

## Migration Phases

### Phase 0: Freeze And Snapshot

Before any bulk move:

- freeze the target branch and document the commit hash
- export row counts from every SuiteCRM source table in scope
- back up the LuxuryCRM target database
- write the exact export timestamp into the run report

### Phase 1: Schema Readiness

Complete the missing target schema first.

Required before operational import:

- apply [026_suitecrm_migration_readiness.sql](/home/guilherme/Documents/Work/IT/LuxuryCRM/apps/api/src/database/migrations/026_suitecrm_migration_readiness.sql) to absorb `users_cstm`, `meetings_cstm`, `emails_email_addr_rel`, `securitygroups_acl_roles`, `contacts_users`, quote/call relations, and `sdmod_operations_center`
- `sdmod_trainers` is resolved: it shares the same schema as `sdmod_formation_trainers` and both merge into `trainers` with dedup by source ID
- decide how to resolve lossy multi-parent joins before load code is written
- decide whether SuiteCRM `sdmod_attendances` fully replaces or only enriches local `attendances`
- decide whether `project_sdmod_capability_1_c` requires adding `project_id` to `capabilities` or creating a `projects_capabilities` join table
- decide whether `sdmod_operations_center_documents_1_c` requires creating an `operations_centers_documents` join table

### Phase 2: Identity And Security

Load in this order:

1. `users`
2. `users_cstm`
3. `acl_roles`
4. flattened `acl_actions` + `acl_roles_actions` into `acl_role_actions`
5. `acl_roles_users`
6. `securitygroups`
7. `securitygroups_users`
8. `securitygroups_records`
9. `securitygroups_acl_roles`

Validation:

- every imported user ID exists
- role-user counts match
- security group membership counts match
- every security group record points to an imported record

### Phase 3: Base CRM Entities

Load in this order:

1. `accounts` + `accounts_cstm`
2. `contacts` + `contacts_cstm`
3. `leads` + `leads_cstm`
4. `opportunities` + `opportunities_cstm`
5. `accounts_contacts`
6. `opportunities_contacts -> contacts_opportunities`
7. `email_addresses`
8. `email_addr_bean_rel`
9. `product_categories`
10. `products` + `products_cstm`
11. `notes`

Validation:

- account/contact/lead/opportunity counts match source active rows
- join rows resolve on both sides
- all absorbed custom columns land in the correct target field
- varchar-to-numeric casts succeed for `accounts.annual_revenue`, `accounts.employees`, `accounts_cstm.employees_establishment_c`, `accounts_cstm.n_condutores_c`

### Phase 4: Sales Documents

Load in this order:

1. `quotes` + `quotes_cstm`
2. `contracts` + `contracts_cstm`
3. `invoices` + `invoices_cstm`
4. transformed join relations:
   - `aos_quotes_aos_invoices_c -> invoices.quote_id`
   - `aos_quotes_os_contracts_c -> quotes_contracts`
   - `aos_contracts_aos_invoices_1_c -> invoices.contract_id`
   - `aos_quotes_project_c -> projects_quotes`
   - `aos_contracts_documents -> contracts_documents`
5. document/activity joins on quotes:
   - `aos_quotes_documents_1_c -> quotes_documents`
   - `aos_quotes_calls_1_c -> quotes_calls`
   - `aos_quotes_meetings_1_c` (requires `quotes_meetings` join table or explicit deferral)
   - `aos_quotes_tasks_1_c` (requires `quotes_tasks` join table or explicit deferral)
6. transformed support/training links:
   - `aos_invoices_cases_1_c -> cases.invoice_id`
   - `aos_invoices_sdmod_renewals_1_c -> renewals.invoice_id`
   - `aos_invoices_sdmod_training_1_c -> trainings.invoice_id`
7. line items rebuilt from:
   - `aos_products_quotes`
   - `aos_line_item_groups`

Validation:

- every quote/invoice/contract total recomputes within tolerance
- every relation row resolves to an imported parent
- every line item lands under the correct parent module
- group ordering and `group_name` survive the transformation

### Phase 5: Support And Training Domain

Load in this order:

1. `tasks`
2. `cases` + `cases_cstm`
3. `calls_contacts`
4. `projects` + `project_cstm`
5. `capabilities` + `sdmod_capability_cstm`
6. `trainings` + `sdmod_training_cstm`
7. `trainers` from `sdmod_formation_trainers` + `sdmod_formation_trainers_cstm`, merged with `sdmod_trainers` + `sdmod_trainers_cstm` (dedup by source ID; both share the same schema and target `trainers`)
8. `training_controls` + `sdmod_training_control_cstm`
9. `sessions` + `sdmod_sessions_cstm`
10. `attendances` + `sdmod_attendances_cstm`
11. `renewals` + `sdmod_renewals_cstm`
12. `iefp_accesses` + `sdmod_iefp_accesses_cstm`
13. `contacts_users`
14. `sdmod_operations_center` + `sdmod_operations_center_cstm`
15. relation transforms:
   - `contacts_cases -> cases_contacts`
   - `contacts_project_1_c -> projects.contact_id`
   - `accounts_sdmod_capability_1_c -> capabilities.account_id`
   - `contacts_sdmod_capability_1_c -> capabilities.contact_id`
   - `accounts_sdmod_training_1_c -> trainings.account_id`
   - `accounts_sdmod_training_control_1_c -> training_controls.account_id`
   - `contacts_sdmod_training_control_1_c -> training_controls.contact_id`
   - `contacts_sdmod_iefp_accesses_1_c -> iefp_accesses.contact_id`
   - `contacts_sdmod_attendances_1_c -> attendances.contact_id`
   - `projects_cases -> cases_projects`
   - `sdmod_sessions_sdmod_attendances_c -> attendances.session_id`
   - `sdmod_sessions_sdmod_formation_trainers_c -> trainers_sessions`
   - `sdmod_sessions_sdmod_training_c -> sessions.training_id`
   - `sdmod_training_sdmod_attendances_c -> attendances.training_id`
   - `sdmod_training_sdmod_trainers_c -> trainers.training_id` (reconcile with `sdmod_trainers_sdmod_training_c`)
   - `sdmod_formation_trainers_sdmod_training_c -> trainers.training_id`
   - `sdmod_trainers_contacts_c -> trainers.contact_id`
   - `sdmod_attendances_contacts_c -> attendances.contact_id`
   - `sdmod_operations_center_accounts_c -> accounts_operations_centers`

Validation:

- every training/session/trainer relation resolves
- account/contact ownership survives custom-module imports
- `sdmod_trainers` and `sdmod_formation_trainers` records are merged without ID collisions
- attendances have consistent `contact_id`, `session_id`, and `training_id` from all source join tables
- varchar-to-numeric casts succeed for `sdmod_formation_trainers.total_amount`

### Phase 6: Documents And Emails

Load in this order:

1. `documents`
2. `document_revisions`
3. document joins:
   - `documents_accounts -> accounts_documents`
   - `documents_cases -> cases_documents`
   - `documents_contacts -> contacts_documents`
   - `project_documents_1_c -> projects_documents`
   - `sdmod_capability_documents_1_c -> capabilities_documents`
   - `sdmod_operations_center_documents_1_c` (requires `operations_centers_documents` join table)
4. `emails`
5. `emails_text`
6. `emails_beans`
7. `emails_email_addr_rel` if modeled
8. `email_templates`
9. `outbound_email`

Validation:

- every document revision points to an imported document
- every email parent record resolves
- every email text row has a matching email row
- outbound account counts and sender identities match

### Phase 7: Workflow, Reports, And Metadata

Load in this order:

1. `aow_workflow -> workflows`
2. `aow_conditions -> workflow_conditions`
3. `aow_actions -> workflow_actions`
4. `aow_processed -> workflow_processed`
5. `os_reports -> aor_reports`
6. selected `relationships -> relationship_metadata`

Validation:

- workflow module names are translated to LuxuryCRM module names
- no relationship metadata points to modules that do not exist locally

### Phase 8: History And Tracker

Treat this as a separate project.

Source tables:

- `accounts_audit`
- `aos_contracts_audit`
- `aos_invoices_audit`
- `aos_products_audit`
- `aos_products_quotes_audit`
- `aos_quotes_audit`
- `cases_audit`
- `contacts_audit`
- `email_addresses_audit`
- `sdmod_capability_audit`
- `sdmod_formation_trainers_audit`
- `sdmod_operations_center_audit`
- `sdmod_renewals_audit`
- `sdmod_trainers_audit`
- `sdmod_sessions_audit`
- `sdmod_attendances_audit`
- `sdmod_training_audit`
- `sdmod_training_control_audit`
- `tracker`

Do not mix this into the main operational migration until a clear target model is approved.

## Validation And Reconciliation

Required checks for every domain:

- row-count reconciliation
- deleted-row reconciliation
- FK coverage reports
- orphan join reports
- sample record diffs
- numeric recomputation for financial modules
- relation cardinality comparison

Recommended reconciliation outputs:

- `counts.json`
- `orphans.json`
- `fk-misses.json`
- `financial-diffs.json`
- `samples.json`

## Type-Casting Requirements

SuiteCRM stores several fields as `varchar` that LuxuryCRM types as numeric or integer. Loaders must parse and cast explicitly, falling back to `NULL` on unparseable values:

- `accounts.annual_revenue` varchar(100) -> numeric
- `accounts.employees` varchar(10) -> integer
- `accounts_cstm.employees_establishment_c` varchar(10) -> integer
- `accounts_cstm.n_condutores_c` varchar(10) -> integer
- `sdmod_formation_trainers.total_amount` varchar(255) -> numeric(26,6)
- `sdmod_trainers.receipt_value` varchar(255) -> numeric(26,6)

SuiteCRM uses `char(36)` for IDs. LuxuryCRM uses PostgreSQL native `UUID`. All source IDs must be validated as RFC 4122 format before insert. Malformed IDs should be logged and skipped.

## Rollback Rules

1. Every loader runs in a database transaction per batch or per domain.
2. Every loader must be resumable by stable source ID.
3. Never delete target data unless the domain loader is explicitly running in replace mode.
4. For first live runs, load into a clean target snapshot, not into a long-lived shared environment.

## Repo Constraints

- [migrate.ts](/home/guilherme/Documents/Work/IT/LuxuryCRM/apps/api/src/database/migrate.ts) executes SQL files strictly in lexicographic order.
- The current repo has an unrelated migration blocker in [021_google_calendar_sync.sql](/home/guilherme/Documents/Work/IT/LuxuryCRM/apps/api/src/database/migrations/021_google_calendar_sync.sql).
- Existing import tooling is ad hoc and should be consolidated before large-scale migration.
- TypeScript types do not fully match the live database in every case and should not be treated as the sole source of truth during the import.

## Immediate Next Steps

1. Apply [026_suitecrm_migration_readiness.sql](/home/guilherme/Documents/Work/IT/LuxuryCRM/apps/api/src/database/migrations/026_suitecrm_migration_readiness.sql) in a disposable target database and verify it cleanly.
2. Use [migration-matrix.md](/home/guilherme/Documents/Work/IT/LuxuryCRM/documentation/suitecrm/migration-matrix.md) as the authoritative table map and keep it current as loaders land.
3. Fill the `apps/api/src/database/suitecrm/` harness phase by phase, starting with identity/security and base CRM.
4. Resolve the lossy join policy before implementing the sales/support loaders:
   - identity/security
   - accounts/contacts
   - sales/products
5. Build reconciliation scripts before the first bulk load.
