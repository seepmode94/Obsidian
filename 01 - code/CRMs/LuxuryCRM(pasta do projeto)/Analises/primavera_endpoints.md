# Primavera Endpoints Used in the App

This document maps the Primavera ERP endpoints implemented in this codebase, the files that call them, the workflows that trigger them, the request/response shape expected by the app, and the side effects inside SuiteCRM.

Source files reviewed:

- `public/legacy/modules/AOS_Quotes/converToInvoice.php`
- `public/legacy/modules/AOS_Quotes/convertocreditnote.php`
- `public/legacy/custom/modules/AOS_Invoices/createInvoicePDF.php`
- `public/legacy/modules/Schedulers/_AddJobsHere.php`
- `public/legacy/custom/tools/validate_salesman_primavera_code.php`

## Active Endpoints

| Method | Path | Called From | Workflow |
| --- | --- | --- | --- |
| `POST` | `/token` | `converToInvoice.php`, `convertocreditnote.php`, `_AddJobsHere.php` | Authentication for interactive quote flows and scheduler sync |
| `GET` | `/Base/Clientes/NumeroContribuintesRepetidos/{vatNumber}` | `converToInvoice.php`, `convertocreditnote.php` | Check whether the customer VAT already exists in Primavera |
| `POST` | `/Base/Clientes/Actualiza` | `converToInvoice.php` | Create or update the customer in Primavera when VAT is missing |
| `GET` | `/v2/Contabilidade/PlanoContas/Existe/{year}/{contaCode}` | `converToInvoice.php` | Check whether the accounting account already exists |
| `GET` | `/v2/Contabilidade/PlanoContas/DaDescricao/{year}/{contaCode}` | `converToInvoice.php` | Fetch the description of an already-existing accounting account |
| `POST` | `/v2/Contabilidade/ConfiguracaoTabCBL/Actualiza` | `converToInvoice.php` | Link the Primavera customer to an accounting account |
| `POST` | `/v2/Contabilidade/PlanoContas/Actualiza` | `converToInvoice.php` | Create the customer accounting account |
| `GET` | `/Base/Artigos/Existe/{productCode}` | `converToInvoice.php`, `convertocreditnote.php` | Validate every product before creating the document |
| `POST` | `/Vendas/Docs/CreateSalesDocument/` | `converToInvoice.php`, `convertocreditnote.php` | Create invoices and credit notes in Primavera |
| `GET` | `/v2/Base/LigacaoContabilidade/IntegraDocumentoLogCBL/V/{tipoDoc}/{year}/{numdoc}/{filial}` | `converToInvoice.php`, `convertocreditnote.php` | Integrate the created document with accounting |
| `GET` | `/Vendas/Docs/PrintDocumentToPDF/{tipoDoc}/{serie}/{numdoc}/000/1/{report}/false/{pdfFileName}/0` | `createInvoicePDF.php` | Generate the Primavera PDF that gets attached in SuiteCRM |
| `GET` | `/Base/Clientes/LstClientes` | `_AddJobsHere.php` | Scheduled customer cache sync |
| `GET` | `/Contabilidade/PlanoContas/LstContas` | `_AddJobsHere.php` | Scheduled plan-of-accounts cache sync |

## Authentication

### `POST /token`

Used by:

- Quote to invoice
- Quote to credit note
- Scheduled customer sync
- Scheduled plan-of-accounts sync

Request format:

- Content type: `application/x-www-form-urlencoded`
- Body fields:
  - `username`
  - `password`
  - `company`
  - `instance`
  - `grant_type`
  - `line`

Expected response:

- JSON containing `access_token`

Failure behavior:

- Interactive flows abort with `die('Access token not received from Primavera.')`
- Scheduler logs a fatal error and skips the affected company branch

Notes:

- Company is selected from `AOS_Quotes.empresa_c`
- `seepmode` uses `PRIMAVERA_SEEPMODE_COMPANY`
- `seepmed` uses `PRIMAVERA_SEEPMED_COMPANY`
- Any other value falls back to `PRIMAVERA_DEMO_COMPANY`

## Customer Resolution

### `GET /Base/Clientes/NumeroContribuintesRepetidos/{vatNumber}`

Used by:

- Quote to invoice
- Quote to credit note

Auth:

- Bearer token

Expected response:

- JSON-decoded integer
  - `0`: no customer with that VAT
  - `1`: exactly one customer
  - `>1`: duplicate VAT in Primavera

App behavior:

- Invoice flow:
  - `0` triggers local/manual customer creation logic
  - `1` resolves `Cliente` from the local customer JSON cache
  - `>1` aborts
