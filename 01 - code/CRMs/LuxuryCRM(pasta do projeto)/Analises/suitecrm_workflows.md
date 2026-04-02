# SuiteCRM Seepmode Workflow Catalogue

This document reconstructs the configured SuiteCRM workflows from the live workflow table exports embedded in `prompt.md` (sections `22.1` to `22.3`).

Scope:

- Included: workflows, conditions, and actions with `deleted = 0`.
- Excluded: soft-deleted duplicate rows.
- Source note: direct MariaDB access is blocked in this sandbox, so this catalogue is based on the captured live exports present in the workspace.

Summary:

- Total workflows: `44`.
- Active workflows: `33`.
- Inactive workflows: `11`.
- Modules covered: `7`.

| Module | Label | Workflows | Active | Inactive |
|---|---|---|---|---|
| `AOS_Contracts` | Contratos | `7` | `7` | `0` |
| `AOS_Invoices` | Faturas | `6` | `6` | `0` |
| `AOS_Quotes` | Propostas | `9` | `7` | `2` |
| `Cases` | Assistências | `13` | `10` | `3` |
| `Meetings` | Meetings | `3` | `0` | `3` |
| `Project` | Medicinas Ocupacional | `3` | `3` | `0` |
| `sdmod_training` | Formações | `3` | `0` | `3` |

## `AOS_Contracts` — Contratos

### VM04 - Termina automaticamente o contrato

- Workflow id: `589ac997-d367-e5cc-2a32-65b0f90ce94d`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Contracts` -> `pack_state_c` (Estado do Pack) equals `Active` (Activo).
  2. `AOS_Contracts` -> `renewal_date_c` (Data Renovação) equals today.
  3. `AOS_Contracts` -> `name` (Nº) starts with `M`.
- Results:
  1. `Fecha Contrato (SeepMed)` updates `AOS_Contracts` with: `pack_state_c` = `Finished` (Terminado).

### VM05 - Fim do contrato SST

- Workflow id: `b4e1b3a6-9b2e-16d9-9b96-650ece2f1776`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Contracts` -> `renewal_date_c` (Data Renovação) equals today + 30 day.
  2. `AOS_Contracts` -> `versao_c` (Versão) contains `Pack`.
  3. `AOS_Contracts` -> `pack_state_c` (Estado do Pack) equals `Active` (Activo).
  4. `AOS_Contracts > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `Cria nova Proposta com validade de uma semana` creates `AOS_Quotes` linked to the triggering record with fields: `name` = `Renovação SST`; `total_amt` <- `renewal_value_c`; `total_amount` <- `renewal_value_c`; `billing_account` <- `contract_account`; `assigned_user_name` <- `assigned_user_name`; `stage` = `On Hold` (Proposta); `expiration` = today + 1 month; `data_prevista_fecho_c` = today + 1 week; `empresa_c` <- `empresa_c`.
  2. `Envia email a avisar cliente do fim do contrato SST` sends email using template `5f518e6f-282c-9aae-e08a-650ece1e1d82` with recipients: from: `faturas@seepmed.pt`; to: related field `accounts`; cc: related field `assigned_user_name`; bcc: `faturas@seepmed.pt`.
  3. `Cria Contrato de renovação (Pendente) um mês antes do contrato renovar` creates `AOS_Contracts` linked to the triggering record with fields: `name` <- `name`; `net_value_c` <- `net_value_c`; `start_date` <- `renewal_date_c`; `pack_state_c` = `Pendente` (Pendente); `versao_c` <- `versao_c`; `renewal_date_c` <- `renewal_date_plus_1y_c`; `contract_account` <- `contract_account`; `renewal_value_c` <- `renewal_value_c`; `assigned_user_name` <- `assigned_user_name`; `empresa_c` <- `empresa_c`; `pack_c` <- `pack_c`.
  4. `Alerta Vendedor que o contrato com o cliente foi renovado automáticamente (SeepMed)` sends email using template `e58ef959-d8b5-88c6-afa6-65b0fc9b5653` with recipients: from: `crm@seepmed.pt`; to: related field `assigned_user_name`.

### VM06 - Fim do contrato SON

- Workflow id: `3d55136a-21d5-36df-0a72-671275c8cbee`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `In_Scheduler`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Contracts` -> `renewal_date_c` (Data Renovação) equals today + 30 day.
  2. `AOS_Contracts` -> `versao_c` (Versão) contains `SON`.
  3. `AOS_Contracts` -> `name` (Nº) starts with `M`.
  4. `AOS_Contracts` -> `pack_state_c` (Estado do Pack) equals `Active` (Activo).
  5. `AOS_Contracts > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `Envia email ao cliente a informar que o contrato vai renovar (SON)` sends email using template `4dd7befb-664d-a8a9-d0ba-671275ff249b` with recipients: from: `faturas@seepmed.pt`; cc: related field `accounts`; bcc: `faturas@seepmed.pt`; cc: related field `assigned_user_name`.
  2. `Cria nova Proposta com validade de uma semana (SON)` creates `AOS_Quotes` linked to the triggering record with fields: `name` = `Renovação SON`; `total_amt` <- `renewal_value_c`; `total_amount` <- `renewal_value_c`; `billing_account` <- `contract_account`; `assigned_user_name` <- `assigned_user_name`; `stage` = `On Hold` (Proposta); `expiration` = today + 1 month; `data_prevista_fecho_c` = today + 1 week; `empresa_c` <- `empresa_c`.
  3. `Cria Contrato de renovação (Pendente) um mês antes do contrato renovar` creates `AOS_Contracts` linked to the triggering record with fields: `name` <- `name`; `net_value_c` <- `net_value_c`; `start_date` <- `renewal_date_c`; `pack_state_c` = `Pendente` (Pendente); `versao_c` <- `versao_c`; `renewal_date_c` <- `renewal_date_plus_1y_c`; `contract_account` <- `contract_account`; `renewal_value_c` <- `renewal_value_c`; `assigned_user_name` <- `assigned_user_name`; `empresa_c` <- `empresa_c`; `pack_c` <- `pack_c`.
  4. `Alerta Vendedor que o contrato com o cliente foi renovado automáticamente (SeepMed)` sends email using template `e58ef959-d8b5-88c6-afa6-65b0fc9b5653` with recipients: from: `crm@seepmed.pt`; to: related field `assigned_user_name`.

### VM07 - Fim do contrato ELIC

- Workflow id: `c2a3a2c0-27df-f1ed-9676-6712788c5e4d`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `In_Scheduler`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Contracts` -> `renewal_date_c` (Data Renovação) equals today + 30 day.
  2. `AOS_Contracts` -> `versao_c` (Versão) contains `Elic`.
  3. `AOS_Contracts` -> `name` (Nº) starts with `M`.
  4. `AOS_Contracts` -> `pack_state_c` (Estado do Pack) equals `Active` (Activo).
  5. `AOS_Contracts > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `Envia email a avisar cliente do fim do contrato E-lic` sends email using template `cbc9d7ca-eaac-1eb3-acd1-6712770db550` with recipients: from: `faturas@e-lic.eu`; to: related field `accounts`; to: related field `assigned_user_name`; bcc: `faturas@e-lic.eu`.
  2. `Cria nova Proposta com validade de uma semana` creates `AOS_Quotes` linked to the triggering record with fields: `name` = `Renovação ELIC`; `total_amt` <- `renewal_value_c`; `total_amount` <- `renewal_value_c`; `billing_account` <- `contract_account`; `assigned_user_name` <- `assigned_user_name`; `stage` = `On Hold` (Proposta); `expiration` = today + 1 month; `data_prevista_fecho_c` = today + 1 week.
  3. `Cria Contrato de renovação (Pendente) um mês antes do contrato renovar` creates `AOS_Contracts` linked to the triggering record with fields: `name` <- `name`; `net_value_c` <- `net_value_c`; `start_date` <- `renewal_date_c`; `pack_state_c` = `Pendente` (Pendente); `versao_c` <- `versao_c`; `renewal_date_c` <- `renewal_date_plus_1y_c`; `contract_account` <- `contract_account`; `renewal_value_c` <- `renewal_value_c`; `assigned_user_name` <- `assigned_user_name`; `empresa_c` <- `empresa_c`; `pack_c` <- `pack_c`.
  4. `Alerta Vendedor que o contrato com o cliente foi renovado automáticamente (SeepMed)` sends email using template `e58ef959-d8b5-88c6-afa6-65b0fc9b5653` with recipients: from: `crm@seepmed.pt`; to: related field `assigned_user_name`.

### VS04 - Termina automaticamente o contrato

- Workflow id: `1886309f-a2e9-29cf-eb58-650eeb692101`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Contracts` -> `pack_state_c` (Estado do Pack) equals `Active` (Activo).
  2. `AOS_Contracts` -> `renewal_date_c` (Data Renovação) equals today.
  3. `AOS_Contracts` -> `name` (Nº) does not start with `M`.
