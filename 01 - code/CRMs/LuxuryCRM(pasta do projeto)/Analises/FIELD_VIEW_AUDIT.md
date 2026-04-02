# Field & View Alignment Audit

Cross-reference of the source-of-truth documents (`module_field_nature.md`, `module_views.md`) against the actual codebase (migrations, seed data, frontend field rendering).

---

## CRITICAL: Module Name Mismatches (Migration 014 vs 011/009)

Migration 014 (`dropdowns_field_types_i18n.sql`) attempts to UPDATE field types to `enum` and set `options_name`, but uses **SuiteCRM-style module names** that don't match the names used when the fields were created in migrations 009 and 011.

| Migration 014 uses | Actual module_name in DB | Result |
|---|---|---|
| `AOS_Quotes` | `Quotes` | **All UPDATEs fail — 0 rows affected** |
| `AOS_Invoices` | `Invoices` | **All UPDATEs fail — 0 rows affected** |
| `AOS_Contracts` | `Contracts` | **All UPDATEs fail — 0 rows affected** |
| `Project` | `Projects` | **All UPDATEs fail — 0 rows affected** |
| `sdmod_training` | `Trainings` | **All UPDATEs fail — 0 rows affected** |
| `sdmod_capability` | `Capabilities` | **All UPDATEs fail — 0 rows affected** |
| `sdmod_Training_control` | `TrainingControls` | **All UPDATEs fail — 0 rows affected** |
| `Accounts` | `Accounts` | OK |
| `Contacts` | `Contacts` | OK |
| `Cases` | `Cases` | OK |

**Impact**: All dropdown/enum fields in Quotes, Invoices, Contracts, Projects, Trainings, Capabilities, and TrainingControls remain as `varchar` — they render as plain text inputs instead of dropdowns.

---

## 1. Fields That Should Be Dropdowns But Render as Plain Text

### 1.1 Quotes (Propostas) — ALL dropdown fields broken

| Field | Source of Truth Type | DB field_type | Expected Dropdown | Status |
|---|---|---|---|---|
| `stage` | `enum` | `varchar` | `quote_stage_dom` | BROKEN — plain text |
| `invoice_status` | `enum` | `varchar` | `quote_invoice_status_dom` | BROKEN — plain text |
| `term` | `enum` | `varchar` | `quote_term_dom` | BROKEN — plain text |
| `approval_status` | `enum` | `varchar` | `approval_status_dom` | BROKEN — plain text |
| `empresa_c` | `enum` | `varchar` | `empresa_list` | BROKEN — plain text |

### 1.2 Invoices (Faturas) — ALL dropdown fields broken

| Field | Source of Truth Type | DB field_type | Expected Dropdown | Status |
|---|---|---|---|---|
| `type_c` | `enum` | `varchar` | `type_invoice` | BROKEN — plain text |
| `payment_reminder_c` | `enum` | `boolean` | `yes_no_list` | BROKEN — renders as toggle, should be Yes/No dropdown |
| `status` | `enum` | `varchar` | `invoice_status_dom` | BROKEN — plain text |
| `empresa_c` | `enum` | `varchar` | `empresa_list` | BROKEN — plain text |

### 1.3 Contracts (Contratos) — ALL dropdown fields broken

| Field | Source of Truth Type | DB field_type | Expected Dropdown | Status |
|---|---|---|---|---|
| `anuidade_c` | `enum` | `varchar` | `anuidade_list` | BROKEN — plain text |
| `pack_c` | `enum` | `varchar` | `pack_list` | BROKEN — plain text |
| `pack_state_c` | `enum` | `varchar` | `contracts_status_list` | BROKEN — plain text |
| `empresa_c` | `enum` | `varchar` | `empresa_list` | BROKEN — plain text |

### 1.4 Projects / Medicina Ocupacional — ALL dropdown fields broken

| Field | Source of Truth Type | DB field_type | Expected Dropdown | Status |
|---|---|---|---|---|
| `medicine_exam_type_c` | `enum` | `varchar` | `exam_type_list` | BROKEN — plain text |
| `attendances_c` | `enum` | `varchar` | `attendances_list` | BROKEN — plain text |
| `medical_appreciation_c` | `enum` | `varchar` | `medical_appreciation_list` | BROKEN — plain text |

