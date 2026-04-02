# Primavera Workflows: Coding Agent Implementation Guide

This document explains how the app currently implements Primavera-related workflows and how a coding agent should rebuild them without losing business behavior.

It is based on the active code paths in:

- `public/legacy/modules/AOS_Quotes/converToInvoice.php`
- `public/legacy/modules/AOS_Quotes/convertocreditnote.php`
- `public/legacy/custom/modules/AOS_Invoices/createInvoicePDF.php`
- `public/legacy/modules/Schedulers/_AddJobsHere.php`
- `public/legacy/custom/tools/primavera_mapping.php`
- `public/legacy/custom/tools/primavera_product_list_cat.php`
- `public/legacy/custom/tools/validate_salesman_primavera_code.php`
- `public/legacy/custom/modules/AOS_Quotes/HideInvoiceButton.php`
- `public/legacy/custom/modules/AOS_Quotes/HideCreditNoteButton.php`
- `public/legacy/custom/modules/AOS_Quotes/metadata/detailviewdefs.php`

## What Exists Today

There are 5 implemented Primavera workflows and 1 dormant helper workflow:

1. Quote -> Primavera invoice -> SuiteCRM invoice -> attached PDF
2. Quote -> Primavera credit note -> SuiteCRM credit note -> attached PDF
3. Primavera PDF generation and attachment
4. Scheduled Primavera customer and plan-of-accounts sync
5. Scheduled customer/account mapping generation
6. Dormant salesperson-code validation helper

## Required Configuration

The integration depends on these environment variables:

- `PRIMAVERA_API_URL`
- `PRIMAVERA_USERNAME`
- `PRIMAVERA_PASSWORD`
- `PRIMAVERA_GRANTTYPE`
- `PRIMAVERA_INSTANCE`
- `PRIMAVERA_LINE`
- `PRIMAVERA_SEEPMODE_COMPANY`
- `PRIMAVERA_SEEPMED_COMPANY`
- `PRIMAVERA_DEMO_COMPANY`

The integration also depends on these SuiteCRM fields:

- `AOS_Quotes.empresa_c`
- `AOS_Quotes.invoice_status`
- `AOS_Quotes.invoicing_notes_c`
- `Accounts.sic_code` as the VAT source
- `Accounts.billing_address_country`
- `Accounts.billing_address_state`
- `Users_cstm.primavera_code_c`
- `Users_cstm.primavera_code_sst_c`
- `AOS_Invoices.type_c`
- `AOS_Invoices.user_id_c`

The integration writes and reads these JSON caches:

- `public/legacy/custom/primavera_scripts/json_files/customers/seepmode_customers.json`
- `public/legacy/custom/primavera_scripts/json_files/customers/seepmed_customers.json`
- `public/legacy/custom/primavera_scripts/json_files/planocontas/seepmode_planocontas.json`
- `public/legacy/custom/primavera_scripts/json_files/planocontas/seepmed_planocontas.json`
- `public/legacy/custom/primavera_scripts/json_files/planocontas/mapeamento/seepmed_client_account_mapping.json`

## Shared Rules You Must Preserve

### Company selection

- If `empresa_c == "seepmode"`, use `PRIMAVERA_SEEPMODE_COMPANY`
- If `empresa_c == "seepmed"`, use `PRIMAVERA_SEEPMED_COMPANY`
- Otherwise, use `PRIMAVERA_DEMO_COMPANY`

### VAT resolution

- Source field is `Accounts.sic_code`
- If the VAT starts with `M`, strip the leading `M`
- Country code comes from `CountryCodeMapper`, using `Accounts.billing_address_country`

### VAT validation

The current validator does this:

1. Reject VAT values containing spaces.
2. Immediately accept VATs whose first digit is `1`, `2`, `3`, or `5`.
3. Immediately accept VATs starting with `90`.
4. For everything else, try VIES validation.
5. If VIES fails or returns invalid, fall back to the local customer JSON and accept the VAT if it already exists there.

### Product section (`Seccao`) mapping

- `01 - Software SON` -> `3`
- `02 - Software E-Lic` -> `3`
- `03 - Software OR` -> `3`
- `04 - Formação` -> `5`
- `05 - SST-Saúde` -> `9`
- `06 - SST-Segurança` -> `9`
- `07 - Hardware` -> `8`
- `08 - Serviços` -> `6`
- `09 - Consultoria` -> `6`
- `10 - Renovação` -> `7`
- default -> `1`

Current implementation detail:

- The document payload carries a single `Seccao` value
- In both quote conversion flows that value is whatever was assigned during the last product iteration
- If a quote mixes categories, the last iterated product wins

### Duplicate prevention

- Invoice creation is blocked when a non-deleted `AOS_Invoices` record already exists for the same `quote_number` and `type_c = "invoice"`
- Credit-note creation is blocked when a non-deleted `AOS_Invoices` record already exists for the same `quote_number` and `type_c = "credit_note"`

### PDF report selection

- `seepmode` -> `Seep_SC`
- `seepmed` -> `Seepmed`
- fallback -> `GcpVls01`

## Workflow 1: Quote to Invoice

### Entry point

- UI button in `custom/modules/AOS_Quotes/metadata/detailviewdefs.php`
- Server action file: `modules/AOS_Quotes/converToInvoice.php`

### UI trigger condition

The invoice button is hidden for non-admin users when any of these are true:

- No `AOS_Invoices` edit permission
- Quote `stage != "Closed Accepted"`
- Quote `invoice_status == "Invoiced"`

### Inputs

- Quote record ID from `$_REQUEST['record']`
- Quote line items from `aos_products_quotes`
- Quote company from `aos_quotes_cstm.empresa_c`
- Account VAT from `Accounts.sic_code`

### Current execution order

1. Check `AOS_Invoices` edit ACL.
2. Load `.env`.
3. Resolve Primavera company from `empresa_c`.
4. Request a Primavera token.
5. Check whether a SuiteCRM invoice already exists for the quote.
6. Set the quote `invoice_status = "Invoiced"` and save it immediately.
7. Load the billing account.
8. Normalize and validate the VAT.
9. Load the company-specific customer cache JSON.
10. Call Primavera to check VAT duplicates.
11. If the VAT does not exist in Primavera:
    - Reuse a `manually_introduced` local customer if one exists.
    - Otherwise compute the next available `Cliente` number.
    - Create the customer in Primavera.
    - Append the new customer to the local JSON cache.
    - Create or link the accounting account.
12. If the VAT exists exactly once:
    - Resolve the `Cliente` code from the local JSON cache.
13. If the VAT exists more than once:
    - Abort.
14. Validate every product against Primavera.
15. Build sales-document lines.
16. Append free-text comment lines from `item_description` as lines with `TipoLinha = "60"`.
17. Create the Primavera sales document with `Tipodoc = "FA"`.
18. Parse the returned Primavera document number.
19. Call accounting integration for that document.
20. Clone the quote into a new `AOS_Invoices` record with `type_c = "invoice"`.
21. Clone the quote group lines and product lines into the new invoice.
22. Build the invoice description from `name + item_description`.
23. Generate the Primavera PDF.
24. Create an `sdmod_Renewals` record and link the PDF to the invoice.
25. Save the quote again with `invoice_status = "Invoiced"`.
26. Redirect to the invoice edit view.

### Conditions

- Required env vars must exist
- Access token must be issued
- No duplicate SuiteCRM invoice may exist
- Account and customer cache JSON must be available
- VAT must pass the validator
- Primavera must return `0` or `1` for the VAT duplicate endpoint
- Every product must exist in Primavera
- `CreateSalesDocument` must return `StatusCode = 200`

### Result

On success the system produces:

- A Primavera customer if one did not exist
- A Primavera accounting account and TabCBL link if one did not exist
- A Primavera invoice document
- A SuiteCRM `AOS_Invoices` record of `type_c = "invoice"`
- Cloned line-item groups and product rows
- An attached PDF stored through `sdmod_Renewals`

### Failure behavior

- Most failures abort with `die(...)`
- Accounting integration failure is only logged and does not roll back the SuiteCRM invoice
- PDF generation throws after the SuiteCRM invoice already exists
- Because the quote is marked `Invoiced` before the external work finishes, partial failures can leave inconsistent state

## Workflow 2: Quote to Credit Note

### Entry point

- UI button in `custom/modules/AOS_Quotes/metadata/detailviewdefs.php`
- Server action file: `modules/AOS_Quotes/convertocreditnote.php`

### UI trigger condition

The credit-note button is hidden for non-admin users when any of these are true:

- No `AOS_Invoices` edit permission
- Quote `stage != "credit_note"`

Important note:

- The comment in the hook suggests a different intended rule, but the active code checks for the exact stage value `"credit_note"`

### Inputs

- Same base inputs as the invoice flow

### Current execution order