- Results:
  1. `Termina Contrato` updates `AOS_Contracts` with: `pack_state_c` = `Finished` (Terminado).

### VS05 - Fim do contrato SON

- Workflow id: `45f47a30-3f0e-02b6-f5a3-64f574b9d334`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Contracts` -> `renewal_date_c` (Data Renovação) equals today + 30 day.
  2. `AOS_Contracts` -> `versao_c` (Versão) contains `SON`.
  3. `AOS_Contracts` -> `name` (Nº) does not start with `M`.
  4. `AOS_Contracts` -> `pack_state_c` (Estado do Pack) equals `Active` (Activo).
  5. `AOS_Contracts > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `Envia email ao cliente a informar que o contrato vai renovar (SON)` sends email using template `8af66d81-62b0-8c34-caff-64f57409d407` with recipients: from: `faturas@seepmode.com`; to: related field `accounts`; bcc: related field `assigned_user_name`; bcc: `faturas@seepmode.com`.
  2. `Cria nova Proposta com validade de uma semana (SON)` creates `AOS_Quotes` linked to the triggering record with fields: `name` = `Renovação SON`; `total_amt` <- `renewal_value_c`; `total_amount` <- `renewal_value_c`; `billing_account` <- `contract_account`; `assigned_user_name` <- `assigned_user_name`; `stage` = `On Hold` (Proposta); `expiration` = today + 1 month; `data_prevista_fecho_c` = today + 1 week; `empresa_c` <- `empresa_c`.
  3. `Cria Contrato de renovação (Pendente) um mês antes do contrato renovar` creates `AOS_Contracts` linked to the triggering record with fields: `name` <- `name`; `net_value_c` <- `net_value_c`; `start_date` <- `renewal_date_c`; `pack_state_c` = `Pendente` (Pendente); `versao_c` <- `versao_c`; `renewal_date_c` <- `renewal_date_plus_1y_c`; `contract_account` <- `contract_account`; `renewal_value_c` <- `renewal_value_c`; `assigned_user_name` <- `assigned_user_name`; `empresa_c` <- `empresa_c`; `pack_c` <- `estado_pack_plus_c`.
  4. `Alerta vendedor da renovação automática do contrato` sends email using template `db759b42-fd0e-0cda-8418-64d60d85ded8` with recipients: from: `crm@seepmode.com`; to: related field `assigned_user_name`.

### VS06 - Fim do contrato ELIC