### 1.5 Trainings (Formações) — ALL dropdown fields broken

| Field | Source of Truth Type | DB field_type | Expected Dropdown | Status |
|---|---|---|---|---|
| `status` | `enum` | `varchar` | `campaign_status_dom` | BROKEN — plain text |
| `nutsii_c` | `enum` | `varchar` | `nutsii_list` | BROKEN — plain text |
| `formation_check_checkbox_c` | `enum` | `varchar` | `yes_no_list` | BROKEN — plain text |

### 1.6 Capabilities (Fichas de Aptidão) — ALL dropdown fields broken

| Field | Source of Truth Type | DB field_type | Expected Dropdown | Status |
|---|---|---|---|---|
| `service_organization_c` | `enum` | `varchar` | `service_organization_list` | BROKEN — plain text |
| `service_organization_name_c` | `enum` | `varchar` | `service_organization_name_c_list` | BROKEN — plain text |
| `service_organization_nipc_c` | `enum` | `varchar` | `service_organization_nipc_c_list` | BROKEN — plain text |
| `sexo_c` | `enum` | `varchar` | `sexo_c_list` | BROKEN — plain text |
| `analise_posto_trabalho_c` | `enum` | `varchar` | `yes_no_list` | BROKEN — plain text |
| `fatores_risco_pro_c` | `enum` | `varchar` | `yes_no_list` | BROKEN — plain text |
| `exposicao_profissional_c` | `enum` | `varchar` | `yes_no_list` | BROKEN — plain text |
| `ability_result_c` | `enum` | `varchar` | `medical_appreciation_list` | BROKEN — plain text |
| `exam_type_c` | `enum` | `varchar` | `exam_type_list` | BROKEN — plain text |
| `recommendations_c` | `multienum` | `varchar` | `recommendations_list` | BROKEN — plain text |

### 1.7 TrainingControls (Formandos) — ALL dropdown fields broken

| Field | Source of Truth Type | DB field_type | Expected Dropdown | Status |
|---|---|---|---|---|
| `training_types_c` | `enum` | `varchar` | `training_types_list` | BROKEN — plain text |
| `candidature_status_c` | `enum` | `varchar` | `candidature_status_list` | BROKEN — plain text |

### 1.8 Contacts — Mostly OK (migration 014 matches module name)

| Field | Source of Truth Type | DB field_type (after 014) | Status |
|---|---|---|---|
| `nutsii_c` | `enum` | `enum` ✓ | OK |
| `marital_status_c` | `enum` | `enum` ✓ | OK |
| `contact_gender_c` | `enum` | `enum` ✓ | OK |
| `literary_abilities_c` | `enum` | `enum` ✓ | OK |
| `contacts_adr_c` | `enum` | `enum` ✓ | OK |
| `contact_type_c` | `multienum` | `multienum` ✓ | OK |
| `lead_source` | `enum` | `enum` ✓ | OK |

### 1.9 Accounts — Mostly OK (migration 014 matches module name)

| Field | Source of Truth Type | DB field_type (after 014) | Status |
|---|---|---|---|
| `nutsii_c` | `dynamicenum` | `enum` ✓ | OK (dynamicenum mapped to enum) |
| `place_of_visit_c` | `dynamicenum` | `enum` ✓ | OK |
| `account_type` | `enum` | `enum` ✓ | OK |
| `industry` | `enum` | `enum` ✓ | OK |
| `client_service_type_c` | `enum` | `enum` ✓ | OK |

### 1.10 Cases — Mostly OK (migration 014 matches module name)

| Field | Source of Truth Type | DB field_type (after 014) | Status |
|---|---|---|---|
| `mode_c` | `enum` | `enum` ✓ | OK |
| `send_receive_c` | `enum` | `enum` ✓ | OK |
| `area_c` | `enum` | `enum` ✓ | OK |
| `billing_address_country` | `enum` | `enum` ✓ | OK |
| `billing_address_state` | `dynamicenum` | `enum` ✓ | OK |
| `priority` | `enum` | `enum` ✓ | OK |
| `code_c` | `enum` | `enum` ✓ | OK |
| `status` | `enum` | `enum` ✓ | OK |