1. Check `AOS_Invoices` edit ACL.
2. Load `.env`.
3. Resolve company from `empresa_c`.
4. Request a Primavera token.
5. Check whether a SuiteCRM credit note already exists for the quote.
6. Set the quote `invoice_status = "Invoiced"` and save it immediately.
7. Load the account, normalize VAT, and validate VAT.
8. Load the company-specific customer cache JSON.
9. Check the VAT in Primavera.
10. Require exactly one matching Primavera customer.
11. Resolve the `Cliente` code from the local JSON cache.
12. Validate every product against Primavera.
13. Build the credit-note payload with:
    - `Tipodoc = "NC"`
    - `RefDocOrig = "00"`
    - `MotivoEmissao = "002"`
    - `RefTipoDocOrig = "FA"`
14. Create the Primavera document.
15. Parse the returned document number and convert it to `NC ...` or `MNC ...`.
16. Call accounting integration for that document.
17. Clone the quote into a new `AOS_Invoices` record with `type_c = "credit_note"`.
18. Clone group lines and product lines.
19. Generate the Primavera PDF.
20. Link the PDF through `sdmod_Renewals`.
21. Save the quote and redirect.

### Conditions

- Required env vars must exist
- No duplicate SuiteCRM credit note may exist
- VAT must be valid
- Primavera must report exactly one customer for the VAT
- That customer must also be present in the local JSON cache
- Every product must exist in Primavera
- `CreateSalesDocument` must return `StatusCode = 200`

### Result

On success the system produces:

- A Primavera credit note
- A SuiteCRM `AOS_Invoices` record of `type_c = "credit_note"`
- A linked PDF attachment via `sdmod_Renewals`

### Failure behavior

- If the customer does not already exist in Primavera, the flow aborts
- Unlike the invoice flow, this flow never creates a customer or accounting account
- Accounting integration failure is logged only

## Workflow 3: Primavera PDF Generation and Attachment

### Entry point

- Helper function: `custom/modules/AOS_Invoices/createInvoicePDF.php`
- Called by both quote conversion flows after the SuiteCRM invoice bean is saved

### Conditions

- The `AOS_Invoices` bean must exist
- The related `Accounts` bean must exist
- Invoice `name` must follow the pattern `TYPE YEAR/NUMDOC`

### Current execution order

1. Load the invoice bean and account bean.
2. Parse `invoice->name` into:
   - document type prefix
   - `serie`
   - `numdoc`
3. Select the Primavera report name from `empresa`.
4. Build the PDF filename from:
   - document number
   - series
   - sanitized account name
5. Call `PrintDocumentToPDF`.
6. Retry up to 3 times if the response is empty, non-200, or not a PDF.
7. On success, create an `sdmod_Renewals` record.
8. Save the PDF to `public/legacy/upload/{renewal_id}`.
9. Insert the invoice/renewal relation row.

### Result

- One PDF file on disk
- One `sdmod_Renewals` record
- One junction-row link back to the invoice

### Important behavior

- The helper uses the `tipoDoc` function parameter for Primavera, not the prefix in the invoice name
- This is what allows SuiteCRM names like `MFA ...` while still calling Primavera with `FA`

## Workflow 4: Scheduled Customer and Plan-of-Accounts Sync

### Entry point

- Scheduler job: `updateCustomersPrimaveraList`
- Implemented in `modules/Schedulers/_AddJobsHere.php`

### What it does

This is really 4 sync branches inside one job:

1. Sync SEEPMODE customers
2. Sync SEEPMED customers
3. Sync SEEPMED plan-of-accounts
4. Sync SEEPMODE plan-of-accounts

### Current execution order

1. Load `.env`.
2. Validate base Primavera credentials.
3. Ensure the local output folders exist.
4. For each configured company:
   - request a token
   - fetch `Base/Clientes/LstClientes`
   - sort the customer list
   - write the formatted JSON file
5. For each configured company:
   - request a token
   - fetch `Contabilidade/PlanoContas/LstContas`
   - keep only records where `Ano == 2025` and `Conta` starts with `2111`
   - write the simplified JSON file

### Conditions

- Base Primavera credentials must be present
- Company env vars must be present for the company branch to run
- Output directories must be writable
- Primavera must return JSON in the expected `DataSet.Table` structure

### Result

- Refreshed customer cache JSON for both companies
- Refreshed simplified plan-of-accounts JSON for both companies

### Important behavior to preserve

- Customer lists are sorted before saving
- The `Query` key is removed if present
- The plan-of-accounts sync is hard-coded to year `2025`
- The plan-of-accounts filter keeps prefix `2111` for both companies

## Workflow 5: Scheduled Customer/Account Mapping Generation

### Entry point

