# SuiteCRM To LuxuryCRM Migration Matrix

Date: 2026-03-22

Legend:

- `direct`: target table already exists with near 1:1 semantics
- `renamed`: target exists under a different name
- `transform`: target exists, but fields or joins must be reshaped
- `partial`: target exists but important source fields are not fully modeled
- `missing`: no acceptable target exists yet
- `defer`: intentionally exclude from the operational migration until a dedicated history model is approved

## Core CRM And Sales

- `accounts` -> `accounts` | `direct`
- `accounts_audit` -> `audit_log` | `defer` | source is per-module history, target is generic and not migration-ready
- `accounts_contacts` -> `accounts_contacts` | `direct`
- `accounts_cstm` -> `accounts` custom columns | `transform`
- `accounts_sdmod_capability_1_c` -> `capabilities.account_id` | `transform`
- `accounts_sdmod_training_1_c` -> `trainings.account_id` | `transform`
- `accounts_sdmod_training_control_1_c` -> `training_controls.account_id` | `transform`
- `acl_actions` -> `acl_role_actions` policy columns | `transform` | flattened permission model
- `acl_roles` -> `roles` | `renamed`
- `acl_roles_actions` -> `acl_role_actions` | `transform`
- `acl_roles_users` -> `roles_users` | `renamed`
- `aos_contracts` -> `contracts` | `renamed`
- `aos_contracts_aos_invoices_1_c` -> `invoices.contract_id` | `transform`
- `aos_contracts_audit` -> `audit_log` | `defer`
- `aos_contracts_cstm` -> `contracts` custom columns | `transform`
- `aos_invoices` -> `invoices` | `renamed`
- `aos_invoices_audit` -> `audit_log` | `defer`
- `aos_invoices_cases_1_c` -> `cases.invoice_id` | `transform`
- `aos_invoices_cstm` -> `invoices` custom columns | `transform`
- `aos_invoices_sdmod_renewals_1_c` -> `renewals.invoice_id` | `transform`
- `aos_invoices_sdmod_training_1_c` -> `trainings.invoice_id` | `transform`
- `aos_line_item_groups` -> line-item grouping in `quotes_line_items`, `invoices_line_items`, `contracts_line_items` | `transform`
- `aos_product_categories` -> `product_categories` | `renamed`
- `aos_products` -> `products` | `renamed`
- `aos_products_audit` -> `audit_log` | `defer`
- `aos_products_cstm` -> `products` custom columns | `transform`
- `aos_products_quotes` -> `quotes_line_items`, `invoices_line_items`, `contracts_line_items` | `transform`
- `aos_products_quotes_audit` -> `audit_log` | `defer`
- `aos_quotes` -> `quotes` | `renamed`
- `aos_quotes_aos_invoices_c` -> `invoices.quote_id` | `transform`
- `aos_quotes_audit` -> `audit_log` | `defer`
- `aos_quotes_calls_1_c` -> `quotes_calls` | `transform`
- `aos_quotes_cstm` -> `quotes` custom columns | `transform`
- `aos_quotes_documents_1_c` -> `quotes_documents` | `transform`
- `aos_quotes_meetings_1_c` -> `quotes_meetings` | `transform` | needs join table in LuxuryCRM if quote-meeting relation is required
- `aos_quotes_os_contracts_c` -> `quotes_contracts` | `transform`
- `aos_quotes_project_c` -> `projects_quotes` | `transform`
- `aos_quotes_tasks_1_c` -> `quotes_tasks` | `transform` | needs join table in LuxuryCRM if quote-task relation is required
- `aos_contracts_documents` -> `contracts_documents` | `renamed`
- `leads` -> `leads` | `direct`
- `leads_cstm` -> `leads` custom columns | `transform`
- `notes` -> `notes` | `direct`
- `opportunities` -> `opportunities` | `direct`
- `opportunities_cstm` -> `opportunities` custom columns | `transform`
- `opportunities_contacts` -> `contacts_opportunities` | `renamed`