- Workflow id: `c4c5692f-6d3c-33f7-02e3-650ecd918188`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `In_Scheduler`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Contracts` -> `renewal_date_c` (Data Renovação) equals today + 30 day.
  2. `AOS_Contracts` -> `versao_c` (Versão) contains `Elic`.
  3. `AOS_Contracts` -> `name` (Nº) does not start with `M`.
  4. `AOS_Contracts` -> `pack_state_c` (Estado do Pack) equals `Active` (Activo).
- Results:
  1. `Fim do contrato E-lic` sends email using template `b3588cf2-60a2-3801-e2f7-650ecd7d35e1` with recipients: from: `faturas@e-lic.eu`; to: related field `accounts`; bcc: related field `assigned_user_name`.
  2. `Cria nova Proposta com validade de uma semana (SON)` creates `AOS_Quotes` linked to the triggering record with fields: `name` = `Renovação Elic`; `total_amt` <- `renewal_value_c`; `total_amount` <- `renewal_value_c`; `billing_account` <- `contract_account`; `assigned_user_name` <- `assigned_user_name`; `stage` = `On Hold` (Proposta); `expiration` = today + 1 month; `data_prevista_fecho_c` = today + 1 week; `empresa_c` <- `empresa_c`.
  3. `Cria Contrato de renovação (Pendente) um mês antes do contrato renovar` creates `AOS_Contracts` linked to the triggering record with fields: `name` <- `name`; `net_value_c` <- `net_value_c`; `start_date` <- `renewal_date_c`; `versao_c` <- `versao_c`; `renewal_date_c` <- `renewal_date_plus_1y_c`; `contract_account` <- `contract_account`; `renewal_value_c` <- `renewal_value_c`; `assigned_user_name` <- `assigned_user_name`; `empresa_c` <- `empresa_c`; `pack_state_c` = `Active` (Activo); `pack_c` <- `pack_c`.
  4. `Alerta vendedor da renovação automática do contrato` sends email using template `db759b42-fd0e-0cda-8418-64d60d85ded8` with recipients: from: `crm@seepmode.com`; to: related field `assigned_user_name`.

## `AOS_Invoices` — Faturas

### VM01 - Enviar e-mail a pedir pagamento #1

- Workflow id: `c52563b8-954f-29e7-beec-65b3f8d01832`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Invoices` -> `name` (Título) starts with `M`.
  2. `AOS_Invoices` -> `open_value_c` (Valor Aberto (€)) is greater than `0.01`.
  3. `AOS_Invoices` -> `invoice_date` (Data da fatura) equals today - 15 day.
  4. `AOS_Invoices` -> `payment_reminder_c` (Enviar Email Automático a Relembrar Pagamento) equals `Sim` (Sim).
  5. `AOS_Invoices > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `(Seepmed) Enviar e-mail a pedir pagamento #1` sends email using template `dfe7a174-1020-beee-03c6-65afaf67c43c` with recipients: from: `faturas@seepmed.pt`; to: related field `accounts`; cc: related field `salesperson_c`; bcc: `faturas@seepmed.pt`.

### VM02 - Enviar e-mail a pedir pagamento #2

- Workflow id: `95637b85-d90b-0440-a7f9-65afd04f9d5c`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Invoices` -> `name` (Título) starts with `M`.
  2. `AOS_Invoices` -> `open_value_c` (Valor Aberto (€)) is greater than `0.01`.
  3. `AOS_Invoices` -> `invoice_date` (Data da fatura) equals today - 30 day.
  4. `AOS_Invoices` -> `payment_reminder_c` (Enviar Email Automático a Relembrar Pagamento) equals `Sim` (Sim).
  5. `AOS_Invoices > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `(Seepmode) Enviar e-mail a pedir pagamento #2` sends email using template `c531de4b-99cf-6aef-a72f-65afafbb2544` with recipients: from: `faturas@seepmed.pt`; to: related field `accounts`; cc: related field `salesperson_c`; bcc: `faturas@seepmed.pt`.

### VM03 - Enviar e-mail a pedir pagamento #3

- Workflow id: `7c3714b8-da29-35cb-38ee-65afd00c1ffc`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Invoices` -> `name` (Título) starts with `M`.
  2. `AOS_Invoices` -> `open_value_c` (Valor Aberto (€)) is greater than `0.01`.
  3. `AOS_Invoices` -> `invoice_date` (Data da fatura) equals today - 60 day.
  4. `AOS_Invoices` -> `payment_reminder_c` (Enviar Email Automático a Relembrar Pagamento) equals `Sim` (Sim).
  5. `AOS_Invoices > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `(Seepmed) Enviar e-mail a pedir pagamento (Contencioso) #3` sends email using template `7cee3001-6bf0-8e7b-4e4e-65afaf453d31` with recipients: from: `faturas@seepmed.pt`; to: related field `accounts`; cc: related field `salesperson_c`; bcc: `contencioso@seepmed.pt`.

### VS01 - Enviar e-mail a pedir pagamento #1

- Workflow id: `7d77683a-552c-14af-07ad-650ed90accf0`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Invoices` -> `name` (Título) does not start with `M`.
  2. `AOS_Invoices` -> `open_value_c` (Valor Aberto (€)) is greater than `0.01`.
  3. `AOS_Invoices` -> `invoice_date` (Data da fatura) equals today - 15 day.
  4. `AOS_Invoices` -> `payment_reminder_c` (Enviar Email Automático a Relembrar Pagamento) equals `Sim` (Sim).
  5. `AOS_Invoices > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `(Seepmode) Enviar e-mail a pedir pagamento #1` sends email using template `354f73a4-5d20-1b4c-8c00-650ed746131a` with recipients: from: `faturas@seepmode.com`; to: related field `accounts`; cc: related field `assigned_user_name`; bcc: `faturas@seepmode.com`.

### VS02 - Enviar e-mail a pedir pagamento #2

- Workflow id: `7b57a857-82cf-c887-7faa-650ede3850b0`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Invoices` -> `name` (Título) does not start with `M`.
  2. `AOS_Invoices` -> `open_value_c` (Valor Aberto (€)) is greater than `0.01`.
  3. `AOS_Invoices` -> `invoice_date` (Data da fatura) equals today - 30 day.
  4. `AOS_Invoices` -> `payment_reminder_c` (Enviar Email Automático a Relembrar Pagamento) equals `Sim` (Sim).
  5. `AOS_Invoices > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `(Seepmode) Enviar e-mail a pedir pagamento #2` sends email using template `95c56ec3-eec5-7194-6a1b-650ede2858fa` with recipients: from: `faturas@seepmode.com`; to: related field `accounts`; cc: related field `assigned_user_name`; bcc: `faturas@seepmode.com`.

### VS03 - Enviar e-mail a pedir pagamento #3

- Workflow id: `481c2dc7-d050-7842-569a-650edfd15414`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Invoices` -> `name` (Título) does not start with `M`.
  2. `AOS_Invoices` -> `open_value_c` (Valor Aberto (€)) is greater than `0.01`.
  3. `AOS_Invoices` -> `invoice_date` (Data da fatura) equals today - 60 day.
  4. `AOS_Invoices` -> `payment_reminder_c` (Enviar Email Automático a Relembrar Pagamento) equals `Sim` (Sim).
  5. `AOS_Invoices > accounts` -> `billing_address_country` (Faturação - País:) equals `Portugal` (Portugal).
- Results:
  1. `(Seepmode) Enviar e-mail a pedir pagamento #3 (Contencioso)` sends email using template `9344859b-b7e3-deb4-52c4-650edfb4a2c6` with recipients: from: `faturas@seepmode.com`; to: related field `accounts`; cc: related field `assigned_user_name`; bcc: `contencioso@seepmode.com`.

