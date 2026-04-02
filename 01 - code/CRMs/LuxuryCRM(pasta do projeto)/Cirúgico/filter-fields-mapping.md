# SuiteCRM Filter Fields Mapping

**Date:** 2026-03-24
**Source:** SuiteCRM production screenshots
**Purpose:** Define the exact filter fields, labels, and input types for each module so LuxuryCRM filters match SuiteCRM 1:1.

## Clientes (Accounts)

| Label PT | Field Name | Input Type |
|---|---|---|
| Nome | name | text |
| NIF | sic_code | text |
| Telefone de trabalho | phone_office | text |
| Pesados | n_condutores_c | text |
| Faturacao - Rua | billing_address_street | text |
| Cidade | billing_address_city | text |
| Concelho | billing_address_state | dropdown (billing_state_list) |
| Local de Visita | place_of_visit_c | dropdown (billing_state_list) |
| Pais | billing_address_country | dropdown (countries_list) |
| N Cond. | n_condutores_c | text |
| Nuts II | nutsii_c | dropdown (nutsii_list) |
| N Func. | employees | text |
| Atribuido a | assigned_user_id | dropdown (users) |
| Data de criacao | date_entered | date (with operator: Igual) |
| Meus itens | current_user_only | checkbox |

## Propostas (Quotes)

| Label PT | Field Name | Input Type |
|---|---|---|
| Titulo | name | text |
| Fase proposta | quote_stage | multiselect (quote_stage_dom) |
| Clientes | billing_account_id | relate (Accounts) |
| Concelho | billing_address_state | text |
| Contactos | billing_contact_id | relate (Contacts) |
| Valido ate | valid_until | date (with operator) |
| Data prevista fecho | data_prevista_fecho_c | date (with operator) |
| Situacao de aprovacao | approval_status | multiselect (approval_status_dom) |
| Total final | total_amount | currency (with operator) |
| Condicoes de pagamento | payment_terms | multiselect (quote_term_dom) |
| Empresa | empresa_c | multiselect (empresa_list) |
| Data alteracao | date_modified | date (with operator) |
| Data criacao | date_entered | date (with operator) |
| Atribuido a | assigned_user_id | multiselect (users) |

## Faturas (Invoices)

| Label PT | Field Name | Input Type |
|---|---|---|
| Valor Aberto (EUR) | open_value_c | currency (with operator) |
| Data da fatura | invoice_date | date (with operator) |
| Data Pagamento | due_date | date (with operator) |
| Titulo | name | text |
| Clientes | billing_account_id | relate (Accounts) |
| Valor Pago (EUR) | paid_value_c | text |
| Total final | total_amount | currency (with operator) |
| Categoria do produto | product_category | multiselect |
| Produtos | product_name | multiselect |
| Itens de linha | line_items | text |
| Vendedor | salesperson_c | relate (Users) |
| Atribuido a | assigned_user_id | multiselect (users) |

## Contratos (Contracts)

| Label PT | Field Name | Input Type |
|---|---|---|
| N | name | text |
| Cliente | contract_account_id | relate (Accounts) |
| Anuidade | anuidade_c | multiselect (anuidade_list) |
| Data Renovacao | renewal_date_c | date (with operator) |
| Data inicio | start_date | date (with operator) |
| Valor do contrato | total_contract_value | currency (with operator) |
| Versao | versao_c | text |
| Data fim | end_date | date (with operator) |
| Pack | pack_c | multiselect (pack_list) |
| Estado do Pack | pack_state_c | multiselect (contracts_status_list) |
| Valor do Pack | renewal_value_c | text |
| Empresa | empresa_c | multiselect (empresa_list) |
| Tipo de contrato | contract_type | text |
| Gestor do contrato | contract_manager_id | multiselect (users) |

## Contactos (Contacts)

| Label PT | Field Name | Input Type |
|---|---|---|
| Nome proprio | first_name | text |
| Apelido | last_name | text |
| Todos os enderecos de email | email | text |
| Todos os telefones | phone | text |
| Todos os enderecos | primary_address_street | text |
| Nome da conta | account_id | dropdown (Accounts) with relate |
| Departamento | department | text |
| NIF | vat_number_c | text |
| Cidade | primary_address_city | text |
| Concelho | primary_address_state | text |
| Codigo postal | primary_address_postalcode | text |
| Pais | primary_address_country | text |
| Tipo | contact_type_c | dropdown (type_list) |
| Cargo | title | text |
| Atribuido a | assigned_user_id | dropdown (users) |
| Meus itens | current_user_only | checkbox |

## Telefonemas (Calls)

