# SuiteCRM → LuxuryCRM Migration Report

**Date:** 2026-03-23
**Source:** `seepmode_suitecrm_db_20260322.sql` (6.1 GB MySQL dump)
**Target:** LuxuryCRM PostgreSQL (`luxurycrm` database)

## Import Summary

All 6 import phases completed successfully.

### Phase 1: Users & Security

| Table | Records |
|---|---|
| users | 143 |
| roles | 26 |
| security_groups | 28 |

**Warnings:**
- 56 users have legacy SuiteCRM `$1$` password hashes (not bcrypt); they cannot log in until passwords are reset
- 9 users had no email relation and were assigned `@suitecrm.local` placeholders
- 52 ACL categories do not map to a local LuxuryCRM module yet
- 7 security-group record module names do not map locally and were skipped

### Phase 2: Base CRM Entities

| Table | Records |
|---|---|
| accounts | 76,702 |
| contacts | 109,763 |
| leads | 13 |
| opportunities | 64,443 |
| notes | 83 |
| products | 366 |
| product_categories | 20 |
| email_addresses | 71,843 |
| accounts_contacts (links) | 107,579 |
| contacts_opportunities (links) | 131 |
| email_addr_bean_rel (links) | 83,864 |

### Phase 3: Sales Documents

| Table | Records |
|---|---|
| quotes | 32,465 |
| invoices | 41,063 |
| contracts | 19,805 |
| join table rows | 32,251 |

**Warnings:**
- 79,524 line items were skipped due to missing `parent_id`, `parent_type`, or unrecognized `parent_type` value
- 297,169 non-UUID identifiers were deterministically converted to UUID v5

### Phase 4: Support & Training

| Table | Records |
|---|---|
| cases | 57,194 |
| projects | 51,535 |
| capabilities | 32,119 |
| trainings | 25,808 |
| training_controls | 139,193 |
| trainers | 4,182 |
| sessions | 2,920 |
| attendances | 165 |
| renewals | 5 |
| iefp_accesses | 5 |
| operations_centers | 34,535 |
| tasks | 745 |
| calls | 1,555 |
| meetings | 57,181 |
| join table links | 404,594 |

### Phase 5: Documents & Emails

| Table | Records |
|---|---|
| documents | 44,733 |
| emails | 84,988 |
| email_templates | 181 |
| document join links | 43,200 |
| document_revisions | 44,772 |
| outbound_email_accounts | 100 |
| aor_reports | 17 |

### Phase 6: History & Metadata

| Table | Records |
|---|---|
| workflows | 85 |
| workflow_conditions | 250 |
| workflow_actions | 96 |
| workflow_processed | 54,983 |

**Warnings:**
- 3 workflow `flow_module` values do not map to a local module and were skipped
- 14 audit/tracker tables were deferred (not imported)

## Totals

| Category | Active Records |
|---|---|
| **CRM Core** (accounts, contacts, leads, opportunities) | 250,921 |
| **Sales** (quotes, invoices, contracts) | 93,333 |
| **Support & Training** (cases, projects, capabilities, trainings, etc.) | 323,462 |
| **Activities** (calls, meetings, tasks, notes) | 59,564 |
| **Documents & Emails** | 129,721 |
| **Security & System** (users, roles, groups, workflows) | 282 |
| **Grand Total** | **~857,000+** |

## Deferred Items

The following were intentionally excluded from this migration:

- **Audit tables** (15 tables): `accounts_audit`, `contacts_audit`, `cases_audit`, etc. — deferred until a target audit model is approved
- **Tracker history**: `tracker` table — deferred
- **Line items**: 79,524 skipped due to data quality issues in `parent_type`/`parent_id`

## Schema Changes Applied

Migration `027_suitecrm_migration_columns.sql` applied the following:

- Safe cast functions: `safe_uuid()`, `safe_date()`, `safe_timestamptz()`, `safe_numeric()`
- All varchar columns on entity tables widened to `TEXT` (indexes dropped first)
- All FK constraints dropped to allow orphan references
- All CHECK constraints dropped for dirty data tolerance
- 3 new join tables: `quotes_meetings`, `quotes_tasks`, `operations_centers_documents`
- Missing columns added: `renewals` (26 cols), `iefp_accesses` (3 cols), `sessions` (1 col), `leads` (16 cols), `notes.file_url`, `quotes.approval_issue`, `invoices.type_c`/`empresa_c`, `name` on projects/capabilities/trainers/training_controls

## How to Re-run

```bash
# Full reset + import (~60 minutes)
pnpm suitecrm:reset-import

# Import specific phases only
SUITECRM_PHASES=documents-emails,history-metadata pnpm suitecrm:run
```