## Workflow

- `aow_actions` -> `workflow_actions` | `renamed`
- `aow_conditions` -> `workflow_conditions` | `renamed`
- `aow_processed` -> `workflow_processed` | `renamed`
- `aow_workflow` -> `workflows` | `renamed`

## Activities

- `calls` -> `calls` | `direct`
- `calls_contacts` -> `calls_contacts` | `direct`
- `calls_users` -> `calls_users` | `direct`
- `cases` -> `cases` | `direct`
- `cases_audit` -> `audit_log` | `defer`
- `cases_cstm` -> `cases` custom columns | `transform`
- `contacts` -> `contacts` | `direct`
- `contacts_audit` -> `audit_log` | `defer`
- `contacts_cases` -> `cases_contacts` | `renamed`
- `contacts_cstm` -> `contacts` custom columns | `transform`
- `contacts_project_1_c` -> `projects.contact_id` | `transform`
- `contacts_sdmod_capability_1_c` -> `capabilities.contact_id` | `transform`
- `contacts_sdmod_iefp_accesses_1_c` -> `iefp_accesses.contact_id` | `transform`
- `contacts_sdmod_training_control_1_c` -> `training_controls.contact_id` | `transform`
- `contacts_sdmod_attendances_1_c` -> `attendances.contact_id` | `transform` | attendance-contact ownership link
- `contacts_users` -> `contacts_users` | `transform`
- `meetings` -> `meetings` | `direct`
- `meetings_contacts` -> `meetings_contacts` | `direct`
- `meetings_cstm` -> `meetings` custom columns | `transform`
- `meetings_users` -> `meetings_users` | `direct`
- `tasks` -> `tasks` | `direct`

## Documents And Email

- `document_revisions` -> `document_revisions` | `direct`
- `documents` -> `documents` | `direct`
- `documents_accounts` -> `accounts_documents` | `renamed`
- `documents_cases` -> `cases_documents` | `renamed`
- `documents_contacts` -> `contacts_documents` | `renamed`
- `email_addr_bean_rel` -> `email_addr_bean_rel` | `direct`
- `email_addresses` -> `email_addresses` | `direct`
- `email_addresses_audit` -> `audit_log` | `defer`
- `email_templates` -> `email_templates` | `direct`
- `emails` -> `emails` | `direct`
- `emails_beans` -> `emails_beans` | `direct`
- `emails_email_addr_rel` -> `emails_email_addr_rel` | `direct`
- `emails_text` -> `emails_text` | `direct`
- `os_reports` -> `aor_reports` | `renamed`
- `outbound_email` -> `outbound_email_accounts` | `renamed`

## Projects, Training, And Health/Safety