- Scheduler job: `updatePrimaveraMappingJob`
- It simply includes `custom/tools/primavera_mapping.php`

### Inputs

- `customers/seepmed_customers.json`
- `planocontas/seepmed_planocontas.json`

### Current execution order

1. Resolve the legacy path.
2. Include `primavera_mapping.php`.
3. Load the SEEPMED customer JSON.
4. Build a `Cliente -> customer record` map.
5. Load the SEEPMED plan-of-accounts JSON.
6. Try to match accounts to customers by expected suffix first.
7. Measure name similarity with the custom hybrid function.
8. Only keep matches with similarity exactly `1.0`.
9. For unresolved customers, retry by searching the full account list.
10. Compute `shift` for the matched account suffix.
11. Re-order the final mapping using the customer JSON order.
12. Write `mapeamento/seepmed_client_account_mapping.json`.

### Conditions

- Both input JSON files must exist
- The output directory must exist or be creatable
- Only exact similarity `1.0` matches are persisted

### Result

- One ordered mapping JSON file for SEEPMED only

### Important behavior to preserve

- The current mapping job does not generate a SEEPMODE mapping file
- Matching is strict: if similarity is not exactly `1.0`, the mapping is discarded
- Name normalization removes trailing legal suffixes like `lda`, `s.a`, and `sa`
- Expected suffix logic is:
  - non-PT customer -> `21112` + `Cliente`
  - PT customer with 3-digit `Cliente` -> left-pad to 4 digits
  - otherwise -> use the raw `Cliente`
- `shift` is the numeric difference between the actual account suffix and the expected suffix

## Workflow 6: Dormant Salesperson Validation Helper

### Status

- Implemented but not called in the active invoice or credit-note flows
- Both call sites are commented out

### What it would do if enabled

1. Read the assigned user from `users` and `users_cstm`.
2. Pick the Primavera code field based on company:
   - `primavera_code_c` for Seepmode
   - `primavera_code_sst_c` for Seepmed
3. Call Primavera to fetch the seller name.
4. Compare the last part of the Primavera name to the first two letters of the SuiteCRM username.
5. Abort if the mapping does not match.

### Recommendation

- Document it as optional in a rebuild
- Do not describe it as active unless the call sites are restored

## Recommended Implementation Order for a Coding Agent

If a coding agent needs to rebuild this integration cleanly, implement it in this order:

1. Build a single Primavera config loader that resolves all env vars and company selection.
2. Build a token client for `POST /token`.
3. Build a thin Primavera HTTP client with endpoint wrappers and uniform error handling.
4. Build repositories for:
   - customer cache JSON
   - plan-of-accounts JSON
   - mapping JSON
5. Build the shared validators:
   - VAT normalization and validation
   - product existence check
   - `Seccao` resolution
6. Build the quote-to-invoice workflow orchestrator.
7. Build the quote-to-credit-note workflow orchestrator.
8. Build the PDF generation and attachment service.
9. Build the scheduler sync job.
10. Build the mapping job.
11. Only after the main flows work, decide whether to enable salesperson validation.

## Current Quirks a Rebuild Must Preserve or Intentionally Fix

- The quote is marked `Invoiced` before the external workflow finishes.
- The invoice flow creates missing customers and accounting accounts; the credit-note flow does not.
- Accounting integration failure is non-blocking.
- PDF generation failure happens after the SuiteCRM invoice has already been created.
- The scheduler plan-of-accounts filter is hard-coded to `Ano == 2025`.
- `distritosMap` is referenced in the invoice flow but is not defined anywhere else in this repository.
- The invoice flow strips `FT ` from the Primavera `Documento` value even though the document type sent is `FA`.
- The credit-note button visibility rule checks `stage == "credit_note"`.
- The document-level `Seccao` is whichever value was assigned on the last iterated product line.
- The salesperson validation helper is implemented but inactive.

## Minimum Test Matrix

At minimum, a coding agent should validate these cases:

1. Invoice flow with an existing Primavera customer.
2. Invoice flow where the Primavera customer does not exist and must be created.
3. Invoice flow where the accounting account already exists and must abort.
4. Credit-note flow with an existing Primavera customer.
5. Credit-note flow where Primavera returns `0` for VAT and the process aborts.
6. Product validation failure for at least one line item.
7. PDF generation success.
8. PDF generation failure after all retries.
9. Customer sync for both companies.
10. Plan-of-accounts sync producing only `Ano == 2025` and `Conta` prefix `2111`.
11. Mapping generation producing `seepmed_client_account_mapping.json`.