## `AOS_Quotes` — Propostas

### V01 - Proposta Perdida + criação de telefonema

- Workflow id: `85f81297-1643-3ff4-4e48-66f6ed5fb2e4`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `stage` (Fase proposta) equals `Closed Lost` (Perdida).
- Results:
  1. `Follow up Call` creates `Calls` linked to the triggering record with fields: `name` = `Proposta Perdida: Acompanhar Cliente`; `assigned_user_name` <- `assigned_user_name`; `date_start` = now + 90 day; `duration_minutes` = `5`; `duration_hours` = `0`. Relations: `accounts` <- `billing_account`.
  2. `Email para o vendedor para acompanhar cliente` sends email using template `a1f752f1-4d2c-a045-518f-652c189ba8d1` with recipients: from: `crm@seepmode.com`; to: related field `assigned_user_name`.

### VM08 – Email a pedir faturação a Departamento de Faturação (Proposta Ganha) + Criação De Telefonema

- Workflow id: `1dd8e51c-60e3-8e5e-4535-66ffc3d266da`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `stage` (Fase proposta) equals `Closed Accepted` (Ganha).
  2. `AOS_Quotes` -> `empresa_c` (Empresa) equals `seepmed` (Seepmed).
- Results:
  1. `Email a pedir fatura ao departamento de Faturação` sends email using template `904168f0-a388-225d-46c5-650dde2759c5` with recipients: from: `crm@seepmed.pt`; to: `faturas@seepmed.pt`; cc: related field `assigned_user_name`.
  2. `Follow up Call` creates `Calls` linked to the triggering record with fields: `name` = `Proposta Ganha: Acompanhar Cliente`; `assigned_user_name` <- `assigned_user_name`; `date_start` = now + 3 day; `duration_minutes` = `5`; `duration_hours` = `0`. Relations: `accounts` <- `billing_account`.
  3. `Follow up email` sends email using template `5724c2d6-ab1a-a1fc-7de5-64f705ea28c0` with recipients: from: `crm@seepmed.pt`; to: related field `assigned_user_name`.

### VM09 – Email a pedir fatura a Departamento de Faturação (Renovação)

- Workflow id: `d8975df2-0af4-da3e-1917-672b9de36789`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `stage` (Fase proposta) equals `Negotiation` (Revisão).
  2. `AOS_Quotes` -> `empresa_c` (Empresa) equals `seepmed` (Seepmed).
  3. `AOS_Quotes` -> `data_prevista_fecho_c` (Data prevista fecho) equals today.
- Results:
  1. `Email a pedir fatura ao departamento de Faturação` sends email using template `904168f0-a388-225d-46c5-650dde2759c5` with recipients: from: `crm@seepmed.pt`; to: `faturas@seepmed.pt`; cc: related field `assigned_user_name`.
  2. `Follow up Call` creates `Calls` linked to the triggering record with fields: `name` = `Proposta Ganha: Acompanhar Cliente (Renovação))`; `assigned_user_name` <- `assigned_user_name`; `date_start` = now + 30 day; `duration_minutes` = `10`; `duration_hours` = `0`. Relations: `accounts` <- `billing_account`.
  3. `Follow up email` sends email using template `fe170555-65ca-40da-e3bf-672b9c744286` with recipients: from: `crm@seepmed.pt`; to: related field `assigned_user_name`.

### VM10 – Email a pedir Nota de Crédito à Faturação

- Workflow id: `ededd2bd-6651-7a21-7264-67f7f442f829`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `stage` (Fase proposta) equals `credit_note` (Nota de Crédito).
  2. `AOS_Quotes` -> `empresa_c` (Empresa) equals `seepmed` (Seepmed).
- Results:
  1. `Email a pedir fatura ao departamento de Faturação` sends email using template `1a14c029-6194-3072-d8b9-67f7f51e4920` with recipients: from: `crm@seepmed.pt`; to: `faturas@seepmed.pt`; cc: related field `assigned_user_name`.

### VM11 – Email a avisar o vendedor de que a proposta não foi aprovada

- Workflow id: `26e6db22-a1fe-1474-35aa-683ef94379dc`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `approval_status` (Situação de aprovação) equals `Not Approved` (Não aprovado).
  2. `AOS_Quotes` -> `empresa_c` (Empresa) equals `seepmed` (Seepmed).
- Results:
  1. `Email a avisar o vendedor de que a proposta não foi aprovada` sends email using template `b696435a-fd91-719c-ae53-683efb372596` with recipients: from: `faturas@seepmed.pt`; to: related field `assigned_user_name`; cc: `faturas@seepmed.pt`.

### VS07 – Email a pedir faturação a Departamento de Faturação (Proposta Ganha) + Criação De Telefonema

- Workflow id: `ccdf8e5c-b182-13dd-ada6-650dde5c00a0`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `stage` (Fase proposta) equals `Closed Accepted` (Ganha).
  2. `AOS_Quotes` -> `empresa_c` (Empresa) equals `seepmode` (Seepmode).
- Results:
  1. `Email a pedir fatura ao departamento de Faturação` sends email using template `904168f0-a388-225d-46c5-650dde2759c5` with recipients: from: `crm@seepmode.com`; to: `faturas@seepmode.com`; to: related field `assigned_user_name`.
  2. `Cria Telefonema de Acompanhamento` creates `Calls` linked to the triggering record with fields: `name` = `Proposta Ganha: Acompanhar Cliente`; `assigned_user_name` <- `assigned_user_name`; `date_start` = today + 3 day; `duration_minutes` = `5`; `duration_hours` = `0`. Relations: `accounts` <- `billing_account`.
  3. `Informa o vendedor que a proposta foi ganha e fechada` sends email using template `5724c2d6-ab1a-a1fc-7de5-64f705ea28c0` with recipients: from: `crm@seepmode.com`; to: related field `assigned_user_name`.

### VS08 – Email a pedir fatura a Departamento de Faturação (Renovação)