**Summary**: 42 dropdown fields are broken across 7 modules. Only Accounts, Contacts, and Cases have working dropdowns.

---

## 2. Fields With Wrong Data Types (beyond dropdowns)

### Cases

| Field | Source of Truth Type | DB field_type | Issue |
|---|---|---|---|
| `inspectio_simulaction_c` | `bool` | `varchar` | Should be boolean toggle, renders as text |
| `who_contacted_c` | `relate` (→ Contacts) | `varchar` | Should be relate picker, renders as text |
| `opened_by_c` | `relate` (→ Users) | `varchar` | Should be relate picker, renders as text |
| `closed_by_c` | `relate` (→ Users) | `varchar` | Should be relate picker, renders as text |
| `units_c` | `int` | `varchar` | Should be number input, renders as text |
| `service_date_c` | `datetimecombo` | `date` | Minor — date is acceptable |

### Projects (Medicina Ocupacional)

| Field | Source of Truth Type | DB field_type | Issue |
|---|---|---|---|
| `blood_test_c` | `bool` | `varchar` | Should be boolean toggle |
| `ecg_c` | `bool` | `varchar` | Should be boolean toggle |
| `urine_tests_c` | `bool` | `varchar` | Should be boolean toggle |
| `rx_torax_c` | `bool` | `varchar` | Should be boolean toggle |
| `stool_analyzes_c` | `bool` | `varchar` | Should be boolean toggle |
| `ophthalmologi_tracking_c` | `bool` | `varchar` | Should be boolean toggle |
| `glycaemia_analyses_c` | `bool` | `varchar` | Should be boolean toggle |
| `cholesterol_analyses_c` | `bool` | `varchar` | Should be boolean toggle |
| `audiometry_c` | `bool` | `varchar` | Should be boolean toggle |
| `spirometry_c` | `bool` | `varchar` | Should be boolean toggle |
| `estimated_start_date` | `datetimecombo` | `date` | Minor — date is acceptable |
| `attendance_date_c` | `datetimecombo` | not seeded | Missing field |

### Invoices

| Field | Source of Truth Type | DB field_type | Issue |
|---|---|---|---|
| `legal_pack_c` | `bool` | `varchar` | Should be boolean toggle |

### Contacts

| Field | Source of Truth Type | DB field_type | Issue |
|---|---|---|---|
| `ultimo_exame_c` | `varchar` (source) | `date` | Seed uses `date`, source says `varchar` — verify intent |
| `proximo_exame_c` | `varchar` (source) | `date` | Same as above |

---

## 3. Missing Fields (in source of truth but not seeded in DB)

### Accounts — Missing custom fields

| Missing Field | Source of Truth Type | Notes |
|---|---|---|
| `email1` | `varchar` (email widget) | Not in seed.ts or migration 011 |
| `phone_alternate` | `phone` | Added in 011 as `varchar`, not typed as `phone` |

### Contacts — Missing fields

| Missing Field | Source of Truth Type |
|---|---|
| `birth_village_c` | Present in Detail View (module_views.md) but not in field_metadata |
| `birth_county_c` | Present in Edit View (module_views.md) but not in field_metadata |

### Quotes — Missing source-of-truth fields

| Missing Field | Source of Truth Type | Notes |
|---|---|---|
| `billing_contact` | `relate` | Source says relate to Contacts |
| `billing_address_city` | `varchar` | Used in table/filter views |
| `billing_address_state` | `varchar` | Used in filter views |

### Cases — Missing fields

| Missing Field | Source of Truth Type | Notes |
|---|---|---|
| `phone_office` | derived | Used in table view, likely from related Account |
| `billing_address_city` | derived | Used in table view, likely from related Account |

### Projects — Missing fields

| Missing Field | Source of Truth Type |
|---|---|
| `attendance_date_c` | `datetimecombo` |
| `nome_do_medico_c` | `varchar` |
| `n_cedula_profissional_c` | `varchar` |
| `medic_signature_c` | `varchar` |
| `am_projecttemplates_project_1_name` | `relate` |
| `override_business_hours` | `bool` |

### Trainings — Missing fields

Large number of fields from source of truth not seeded. Migration 011 does not create field_metadata for Trainings at all (only seed data in 013). Need to verify if field_metadata exists for this module.

### Formadores, Sessões, Formandos — Similar gaps likely