| Label PT | Field Name | Input Type |
|---|---|---|
| Assunto | name | text |
| Referente a | parent_name | text |
| Direcao | direction | dropdown (call_direction_dom) |
| Situacao | status | dropdown (call_status_dom) |
| Atribuido a | assigned_user_id | dropdown (users) |
| Data inicio | date_start | date (with operator) |
| Data criacao | date_entered | date (with operator) |
| Data alteracao | date_modified | date (with operator) |
| Meus itens | current_user_only | checkbox |
| Abrir itens | open_only | checkbox |

## Reunioes (Meetings)

| Label PT | Field Name | Input Type |
|---|---|---|
| Assunto | name | text |
| Cliente | parent_name | text |
| Situacao | status | dropdown (meeting_status_dom) |
| Atribuido a | assigned_user_id | dropdown (users) |
| Meus itens | current_user_only | checkbox |
| Abrir itens | open_only | checkbox |
| Meus favoritos | favorites_only | checkbox |

## Formacoes (Trainings)

| Label PT | Field Name | Input Type |
|---|---|---|
| Accao | formation_action | text |
| Cliente | account_id | relate (Accounts) |
| Ano | year | text |
| Local | place | text |
| Data Pagamento | payment_date | date (with operator) |
| Tipo de accao | formation_check_checkbox_c | text |
| Data Formacao | formation_date | date (with operator) |
| Data Envio Email Info ao Cliente | cliente_email_info_date_c | date (with operator) |
| Valor pago (EUR) | paid_value_c | currency (with operator) |
| Data Inicio Candidatura | data_candidatura_c | date (with operator) |
| Data Recepcao Info Cliente | client_tele_confirm_date_c | date (with operator) |
| Data envio certificados | sent_certificates_date | date (with operator) |
| Data Analise Estatistica | data_analise_estatistica_c | date (with operator) |
| Data Fecho accao | data_fecho_acao_c | date (with operator) |
| Data Digitalizacao | data_da_digitalizacao_c | date (with operator) |
| Estado | status | multiselect (campaign_status_dom) |
| NUTS II | nutsii_c | multiselect (nutsii_list) |
| Com Cheque Formacao | formation_check_checkbox_c | multiselect (yes_no_list) |
| Criado em | date_entered | date (with operator) |
| Atribuido a | assigned_user_id | relate (Users) |
| Vendedor | salesperson_c | relate (Users) |

## Formandos (TrainingControls)

| Label PT | Field Name | Input Type |
|---|---|---|
| N accao | action_number_c | text |
| Cliente | account_id | relate (Accounts) |
| Contacto | contact_id | relate (Contacts) |
| N de candidatura IEFP | iefp_application_number | text |

## Medicinas Ocupacional (Projects)

| Label PT | Field Name | Input Type |
|---|---|---|
| Cliente | account_id | relate (Accounts) |
| Concelho | billing_address_state | multiselect (billing_state_list) |
| Cidade | billing_address_city | text |
| Data de Nascimento | data_nascimento_c | date (with operator) |
| Sexo | contact_gender_c | multiselect (gender_list) |
| Tipo de exame | medicine_exam_type_c | multiselect (exam_type_list) |
| Apreciacao medica | medical_appreciation_c | multiselect (medical_appreciation_list) |
| Paciente | contact_id | relate (Contacts) |
| Medico/Enfermeira | nome_do_medico_c | relate (Users) |
| Data Prevista | estimated_start_date | date (with operator) |
| Data de alteracao | date_modified | date (with operator) |
| Data Presenca | attendance_date_c | date (with operator) |
| Data de admissao | admission_date_c | date (with operator) |
| NUTS II | nutsii_c | multiselect (nutsii_list) |
| Criado por | created_by | multiselect (users) |

## Fichas de Aptidao (Capabilities)

| Label PT | Field Name | Input Type |
|---|---|---|
| (field 1) | account_id | relate (Accounts) with dropdown |
| (field 2) | name | text |
| (field 3) | service_organization_c | dropdown |
| (field 4) | exam_date_c | date (with operator) |
| (field 5) | contact_id | dropdown |
| Atribuido a | assigned_user_id | dropdown (users) |
| Meus itens | current_user_only | checkbox |

## Notes

- **"with operator"** means the date field has an operator dropdown (Igual/Antes/Depois/Entre) before the date input
- **multiselect** means a multi-line list box where multiple values can be selected (not a single dropdown)
- **relate** means a text input with a search icon that opens a popup picker
- **dropdown** means a single-select `<select>` element
- **checkbox** means a boolean checkbox input
- **text** means a plain text `<input>`
- **currency (with operator)** means a number input preceded by an operator dropdown (Igual/Maior/Menor)