- Workflow id: `855728db-62f5-cf4b-53e0-672b9c61b762`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `stage` (Fase proposta) equals `Negotiation` (Revisão).
  2. `AOS_Quotes` -> `empresa_c` (Empresa) equals `seepmode` (Seepmode).
  3. `AOS_Quotes` -> `data_prevista_fecho_c` (Data prevista fecho) equals today.
- Results:
  1. `Email a pedir fatura ao departamento de Faturação` sends email using template `904168f0-a388-225d-46c5-650dde2759c5` with recipients: from: `crm@seepmode.com`; to: `faturas@seepmode.com`; to: related field `assigned_user_name`.
  2. `Follow up Call` creates `Calls` linked to the triggering record with fields: `name` = `Proposta Ganha: Acompanhar Cliente (Renovação)`; `assigned_user_name` <- `assigned_user_name`; `date_start` = now + 30 day; `duration_minutes` = `10`; `duration_hours` = `0`. Relations: `accounts` <- `billing_account`.
  3. `Follow up email` sends email using template `fe170555-65ca-40da-e3bf-672b9c744286` with recipients: from: `crm@seepmode.com`; to: related field `assigned_user_name`.

### VS09 – Email a pedir Nota de Crédito à Faturação

- Workflow id: `77105c67-0500-cc4b-cd26-67f7f3b78d20`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `stage` (Fase proposta) equals `credit_note` (Nota de Crédito).
  2. `AOS_Quotes` -> `empresa_c` (Empresa) equals `seepmode` (Seepmode).
- Results:
  1. `Email a pedir fatura ao departamento de Faturação` sends email using template `1a14c029-6194-3072-d8b9-67f7f51e4920` with recipients: from: `crm@seepmode.com`; to: `faturas@seepmode.com`; cc: related field `assigned_user_name`.

### VS10 – Email a avisar o vendedor de que a proposta não foi aprovada

- Workflow id: `3eac4553-7bca-85bc-9141-683ef490554b`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `AOS_Quotes` -> `approval_status` (Situação de aprovação) equals `Not Approved` (Não aprovado).
  2. `AOS_Quotes` -> `empresa_c` (Empresa) equals `seepmode` (Seepmode).
- Results:
  1. `Email a avisar o vendedor de que a proposta não foi aprovada` sends email using template `661deb48-bb79-8c61-4cde-683ef9e904f4` with recipients: from: `faturas@seepmode.com`; to: related field `assigned_user_name`; cc: `faturas@seepmode.com`.

## `Cases` — Assistências

### 01- Fecho de Assistencia (SON) PORTUGAL

- Workflow id: `258f0d8d-fae8-0c1c-b490-64fc916a73cc`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `Closed` (3 - Fechado).
  2. `Cases` -> `code_c` (Código) equals `1` (1 - Reinstalação), `2` (2 - Instalação), `3` (3 - Dúvidas Funcionais( Apoio Técnico)), `5` (5 - Peritagens), `6` (6 - Formação), `7` (7 - Envio de equip.), `8` (8 - Atualização), `9` (9 - Reclamações/Sugestões), `12` (12 - Pós Formação), `14` (14 - Receção/Avaria Hardware), `15` (15 - Envio T2S), `16` (16 - Envio SCR USB), `17` (17 - Envio Micro USB-B), `18` (18 - Envio Micro USB-C), `19` (19 - Envio Scanner), `20` (20 - Envio TTPRO2), `23` (23 - Atualização nº utilizadores), `24` (24 - Suporte técnico Online), `25` (25 - Suporte técnico Bloqueante), `26` (26 - Report de erros plataforma), `28` (28 - Ren Seeptrucker), `29` (29 - Teste Plataforma).
  3. `Cases` -> `automatic_email_sending_c` (Envio automático de Email ao Cliente quando encerrado assistência) equals `1`.
  4. `Cases > accounts` -> `billing_address_country` equals `Portugal` (Portugal).
- Results:
  1. `Fecho de Assistencia` sends email using template `efe64c8e-20f6-bbba-2345-650dd73abe5d` with recipients: from: `suporte@seepmode.com`; to: related field `account_name`; bcc: `suporte@seepmode.com`.

### 02- Fecho de Assistencia (ELIC) PORTUGAL

- Workflow id: `5aa258a5-d266-4e6d-d0b6-670d290e1e48`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `Closed` (3 - Fechado).
  2. `Cases` -> `code_c` (Código) equals `33`, `34`, `35`, `36`, `38`, `39`.
  3. `Cases` -> `automatic_email_sending_c` (Envio automático de Email ao Cliente quando encerrado assistência) equals `1`.
  4. `Cases > accounts` -> `billing_address_country` equals `Portugal` (Portugal).
- Results:
  1. `Fecho de Assistencia ELIC` sends email using template `8f100cf1-b03a-a3d6-c30e-670f945c3fe7` with recipients: from: `suporte@e-lic.eu`; to: related field `account_name`; bcc: `suporte@e-lic.eu`.

### 03 - Duplicar CRM para daqui a 3 meses (Fechado)

- Workflow id: `78bb7ffb-cf44-fb4c-4a20-66a7ba068561`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `Closed` (3 - Fechado).
  2. `Cases` -> `code_c` (Código) equals `13` (13 - CRM).
- Results:
  1. `Duplicar para daqui a 3 meses, e deixar assistencia vazia e aberta` creates `Cases` linked to the triggering record with fields: `name` = `CRM`; `priority` = `3` (3); `code_c` = `13` (13 - CRM); `datetime_assistence_c` = today; `deadline_c` = today + 3 month; `account_name` <- `account_name`; `status` = `New` (0 - Aberto); `assigned_user_name` <- `assigned_user_name`.

### 04 - Duplicar CRM para daqui a 1 semana (Pendente)

- Workflow id: `159178be-11f5-4791-a017-66a7c6f6c4ff`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `Pendente` (2 - Pendente).
  2. `Cases` -> `code_c` (Código) equals `13` (13 - CRM).
- Results:
  1. `Passar Assistência CRM para daqui a 1 semana a data limite` updates `Cases` with: `deadline_c` = today + 1 week.

### J01 - Fecho de Assistencia