These modules' field_metadata may also be incomplete in migration 011.

---

## 4. View Definition vs Source of Truth Misalignments

### Accounts

**Source of truth table view** has 15 columns including `sic_code`, `employees`, `industry`, `place_of_visit_c`, `employees_establishment_c`, `n_condutores_c`, `ownership`, `ticker_symbol`.

**Actual seeded list view** (seed.ts) has 6 columns: `name`, `billing_address_city`, `billing_address_country`, `phone_office`, `assigned_user_id`, `date_modified`.

**Missing from list view**: `sic_code`, `employees`, `industry`, `billing_address_state`, `place_of_visit_c`, `employees_establishment_c`, `n_condutores_c`, `ownership`, `ticker_symbol`, `date_entered`, `assigned_user_name`.

**Source of truth edit/detail panels** use `lbl_account_information`, `LBL_PANEL_ADVANCED`, `LBL_PANEL_ASSIGNMENT` panel keys.

**Actual seeded panels** use `Overview`, `More Information`, `Billing Address`, `Shipping Address`, `Description`.

**Missing from edit/detail**: `nutsii_c`, `place_of_visit_c`, `n_condutores_c`, `accounts_cae_c`, `employees_establishment_c`, `client_service_type_c`, `send_payment_reminder_c`, `phone_alternate`, `email1`.

> Note: Migration 012 may have replaced these views. Check if 012 aligns with source of truth.

### Contacts

**Source of truth table view** has 9 columns including `contact_type_c`, `department`, `email1`, `date_entered`.

**Actual seeded list view** (seed.ts) has 6 columns: `first_name`, `last_name`, `title`, `account_id`, `email1`, `phone_work`.

**Missing from list view**: `name` (combined), `contact_type_c`, `department`, `assigned_user_name`, `date_entered`.

**Source of truth edit view** has many custom fields in panel `lbl_contact_information`: `data_de_admissao_c`, `sessao_c`, `profissao_c`, `cc_number_c`, `cc_expiration_date_c`, `vat_number_c`, `nutsii_c`, `marital_status_c`, `contact_nationality_c`, `contact_gender_c`, `contacts_adr_c`, `contact_type_c`, `literary_abilities_c`, `tipo_de_recurso_c`, `numero_do_beneficiario_c`, `ultimo_exame_c`, `proximo_exame_c`.

**Actual seeded edit view** only has basic fields in `Overview` panel. None of the custom `_c` fields are in the view layout.

### Quotes, Invoices, Contracts

Migration 012 rewrites all views for these modules. The alignment of 012's view definitions against the source of truth needs to be verified, but given the module name mismatch issues, the field types referenced in views may not work correctly even if the layouts match.

---

## 5. Frontend Field Renderer Gaps

The `FieldRenderer` component (`apps/web/src/components/fields/field-renderer.tsx`) handles these types:

| Type | Handling | Status |
|---|---|---|
| `varchar`, `fullname`, `id` | VarcharField | OK |
| `text`, `html` | TextField | OK |
| `int`, `float`, `decimal` | Inline number input | OK |
| `currency` | CurrencyField | OK (but hardcoded USD) |
| `boolean` | BooleanField | OK |
| `date` | DateField | OK |
| `datetime` | DateField + showTime | OK |
| `enum`, `radioenum` | EnumField (dropdown) | OK |
| `multienum` | Inline multi-select | OK (basic HTML select) |
| `email` | EmailField | OK |
| `phone` | PhoneField | OK |
| `url` | UrlField | OK |
| `relate`, `flex_relate` | RelateField | OK |
| `image`, `file` | Inline | OK |
| `password` | Inline | OK |

**Unhandled types (fall through to plain text):**

| Type | Source of Truth Usage | Impact |
|---|---|---|
| `dynamicenum` | Accounts: `nutsii_c`, `place_of_visit_c`; Cases: `billing_address_state` | Falls to varchar. Mitigated IF migration 014 converts to `enum` (works for Accounts/Cases) |
| `name` | Used as primary name field on most modules | Falls to default VarcharField — acceptable behavior |
| `datetimecombo` | Trainings: `formation_date`, `end_date_c`; Cases: `service_date_c`; Projects: `estimated_start_date`, `attendance_date_c` | Falls to varchar — should be datetime |
| `address` (composite) | Not currently used in field_metadata | N/A for now |
| `multirelate` | Not currently used | N/A for now |
| `calculated` | Not currently used | N/A for now |

