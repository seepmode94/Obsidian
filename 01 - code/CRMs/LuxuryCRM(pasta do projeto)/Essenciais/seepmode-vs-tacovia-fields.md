# SuiteCRM Field Comparison: Seepmode vs Tacovia

**Date:** 2026-03-23
**Seepmode:** `https://crm.seepmode.com` (`/var/www/html/seepmode`, DB: `seepform_suitecrm_db`)
**Tacovia:** `https://crm.tacovia.eu` (`/var/www/html/tacovia`, DB: `tacovia_suitecrm_db`)
**Both instances:** SuiteCRM 6.5.25 (SuiteCRM 8 wrapper)

## Methodology

Field definitions were extracted from both instances via SSH by parsing `vardefs.php` files and custom `Ext/Vardefs/` extensions. A verification pass confirmed that both instances share identical base module vardefs (verified via MD5 checksums). Differences caused by template inheritance resolution (SugarCRM's `VardefManager::createVardef()` templates like `basic`, `company`, `person`, `assignable`, etc.) were filtered out — they exist in both instances but were captured at different resolution levels.

## Summary

| Metric | Count |
|---|---|
| Modules in both instances | 114 |
| Modules only in Seepmode | 1 (`Audit`) |
| Modules only in Tacovia | 0 |
| Real field differences | ~61 |

The two instances are **structurally identical** at the base module level. All differences are in **custom fields** (`_c` suffix) added via Studio, and **relationship links** to customized modules.

## Real Differences

### 1. sdmod_capability (Capabilities / Fichas de Aptidao) — 54 fields, Seepmode only

This is the biggest difference. Seepmode has fully customized this module for occupational health/safety assessments. Tacovia has the base module but no custom fields configured.

**Seepmode custom fields (54):**

| Field | Type | Purpose |
|---|---|---|
| `ability_result_c` | enum | Exam result |
| `analise_posto_trabalho_c` | enum | Workplace analysis |
| `analise_posto_trabalho_justi_c` | varchar | Workplace analysis justification |
| `atividade_funcao_c` | varchar | Activity/function |
| `cae_c` | varchar | CAE code |
| `cat_profissional_c` | varchar | Professional category |
| `data_admissao_atividade_c` | date | Activity admission date |
| `data_admissao_c` | date | Admission date |
| `data_nascimento_c` | date | Birth date |
| `dgs_authorization_process_c` | varchar | DGS authorization process |
| `email_c` | varchar | Email |
| `endereco_c` | varchar | Address |
| `estabelecimento_c` | varchar | Establishment |
| `exam_date_c` | date | Exam date |
| `exam_type_c` | enum | Exam type |
| `exam_type_other_c` | varchar | Other exam type |
| `exposicao_profissional_c` | enum | Professional exposure |
| `exposicao_profissional_espec_c` | varchar | Exposure specifics |
| `fatores_risco_pro_c` | enum | Professional risk factors |
| `fatores_risco_pro_especifica_c` | varchar | Risk factor specifics |
| `localidade_c` | varchar | Locality |
| `manager_signature_c` | text | Manager signature (base64) |
| `manager_signature_date_c` | date | Manager signature date |
| `medic_signature_c` | text | Medic signature (base64) |
| `medic_signature_date_c` | date | Medic signature date |
| `n_cedula_profissional_c` | varchar | Professional license number |
| `nacionalidade_c` | varchar | Nationality |
| `nipc_c` | varchar | NIPC (tax ID) |
| `nome_do_medico_c` | varchar | Doctor name |
| `other_recommendations_c` | text | Other recommendations |
| `outras_funcoes_c` | text | Other functions |
| `posto_trabalho_c` | varchar | Work position |
| `recommendations_c` | text | Recommendations |
| `service_organization_c` | enum | Service organization |
| `service_organization_name_c` | varchar | Service org name |
| `service_organization_nipc_c` | varchar | Service org NIPC |
| `service_organization_other_c` | varchar | Service org other |
| `sexo_c` | enum | Gender |
| `telefone_c` | varchar | Phone |
| `worker_signature_c` | text | Worker signature (base64) |
| `worker_signature_date_c` | date | Worker signature date |
| `zip_code_c` | varchar | ZIP code |

Plus relationship links: `accounts_sdmod_capability_1`, `contacts_sdmod_capability_1`, `project_sdmod_capability_1`, `sdmod_capability_documents_1` (all Seepmode only).

### 2. Users — 1 field, Seepmode only

| Field | Type | Label |
|---|---|---|
| `primavera_code_sst_c` | varchar | Codigo respetivo no Primavera SEEPMED |

Seepmode-specific Primavera ERP integration field for SST (occupational health) code.

### 3. sdmod_Renewals — 2 fields, Seepmode only

| Field | Type | Purpose |
|---|---|---|
| `aos_invoice_renawal_c` | relate | Invoice link for renewal |
| `sdmod_iefp_accesses_id_c` | id | IEFP access link |

### 4. sdmod_training — 1 field each instance

| Field | Instance | Type |
|---|---|---|
| `contact_id1_c` | Seepmode only | id |
| `sdmod_iefp_accesses_id_c` | Tacovia only | id |

Both are relationship FK fields added via Studio. Different customization choices for linking trainings to other entities.

### 5. sdmod_formation_trainers — 1 field, Seepmode only

| Field | Type | Notes |
|---|---|---|
| `training_date` | date | Non-custom version of `training_date_c` (both instances have `training_date_c`) |

### 6. AOS_Contracts — Renamed field

| Seepmode | Tacovia | Type | Label |
|---|---|---|---|
| `anuidade_c` | `anuidade_list_c` | enum | Anuidade |

Same purpose, different field name. Created ~30 minutes apart on 2025-05-05 — likely a rename that diverged between instances.

### 7. Capability relationship links — Seepmode only

Because `sdmod_capability` is only customized in Seepmode, these relationship link fields exist only in Seepmode:

| Module | Link field |
|---|---|
| Accounts | `accounts_sdmod_capability_1` |
| Contacts | `contacts_sdmod_capability_1` |
| Project | `project_sdmod_capability_1` |
| Documents | `sdmod_capability_documents_1` |

## Identical Modules

All other modules have identical field definitions across both instances. This includes all standard CRM modules (Accounts base, Contacts base, Leads, Opportunities, Quotes, Invoices, Contracts, Products, Cases, Projects, Documents, Emails, Meetings, Calls, Tasks, Notes) and all custom `sdmod_*` modules (except the differences noted above).

## Implications for LuxuryCRM

1. **sdmod_capability customization** — LuxuryCRM already has all 54 Seepmode-specific capability fields modeled (they were part of the migration). If Tacovia data needs to be imported, the capability table will accept it but those 54 fields will be empty.

2. **primavera_code_sst_c** — Already in LuxuryCRM's users table from migration 026. Tacovia users won't have this populated.

3. **AOS_Contracts.anuidade_c vs anuidade_list_c** — LuxuryCRM uses `anuidade_c` (Seepmode convention). A Tacovia import would need to map `anuidade_list_c` to `anuidade_c`.

4. **sdmod_training FK differences** — Minor. LuxuryCRM has both `contact_id` and `iefp_accesses_id` on trainings, covering both instances.

## Dropdown / Enum Value Differences

Both instances share the same base SuiteCRM dropdown definitions. The differences below are in **custom overrides** — dropdown lists where one instance has added, removed, or renamed values.

### Critical Business Dropdowns

#### empresa_list (Company Entity)

This dropdown identifies which legal entity owns a record. Each instance has its own companies.

| Key | Seepmode | Tacovia |
|---|---|---|
| `seepmode` | Seepmode | (not present) |
| `seepmed` | Seepmed | (not present) |
| `tacovia` | (not present) | Tacovia |

**Impact:** LuxuryCRM must support multi-tenant company identifiers. Records from each instance use different `empresa_c` values.

#### product_code_dom (Product Codes) — Seepmode: 355, Tacovia: 317

Different product catalogs. Seepmode uses codes like `AR001`-`AR007`, `ASaaSE003`-`ASaaSE005`. Tacovia uses `AR0001`-`AR0010` (4-digit padding). The code namespaces overlap but values differ.

#### products_list (Product Names) — Seepmode: 214, Tacovia: 136

Entirely different product catalogs:
- Seepmode training products: `FM001` = "Formacao Lei 27/2010", `FM005`-`FM089` (Portuguese training courses)
- Tacovia training products: `FM001` = "Formacion Tacografos - Elearning - 8h", `R007`-`R011`, `SR013`-`SR016` (Spanish/international courses)

#### quote_stage_dom (Quote Stages) — Seepmode: 5, Tacovia: 9

| Stage | Seepmode | Tacovia |
|---|---|---|
| Draft | (not present) | Draft |
| Negotiation | Negotiation | Negotiation |
| Delivered | (not present) | Delivered |
| On Hold | On Hold | On Hold |
| Confirmed | (not present) | Confirmed |
| Closed Accepted | Closed Accepted | Closed Accepted |
| Closed Lost | Closed Lost | Closed Lost |
| Closed Dead | (not present) | Closed Dead |
| Closed Withdrawn | Closed Withdrawn | (not present) |

#### salesman_region_list (Sales Regions) — Seepmode: 30, Tacovia: 15

Completely different regional structures:
- **Seepmode** (Portugal-focused): `vendas_norte_sf`, `vendas_centro_sf`, `vendas_lisboa_sf`, `vendas_sul_sf`, `vendas_es_canarias`, `vendas_es_cataluna` — covers Portugal regions + Spanish expansion
- **Tacovia** (simplified): `vendas_centro`, `vendas_lx`, `vendas_norte`, `vendas_sul`, `vendas_ilhas`, `vendas_lx_alentejo`, `nacional` — Portugal-only regions

#### code_list (Case/Support Codes) — Seepmode: 1, Tacovia: 135

Tacovia has a fully populated numeric code list (1-135). Seepmode has only 1 entry — codes may be stored differently or the list was never populated.

### Minor Dropdown Differences

| Dropdown | Difference |
|---|---|
| `anuidade_list` | Capitalization: Seepmode "1/2 anos" vs Tacovia "1/2 Anos" |
| `billing_state_list` | Tacovia adds `Belgium_` (1 extra entry among 1003) |
| `nutsii_list` | Tacovia adds `Belgium_` (1 extra entry among 702) |
| `department_c_list` | Seepmode has `marketing` (11 vs 10) |
| `exam_type_list` | Capitalization: "A pedido" vs "a pedido" |
| `type_list` | Seepmode has `admin` and `distributer` (15 vs 13) |
| `vat_list` | Tacovia adds `5.0`, `7.5`, `17.5`, `20.0` (10 vs 6) — different VAT regimes |
| `yes_no_list` | Value difference on `Sim` key |
| `moduleList` | Different Portuguese labels for modules (e.g., "Medicinas Ocupacional" vs "Medicina Ocupacional") |

### Dropdown Differences Impact on LuxuryCRM

1. **empresa_list** — LuxuryCRM should merge all company values: `seepmode`, `seepmed`, `tacovia`
2. **product_code_dom / products_list** — Different catalogs. LuxuryCRM should maintain separate product sets or merge with prefixed namespaces
3. **quote_stage_dom** — LuxuryCRM should use the superset (Tacovia's 9 stages includes all of Seepmode's)
4. **salesman_region_list** — LuxuryCRM should merge both regional structures
5. **code_list** — Import Tacovia's full 135-code list
6. **vat_list** — Merge both VAT rate sets (different country tax regimes)

## View Layout Differences

Both instances use the same base view definitions (editviewdefs.php, detailviewdefs.php, listviewdefs.php). Custom view overrides in `custom/modules/*/metadata/` are identical between instances for all core modules. The only view differences stem from the `sdmod_capability` customization in Seepmode (additional panels for health/safety assessment fields that don't exist in Tacovia).

## Relationship Differences

Both instances have identical relationship configurations (subpaneldefs.php) for all modules except:

1. **sdmod_capability relationships** — Seepmode only: links to Accounts, Contacts, Projects, Documents
2. **sdmod_Renewals.aos_invoice_renawal_c** — Seepmode has an additional Invoice relationship link

All other relationship structures (Activities, History, Documents, Quotes-Invoices-Contracts, Training domain, Security Groups) are identical.

## Raw Data

- Seepmode extraction: `tmp/seepmode-fields.json` (115 modules, 2,625 fields)
- Tacovia extraction: `tmp/tacovia-fields.json` (114 modules, 3,853 fields)
- Seepmode enums/views: `tmp/seepmode-enums-views.txt` (2.1 MB)
- Tacovia dropdowns: `tmp/tacovia-dropdowns.txt` (152 dropdown lists)
- Enum diff: `tmp/enum-diff.json`
- Field diff (before verification): `tmp/field-diff.json`
- Verification findings: `tmp/verification-findings.txt`