- Workflow id: `cd02e65f-7eb9-3116-9884-66d9b1506dad`.
- Status: `Active`.
- Applies to: `New_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `Closed` (3 - Fechado).
  2. `Cases` -> `code_c` (Código) equals `40` (40 – Dúvida de interpretação legal), `41` (41 – Análise de Notificação GNR), `42` (42- Análise de Notificação ACT), `43` (43 – Excesso de condução 9h/10h), `44` (44 – Minoração de repouso abaixo de 9h/11h), `45` (45 – Excesso de condução contínua), `46` (46 – Excesso de condução semanal e bissemanal), `47` (47 – Âmbito de trabalho noturno), `48` (48 – Má comutação), `49` (49 – Minoração de repouso semanal), `50` (50 – Períodos não atribuídos), `51` (51 – Atividade desconhecida), `52` (52 – Diversos), `53` (53 – Análise de processo administrativo), `54` (54 – Defesa/Resposta Escrita), `55` (55 – Impugnação/Recurso Judicial), `56` (56 – Outros Assuntos), `57` (57 - Processos Trib.Trabalho).
  3. `Cases` -> `automatic_email_sending_c` (Envio automático de Email ao Cliente quando encerrado assistência) equals `1`.
- Results:
  1. `Enviar email ao cliente a avisar que a assistência Juridica foi encerrada` sends email using template `4834844a-1021-6e08-b19f-66d9af8db4ea` with recipients: from: `juridico@seepmode.com`; to: related field `account_name`; to: related field `contacts`; bcc: `juridico@seepmode.com`.

### J02 - Assistência Expirada

- Workflow id: `9d57b6cb-16ba-3ac7-3bbe-66d9bfa1d3b2`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `Expirado` (6 - Expirado).
  2. `Cases` -> `code_c` (Código) equals `40` (40 – Dúvida de interpretação legal), `41` (41 – Análise de Notificação GNR), `42` (42- Análise de Notificação ACT), `43` (43 – Excesso de condução 9h/10h), `44` (44 – Minoração de repouso abaixo de 9h/11h), `45` (45 – Excesso de condução contínua), `46` (46 – Excesso de condução semanal e bissemanal), `47` (47 – Âmbito de trabalho noturno), `48` (48 – Má comutação), `49` (49 – Minoração de repouso semanal), `50` (50 – Períodos não atribuídos), `51` (51 – Atividade desconhecida), `52` (52 – Diversos), `53` (53 – Análise de processo administrativo), `54` (54 – Defesa/Resposta Escrita), `55` (55 – Impugnação/Recurso Judicial), `56` (56 – Outros Assuntos), `57` (57 - Processos Trib.Trabalho).
  3. `Cases` -> `automatic_email_sending_c` (Envio automático de Email ao Cliente quando encerrado assistência) equals `1`.
- Results:
  1. `Enviar email ao cliente a avisar que a assistência Juridica foi encerrada` sends email using template `ee0c4aa5-82f0-d656-77a9-66d9bac54333` with recipients: from: `juridico@seepmode.com`; to: related field `account_name`; to: related field `contacts`; bcc: `juridico@seepmode.com`.

### J03 - Assistência Aberta

- Workflow id: `3c0c8cb5-548e-0188-5030-66d9bf10703b`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `New` (0 - Aberto).
  2. `Cases` -> `code_c` (Código) equals `40` (40 – Dúvida de interpretação legal), `41` (41 – Análise de Notificação GNR), `42` (42- Análise de Notificação ACT), `43` (43 – Excesso de condução 9h/10h), `44` (44 – Minoração de repouso abaixo de 9h/11h), `45` (45 – Excesso de condução contínua), `46` (46 – Excesso de condução semanal e bissemanal), `47` (47 – Âmbito de trabalho noturno), `48` (48 – Má comutação), `49` (49 – Minoração de repouso semanal), `50` (50 – Períodos não atribuídos), `51` (51 – Atividade desconhecida), `52` (52 – Diversos), `53` (53 – Análise de processo administrativo), `54` (54 – Defesa/Resposta Escrita), `55` (55 – Impugnação/Recurso Judicial), `56` (56 – Outros Assuntos), `57` (57 - Processos Trib.Trabalho).
  3. `Cases` -> `automatic_email_sending_c` (Envio automático de Email ao Cliente quando encerrado assistência) equals `1`.
- Results:
  1. `Enviar email ao cliente a avisar que a assistência Juridica foi aberta` sends email using template `b72002d9-e865-d0b5-fbc6-66d9bd79dd22` with recipients: from: `juridico@seepmode.com`; to: related field `account_name`; to: related field `contacts`; bcc: `juridico@seepmode.com`.

### SST04 - Envio do Relatório Técnico ao Cliente (Segurança)

- Workflow id: `4fb6cc58-ea96-6630-7b3b-66c8bf22eaf8`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `resolutions_date_c` (Data resolução) equals `NULL`.
  2. `Cases` -> `code_c` (Código) equals `201` (201 - Cronograma de implementação), `250` (250 - Pack Confort).
  3. `Cases` -> `status` (Situação:) equals `Realized` (4 - Realizado).
- Results:
  1. `Telefonema a Finalizar o registo` creates `Calls` linked to the triggering record with fields: `name` = `Finalizar Assistência`; `status` = `Planned` (Planeada); `date_start` = today + 1 week; `assigned_user_name` <- `modified_by_name`; `duration_minutes` = `10`; `duration_hours` = `0`. Relations: `accounts` <- `account_name`.
  2. `QAS (SGT)- data (Realizada)` creates `Cases` linked to the triggering record with fields: `name` = `QAS (SGT) -`; `status` = `Realized` (4 - Realizado); `assistence_datetime_c` = today; `code_c` = `255` (255 - Questionário de avaliação do serviço (SGT)); `area_c` = `SGT` (SGT); `service_date_c` <- `service_date_c`; `resolutions_date_c` <- `resolutions_date_c`. Relations: `accounts` <- `account_name`.
  3. `CI-AR-20– (Pendente)` creates `Cases` linked to the triggering record with fields: `name` = `CI-AR -`; `status` = `Pendente` (2 - Pendente); `assistence_datetime_c` = `service_date_c` + 1 year; `code_c` = `201` (201 - Cronograma de implementação); `area_c` <- `area_c`. Relations: `accounts` <- `account_name`.
  4. `SCL 20– (Pendente)` creates `Cases` linked to the triggering record with fields: `name` = `SCL -`; `status` = `Pendente` (2 - Pendente); `assistence_datetime_c` = `service_date_c` + 1 year; `code_c` = `254` (254 - Sensibilização em contexto laboral); `area_c` <- `area_c`. Relations: `accounts` <- `account_name`.
  5. `CT 20– (Pendente)` creates `Cases` linked to the triggering record with fields: `name` = `CT -`; `status` = `Pendente` (2 - Pendente); `assistence_datetime_c` = `service_date_c` + 1 year; `code_c` = `211` (211 - Consulta dos trabalhadores); `area_c` <- `area_c`. Relations: `accounts` <- `account_name`.

### SST05 - Envio do Relatório Técnico ao Cliente (SAUDE)

- Workflow id: `8db1b069-6fb6-9439-9748-66fd7110d398`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `resolutions_date_c` (Data resolução) equals `NULL`.
  2. `Cases` -> `code_c` (Código) equals `100` (100 - Consulta médica).
  3. `Cases` -> `status` (Situação:) equals `Realized` (4 - Realizado).
- Results:
  1. `QAS (SUT)- data (Realizada)` creates `Cases` linked to the triggering record with fields: `name` = `QAS (SUT) -`; `status` = `Realized` (4 - Realizado); `assistence_datetime_c` = today; `code_c` = `156` (156 - Questionário de avaliação do serviço (SUT)); `area_c` = `SUT` (SUT); `assigned_user_name` <- `assigned_user_name`; `service_date_c` <- `service_date_c`; `resolutions_date_c` <- `resolutions_date_c`. Relations: `accounts` <- `account_name`.

### SST06 - Envio do Relatório Técnico ao Cliente (HACCP)

- Workflow id: `3a1ac3d0-565a-b281-e563-670515f14113`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `resolutions_date_c` (Data resolução) equals `NULL`.
  2. `Cases` -> `code_c` (Código) equals `300` (300 - Auditoria de diagnóstico), `303` (303 - Analises Microbiológicas), `305` (305 - Auditorias de acompanhamento).
  3. `Cases` -> `status` (Situação:) equals `Realized` (4 - Realizado).
- Results:
  1. `QAS (HACCP)- data (Realizada)` creates `Cases` linked to the triggering record with fields: `name` = `QAS (HACCP) -`; `status` = `Realized` (4 - Realizado); `assistence_datetime_c` = today; `code_c` = `330` (330 - Questionário de avaliação do serviço (HACCP)); `area_c` = `SUT` (SUT); `service_date_c` <- `service_date_c`; `resolutions_date_c` <- `resolutions_date_c`. Relations: `accounts` <- `account_name`.

### SST07 - Envio de email a Solicitar o envio dos Documentos aplicáveis (SUT “100”)

- Workflow id: `a0f16549-9379-c077-2ce3-66d1d23eef06`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `hold` (1 - Em espera).
  2. `Cases` -> `code_c` (Código) equals `100` (100 - Consulta médica), `101` (101 - Teste de visão), `102` (102 - Outras biometrias), `103` (103 - Urina II), `104` (104 - Hemograma), `105` (105 - Velocidade de sedimentação), `106` (106 - Colesterol total), `107` (107 - Glicémia), `108` (108 - Audiometria), `109` (109 - Espirometria), `110` (110 - ECG (repouso).), `150` (150 - Pack Administrativo), `151` (151 - Pack Alimentar), `152` (152 - Pack Industrial), `153` (153 - Pack Rodoviário), `154` (154 - Pack Plus), `155` (155 - Pack Específico).
- Results:
  1. `Envia para o email do cliente   a solicitar o envio dos documentos aplicáveis (contrato e DRT atualizado).` sends email using template `930e1881-3514-67c8-6375-66d1d48420b5` with recipients: from: `marcacoes@seepmed.pt`; to: related field `account_name`; bcc: `marcacoes@seepmed.pt`.

### SST08 - Envio de email a Solicitar o envio dos Documentos aplicáveis (SGT "200")

- Workflow id: `2bb718c7-04c8-936c-1ed3-66d1d2946af7`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `hold` (1 - Em espera).
  2. `Cases` -> `code_c` (Código) equals `201` (201 - Cronograma de implementação), `250` (250 - Pack Confort).
- Results:
  1. `Envia para o email do cliente diretamente o relatório técnico` sends email using template `29ed6ba5-2628-5228-4889-66d1d476841e` with recipients: from: `sst@seepmed.pt`; to: related field `account_name`; bcc: `sst@seepmed.pt`.

### SST09 - Envio de email a Solicitar o envio dos Documentos aplicáveis (HACCP “300”)

- Workflow id: `33166f5e-129e-5d6e-7ac7-66d1d3960151`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Cases` -> `status` (Situação:) equals `hold` (1 - Em espera).
  2. `Cases` -> `code_c` (Código) equals `350` (350 - Pack HACCP).