- Credit-note flow:
  - `0` aborts immediately because the customer must already exist
  - `1` resolves `Cliente` from the local customer JSON cache
  - `>1` aborts

### `POST /Base/Clientes/Actualiza`

Used by:

- Quote to invoice only

Auth:

- Bearer token

Content type:

- `application/json`

Purpose:

- Create the Primavera customer when the VAT does not yet exist

Payload fields sent by the app:

- `Cliente`
- `DescricaoEntidade`
- `Nome`
- `Descricao`
- `Morada`
- `Localidade`
- `CodigoPostal`
- `LocalidadeCodigoPostal`
- `Telefone`
- `Fax`
- `EnderecoWeb`
- `NumContribuinte`
- `ModoPag`
- `CondPag`
- `Pais`
- `Moeda`
- `Distrito` only if a district code is resolved

Important implementation detail:

- The code normalizes payload strings to UTF-8 before `json_encode`

Current caveat:

- The code references `$distritosMap`, but that variable is not defined anywhere else in this repository
- In practice, district enrichment is incomplete unless another runtime include defines it

Response handling:

- The response is logged
- The current code does not block on a parsed success status here

Local side effect:

- A manual customer record is appended to the local JSON cache with `manually_introduced: true`

## Accounting Account Creation

### `GET /v2/Contabilidade/PlanoContas/Existe/{year}/{contaCode}`

Used by:

- Quote to invoice only

Auth:

- Bearer token

Expected response:

- JSON with `Results` as a boolean

Purpose:

- Prevent creating an accounting account code that already exists

Account-code rule used by the app:

- `seepmode`: prefix `21111`
- `seepmed`: prefix `2111`
- Customer number is left-padded to 4 digits before the prefix is applied

Failure behavior:

- If `Results === true`, the flow fetches the description with `DaDescricao` and aborts

### `GET /v2/Contabilidade/PlanoContas/DaDescricao/{year}/{contaCode}`

Used by:

- Quote to invoice only

Auth:

- Bearer token

Purpose:

- Produce a more informative fatal error when the computed accounting account already exists

Expected response:

- JSON with `Results` containing the associated description

### `POST /v2/Contabilidade/ConfiguracaoTabCBL/Actualiza`

Used by:

- Quote to invoice only

Auth:

- Bearer token

Content type:

- `application/json`

Purpose:

- Link the Primavera customer entity to an accounting account

Key payload structure:

- `Tabela`
- `Plano`
- `PlanoExercicios[]`
- nested `Linhas[]` with:
  - `Entidade`
  - `Conta`
  - `DescricaoEntidade`
  - `Exercicio`
  - `Coluna`

Expected response:

- JSON with `StatusCode === 201`

Failure behavior:

- Failure is logged
- The invoice flow continues even if this integration step fails

### `POST /v2/Contabilidade/PlanoContas/Actualiza`

Used by:

- Quote to invoice only

Auth:

- Bearer token

Content type:

- `application/json`

Purpose:

- Create the Primavera accounting account for the customer

Payload fields sent by the app:

- `EmModoEdicao`
- `Ano`
- `Conta`
- `Descricao`
- `TipoConta`
- `Grupo`
- `ContaCorrente`
- `TipoEntidade`
- `Entidade`
- `Linha`

Expected response:

- JSON with `StatusCode === 201`

Local side effect:

- On success, the code adds `ContaContabilidade` to the in-memory customer record it just created

## Product Validation

### `GET /Base/Artigos/Existe/{productCode}`

Used by:

- Quote to invoice
- Quote to credit note

Auth:

- Bearer token

Expected response:

- JSON-decoded boolean

Purpose:

- Validate every `AOS_Products.maincode` before attempting document creation

Failure behavior:

- If any product is missing, the flow aborts immediately

Related local rule:

- The document payload also derives `Seccao` from the product category:
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

## Sales Documents

### `POST /Vendas/Docs/CreateSalesDocument/`

Used by:

- Quote to invoice
- Quote to credit note

Auth:

- Bearer token

Content type:

- `application/json`

Invoice payload shape:

- `Linhas`
- `Tipodoc = "FA"`
- `Cambio = 1.0`
- `DataDoc = current date`
- `DataVenc = current date`
- `TipoEntidade = "C"`
- `Entidade = cliente`
- `Serie = current year`
- `RefTipoDocOrig = tipoDoc`
- `RefSerieDocOrig = current year`
- `Seccao`

Credit-note payload shape:

- `Linhas`
- `Tipodoc = "NC"`
- `Cambio = 1.0`
- `DataDoc = current date`
- `DataVenc = current date`
- `TipoEntidade = "C"`
- `Entidade = cliente`
- `Serie = current year`
- `RefDocOrig = "00"`
- `MotivoEmissao = "002"`
- `RefTipoDocOrig = "FA"`
- `RefSerieDocOrig = current year`
- `Seccao`

Expected response:

- JSON with `StatusCode === 200`
- `Results[]` must contain an item with `Nome === "Documento"`

How the app uses `Documento`:

- Invoice flow:
  - Removes `FT ` from the returned value
  - Replaces `.` with a space
  - Left-pads the final string
  - Prefixes the final document name with `M` for `seepmed`
- Credit-note flow:
  - Removes `NC `
  - Extracts the numeric suffix
  - Builds `NC {year}/{numdoc}` or `MNC {year}/{numdoc}`

Failure behavior:

- Any non-`200` status aborts the interactive flow

## Accounting Integration

### `GET /v2/Base/LigacaoContabilidade/IntegraDocumentoLogCBL/V/{tipoDoc}/{year}/{numdoc}/{filial}`

Used by:

- Quote to invoice
- Quote to credit note

Auth:

- Bearer token

Current fixed parameter:

- `filial = "000"`

Expected response:

- JSON with:
  - `StatusCode === 200`
  - `Results.IntegraDocumentoLogCBL` truthy

Failure behavior:

- Failure is logged
- The SuiteCRM invoice or credit note is still created

## PDF Generation

### `GET /Vendas/Docs/PrintDocumentToPDF/{tipoDoc}/{serie}/{numdoc}/000/1/{report}/false/{pdfFileName}/0`

Used by:

- Post-processing after invoice creation
- Post-processing after credit-note creation

Auth:

- Bearer token

Report selection:

- `seepmode` -> `Seep_SC`
- `seepmed` -> `Seepmed`
- fallback -> `GcpVls01`

Expected response:

- Raw PDF bytes whose first four characters are `%PDF`

Retry policy:

- 3 attempts
- 2 seconds between attempts

Failure behavior:

- Throws an exception after retries are exhausted
- That exception aborts the interactive flow after the SuiteCRM invoice bean already exists

Local side effects on success:

- Creates an `sdmod_Renewals` record
- Writes the PDF into `public/legacy/upload/{renewal_id}`
- Inserts the relationship row into `aos_invoices_sdmod_renewals_1_c`

## Scheduled Sync Endpoints

### `GET /Base/Clientes/LstClientes`

Used by:

- Scheduler job `updateCustomersPrimaveraList`

Auth:

- Bearer token

Expected response:

- JSON with `DataSet.Table[]`

What the app does with it:

- Removes `Query` if present
- Sorts the `Cliente` values so numeric codes come first in ascending order
- Saves the result to:
  - `public/legacy/custom/primavera_scripts/json_files/customers/seepmode_customers.json`
  - `public/legacy/custom/primavera_scripts/json_files/customers/seepmed_customers.json`

### `GET /Contabilidade/PlanoContas/LstContas`

Used by:

- Scheduler job `updateCustomersPrimaveraList`

Auth:

- Bearer token

Expected response:

- JSON with `DataSet.Table[]`

What the app does with it:

- Keeps only records where:
  - `Ano == 2025`
  - `Conta` starts with `2111`
- Saves simplified records with only:
  - `Conta`
  - `Descricao`
  - `Ano`
- Output files:
  - `public/legacy/custom/primavera_scripts/json_files/planocontas/seepmode_planocontas.json`
  - `public/legacy/custom/primavera_scripts/json_files/planocontas/seepmed_planocontas.json`

Important date note:

- This is hard-coded to the calendar year `2025` in the current implementation

## Implemented But Currently Dormant

### `GET /v2/Vendas/Vendedores/DaValorAtributo/{primaveraCode}/Nome`

Implemented in:

- `public/legacy/custom/tools/validate_salesman_primavera_code.php`

Current runtime status:

- The helper is included by both quote conversion flows
- The actual calls are commented out in both `converToInvoice.php` and `convertocreditnote.php`
- As shipped in this repository, this endpoint is not part of the active flow

Purpose if enabled:

- Validate that the Primavera salesperson code stored on the assigned user matches the user name prefix

Expected response:

- JSON with `Results.DaValorAtributo`

User fields used:

- `users_cstm.primavera_code_c` for `Seepmode`
- `users_cstm.primavera_code_sst_c` for `Seepmed`