### CurrencyField Issues

- Hardcoded to **USD** (`Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' })`).
- Source of truth indicates **EUR (€)** for all currency fields (labels like "Valor (€)", "Valor Líquido €").
- No integration with the `currencies` table or `currency_id` field.

### MultiEnum Issues

- Uses basic HTML `<select multiple>` — not a proper multi-select component.
- No search/filter capability for large option lists.
- Poor UX compared to the EnumField's Shadcn Select component.

---

## 6. Duplicate Field Definitions

Migration 009 creates fields with simplified names, then migration 011 adds fields with SuiteCRM `_c` suffix names for the same concepts:

### Contracts

| Migration 009 field | Migration 011 field | Same concept |
|---|---|---|
| `annuity` (varchar) | `anuidade_c` (varchar) | Annuity |
| `pack` (varchar) | `pack_c` (varchar) | Pack |
| `pack_status` (varchar) | `pack_state_c` (varchar) | Pack State |
| `company` (varchar) | `empresa_c` (varchar) | Company |
| `net_value` (currency) | `net_value_c` (currency) | Net Value |
| `renewal_date` (date) | `renewal_date_c` (date) | Renewal Date |

### Quotes

| Migration 009 field | Migration 011 field | Same concept |
|---|---|---|
| `approval_status` (varchar) | — | Approval status (only 009 version) |
| `invoice_status` (varchar) | — | Invoice status (only 009 version) |
| `company` (varchar) | `empresa_c` (varchar) | Company |

### Invoices

| Migration 009 field | Migration 011 field | Same concept |
|---|---|---|
| `type` (varchar) | — | Type (no _c duplicate, but `type_c` referenced in 014) |
| `company` (varchar) | `empresa_c` (varchar) | Company |
| `auto_email_reminder` (boolean) | `payment_reminder_c` (boolean) | Payment reminder |

**Impact**: Views may reference one name while data is stored under the other. The source of truth uses the `_c` suffix names.

---

## 7. Label/Internationalization Issues

### Seed.ts uses English labels

All field_metadata labels in `seed.ts` are in English (e.g., "Account Name", "Office Phone", "Industry"), while the source of truth (`module_field_nature.md`) specifies Portuguese labels (e.g., "Nome", "Telefone de trabalho", "Área de atividade").

Migration 014 includes a translations section, but these translations are stored separately and must be loaded by the frontend. The `label` column in `field_metadata` itself remains English.

---

## Summary of Issues by Priority

### P0 — Critical (fields render incorrectly)

1. **42 dropdown fields across 7 modules render as plain text** due to module name mismatch in migration 014. Fix: correct the module names in the UPDATE statements.
2. **15+ boolean fields render as text inputs** in Projects and Cases because they are seeded as `varchar`. Fix: update field_type to `boolean` in field_metadata.
3. **4 relate fields in Cases render as text inputs** (`who_contacted_c`, `opened_by_c`, `closed_by_c`, `invoice_id`) because they are seeded as `varchar`. Fix: update field_type to `relate` with correct `relate_module`.

### P1 — High (missing functionality)

4. **Currency hardcoded to USD** — all currency fields display "$" instead of "€".
5. **Duplicate field definitions** — both simplified and `_c` suffix versions exist for Contracts, Quotes, Invoices. Views and data may reference inconsistent names.
6. **View layouts don't match source of truth** — Accounts and Contacts seed views are generic and missing most custom fields from `module_views.md`.

### P2 — Medium (cosmetic / UX)

7. **`datetimecombo` type not handled** by frontend FieldRenderer — falls to plain text.
8. **MultiEnum uses basic HTML select** — poor UX for multi-select fields.
9. **Missing fields in DB** — several fields from source of truth not seeded at all.
10. **English labels in field_metadata** vs Portuguese in source of truth.

### P3 — Low (minor gaps)

11. **`name` field type** falls to default varchar — works but not explicit.
12. **Panel keys** in seeded views don't match source of truth panel keys.
13. **Missing popup/filter view definitions** for some modules.