- Results:
  1. `Envia para o email do cliente diretamente o relatório técnico` sends email using template `76897c9a-9664-6ce0-9d68-66d1d4117e23` with recipients: from: `sst@seepmed.pt`; to: related field `account_name`; bcc: `sst@seepmed.pt`.

## `Meetings`

### SST01 - Notificação por E-mail e Criação de Evento no Google Calendário para Auditorias de Saude

- Workflow id: `31c02483-51fb-f475-2d63-66c8b1a58554`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Meetings` -> `notificacao_de_auditoria_c` (Notificação auditoria ao cliente) equals `1`.
  2. `Meetings > case` -> `code_c` equals `100`, `101`, `102`, `103`, `104`, `105`, `106`, `107`, `108`, `109`, `110`, `150`, `151`, `152`, `153`, `154`, `155`, `156`, `200`.
- Results:
  1. `Notificar Cliente de Auditoria de SST de Saude` sends email using template `5a57a53b-d3d6-1bb3-c313-66eb083c52c3` with recipients: to: related field `accounts`.

### SST02 - Notificação por E-mail e Criação de Evento no Google Calendário para Auditorias de Segurança

- Workflow id: `b0a9df76-239d-f8e6-7591-66d9dcb65bb9`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Meetings` -> `notificacao_de_auditoria_c` (Notificação auditoria ao cliente) equals `1`.
  2. `Meetings > case` -> `code_c` equals `200`, `201`, `202`, `203`, `204`, `205`, `206`, `207`, `208`, `209`, `210`, `211`, `220`, `221`, `222`, `223`, `224`, `225`, `226`, `227`, `228`, `229`, `250`, `251`, `252`, `253`, `254`, `255`.