- `project` -> `projects` | `renamed`
- `project_cstm` -> `projects` custom columns | `transform`
- `project_documents_1_c` -> `projects_documents` | `renamed`
- `projects_cases` -> `cases_projects` | `renamed`
- `sdmod_capability` -> `capabilities` | `renamed`
- `sdmod_capability_audit` -> `audit_log` | `defer`
- `sdmod_capability_cstm` -> `capabilities` custom columns | `transform`
- `sdmod_capability_documents_1_c` -> `capabilities_documents` | `renamed`
- `sdmod_formation_trainers` -> `trainers` | `renamed`
- `sdmod_formation_trainers_audit` -> `audit_log` | `defer`
- `sdmod_formation_trainers_cstm` -> `trainers` custom columns | `partial`
- `sdmod_iefp_accesses` -> `iefp_accesses` | `renamed`
- `sdmod_iefp_accesses_cstm` -> `iefp_accesses` custom columns | `partial`
- `sdmod_operations_center` -> `operations_centers` | `renamed`
- `sdmod_operations_center_accounts_c` -> `accounts_operations_centers` | `transform`
- `sdmod_operations_center_audit` -> `audit_log` | `defer`
- `sdmod_operations_center_cstm` -> `operations_centers` custom columns | `transform`
- `sdmod_operations_center_documents_1_c` -> join not yet modeled | `partial` | needs an `operations_centers_documents` join table or equivalent
- `sdmod_renewals` -> `renewals` | `renamed`
- `sdmod_renewals_audit` -> `audit_log` | `defer`
- `sdmod_renewals_cstm` -> `renewals` custom columns | `partial`
- `sdmod_sessions` -> `sessions` | `renamed`
- `sdmod_sessions_cstm` -> `sessions` custom columns | `partial`
- `sdmod_sessions_sdmod_attendances_c` -> `attendances.session_id` | `transform`
- `sdmod_sessions_sdmod_formation_trainers_c` -> `trainers_sessions` | `renamed`
- `sdmod_sessions_sdmod_training_c` -> `sessions.training_id` | `transform`
- `sdmod_trainers` -> `trainers` | `transform` | same schema as `sdmod_formation_trainers`; merge into `trainers` with dedup by source ID
- `sdmod_trainers_cstm` -> `trainers` custom columns | `transform` | `trainer_receipt_date_c` absorbs into `receipt_date`
- `sdmod_trainers_contacts_c` -> `trainers.contact_id` | `transform`
- `sdmod_trainers_sdmod_training_c` -> `trainers.training_id` | `transform`
- `sdmod_training` -> `trainings` | `renamed`
- `sdmod_training_audit` -> `audit_log` | `defer`
- `sdmod_training_control` -> `training_controls` | `renamed`
- `sdmod_training_control_audit` -> `audit_log` | `defer`
- `sdmod_training_control_cstm` -> `training_controls` custom columns | `transform`
- `sdmod_training_cstm` -> `trainings` custom columns | `transform`
- `sdmod_training_sdmod_attendances_c` -> `attendances.training_id` | `transform`
- `sdmod_training_sdmod_trainers_c` -> `trainers.training_id` | `transform` | redundant with `sdmod_trainers_sdmod_training_c`; reconcile during load
- `sdmod_formation_trainers_sdmod_training_c` -> `trainers.training_id` | `transform`
- `sdmod_attendances_cstm` -> `attendances` custom columns | `transform`
- `sdmod_attendances_contacts_c` -> `attendances.contact_id` | `transform`
- `project_sdmod_capability_1_c` -> `capabilities.project_id` | `transform` | needs `project_id` column on `capabilities` or a join table

## Security And System Metadata

- `securitygroups` -> `security_groups` | `renamed`
- `securitygroups_acl_roles` -> `security_groups_roles` | `transform`
- `securitygroups_records` -> `security_groups_records` | `renamed`
- `securitygroups_users` -> `security_groups_users` | `renamed`
- `relationships` -> `relationship_metadata` | `partial`
- `tracker` -> `trackers` | `partial`
- `users` -> `users` | `direct`
- `users_cstm` -> `users` custom columns | `transform`

## Operational Blockers

These tables still need extra product or schema decisions before the migration can be called faithful end-to-end:

- `relationships`
- `tracker`

## Type-Casting Notes

These SuiteCRM columns use `varchar` but map to numeric or boolean targets in LuxuryCRM. Loaders must parse/cast explicitly:

- `accounts.annual_revenue` varchar(100) -> numeric
- `accounts.employees` varchar(10) -> integer
- `accounts_cstm.employees_establishment_c` varchar(10) -> integer
- `accounts_cstm.n_condutores_c` varchar(10) -> integer
- `sdmod_formation_trainers.total_amount` varchar(255) -> numeric(26,6)
- `sdmod_trainers.receipt_value` varchar(255) -> numeric(26,6)
- SuiteCRM `char(36)` UUIDs -> PostgreSQL `UUID` type; validate format before insert

## History And Audit

These tables should be treated as a separate migration track after operational parity is complete:

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