- Results:
  1. `Notificar Cliente de Auditoria de SST de SAUDE (FALTA MUDAR EMAIL)` sends email using template `dda6d6b8-1eca-b2a6-ee41-66c8b5e3cc62` with recipients: to: related field `accounts`.

### SST03 - Notificação por E-mail e Criação de Evento no Google Calendário para Auditorias de HACCP

- Workflow id: `4c17357d-a655-c41b-b8d1-66ebe93d3a94`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `Always`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Meetings` -> `notificacao_de_auditoria_c` (Notificação auditoria ao cliente) equals `1`.
  2. `Meetings > case` -> `code_c` equals `300`, `301`, `302`, `303`, `304`, `305`, `330`, `350`.
- Results:
  1. `Notificar Cliente de Auditoria de SST de SAUDE (FALTA MUDAR EMAIL)` sends email using template `5e055890-0f75-7826-bb25-66ebe9d45184` with recipients: to: related field `accounts`.

## `Project` — Medicinas Ocupacional

### SST10 - Envio de email a reelembrar o cliente 24h antes da FMO

- Workflow id: `bcfca5b0-e05d-bfa4-2fe8-66d1d7be4076`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Project` -> `estimated_start_date` (Data Prevista) equals today - 1 day.
  2. `Project` -> `medical_appreciation_c` (Apreciação médica) equals `Marcado` (Marcado).
- Results:
  1. `enviar automaticamente um email para o cliente a lembrar a(s) consulta(s) 24 horas antes;` sends email using template `36e326e7-37c5-ef48-4d6a-66d1d89543c9` with recipients: from: `marcacoes@seepmed.pt`; to: related field `accounts`; bcc: `marcacoes@seepmed.pt`.

### SST11 - Atualizar data prevista da FMO para daqui a 1 anos caso paciente > 50 anos

- Workflow id: `40200454-5981-32c7-37d4-66f2c48ac4d0`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Project` -> `medical_appreciation_c` (Apreciação médica) equals `fit` (Apto).
  2. `Project > contacts_project_1` -> `birthdate` (Data Nascimento:) is on or before today - 50 year.
- Results:
  1. `Cria uma nova FMO com data prevista para daqui a dois anos` creates `Project` linked to the triggering record with fields: `estimated_start_date` = `estimated_start_date` + 1 year; `admission_date_c` <- `admission_date_c`; `cat_profissional_c` <- `cat_profissional_c`; `medicine_exam_type_c` = `periodical` (Periódico); `medical_appreciation_c` = `Marcar` (Marcar). Relations: `contacts_project_1` <- `contacts_project_1_name`; `accounts_project_1accounts_ida` <- `accounts_project_1_name`.

### SST12 - Atualizar data prevista da FMO para daqui a 2 anos caso paciente < 50 anos

- Workflow id: `290c8fab-da2f-ad60-3fc7-66f2e5ba1f2b`.
- Status: `Active`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `Project` -> `medical_appreciation_c` (Apreciação médica) equals `fit` (Apto).
  2. `Project > contacts_project_1` -> `birthdate` (Data Nascimento:) is on or after today - 50 year.
- Results:
  1. `Cria uma nova FMO com data prevista para daqui a dois anos` creates `Project` linked to the triggering record with fields: `estimated_start_date` = `estimated_start_date` + 2 year; `cat_profissional_c` <- `cat_profissional_c`; `medicine_exam_type_c` = `periodical` (Periódico); `admission_date_c` <- `admission_date_c`; `medical_appreciation_c` = `Marcar` (Marcar). Relations: `contacts_project_1` <- `contacts_project_1_name`; `accounts_project_1accounts_ida` <- `accounts_project_1_name`.

## `sdmod_training` — Formações

### F01 – Instruções do curso de formação

- Workflow id: `f3d14a72-3495-03fc-9a59-650ee8a67124`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `sdmod_training` -> `status` (Estado) equals `Active` (Activa).
- Results:
  1. `Envia Email ao cliente com as Instruções` sends email using template `9f63a9fe-0dc7-8c90-dbae-650ee89c9ce5` with recipients: from: `formacao@seepmed.pt`; to: related field `accounts_sdmod_training_1_name`; bcc: `formacao@seepmed.pt`; cc: related field `assigned_user_name`.

### F02 – Pedido de Dados para a formacao quando está em Pre-planeamento (Sem CF)

- Workflow id: `c901b1c7-dd78-8766-476b-66eaf25995c3`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `sdmod_training` -> `status` (Estado) equals `Planning` (Planeamento).
  2. `sdmod_training` -> `formation_check_checkbox_c` (Com Cheque Formação) equals `Não` (Não).
- Results:
  1. `Envia Email ao cliente a solicitar dados (Sem CF)` sends email using template `9f63a9fe-0dc7-8c90-dbae-650ee89c9ce5` with recipients: from: `formacao@seepmed.pt`; to: related field `accounts_sdmod_training_1_name`; bcc: `formacao@seepmed.pt`; cc: related field `assigned_user_name`.

### F03 – Pedido de Dados para a formacao quando está em Pre-planeamento (Com CF)

- Workflow id: `ce38369a-a885-ce6c-8b87-66eaf200e746`.
- Status: `Inactive`.
- Applies to: `All_Records`.
- Run mode: `On_Save`.
- Multiple runs: `0`.
- Run on import: `0`.
- Conditions:
  1. `sdmod_training` -> `status` (Estado) equals `Planning` (Planeamento).
  2. `sdmod_training` -> `formation_check_checkbox_c` (Com Cheque Formação) equals `Sim` (Sim).
- Results:
  1. `Envia Email ao cliente a solicitar dados (Sem CF)` sends email using template `9f63a9fe-0dc7-8c90-dbae-650ee89c9ce5` with recipients: from: `formacao@seepmed.pt`; to: related field `accounts_sdmod_training_1_name`; bcc: `formacao@seepmed.pt`; cc: related field `assigned_user_name`.

