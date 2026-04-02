# SuiteCRM — Field Nature Mapping

This document describes the fields listed in the `## Detail View Fields` section of `module_relations.md`.

Conventions:

- `Nature` is a human-readable description of the field behavior.
- `SuiteCRM Type` shows the effective vardef type, plus any detail-view override or function renderer.
- `Dropdown` is `Yes` for `enum`, `multienum`, `dynamicenum`, and function-based selectors such as `getCurrencyDropDown`.
- Dropdown value sets are centralized in the `Dropdown Lists` appendix at the end.
- Total mapped fields: `403`.
- Dropdown-capable fields: `54`.
- Unique dropdown sources: `40`.

- If a dropdown list does not exist in `pt_PT`, the appendix falls back to `en_us` and marks that explicitly.

## Account (Organização)

Module key: `Accounts`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `lbl_account_information` | `name` | Nome: | text | `name` | No |
| `lbl_account_information` | `phone_office` | Telefone de trabalho: | phone | `phone` | No |
| `lbl_account_information` | `website` | Sítio Internet: | URL shown as hyperlink | `url / detail link` | No |
| `lbl_account_information` | `phone_alternate` | Telefone alternativo: | phone | `phone` | No |
| `lbl_account_information` | `billing_address_street` | Endereço de faturação: | text | `varchar / detail address` | No |
| `lbl_account_information` | `shipping_address_street` | Endereço de envio: | text | `varchar / detail address` | No |
| `lbl_account_information` | `nutsii_c` | Nuts II | dynamic dropdown | `dynamicenum` | Yes: `app_list_strings.nutsii_list` |
| `lbl_account_information` | `place_of_visit_c` | Local de Visita | dynamic dropdown | `dynamicenum` | Yes: `app_list_strings.billing_state_list` |
| `lbl_account_information` | `email1` | Email: | email widget | `varchar / function getEmailAddressWidget` | No |
| `lbl_account_information` | `description` | Descrição: | long text | `text` | No |
| `LBL_PANEL_ADVANCED` | `account_type` | Tipo: | single-select dropdown | `enum` | Yes: `app_list_strings.account_type_dom` |
| `LBL_PANEL_ADVANCED` | `employees` | Nº Func.: | text | `varchar` | No |
| `LBL_PANEL_ADVANCED` | `industry` | Área de atividade: | single-select dropdown | `enum` | Yes: `app_list_strings.industry_dom` |
| `LBL_PANEL_ADVANCED` | `n_condutores_c` | Nº Cond. | text | `varchar` | No |
| `LBL_PANEL_ADVANCED` | `sic_code` | NIF: | text | `varchar` | No |
| `LBL_PANEL_ADVANCED` | `ticker_symbol` | Ligeiros | text | `varchar` | No |
| `LBL_PANEL_ADVANCED` | `parent_name` | Membro de: | related record | `relate` | No |
| `LBL_PANEL_ADVANCED` | `ownership` | Pesados: | text | `varchar` | No |
| `LBL_PANEL_ADVANCED` | `accounts_cae_c` | CAE | text | `varchar` | No |
| `LBL_PANEL_ADVANCED` | `employees_establishment_c` | Nº Estab. | text | `varchar` | No |
| `LBL_PANEL_ADVANCED` | `client_service_type_c` | Tipo | single-select dropdown | `enum` | Yes: `app_list_strings.client_service_type_list` |
| `LBL_PANEL_ADVANCED` | `send_payment_reminder_c` | Enviar lembrete de Pagamento | checkbox | `bool` | No |
| `LBL_PANEL_ASSIGNMENT` | `assigned_user_name` | Atribuído a: | related record | `relate` | No |

## Quotes (Propostas)

Module key: `AOS_Quotes`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `lbl_account_information` | `name` | Título | text | `name` | No |
| `lbl_account_information` | `billing_account` | Clientes | related record | `relate` | No |
| `lbl_account_information` | `number` | Número da proposta | integer number | `int` | No |
| `lbl_account_information` | `stage` | Fase proposta | single-select dropdown | `enum` | Yes: `app_list_strings.quote_stage_dom` |
| `lbl_account_information` | `expiration` | Válida até | date | `date` | No |
| `lbl_account_information` | `data_prevista_fecho_c` | Data prevista fecho | date | `date` | No |
| `lbl_account_information` | `invoice_status` | Situação da fatura | single-select dropdown | `enum` | Yes: `app_list_strings.quote_invoice_status_dom` |
| `lbl_account_information` | `term` | Condições de pagamento | single-select dropdown | `enum` | Yes: `app_list_strings.quote_term_dom` |
| `lbl_account_information` | `approval_status` | Situação de aprovação | single-select dropdown | `enum` | Yes: `app_list_strings.approval_status_dom` |
| `lbl_account_information` | `empresa_c` | Empresa | single-select dropdown | `enum` | Yes: `app_list_strings.empresa_list` |
| `lbl_account_information` | `approval_issue` | Descrição Proposta | long text | `text` | No |
| `lbl_account_information` | `invoicing_notes_c` | Notas para a Faturação | long text | `text` | No |
| `lbl_account_information` | `billing_contact` | Contactos | related record | `relate` | No |
| `lbl_account_information` | `assigned_user_name` | Atribuído a: | related record | `relate` | No |
| `lbl_line_items` | `currency_id` | Moeda: | currency selector | `id / function getCurrencyDropDown` | Yes: `function:getCurrencyDropDown` |
| `lbl_line_items` | `line_items` | Itens de linha | function-rendered widget | `function / function display_lines` | No |
| `lbl_line_items` | `total_amt` | Total | currency amount | `currency` | No |
| `lbl_line_items` | `discount_amount` | Desconto | currency amount | `currency` | No |
| `lbl_line_items` | `subtotal_amount` | Subtotal | currency amount | `currency` | No |
| `lbl_line_items` | `shipping_amount` | Portes de envio | currency amount | `currency` | No |
| `lbl_line_items` | `shipping_tax_amt` | Taxa de envio | currency amount | `currency / function display_shipping_vat` | No |
| `lbl_line_items` | `tax_amount` | Taxa | currency amount | `currency` | No |
| `lbl_line_items` | `total_amount` | Total final | currency amount | `currency` | No |

## Invoices (Faturas)

Module key: `AOS_Invoices`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `LBL_PANEL_OVERVIEW` | `name` | Título | text | `name` | No |
| `LBL_PANEL_OVERVIEW` | `salesperson_c` | Vendedor | related record | `relate` | No |
| `LBL_PANEL_OVERVIEW` | `number` | Número da fatura | integer number | `int` | No |
| `LBL_PANEL_OVERVIEW` | `billing_account` | Clientes | related record | `relate` | No |
| `LBL_PANEL_OVERVIEW` | `type_c` | Tipo | single-select dropdown | `enum` | Yes: `app_list_strings.type_invoice` |
| `LBL_PANEL_OVERVIEW` | `description` | Descrição | long text | `text` | No |
| `LBL_PANEL_OVERVIEW` | `invoice_date` | Data da fatura | date | `date` | No |
| `LBL_PANEL_OVERVIEW` | `paid_value_c` | Valor Pago (€) | currency amount | `currency` | No |
| `LBL_PANEL_OVERVIEW` | `due_date` | Data Pagamento | date | `date` | No |
| `LBL_PANEL_OVERVIEW` | `open_value_c` | Valor  Aberto (€) | currency amount | `currency` | No |
| `LBL_PANEL_OVERVIEW` | `legal_pack_c` | Pack Avançado | checkbox | `bool` | No |
| `LBL_PANEL_OVERVIEW` | `renovation_value_c` | Valor renovação (€) | currency amount | `currency` | No |
| `LBL_PANEL_OVERVIEW` | `quote_date` | Data Renovação | date | `date` | No |
| `LBL_PANEL_OVERVIEW` | `empresa_c` | Empresa | single-select dropdown | `enum` | Yes: `app_list_strings.empresa_list` |
| `LBL_PANEL_OVERVIEW` | `aos_contracts_aos_invoices_1_name` | Contratos | related record | `relate` | No |
| `LBL_PANEL_OVERVIEW` | `invoicing_notes_c` | Notas da Faturação | long text | `text` | No |
| `LBL_PANEL_OVERVIEW` | `payment_reminder_c` | Enviar Email Automático a Relembrar Pagamento | single-select dropdown | `enum` | Yes: `app_list_strings.yes_no_list` |
| `LBL_PANEL_OVERVIEW` | `status` | Situação | single-select dropdown | `enum` | Yes: `app_list_strings.invoice_status_dom` |
| `LBL_PANEL_OVERVIEW` | `date_entered` | Data de criação | date-time | `datetime` | No |
| `LBL_PANEL_OVERVIEW` | `assigned_user_name` | Atribuído a | related record | `relate` | No |
| `lbl_line_items` | `currency_id` | Moeda: | currency selector | `id / function getCurrencyDropDown` | Yes: `function:getCurrencyDropDown` |
| `lbl_line_items` | `line_items` | Itens de linha | function-rendered widget | `function / function display_lines` | No |
| `lbl_line_items` | `total_amt` | Total | currency amount | `currency` | No |
| `lbl_line_items` | `discount_amount` | Desconto | currency amount | `currency` | No |
| `lbl_line_items` | `subtotal_amount` | Subtotal | currency amount | `currency` | No |
| `lbl_line_items` | `shipping_amount` | Portes de envio | currency amount | `currency` | No |
| `lbl_line_items` | `shipping_tax_amt` | Taxa de envio | currency amount | `currency / function display_shipping_vat` | No |
| `lbl_line_items` | `tax_amount` | Taxa | currency amount | `currency` | No |
| `lbl_line_items` | `total_amount` | Total final | currency amount | `currency` | No |

## Contracts (Contratos)

Module key: `AOS_Contracts`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `default` | `name` | Nº | text | `name` | No |
| `default` | `assigned_user_name` | Gestor do contrato | related record | `relate` | No |
| `default` | `anuidade_c` | Anuidade | single-select dropdown | `enum` | Yes: `app_list_strings.anuidade_list` |
| `default` | `versao_c` | Versão | text | `varchar` | No |
| `default` | `start_date` | Data  início | date | `date` | No |
| `default` | `end_date` | Data  fim | date | `date` | No |
| `default` | `contract_account` | Cliente | related record | `relate` | No |
| `default` | `renewal_date_c` | Data Renovação | date | `date` | No |
| `default` | `net_value_c` | Valor Líquido € | currency amount | `currency` | No |
| `default` | `renewal_value_c` | Valor do Pack | currency amount | `currency` | No |
| `default` | `pack_c` | Pack | single-select dropdown | `enum` | Yes: `app_list_strings.pack_list` |
| `default` | `pack_state_c` | Estado do Pack | single-select dropdown | `enum` | Yes: `app_list_strings.contracts_status_list` |
| `default` | `description` | Descrição | long text | `text` | No |
| `default` | `empresa_c` | Empresa | single-select dropdown | `enum` | Yes: `app_list_strings.empresa_list` |
| `default` | `contact` | Contacto | related record | `relate` | No |
| `default` | `date_entered` | Data  criação | date-time | `datetime` | No |
| `lbl_line_items` | `currency_id` | Moeda: | currency selector | `id / function getCurrencyDropDown` | Yes: `function:getCurrencyDropDown` |
| `lbl_line_items` | `line_items` | Itens de linha | function-rendered widget | `function / function display_lines` | No |
| `lbl_line_items` | `total_amt` | Total | currency amount | `currency` | No |
| `lbl_line_items` | `discount_amount` | Desconto | currency amount | `currency` | No |
| `lbl_line_items` | `subtotal_amount` | Subtotal | currency amount | `currency` | No |
| `lbl_line_items` | `shipping_amount` | Portes de envio | currency amount | `currency` | No |
| `lbl_line_items` | `shipping_tax_amt` | Taxa de envio | currency amount | `currency / function display_shipping_vat` | No |
| `lbl_line_items` | `tax_amount` | Taxa | currency amount | `currency` | No |
| `lbl_line_items` | `total_amount` | Total final | currency amount | `currency` | No |

## Contacts (Contactos)

Module key: `Contacts`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `lbl_contact_information` | `first_name` | Nome próprio: | text | `varchar` | No |
| `lbl_contact_information` | `data_de_admissao_c` | Data Admissão | date | `date` | No |
| `lbl_contact_information` | `last_name` | Apelido: | text | `varchar` | No |
| `lbl_contact_information` | `phone_work` | Telefone trabalho: | phone | `phone` | No |
| `lbl_contact_information` | `birthdate` | Data Nascimento: | date | `date` | No |
| `lbl_contact_information` | `phone_mobile` | Telemóvel: | phone | `phone` | No |
| `lbl_contact_information` | `title` | Cargo: | text | `varchar` | No |
| `lbl_contact_information` | `phone_fax` | Fax: | phone | `phone` | No |
| `lbl_contact_information` | `department` | Departamento: | text | `varchar` | No |
| `lbl_contact_information` | `sessao_c` | Sessão | text | `varchar` | No |
| `lbl_contact_information` | `account_name` | Nome da conta: | related record | `relate` | No |
| `lbl_contact_information` | `profissao_c` | Profissão | text | `varchar` | No |
| `lbl_contact_information` | `primary_address_street` | Endereço principal: | text | `varchar / detail address` | No |
| `lbl_contact_information` | `alt_address_street` | Endereço alternativo: | text | `varchar / detail address` | No |
| `lbl_contact_information` | `cc_number_c` | Número CC | text | `varchar` | No |
| `lbl_contact_information` | `cc_expiration_date_c` | Data Validade CC | date | `date` | No |
| `lbl_contact_information` | `vat_number_c` | NIF | text | `varchar` | No |
| `lbl_contact_information` | `nutsii_c` | Nuts II | single-select dropdown | `enum` | Yes: `app_list_strings.nutsii_list` |
| `lbl_contact_information` | `marital_status_c` | Estado civil | single-select dropdown | `enum` | Yes: `app_list_strings.marital_status_list` |
| `lbl_contact_information` | `contact_nationality_c` | Nacionalidade | text | `varchar` | No |
| `lbl_contact_information` | `contact_gender_c` | Sexo | single-select dropdown | `enum` | Yes: `app_list_strings.gender_list` |
| `lbl_contact_information` | `literary_abilities_c` | Habilitações Literárias | single-select dropdown | `enum` | Yes: `app_list_strings.literary_abilities_list` |
| `lbl_contact_information` | `contacts_adr_c` | ADR? | single-select dropdown | `enum` | Yes: `app_list_strings.yes_no_list` |
| `lbl_contact_information` | `is_trainee_c` | É Formando? | checkbox | `bool` | No |
| `lbl_contact_information` | `is_trainer_c` | É Formador? | checkbox | `bool` | No |
| `lbl_contact_information` | `contact_type_c` | Tipo | multi-select dropdown | `multienum` | Yes: `app_list_strings.type_list` |
| `lbl_contact_information` | `email1` | Email: | email widget | `varchar / function getEmailAddressWidget` | No |
| `lbl_contact_information` | `description` | Descrição: | long text | `text` | No |
| `lbl_contact_information` | `tipo_de_recurso_c` | Tipo de Recurso: | text | `varchar` | No |
| `lbl_contact_information` | `numero_do_beneficiario_c` | Número do Beneficiário: | text | `varchar` | No |
| `lbl_contact_information` | `ultimo_exame_c` | Ultimo Exame: | text | `varchar` | No |
| `lbl_contact_information` | `proximo_exame_c` | Próximo Exame: | text | `varchar` | No |
| `LBL_PANEL_ADVANCED` | `report_to_name` | Supervisionado por: | related record | `relate` | No |
| `LBL_PANEL_ADVANCED` | `sync_contact` | Sincronizar contacto: | checkbox | `bool` | No |
| `LBL_PANEL_ADVANCED` | `lead_source` | Fonte da pista: | single-select dropdown | `enum` | Yes: `app_list_strings.lead_source_dom` |
| `LBL_PANEL_ADVANCED` | `do_not_call` | Não telefonar: | checkbox | `bool` | No |
| `LBL_PANEL_ADVANCED` | `campaign_name` | Campanha: | related record | `relate` | No |
| `LBL_PANEL_ASSIGNMENT` | `assigned_user_name` | Atribuído a: | related record | `relate` | No |

## Formações

Module key: `sdmod_training`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `default` | `formation_action` | Ação | text | `varchar` | No |
| `default` | `year` | Ano | text | `varchar` | No |
| `default` | `name` | Tipo de ação | text | `name` | No |
| `default` | `status` | Estado | single-select dropdown | `enum` | Yes: `app_list_strings.campaign_status_dom` |
| `default` | `formation_date` | Data  Formação | date-time | `datetimecombo` | No |
| `default` | `end_date_c` | Data Fim da Formação | date-time | `datetimecombo` | No |
| `default` | `accounts_sdmod_training_1_name` | Cliente | related record | `relate` | No |
| `default` | `trainer_c` | Formador | related record | `relate` | No |
| `default` | `contact` | Contacto | related record | `relate` | No |
| `default` | `sessions` | Sessões | text | `varchar` | No |
| `default` | `hours_number` | Nº horas | integer number | `int` | No |
| `default` | `adjudication_date` | Data  adjudicação | date | `date` | No |
| `default` | `formation_value` | Valor  formação (€) | currency amount | `currency` | No |
| `default` | `nutsii_c` | NUTS II | single-select dropdown | `enum` | Yes: `app_list_strings.nutsii_list` |
| `default` | `trainees_number` | Nº   Faturados | integer number | `int` | No |
| `default` | `trainees_average` | Média dos Formandos (€) | currency amount | `currency` | No |
| `default` | `trainees_number_action_c` | Nº  presenças | integer number | `int` | No |
| `default` | `formation_check_checkbox_c` | Com Cheque Formação | single-select dropdown | `enum` | Yes: `app_list_strings.yes_no_list` |
| `default` | `formation_check_quantity_c` | Nº cand | integer number | `int` | No |
| `default` | `data_candidatura_c` | Data Candidatura | date | `date` | No |
| `lbl_editview_panel4` | `verificarion_date_c` | Data Verificação | date | `date` | No |
| `lbl_editview_panel4` | `cliente_email_info_date_c` | Data Envio Email Info ao Cliente | date | `date` | No |
| `lbl_editview_panel4` | `trainee_info_deliver_date` | Data  entrega  informação do formando | date | `date` | No |
| `lbl_editview_panel4` | `client_tele_confirm_date_c` | Data Confirmação Telf Cliente | date | `date` | No |
| `lbl_editview_panel4` | `trainer_info_deliver_date_c` | Data Envio Adjudicação ao Formador | date | `date` | No |
| `lbl_editview_panel4` | `formation_reminder_date_c` | Data a Relembrar Formação | date | `date` | No |
| `lbl_editview_panel4` | `number_certificates_sent` | Nº certificados enviados | integer number | `int` | No |
| `lbl_editview_panel4` | `sent_certificates_date` | Data  envio  certificados | date | `date` | No |
| `lbl_editview_panel4` | `followup_client_c` | Followup Cliente | long text | `text` | No |
| `lbl_editview_panel4` | `observations_c` | Observações | long text | `text` | No |
| `lbl_editview_panel4` | `data_da_digitalizacao_c` | Data  Digitalização | date | `date` | No |
| `lbl_editview_panel4` | `data_analise_estatistica_c` | Data Análise Estatistica | date | `date` | No |
| `lbl_editview_panel4` | `closed_training_c` | Ação Fechada? | checkbox | `bool` | No |
| `lbl_editview_panel4` | `data_fecho_acao_c` | Data Fecho ação | date | `date` | No |
| `lbl_editview_panel4` | `issued_by_c` | Fechado por | related record | `relate` | No |
| `lbl_editview_panel1` | `place` | Local | text | `varchar` | No |
| `lbl_editview_panel1` | `local_invoice_number_c` | Nº  Fatura | text | `varchar` | No |
| `lbl_editview_panel1` | `address` | Morada | text | `varchar` | No |
| `lbl_editview_panel1` | `local_value_c` | Valor | currency amount | `currency` | No |
| `lbl_editview_panel1` | `room` | Sala | text | `varchar` | No |
| `lbl_editview_panel1` | `local_payment_date_c` | Data  Pagamento Sala | date | `date` | No |
| `lbl_editview_panel1` | `projector` | Projector | text | `varchar` | No |
| `lbl_editview_panel2` | `invoice_number_new_c` | Nº factura | text | `varchar` | No |
| `lbl_editview_panel2` | `payment_date` | Data  Pagamento | date | `date` | No |
| `lbl_editview_panel2` | `invoice_value` | Valor  factura (€) | currency amount | `currency` | No |
| `lbl_editview_panel2` | `paid_value_c` | Valor pago (€) | currency amount | `currency` | No |
| `lbl_editview_panel2` | `invoice_date` | Data  factura | date | `date` | No |
| `lbl_editview_panel3` | `assigned_user_name` | Atribuído a | related record | `relate` | No |
| `lbl_editview_panel3` | `salesperson_c` | Vendedor | related record | `relate` | No |

## Formadores

Module key: `sdmod_formation_trainers`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `default` | `trainer_name` | Nome | related record | `relate` | No |
| `default` | `hour_value` | Valor/Hora | currency amount | `currency` | No |
| `default` | `total_amount` | Valor Total | text | `varchar` | No |
| `default` | `receipt_number` | Número da Factura | text | `varchar` | No |
| `default` | `payment_date` | Data de pagamento | date | `date` | No |
| `default` | `receipt_date` | Data da factura | date | `date` | No |
| `default` | `registration_cost` | Valor do recibo (€) | currency amount | `currency` | No |
| `default` | `receipt_delivery_date_c` | Data Entrega Recibo | date | `date` | No |
| `default` | `trainer_info_date_c` | Dossier entregue pelo formador/a | date | `date` | No |
| `default` | `info_verification_date_c` | Data verificação do Dossier | date | `date` | No |
| `default` | `observations` | Observações | long text | `text` | No |

## Sessões

Module key: `sdmod_Sessions`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `default` | `sdmod_sessions_sdmod_training_name` | Formação | related record | `relate` | No |
| `default` | `name` | Nome | text | `name` | No |
| `default` | `abbreviation` | Abreviatura | text | `varchar` | No |
| `default` | `session` | Sessões | integer number | `int` | No |
| `default` | `description` | Descrição | long text | `text` | No |

## Assistências

Module key: `Cases`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `lbl_case_information` | `name` | Assunto: | text | `name` | No |
| `lbl_case_information` | `assistence_datetime_c` | Data | date | `date` | No |
| `lbl_case_information` | `mode_c` | Modo | single-select dropdown | `enum` | Yes: `app_list_strings.cases_mode_list` |
| `lbl_case_information` | `service_date_c` | Data do serviço/auditoria | date-time | `datetimecombo` | No |
| `lbl_case_information` | `send_receive_c` | Enviar/Receber | single-select dropdown | `enum` | Yes: `app_list_strings.send_receive_list` |
| `lbl_case_information` | `who_contacted_c` | Contacto | related record | `relate` | No |
| `lbl_case_information` | `area_c` | Área | single-select dropdown | `enum` | Yes: `app_list_strings.area_list` |
| `lbl_case_information` | `account_name` | Nome da conta: | related record | `relate` | No |
| `lbl_case_information` | `billing_address_country` | LBL_BILLING_ADDRESS_COUNTRY | single-select dropdown | `enum` | Yes: `app_list_strings.countries_list` |
| `lbl_case_information` | `billing_address_state` | Concelho | dynamic dropdown | `dynamicenum` | Yes: `app_list_strings.billing_state_list` |
| `lbl_case_information` | `deadline_c` | Data Limite | date | `date` | No |
| `lbl_case_information` | `priority` | Prioridade: | single-select dropdown | `enum` | Yes: `app_list_strings.priority_list` |
| `lbl_case_information` | `code_c` | Código | single-select dropdown | `enum` | Yes: `app_list_strings.code_list` |
| `lbl_case_information` | `inspectio_simulaction_c` | Simulação de Inspeção Realizada? | checkbox | `bool` | No |
| `lbl_case_information` | `status` | Situação: | single-select dropdown | `enum` | Yes: `app_list_strings.case_status_dom` |
| `lbl_case_information` | `resolutions_date_c` | Data resolução | date | `date` | No |
| `lbl_case_information` | `opened_by_c` | Aberto por | related record | `relate` | No |
| `lbl_case_information` | `closed_by_c` | Fechado por | related record | `relate` | No |
| `lbl_case_information` | `assigned_user_name` | Atribuído a: | related record | `relate` | No |
| `lbl_case_information` | `automatic_email_sending_c` | Envio automático de Email ao Cliente quando encerrado assistência | checkbox | `bool` | No |
| `lbl_case_information` | `aos_invoices_cases_1_name` | Faturas | related record | `relate` | No |
| `lbl_case_information` | `date_entered` | Criado em | date-time | `datetime` | No |
| `LBL_PANEL_ASSIGNMENT` | `problem_description_c` | Descrição do Problema / Serviços | text | `varchar` | No |
| `LBL_PANEL_ASSIGNMENT` | `suggestion_box` | Sugestões | readonly | `readonly` | No |
| `LBL_PANEL_ASSIGNMENT` | `resolution` | Resolução: | long text | `text` | No |
| `LBL_PANEL_ASSIGNMENT` | `update_text` | Atualizações - Texto | long text | `text` | No |
| `LBL_PANEL_ASSIGNMENT` | `hardware_c` | Hardware | text | `varchar` | No |
| `LBL_PANEL_ASSIGNMENT` | `units_c` | Unidades | integer number | `int` | No |
| `LBL_PANEL_ASSIGNMENT` | `internal` | Atualização interna | checkbox | `bool` | No |
| `LBL_PANEL_ASSIGNMENT` | `created_by_name` | Criado por | related record | `relate` | No |

## Medicina Ocupacional

Module key: `Project`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `lbl_project_information` | `contacts_project_1_name` | Paciente | related record | `relate` | No |
| `lbl_project_information` | `medicine_exam_number_c` | Nº Exame | text | `varchar` | No |
| `lbl_project_information` | `accounts_project_1_name` | Cliente | related record | `relate` | No |
| `lbl_project_information` | `estimated_start_date` | Data Prevista | date-time | `datetimecombo` | No |
| `lbl_project_information` | `cat_profissional_c` | Categoria Profissional | text | `varchar` | No |
| `lbl_project_information` | `medicine_exam_type_c` | Tipo de exame | single-select dropdown | `enum` | Yes: `app_list_strings.exam_type_list` |
| `lbl_project_information` | `admission_date_c` | Data de admissão | date | `date` | No |
| `lbl_project_information` | `assigned_user_name` | Gestor de projeto | related record | `relate` | No |
| `lbl_editview_panel1` | `family_history_irrelevant_c` | Irrelevante | checkbox | `bool` | No |
| `lbl_editview_panel1` | `family_history_relevant_c` | Relevante | checkbox | `bool` | No |
| `lbl_editview_panel1` | `family_history_which_c` | Qual | text | `varchar` | No |
| `lbl_editview_panel2` | `occupational_pro_disease_c` | Sem doenças | checkbox | `bool` | No |
| `lbl_editview_panel2` | `occupational_pro_declared_c` | Declaradas | checkbox | `bool` | No |
| `lbl_editview_panel2` | `occupational_pro_declared_t_c` | Quais? | text | `varchar` | No |
| `lbl_editview_panel2` | `occupational_pro_detected_c` | Detetadas | checkbox | `bool` | No |
| `lbl_editview_panel2` | `occupational_pro_disease_t_c` | Quais? | text | `varchar` | No |
| `lbl_editview_panel3` | `work_accidents_no_c` | Sem acidentes | checkbox | `bool` | No |
| `lbl_editview_panel3` | `work_accidents_yes_c` | Com acidentes | checkbox | `bool` | No |
| `lbl_editview_panel3` | `work_accidents_which_c` | Quais? | text | `varchar` | No |
| `lbl_editview_panel4` | `hazards_exposure_no_c` | Não | checkbox | `bool` | No |
| `lbl_editview_panel4` | `hazards_exposure_yes_c` | Sim | checkbox | `bool` | No |
| `lbl_editview_panel4` | `hazards_exposure_which_c` | Quais? | text | `varchar` | No |
| `lbl_editview_panel4` | `occupational_pro_exposure_c` | Avaliação da exposição profissional do trabalhador | text | `varchar` | No |
| `lbl_editview_panel5` | `alcohol_no_c` | Não | checkbox | `bool` | No |
| `lbl_editview_panel5` | `alcohol_yes_c` | Sim | checkbox | `bool` | No |
| `lbl_editview_panel5` | `alcohol_frequency_c` | Frequência | text | `varchar` | No |
| `lbl_editview_panel6` | `tobacco_no_c` | Não | checkbox | `bool` | No |
| `lbl_editview_panel6` | `tobacco_yes_c` | Sim | checkbox | `bool` | No |
| `lbl_editview_panel6` | `tobacco_frequency_c` | Frequencia | text | `varchar` | No |
| `lbl_editview_panel7` | `coffee_no_c` | Não | checkbox | `bool` | No |
| `lbl_editview_panel7` | `coffee_yes_c` | Sim | checkbox | `bool` | No |
| `lbl_editview_panel7` | `coffee_frequency_c` | Frequencia | text | `varchar` | No |
| `lbl_editview_panel8` | `medication_no_c` | Não | checkbox | `bool` | No |
| `lbl_editview_panel8` | `medication_yes_c` | Sim | checkbox | `bool` | No |
| `lbl_editview_panel8` | `medication_frequency_c` | Frequência | text | `varchar` | No |
| `lbl_editview_panel9` | `hobbies_c` | Passatempos | text | `varchar` | No |
| `lbl_editview_panel10` | `height_c` | Altura | text | `varchar` | No |
| `lbl_editview_panel10` | `weight_c` | Peso | text | `varchar` | No |
| `lbl_editview_panel10` | `pulse_c` | Pulsação | text | `varchar` | No |
| `lbl_editview_panel10` | `blood_pressure_min_c` | Tensão arterial (min-mmhg) | text | `varchar` | No |
| `lbl_editview_panel10` | `blood_pressure_max_c` | Tensão arterial (máx-mmhg) | text | `varchar` | No |
| `lbl_editview_panel18` | `vaccination_yes_c` | Atualizado | checkbox | `bool` | No |
| `lbl_editview_panel18` | `vaccination_no_c` | Não Atualizado | checkbox | `bool` | No |
| `lbl_editview_panel18` | `vaccination_which_c` | Quais? | text | `varchar` | No |
| `lbl_editview_panel18` | `vaccination_observations_c` | Observações ao boletim de vacinas | long text | `text` | No |
| `lbl_editview_panel11` | `blood_test_c` | Análises ao Sangue | checkbox | `bool` | No |
| `lbl_editview_panel11` | `ecg_c` | ECG | checkbox | `bool` | No |
| `lbl_editview_panel11` | `urine_tests_c` | Análises à Urina | checkbox | `bool` | No |
| `lbl_editview_panel11` | `rx_torax_c` | RX Tórax | checkbox | `bool` | No |
| `lbl_editview_panel11` | `stool_analyzes_c` | Análises às Fezes | checkbox | `bool` | No |
| `lbl_editview_panel11` | `ophthalmologi_tracking_c` | Rastreio oftalmológico | checkbox | `bool` | No |
| `lbl_editview_panel11` | `glycaemia_analyses_c` | Análises à Glicémia | checkbox | `bool` | No |
| `lbl_editview_panel11` | `cholesterol_analyses_c` | Análises ao Colestrol | checkbox | `bool` | No |
| `lbl_editview_panel11` | `audiometry_c` | Audiometria | checkbox | `bool` | No |
| `lbl_editview_panel11` | `spirometry_c` | Espirometria | checkbox | `bool` | No |
| `lbl_editview_panel11` | `others_c` | Outros | text | `varchar` | No |
| `lbl_editview_panel11` | `observations_c` | Observações | long text | `text` | No |
| `lbl_editview_panel12` | `health_problems_no_c` | Sem problemas de saúde | checkbox | `bool` | No |
| `lbl_editview_panel12` | `health_problems_yes_c` | Com problemas de saúde | checkbox | `bool` | No |
| `lbl_editview_panel12` | `presented_patholog_obs_c` | Observações | long text | `text` | No |
| `lbl_editview_panel13` | `recommendations_c` | Recomendações | long text | `text` | No |
| `lbl_editview_panel14` | `specialty_medical_assistant_c` | Médico Assistente | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_gynecology_c` | Ginecologia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_cardiology_c` | Cardiologia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_neurology_c` | Neurologia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_surgery_c` | Cirurgia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_ophthalmology_c` | Oftalmologia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_dermatology_c` | Dermatologia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_orthopedy_c` | Ortopedia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_endocrinology_c` | Endocrinologia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_otorrino_c` | Otorrinolaringologia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_stomatology_c` | Estomatologia | checkbox | `bool` | No |
| `lbl_editview_panel14` | `specialty_others_c` | Outros | text | `varchar` | No |
| `lbl_editview_panel15` | `advice_reduce_weight_c` | Reduzir peso corporal | checkbox | `bool` | No |
| `lbl_editview_panel15` | `advice_reduce_tobacco_c` | Reduzir consumo tabágico | checkbox | `bool` | No |
| `lbl_editview_panel15` | `advice_reduce_alcohol_c` | Reduzir consumo bebidas alcoólicas | checkbox | `bool` | No |
| `lbl_editview_panel15` | `advice_exercice_c` | Praticar exercício físico | checkbox | `bool` | No |
| `lbl_editview_panel15` | `advice_vaccines_c` | Atualizar vacinas | checkbox | `bool` | No |
| `lbl_editview_panel15` | `advice_others_c` | Outros | text | `varchar` | No |
| `lbl_editview_panel16` | `final_observations_c` | Observações Finais | long text | `text` | No |
| `lbl_editview_panel17` | `attendances_c` | Presenças | single-select dropdown | `enum` | Yes: `app_list_strings.attendances_list` |
| `lbl_editview_panel17` | `attendance_date_c` | Data Presença | date-time | `datetimecombo` | No |
| `lbl_editview_panel17` | `medical_appreciation_c` | Apreciação médica | single-select dropdown | `enum` | Yes: `app_list_strings.medical_appreciation_list` |
| `lbl_editview_panel17` | `nome_do_medico_c` | Nome do Médico | text | `varchar` | No |
| `lbl_editview_panel17` | `n_cedula_profissional_c` | Nº Cédula Profissional | text | `varchar` | No |
| `lbl_editview_panel17` | `medic_signature_c` | Assinatura (Médico) | text | `varchar` | No |
| `lbl_editview_panel17` | `am_projecttemplates_project_1_name` | Modelo de projeto | related record | `relate` | No |
| `lbl_editview_panel17` | `date_entered` | Data de criação: | date-time | `datetime` | No |
| `lbl_editview_panel17` | `date_modified` | Data de alteração: | date-time | `datetime` | No |
| `lbl_editview_panel17` | `override_business_hours` | Considerar dias úteis | checkbox | `bool` | No |

## Fichas de Aptidão

Module key: `sdmod_capability`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `lbl_editview_panel6` | `accounts_sdmod_capability_1_name` | Cliente | related record | `relate` | No |
| `lbl_editview_panel6` | `nipc_c` | NIPC/NIF | text | `varchar` | No |
| `lbl_editview_panel6` | `estabelecimento_c` | Estabelecimento | text | `varchar` | No |
| `lbl_editview_panel6` | `cae_c` | CAE principal | text | `varchar` | No |
| `lbl_editview_panel6` | `endereco_c` | Endereço | text | `varchar` | No |
| `lbl_editview_panel6` | `zip_code_c` | Código Postal | text | `varchar` | No |
| `lbl_editview_panel6` | `localidade_c` | Localidade | text | `varchar` | No |
| `lbl_editview_panel6` | `telefone_c` | Telefone | text | `varchar` | No |
| `lbl_editview_panel6` | `email_c` | E-mail | text | `varchar` | No |
| `lbl_editview_panel6` | `project_sdmod_capability_1_name` | Medicina Ocupacional | related record | `relate` | No |
| `lbl_editview_panel4` | `service_organization_c` | Modalidade de Organização do Serviço de Saúde do Trabalho | single-select dropdown | `enum` | Yes: `app_list_strings.service_organization_list` |
| `lbl_editview_panel4` | `service_organization_other_c` | Se outro, especifique | text | `varchar` | No |
| `lbl_editview_panel4` | `service_organization_name_c` | Designação da empresa de serviço externo de saúde de trabalho [se aplicável] | single-select dropdown | `enum` | Yes: `app_list_strings.service_organization_name_c_list` |
| `lbl_editview_panel4` | `service_organization_nipc_c` | NIPC/NIF | single-select dropdown | `enum` | Yes: `app_list_strings.service_organization_nipc_c_list` |
| `lbl_editview_panel4` | `dgs_authorization_process_c` | Processo de autorização (PA) da DGS nº | text | `varchar` | No |
| `lbl_editview_panel1` | `contacts_sdmod_capability_1_name` | Paciente | related record | `relate` | No |
| `lbl_editview_panel1` | `nacionalidade_c` | Nacionalidade | text | `varchar` | No |
| `lbl_editview_panel1` | `sexo_c` | Sexo | single-select dropdown | `enum` | Yes: `app_list_strings.sexo_c_list` |
| `lbl_editview_panel1` | `data_nascimento_c` | Data de nascimento | date | `date` | No |
| `lbl_editview_panel1` | `data_admissao_c` | Data de admissão na empresa | date | `date` | No |
| `lbl_editview_panel1` | `cat_profissional_c` | Categoria Profissional | text | `varchar` | No |
| `lbl_editview_panel1` | `posto_trabalho_c` | Posto de trabalho principal | text | `varchar` | No |
| `lbl_editview_panel1` | `atividade_funcao_c` | Atividade/Função (proposta ou atual) | text | `varchar` | No |
| `lbl_editview_panel1` | `data_admissao_atividade_c` | Data de admissão na Atividade/função | date | `date` | No |
| `lbl_editview_panel2` | `analise_posto_trabalho_c` | Análise do posto de trabalho: | single-select dropdown | `enum` | Yes: `app_list_strings.yes_no_list` |
| `lbl_editview_panel2` | `analise_posto_trabalho_justi_c` | Justificar em caso negativo | text | `varchar` | No |
| `lbl_editview_panel2` | `fatores_risco_pro_c` | Identificação de fatores de risco profissional | single-select dropdown | `enum` | Yes: `app_list_strings.yes_no_list` |
| `lbl_editview_panel2` | `fatores_risco_pro_especifica_c` | Especificar os principais fatores de risco profissional | long text | `text` | No |
| `lbl_editview_panel2` | `exposicao_profissional_c` | Avaliação da exposição profissional do trabalhador | single-select dropdown | `enum` | Yes: `app_list_strings.yes_no_list` |
| `lbl_editview_panel2` | `exposicao_profissional_espec_c` | Especificar a avaliação profissional | text | `varchar` | No |
| `lbl_editview_panel3` | `exam_date_c` | Data do exame | date | `date` | No |
| `lbl_editview_panel3` | `ability_result_c` | Resultado de aptidão | single-select dropdown | `enum` | Yes: `app_list_strings.medical_appreciation_list` |
| `lbl_editview_panel3` | `exam_type_c` | Tipo | single-select dropdown | `enum` | Yes: `app_list_strings.exam_type_list` |
| `lbl_editview_panel3` | `outras_funcoes_c` | Outras funções que pode desempenhar | long text | `text` | No |
| `lbl_editview_panel3` | `exam_type_other_c` | Se outro, especifique | text | `varchar` | No |
| `lbl_editview_panel5` | `recommendations_c` | Recomendações | multi-select dropdown | `multienum` | Yes: `app_list_strings.recommendations_list` |
| `lbl_editview_panel5` | `other_recommendations_c` | Outras recomendações | long text | `text` | No |
| `lbl_detailview_panel8` | `nome_do_medico_c` | Nome do Médico | text | `varchar` | No |
| `lbl_detailview_panel8` | `n_cedula_profissional_c` | Nº Cédula Profissional | text | `varchar` | No |
| `lbl_editview_panel7` | `assigned_user_name` | Gestor | related record | `relate` | No |

## Formandos

Module key: `sdmod_Training_control`

| Panel | Field | Label | Nature | SuiteCRM Type | Dropdown |
|---|---|---|---|---|---|
| `default` | `contacts_sdmod_training_control_1_name` | Contacto | related record | `relate` | No |
| `default` | `assigned_user_name` | Atribuído a | related record | `relate` | No |
| `default` | `accounts_sdmod_training_control_1_name` | Cliente | related record | `relate` | No |
| `default` | `action_number_c` | Nº acção | text | `varchar` | No |
| `default` | `description` | Nome da ação | long text | `text` | No |
| `default` | `formation_hours_c` | Horas | integer number | `int` | No |
| `default` | `training_types_c` | Tipos de Formação | single-select dropdown | `enum` | Yes: `app_list_strings.training_types_list` |
| `default` | `formation_place_c` | Local | text | `varchar` | No |
| `lbl_editview_panel4` | `iefp_submission_date` | Data Inicio Submissão IEFP Formando | date | `date` | No |
| `lbl_editview_panel4` | `iefp_application_number` | Nº de candidatura IEFP | text | `varchar` | No |
| `lbl_editview_panel4` | `trainee_application_date` | Data Candidatura Formando | date | `date` | No |
| `lbl_editview_panel4` | `candidature_status_c` | Estado Candidatura | single-select dropdown | `enum` | Yes: `app_list_strings.candidature_status_list` |
| `lbl_editview_panel4` | `iefp_verification_date` | Data Verificação portal IEFP - Estado da Candidatura | date | `date` | No |
| `lbl_editview_panel4` | `notification_changes_date` | Data Notificação do Pedido | date | `date` | No |
| `lbl_editview_panel4` | `answer_deadline` | Data limite p/ resposta | date | `date` | No |
| `lbl_editview_panel4` | `refusal_reasons` | Razões de indeferimento / Dados | long text | `text` | No |
| `lbl_editview_panel4` | `additional_data_date` | Data Pedido Dados Adicionais | date | `date` | No |
| `lbl_editview_panel4` | `additional_sent_data_date` | Data Envio Dados Adicionais Portal IEFP | date | `date` | No |
| `lbl_editview_panel4` | `iefp_approved_value` | Valor Aprovado em Candidatura IEFP (€) | currency amount | `currency` | No |
| `lbl_editview_panel4` | `customers_result_date` | Data Envio Resultado a Clientes | date | `date` | No |
| `lbl_editview_panel4` | `refusal_date` | Data Deferimento | date | `date` | No |
| `lbl_editview_panel4` | `iefp_process_closed` | Processo encerrado? | checkbox | `bool` | No |
| `lbl_editview_panel3` | `internal_certificate_date` | Data Emissão certificado Internos | date | `date` | No |
| `lbl_editview_panel3` | `certificate_sent_date` | Data envio certificado | date | `date` | No |
| `lbl_editview_panel3` | `intern_certificate_number_c` | Certificado Nº | text | `varchar` | No |
| `lbl_editview_panel3` | `intern_reference_c` | N/ Referência | text | `varchar` | No |
| `lbl_editview_panel3` | `intern_date_start_c` | Data da Ação - Inicio | date | `date` | No |
| `lbl_editview_panel3` | `intern_evaluation_c` | Avaliação | text | `varchar` | No |
| `lbl_editview_panel3` | `intern_date_end_c` | Data da Ação - Fim | date | `date` | No |
| `lbl_editview_panel2` | `certificate_issue_date` | Data Emissão Certificado SIGO | date | `date` | No |
| `lbl_editview_panel2` | `sigo_training_date` | Data inicial certificados SIGO | date | `date` | No |
| `lbl_editview_panel2` | `sigo_formation_code` | Código da Ação - SIGO | text | `varchar` | No |
| `lbl_editview_panel2` | `sigo_training_date_new_c` | Data final certificados SIGO | date | `date` | No |
| `lbl_editview_panel2` | `iefp__upload_date` | Data upload IEFP | date | `date` | No |
| `lbl_editview_panel2` | `sigo_n_c` | Sigo nº: | text | `varchar` | No |
| `lbl_editview_panel1` | `imtt_action_code` | Nº Código Acção IMT | text | `varchar` | No |
| `lbl_editview_panel1` | `application_start_date` | Data Inicio Candidatura | date | `date` | No |
| `lbl_editview_panel1` | `certificate_submission_date` | Data envio certificados | date | `date` | No |
| `lbl_editview_panel1` | `application_closing_date` | Data Fecho da Candidatura | date | `date` | No |
| `lbl_editview_panel1` | `process_closed` | Processo encerrado? | checkbox | `bool` | No |

## Dropdown Lists

This appendix expands the dropdown sources referenced in the module tables above.

### `function:getCurrencyDropDown`

- Source: dynamic function renderer `getCurrencyDropDown`
- Used by: `AOS_Contracts.currency_id`, `AOS_Invoices.currency_id`, `AOS_Quotes.currency_id`
- Options: dynamic from the active Currencies configuration; not stored in `app_list_strings`.

### `app_list_strings.account_type_dom`

- Source: `app_list_strings.account_type_dom` (pt_PT)
- Used by: `Accounts.account_type`

| Key | Label |
|---|---|
| `` |  |
| `Analyst` | Analista |
| `Competitor` | Concorrente |
| `Customer` | Cliente |
| `Integrator` | Integrador |
| `Investor` | Investidor |
| `Partner` | Parceiro |
| `Press` | Imprensa |
| `Prospect` | Cliente potencial |
| `Reseller` | Revendedor |
| `Other` | Outros |

### `app_list_strings.anuidade_list`

- Source: `app_list_strings.anuidade_list` (pt_PT)
- Used by: `AOS_Contracts.anuidade_c`

| Key | Label |
|---|---|
| `1_year` | 1 Ano |
| `1_2_year` | 1/2 anos |
| `2_2_year` | 2/2 Anos |
| `1_3_year` | 1/3 Anos |
| `2_3_year` | 2/3 Anos |
| `3_3_year` | 3/3 Anos |

### `app_list_strings.approval_status_dom`

- Source: `app_list_strings.approval_status_dom` (pt_PT)
- Used by: `AOS_Quotes.approval_status`

| Key | Label |
|---|---|
| `Approved` | Aprovado |
| `Not Approved` | Não aprovado |
| `awaiting` | Pendente |
| `` |  |

### `app_list_strings.area_list`

- Source: `app_list_strings.area_list` (pt_PT)
- Used by: `Cases.area_c`

| Key | Label |
|---|---|
| `Support` | Suporte |
| `Juridical` | Jurídico |
| `SGT` | SGT |
| `SUT` | SUT |
| `HACCP` | HACCP |

### `app_list_strings.attendances_list`

- Source: `app_list_strings.attendances_list` (pt_PT)
- Used by: `Project.attendances_c`

| Key | Label |
|---|---|
| `` |  |
| `Presenca` | Presença |
| `Faltou` | Faltou |

### `app_list_strings.billing_state_list`

- Source: `app_list_strings.billing_state_list` (pt_PT)
- Used by: `Accounts.place_of_visit_c`, `Cases.billing_address_state`

| Key | Label |
|---|---|
| `Portugal_Abrantes` | Abrantes |
| `Portugal_Acores` | Região Autónoma dos Açores |
| `Portugal_Águeda` | Águeda |
| `Portugal_Aguiar da Beira` | Aguiar da Beira |
| `Portugal_Alandroal` | Alandroal |
| `Portugal_Albergaria-a-Velha` | Albergaria-a-Velha |
| `Portugal_Albufeira` | Albufeira |
| `Portugal_Alcácer do Sal` | Alcácer do Sal |
| `Portugal_Alcanena` | Alcanena |
| `Portugal_Alcobaça` | Alcobaça |
| `Portugal_Alcochete` | Alcochete |
| `Portugal_Alcoutim` | Alcoutim |
| `Portugal_Alenquer` | Alenquer |
| `Portugal_Alfândega da Fé` | Alfândega da Fé |
| `Portugal_Alijó` | Alijó |
| `Portugal_Aljezur` | Aljezur |
| `Portugal_Aljustrel` | Aljustrel |
| `Portugal_Almada` | Almada |
| `Portugal_Almeida` | Almeida |
| `Portugal_Almeirim` | Almeirim |
| `Portugal_Almodôvar` | Almodôvar |
| `Portugal_Alpiarça` | Alpiarça |
| `Portugal_Alter do Chão` | Alter do Chão |
| `Portugal_Alvaiázere` | Alvaiázere |
| `Portugal_Alvito` | Alvito |
| `Portugal_Amadora` | Amadora |
| `Portugal_Amarante` | Amarante |
| `Portugal_Amares` | Amares |
| `Portugal_Anadia` | Anadia |
| `Portugal_Ansião` | Ansião |
| `Portugal_Arcos de Valdevez` | Arcos de Valdevez |
| `Portugal_Arganil` | Arganil |
| `Portugal_Armamar` | Armamar |
| `Portugal_Arouca` | Arouca |
| `Portugal_Arraiolos` | Arraiolos |
| `Portugal_Arronches` | Arronches |
| `Portugal_Arruda dos Vinhos` | Arruda dos Vinhos |
| `Portugal_Aveiro` | Aveiro |
| `Portugal_Avis` | Avis |
| `Portugal_Azambuja` | Azambuja |
| `Portugal_Baião` | Baião |
| `Portugal_Barcelos` | Barcelos |
| `Portugal_Barrancos` | Barrancos |
| `Portugal_Barreiro` | Barreiro |
| `Portugal_Batalha` | Batalha |
| `Portugal_Beja` | Beja |
| `Portugal_Belmonte` | Belmonte |
| `Portugal_Benavente` | Benavente |
| `Portugal_Bombarral` | Bombarral |
| `Portugal_Borba` | Borba |
| `Portugal_Boticas` | Boticas |
| `Portugal_Braga` | Braga |
| `Portugal_Bragança` | Bragança |
| `Portugal_Cabeceiras de Basto` | Cabeceiras de Basto |
| `Portugal_Cadaval` | Cadaval |
| `Portugal_Caldas da Rainha` | Caldas da Rainha |
| `Portugal_Caminha` | Caminha |
| `Portugal_Campo Maior` | Campo Maior |
| `Portugal_Cantanhede` | Cantanhede |
| `Portugal_Carrazeda de Ansiães` | Carrazeda de Ansiães |
| `Portugal_Carregal do Sal` | Carregal do Sal |
| `Portugal_Cartaxo` | Cartaxo |
| `Portugal_Cascais` | Cascais |
| `Portugal_Castanheira de Pêra` | Castanheira de Pêra |
| `Portugal_Castelo Branco` | Castelo Branco |
| `Portugal_Castelo de Paiva` | Castelo de Paiva |
| `Portugal_Castelo de Vide` | Castelo de Vide |
| `Portugal_Castro Daire` | Castro Daire |
| `Portugal_Castro Marim` | Castro Marim |
| `Portugal_Castro Verde` | Castro Verde |
| `Portugal_Celorico da Beira` | Celorico da Beira |
| `Portugal_Celorico de Basto` | Celorico de Basto |
| `Portugal_Chamusca` | Chamusca |
| `Portugal_Chaves` | Chaves |
| `Portugal_Cinfães` | Cinfães |
| `Portugal_Coimbra` | Coimbra |
| `Portugal_Condeixa-a-Nova` | Condeixa-a-Nova |
| `Portugal_Constância` | Constância |
| `Portugal_Coruche` | Coruche |
| `Portugal_Covilhã` | Covilhã |
| `Portugal_Crato` | Crato |
| `Portugal_Cuba` | Cuba |
| `Portugal_Elvas` | Elvas |
| `Portugal_Entroncamento` | Entroncamento |
| `Portugal_Espinho` | Espinho |
| `Portugal_Esposende` | Esposende |
| `Portugal_Estarreja` | Estarreja |
| `Portugal_Estremoz` | Estremoz |
| `Portugal_Évora` | Évora |
| `Portugal_Fafe` | Fafe |
| `Portugal_Faro` | Faro |
| `Portugal_Felgueiras` | Felgueiras |
| `Portugal_Ferreira do Alentejo` | Ferreira do Alentejo |
| `Portugal_Ferreira do Zêzere` | Ferreira do Zêzere |
| `Portugal_Figueira da Foz` | Figueira da Foz |
| `Portugal_Figueira de Castelo Rodrigo` | Figueira de Castelo Rodrigo |
| `Portugal_Figueiró dos Vinhos` | Figueiró dos Vinhos |
| `Portugal_Fornos de Algodres` | Fornos de Algodres |
| `Portugal_Freixo de Espada à Cinta` | Freixo de Espada à Cinta |
| `Portugal_Fronteira` | Fronteira |
| `Portugal_Fundão` | Fundão |
| `Portugal_Gavião` | Gavião |
| `Portugal_Góis` | Góis |
| `Portugal_Golegã` | Golegã |
| `Portugal_Gondomar` | Gondomar |
| `Portugal_Gouveia` | Gouveia |
| `Portugal_Grândola` | Grândola |
| `Portugal_Guarda` | Guarda |
| `Portugal_Guimarães` | Guimarães |
| `Portugal_Idanha-a-Nova` | Idanha-a-Nova |
| `Portugal_Ílhavo` | Ílhavo |
| `Portugal_Lagoa` | Lagoa |
| `Portugal_Lagos` | Lagos |
| `Portugal_Lamego` | Lamego |
| `Portugal_Leiria` | Leiria |
| `Portugal_Lisboa` | Lisboa |
| `Portugal_Loulé` | Loulé |
| `Portugal_Loures` | Loures |
| `Portugal_Lourinhã` | Lourinhã |
| `Portugal_Lousã` | Lousã |
| `Portugal_Lousada` | Lousada |
| `Portugal_Mação` | Mação |
| `Portugal_Macedo de Cavaleiros` | Macedo de Cavaleiros |
| `Portugal_Mafra` | Mafra |
| `Portugal_Maia` | Maia |
| `Portugal_Mangualde` | Mangualde |
| `Portugal_Manteigas` | Manteigas |
| `Portugal_Marco de Canaveses` | Marco de Canaveses |
| `Portugal_Madeira` | Madeira |
| `Portugal_Marinha Grande` | Marinha Grande |
| `Portugal_Marvão` | Marvão |
| `Portugal_Matosinhos` | Matosinhos |
| `Portugal_Mealhada` | Mealhada |
| `Portugal_Mêda` | Mêda |
| `Portugal_Melgaço` | Melgaço |
| `Portugal_Mértola` | Mértola |
| `Portugal_Mesão Frio` | Mesão Frio |
| `Portugal_Mira` | Mira |
| `Portugal_Miranda do Corvo` | Miranda do Corvo |
| `Portugal_Miranda do Douro` | Miranda do Douro |
| `Portugal_Mirandela` | Mirandela |
| `Portugal_Mogadouro` | Mogadouro |
| `Portugal_Moimenta da Beira` | Moimenta da Beira |
| `Portugal_Moita` | Moita |
| `Portugal_Monção` | Monção |
| `Portugal_Monchique` | Monchique |
| `Portugal_Mondim de Basto` | Mondim de Basto |
| `Portugal_Monforte` | Monforte |
| `Portugal_Montalegre` | Montalegre |
| `Portugal_Montemor-o-Novo` | Montemor-o-Novo |
| `Portugal_Montemor-o-Velho` | Montemor-o-Velho |
| `Portugal_Montijo` | Montijo |
| `Portugal_Mora` | Mora |
| `Portugal_Mortágua` | Mortágua |
| `Portugal_Moura` | Moura |
| `Portugal_Mourão` | Mourão |
| `Portugal_Murça` | Murça |
| `Portugal_Murtosa` | Murtosa |
| `Portugal_Nazaré` | Nazaré |
| `Portugal_Nelas` | Nelas |
| `Portugal_Nisa` | Nisa |
| `Portugal_Óbidos` | Óbidos |
| `Portugal_Odemira` | Odemira |
| `Portugal_Odivelas` | Odivelas |
| `Portugal_Oeiras` | Oeiras |
| `Portugal_Oleiros` | Oleiros |
| `Portugal_Olhão` | Olhão |
| `Portugal_Oliveira de Azeméis` | Oliveira de Azeméis |
| `Portugal_Oliveira de Frades` | Oliveira de Frades |
| `Portugal_Oliveira do Bairro` | Oliveira do Bairro |
| `Portugal_Oliveira do Hospital` | Oliveira do Hospital |
| `Portugal_Ourém` | Ourém |
| `Portugal_Ourique` | Ourique |
| `Portugal_Ovar` | Ovar |
| `Portugal_Paços de Ferreira` | Paços de Ferreira |
| `Portugal_Palmela` | Palmela |
| `Portugal_Pampilhosa da Serra` | Pampilhosa da Serra |
| `Portugal_Paredes` | Paredes |
| `Portugal_Paredes de Coura` | Paredes de Coura |
| `Portugal_Pedrógão Grande` | Pedrógão Grande |
| `Portugal_Penacova` | Penacova |
| `Portugal_Penafiel` | Penafiel |
| `Portugal_Penalva do Castelo` | Penalva do Castelo |
| `Portugal_Penamacor` | Penamacor |
| `Portugal_Penedono` | Penedono |
| `Portugal_Penela` | Penela |
| `Portugal_Peniche` | Peniche |
| `Portugal_Peso da Régua` | Peso da Régua |
| `Portugal_Pinhel` | Pinhel |
| `Portugal_Pombal` | Pombal |
| `Portugal_Ponte da Barca` | Ponte da Barca |
| `Portugal_Ponte de Lima` | Ponte de Lima |
| `Portugal_Ponte de Sor` | Ponte de Sor |
| `Portugal_Portalegre` | Portalegre |
| `Portugal_Portel` | Portel |
| `Portugal_Portimão` | Portimão |
| `Portugal_Porto` | Porto |
| `Portugal_Porto de Mós` | Porto de Mós |
| `Portugal_Póvoa de Lanhoso` | Póvoa de Lanhoso |
| `Portugal_Póvoa de Varzim` | Póvoa de Varzim |
| `Portugal_Proença-a-Nova` | Proença-a-Nova |
| `Portugal_Redondo` | Redondo |
| `Portugal_Reguengos de Monsaraz` | Reguengos de Monsaraz |
| `Portugal_Resende` | Resende |
| `Portugal_Ribeira de Pena` | Ribeira de Pena |
| `Portugal_Rio Maior` | Rio Maior |
| `Portugal_Sabrosa` | Sabrosa |
| `Portugal_Sabugal` | Sabugal |
| `Portugal_Salvaterra de Magos` | Salvaterra de Magos |
| `Portugal_Santa Comba Dão` | Santa Comba Dão |
| `Portugal_Santa Maria da Feira` | Santa Maria da Feira |
| `Portugal_Santa Marta de Penaguião` | Santa Marta de Penaguião |
| `Portugal_Santarém` | Santarém |
| `Portugal_Santiago do Cacém` | Santiago do Cacém |
| `Portugal_Santo Tirso` | Santo Tirso |
| `Portugal_São Brás de Alportel` | São Brás de Alportel |
| `Portugal_São João da Madeira` | São João da Madeira |
| `Portugal_São João da Pesqueira` | São João da Pesqueira |
| `Portugal_São Pedro do Sul` | São Pedro do Sul |
| `Portugal_Sardoal` | Sardoal |
| `Portugal_Sátão` | Sátão |
| `Portugal_Seia` | Seia |
| `Portugal_Seixal` | Seixal |
| `Portugal_Sernancelhe` | Sernancelhe |
| `Portugal_Serpa` | Serpa |
| `Portugal_Sertã` | Sertã |
| `Portugal_Sesimbra` | Sesimbra |
| `Portugal_Setúbal` | Setúbal |
| `Portugal_Sever do Vouga` | Sever do Vouga |
| `Portugal_Silves` | Silves |
| `Portugal_Sines` | Sines |
| `Portugal_Sintra` | Sintra |
| `Portugal_Sobral de Monte Agraço` | Sobral de Monte Agraço |
| `Portugal_Soure` | Soure |
| `Portugal_Sousel` | Sousel |
| `Portugal_Tábua` | Tábua |
| `Portugal_Tabuaço` | Tabuaço |
| `Portugal_Tarouca` | Tarouca |
| `Portugal_Tavira` | Tavira |
| `Portugal_Terras de Bouro` | Terras de Bouro |
| `Portugal_Tomar` | Tomar |
| `Portugal_Tondela` | Tondela |
| `Portugal_Torre de Moncorvo` | Torre de Moncorvo |
| `Portugal_Torres Novas` | Torres Novas |
| `Portugal_Torres Vedras` | Torres Vedras |
| `Portugal_Trancoso` | Trancoso |
| `Portugal_Trofa` | Trofa |
| `Portugal_Vagos` | Vagos |
| `Portugal_Vale de Cambra` | Vale de Cambra |
| `Portugal_Valença` | Valença |
| `Portugal_Valongo` | Valongo |
| `Portugal_Valpaços` | Valpaços |
| `Portugal_Vendas Novas` | Vendas Novas |
| `Portugal_Viana do Alentejo` | Viana do Alentejo |
| `Portugal_Viana do Castelo` | Viana do Castelo |
| `Portugal_Vidigueira` | Vidigueira |
| `Portugal_Vieira do Minho` | Vieira do Minho |
| `Portugal_Vila de Rei` | Vila de Rei |
| `Portugal_Vila do Bispo` | Vila do Bispo |
| `Portugal_Vila do Conde` | Vila do Conde |
| `Portugal_Vila Flor` | Vila Flor |
| `Portugal_Vila Franca de Xira` | Vila Franca de Xira |
| `Portugal_Vila Nova da Barquinha` | Vila Nova da Barquinha |
| `Portugal_Vila Nova de Cerveira` | Vila Nova de Cerveira |
| `Portugal_Vila Nova de Famalicão` | Vila Nova de Famalicão |
| `Portugal_Vila Nova de Foz Côa` | Vila Nova de Foz Côa |
| `Portugal_Vila Nova de Gaia` | Vila Nova de Gaia |
| `Portugal_Vila Nova de Paiva` | Vila Nova de Paiva |
| `Portugal_Vila Nova de Poiares` | Vila Nova de Poiares |
| `Portugal_Vila Pouca de Aguiar` | Vila Pouca de Aguiar |
| `Portugal_Vila Real` | Vila Real |
| `Portugal_Vila Real de Santo António` | Vila Real de Santo António |
| `Portugal_Vila Velha de Ródão` | Vila Velha de Ródão |
| `Portugal_Vila Verde` | Vila Verde |
| `Portugal_Vila Viçosa` | Vila Viçosa |
| `Portugal_Vimioso` | Vimioso |
| `Portugal_Vinhais` | Vinhais |
| `Portugal_Viseu` | Viseu |
| `Portugal_Vizela` | Vizela |
| `Portugal_Vouzela` | Vouzela |
| `Argentina_Antartica e Islas del Atlantico Sur` | Antartica e Islas del Atlantico Sur |
| `Argentina_Buenos Aires` | Buenos Aires |
| `Argentina_Buenos Aires Capital Federal` | Buenos Aires Capital Federal |
| `Argentina_Catamarca` | Catamarca |
| `Argentina_Chaco` | Chaco |
| `Argentina_Chubut` | Chubut |
| `Argentina_Cordoba` | Cordoba |
| `Argentina_Corrientes` | Corrientes |
| `Argentina_Entre Rios` | Entre Rios |
| `Argentina_Formosa` | Formosa |
| `Argentina_Jujuy` | Jujuy |
| `Argentina_La Pampa` | La Pampa |
| `Argentina_La Rioja` | La Rioja |
| `Argentina_Mendoza` | Mendoza |
| `Argentina_Misiones` | Misiones |
| `Argentina_Neuquen` | Neuquen |
| `Argentina_Rio Negro` | Rio Negro |
| `Argentina_Salta` | Salta |
| `Argentina_San Juan` | San Juan |
| `Argentina_San Luis` | San Luis |
| `Argentina_Santa Cruz` | Santa Cruz |
| `Argentina_Santa Fe` | Santa Fe |
| `Argentina_Santiago del Estero` | Santiago del Estero |
| `Argentina_Tierra del Fuego` | Tierra del Fuego |
| `Argentina_Tucuman` | Tucuman |
| `Belgium_Antwerpen` | Antwerpen |
| `Belgium_Limburg` | Limburg |
| `Belgium_Oost-Vlaanderen` | Oost-Vlaanderen |
| `Belgium_Vlaams-Brabant` | Vlaams-Brabant |
| `Belgium_West-Vlaanderen` | West-Vlaanderen |
| `Belgium_Henegouwen` | Henegouwen |
| `Belgium_Luik` | Luik |
| `Belgium_Luxemburg` | Luxemburg |
| `Belgium_Namen` | Namen |
| `Belgium_Waals-Brabant` | Waals-Brabant |
| `Belgium_Brussels-Capital` | Brussels-Capital |
| `Brazil_Acre` | Acre |
| `Brazil_Alagoas` | Alagoas |
| `Brazil_Amapa` | Amapa |
| `Brazil_Amazonas` | Amazonas |
| `Brazil_Bahia` | Bahia |
| `Brazil_Ceara` | Ceara |
| `Brazil_Distrito Federal` | Distrito Federal |
| `Brazil_Espirito Santo` | Espirito Santo |
| `Brazil_Goias` | Goias |
| `Brazil_Maranhao` | Maranhao |
| `Brazil_Mato Grosso` | Mato Grosso |
| `Brazil_Mato Grosso do Sul` | Mato Grosso do Sul |
| `Brazil_Minas Gerais` | Minas Gerais |
| `Brazil_Para` | Para |
| `Brazil_Paraiba` | Paraiba |
| `Brazil_Parana` | Parana |
| `Brazil_Pernambuco` | Pernambuco |
| `Brazil_Piaui` | Piaui |
| `Brazil_Rio de Janeiro` | Rio de Janeiro |
| `Brazil_Rio Grande do Norte` | Rio Grande do Norte |
| `Brazil_Rio Grande do Sul` | Rio Grande do Sul |
| `Brazil_Rondonia` | Rondonia |
| `Brazil_Roraima` | Roraima |
| `Brazil_Santa Catarina` | Santa Catarina |
| `Brazil_Sao Paulo` | Sao Paulo |
| `Brazil_Sergipe` | Sergipe |
| `Brazil_Tocantins` | Tocantins |
| `Bulgaria_Blagoevgrad` | Blagoevgrad |
| `Bulgaria_Burgas` | Burgas |
| `Bulgaria_Dobrich` | Dobrich |
| `Bulgaria_Gabrovo` | Gabrovo |
| `Bulgaria_Khaskovo` | Khaskovo |
| `Bulgaria_Kurdzhali` | Kurdzhali |
| `Bulgaria_Kyustendil` | Kyustendil |
| `Bulgaria_Lovech` | Lovech |
| `Bulgaria_Montana` | Montana |
| `Bulgaria_Pazardzhik` | Pazardzhik |
| `Bulgaria_Pernik` | Pernik |
| `Bulgaria_Pleven` | Pleven |
| `Bulgaria_Plovdiv` | Plovdiv |
| `Bulgaria_Razgrad` | Razgrad |
| `Bulgaria_Ruse` | Ruse |
| `Bulgaria_Shumen` | Shumen |
| `Bulgaria_Silistra` | Silistra |
| `Bulgaria_Sliven` | Sliven |
| `Bulgaria_Smolyan` | Smolyan |
| `Bulgaria_Sofiya` | Sofiya |
| `Bulgaria_Sofiya-Grad` | Sofiya-Grad |
| `Bulgaria_Stara Zagora` | Stara Zagora |
| `Bulgaria_Turgovishte` | Turgovishte |
| `Bulgaria_Varna` | Varna |
| `Bulgaria_Veliko Turnovo` | Veliko Turnovo |
| `Bulgaria_Vidin` | Vidin |
| `Bulgaria_Vratsa` | Vratsa |
| `Bulgaria_Yambol` | Yambol |
| `France_Alsace` | Alsace |
| `France_Aquitaine` | Aquitaine |
| `France_Auvergne` | Auvergne |
| `France_Basse-Normandie` | Basse-Normandie |
| `France_Bourgogne` | Bourgogne |
| `France_Bretagne` | Bretagne |
| `France_Centre` | Centre |
| `France_Champagne-Ardenne` | Champagne-Ardenne |
| `France_Corse` | Corse |
| `France_Franche-Comte` | Franche-Comte |
| `France_Haute-Normandie` | Haute-Normandie |
| `France_Ile-de-France` | Ile-de-France |
| `France_Languedoc-Roussillon` | Languedoc-Roussillon |
| `France_Limousin` | Limousin |
| `France_Lorraine` | Lorraine |
| `France_Midi-Pyrenees` | Midi-Pyrenees |
| `France_Nord-Pas-de-Calais` | Nord-Pas-de-Calais |
| `France_Pays de la Loire` | Pays de la Loire |
| `France_Picardie` | Picardie |
| `France_Poitou-Charentes` | Poitou-Charentes |
| `France_Provence-Alpes-Cote dAzur` | Provence-Alpes-Cote dAzur |
| `France_Rhone-Alpes` | Rhone-Alpes |
| `Germany_Brandenburg` | Brandenburg |
| `Germany_Berlin` | Berlin |
| `Germany_Baden-Württemberg` | Baden-Württemberg |
| `Germany_Bayern [Bavaria]` | Bayern [Bavaria] |
| `Germany_Bremen` | Bremen |
| `Germany_Hessen` | Hessen |
| `Germany_Hamburg` | Hamburg |
| `Germany_Mecklenburg-Vorpommern` | Mecklenburg-Vorpommern |
| `Germany_Niedersachsen [Lower Saxony]` | Niedersachsen [Lower Saxony] |
| `Germany_Nordrhein-Westfalen` | Nordrhein-Westfalen |
| `Germany_Rheinland-Pfalz [Palatinate]` | Rheinland-Pfalz [Palatinate] |
| `Germany_Schleswig-Holstein` | Schleswig-Holstein |
| `Germany_Saarland` | Saarland |
| `Germany_Sachsen [Saxony]` | Sachsen [Saxony] |
| `Germany_Sachsen-Anhalt [Saxony-Anhalt]` | Sachsen-Anhalt [Saxony-Anhalt] |
| `Germany_Thüringen [Thuringia]` | Thüringen [Thuringia] |
| `Greece_Achaea` | Achaea |
| `Greece_Aetolia-Acarnania` | Aetolia-Acarnania |
| `Greece_Arcadia` | Arcadia |
| `Greece_Argolis` | Argolis |
| `Greece_Arta` | Arta |
| `Greece_Athens` | Athens |
| `Greece_Boeotia` | Boeotia |
| `Greece_Chalcidice` | Chalcidice |
| `Greece_Chania` | Chania |
| `Greece_Chios` | Chios |
| `Greece_Corfu` | Corfu |
| `Greece_Corinthia` | Corinthia |
| `Greece_Cyclades` | Cyclades |
| `Greece_Dodecanese` | Dodecanese |
| `Greece_Drama` | Drama |
| `Greece_East Attica` | East Attica |
| `Greece_Elis` | Elis |
| `Greece_Euboea` | Euboea |
| `Greece_Evros` | Evros |
| `Greece_Evrytania` | Evrytania |
| `Greece_Florina` | Florina |
| `Greece_Grevena` | Grevena |
| `Greece_Heraklion` | Heraklion |
| `Greece_Imathia` | Imathia |
| `Greece_Ioannina` | Ioannina |
| `Greece_Karditsa` | Karditsa |
| `Greece_Kastoria` | Kastoria |
| `Greece_Kavala` | Kavala |
| `Greece_Kefalonia and Ithaka` | Kefalonia and Ithaka |
| `Greece_Kilkis` | Kilkis |
| `Greece_Kozani` | Kozani |
| `Greece_Laconia` | Laconia |
| `Greece_Larissa` | Larissa |
| `Greece_Lasithi` | Lasithi |
| `Greece_Lefkada` | Lefkada |
| `Greece_Lesbos` | Lesbos |
| `Greece_Magnesia` | Magnesia |
| `Greece_Messenia` | Messenia |
| `Greece_Pella` | Pella |
| `Greece_Phocis` | Phocis |
| `Greece_Phthiotis` | Phthiotis |
| `Greece_Pieria` | Pieria |
| `Greece_Piraeus` | Piraeus |
| `Greece_Preveza` | Preveza |
| `Greece_Rethymno` | Rethymno |
| `Greece_Rhodope` | Rhodope |
| `Greece_Samos` | Samos |
| `Greece_Serres` | Serres |
| `Greece_Thesprotia` | Thesprotia |
| `Greece_Thessaloniki` | Thessaloniki |
| `Greece_Trikala` | Trikala |
| `Greece_West Attica` | West Attica |
| `Greece_Xanthi` | Xanthi |
| `Greece_Zakynthos` | Zakynthos |
| `Ireland_Co. Carlow` | Co. Carlow |
| `Ireland_Co. Cavan` | Co. Cavan |
| `Ireland_Co. Clare` | Co. Clare |
| `Ireland_Co. Cork` | Co. Cork |
| `Ireland_Co. Donegal` | Co. Donegal |
| `Ireland_Co. Dublin` | Co. Dublin |
| `Ireland_Co. Galway` | Co. Galway |
| `Ireland_Co. Kerry` | Co. Kerry |
| `Ireland_Co. Kildare` | Co. Kildare |
| `Ireland_Co. Kilkenny` | Co. Kilkenny |
| `Ireland_Co. Laois` | Co. Laois |
| `Ireland_Co. Leitrim` | Co. Leitrim |
| `Ireland_Co. Limerick` | Co. Limerick |
| `Ireland_Co. Longford` | Co. Longford |
| `Ireland_Co. Louth` | Co. Louth |
| `Ireland_Co. Mayo` | Co. Mayo |
| `Ireland_Co. Meath` | Co. Meath |
| `Ireland_Co. Monaghan` | Co. Monaghan |
| `Ireland_Co. Offaly` | Co. Offaly |
| `Ireland_Co. Roscommon` | Co. Roscommon |
| `Ireland_Co. Sligo` | Co. Sligo |
| `Ireland_Co. Tipperary` | Co. Tipperary |
| `Ireland_Co. Waterford` | Co. Waterford |
| `Ireland_Co. Westmeath` | Co. Westmeath |
| `Ireland_Co. Wexford` | Co. Wexford |
| `Ireland_Co. Wicklow` | Co. Wicklow |
| `Italy_Agrigento` | Agrigento |
| `Italy_Alessandria` | Alessandria |
| `Italy_Ancona` | Ancona |
| `Italy_Aosta` | Aosta |
| `Italy_Ascoli Piceno` | Ascoli Piceno |
| `Italy_L Aquila` | L Aquila |
| `Italy_Arezzo` | Arezzo |
| `Italy_Asti` | Asti |
| `Italy_Avellino` | Avellino |
| `Italy_Bari` | Bari |
| `Italy_Bergamo` | Bergamo |
| `Italy_Biella` | Biella |
| `Italy_Belluno` | Belluno |
| `Italy_Benevento` | Benevento |
| `Italy_Bologna` | Bologna |
| `Italy_Brindisi` | Brindisi |
| `Italy_Brescia` | Brescia |
| `Italy_Barletta-Andria-Trani` | Barletta-Andria-Trani |
| `Italy_Bolzano-Bozen` | Bolzano-Bozen |
| `Italy_Cagliari` | Cagliari |
| `Italy_Campobasso` | Campobasso |
| `Italy_Caserta` | Caserta |
| `Italy_Chieti` | Chieti |
| `Italy_Carbonia-Inglesias` | Carbonia-Inglesias |
| `Italy_Caltanissetta` | Caltanissetta |
| `Italy_Cuneo` | Cuneo |
| `Italy_Como` | Como |
| `Italy_Cremona` | Cremona |
| `Italy_Cosenza` | Cosenza |
| `Italy_Catania` | Catania |
| `Italy_Catanzaro` | Catanzaro |
| `Italy_Enna` | Enna |
| `Italy_Forlì-Cesena` | Forlì-Cesena |
| `Italy_Ferrara` | Ferrara |
| `Italy_Foggia` | Foggia |
| `Italy_Firenze` | Firenze |
| `Italy_Fermo` | Fermo |
| `Italy_Frosinone` | Frosinone |
| `Italy_Genova` | Genova |
| `Italy_Gorizia` | Gorizia |
| `Italy_Grosseto` | Grosseto |
| `Italy_Imperia` | Imperia |
| `Italy_Isernia` | Isernia |
| `Italy_Crotone` | Crotone |
| `Italy_Lecco` | Lecco |
| `Italy_Lecce` | Lecce |
| `Italy_Livorno` | Livorno |
| `Italy_Lodi` | Lodi |
| `Italy_Latina` | Latina |
| `Italy_Lucca` | Lucca |
| `Italy_Monza e Brianza` | Monza e Brianza |
| `Italy_Macerata` | Macerata |
| `Italy_Messina` | Messina |
| `Italy_Milano` | Milano |
| `Italy_Mantova` | Mantova |
| `Italy_Modena` | Modena |
| `Italy_Massa-Carrara` | Massa-Carrara |
| `Italy_Matera` | Matera |
| `Italy_Napoli` | Napoli |
| `Italy_Novara` | Novara |
| `Italy_Nuoro` | Nuoro |
| `Italy_Ogliastra` | Ogliastra |
| `Italy_Oristano` | Oristano |
| `Italy_Olbia-Tempio` | Olbia-Tempio |
| `Italy_Palermo` | Palermo |
| `Italy_Piacenza` | Piacenza |
| `Italy_Padova` | Padova |
| `Italy_Pescara` | Pescara |
| `Italy_Perugia` | Perugia |
| `Italy_Pisa` | Pisa |
| `Italy_Pordenone` | Pordenone |
| `Italy_Prato` | Prato |
| `Italy_Parma` | Parma |
| `Italy_Pistoia` | Pistoia |
| `Italy_Pesaro e Urbino` | Pesaro e Urbino |
| `Italy_Pavia` | Pavia |
| `Italy_Potenza` | Potenza |
| `Italy_Ravenna` | Ravenna |
| `Italy_Reggio Calabria` | Reggio Calabria |
| `Italy_Reggio Elilia` | Reggio Elilia |
| `Italy_Ragusa` | Ragusa |
| `Italy_Rieti` | Rieti |
| `Italy_Roma` | Roma |
| `Italy_Rimini` | Rimini |
| `Italy_Rovigo` | Rovigo |
| `Italy_Salerno` | Salerno |
| `Italy_Siena` | Siena |
| `Italy_Sondrio` | Sondrio |
| `Italy_La Spezia` | La Spezia |
| `Italy_Siracusa` | Siracusa |
| `Italy_Sassari` | Sassari |
| `Italy_Savona` | Savona |
| `Italy_Taranto` | Taranto |
| `Italy_Teramo` | Teramo |
| `Italy_Trento` | Trento |
| `Italy_Torino` | Torino |
| `Italy_Trapani` | Trapani |
| `Italy_Terni` | Terni |
| `Italy_Trieste` | Trieste |
| `Italy_Treviso` | Treviso |
| `Italy_Udine` | Udine |
| `Italy_Varese` | Varese |
| `Italy_Verbano-Cusio-Ossola` | Verbano-Cusio-Ossola |
| `Italy_Vercelli` | Vercelli |
| `Italy_Venezia` | Venezia |
| `Italy_Vicenza` | Vicenza |
| `Italy_Verona` | Verona |
| `Italy_Medio Campidano` | Medio Campidano |
| `Italy_Viterbo` | Viterbo |
| `Italy_Vibo Valentia` | Vibo Valentia |
| `Lithuania_Akmenes Rajonas` | Akmenes Rajonas |
| `Lithuania_Alytaus Rajonas` | Alytaus Rajonas |
| `Lithuania_Alytus` | Alytus |
| `Lithuania_Anyksciu Rajonas` | Anyksciu Rajonas |
| `Lithuania_Birstonas` | Birstonas |
| `Lithuania_Birzu Rajonas` | Birzu Rajonas |
| `Lithuania_Druskininkai` | Druskininkai |
| `Lithuania_Ignalinos Rajonas` | Ignalinos Rajonas |
| `Lithuania_Jonavos Rajonas` | Jonavos Rajonas |
| `Lithuania_Joniskio Rajonas` | Joniskio Rajonas |
| `Lithuania_Jurbarko Rajonas` | Jurbarko Rajonas |
| `Lithuania_Kaisiadoriu Rajonas` | Kaisiadoriu Rajonas |
| `Lithuania_Kaunas` | Kaunas |
| `Lithuania_Kauno Rajonas` | Kauno Rajonas |
| `Lithuania_Kedainiu Rajonas` | Kedainiu Rajonas |
| `Lithuania_Kelmes Rajonas` | Kelmes Rajonas |
| `Lithuania_Klaipeda` | Klaipeda |
| `Lithuania_Klaipedos Rajonas` | Klaipedos Rajonas |
| `Lithuania_Kretingos Rajonas` | Kretingos Rajonas |
| `Lithuania_Kupiskio Rajonas` | Kupiskio Rajonas |
| `Lithuania_Lazdiju Rajonas` | Lazdiju Rajonas |
| `Lithuania_Marijampole` | Marijampole |
| `Lithuania_Marijampoles Rajonas` | Marijampoles Rajonas |
| `Lithuania_Mazeikiu Rajonas` | Mazeikiu Rajonas |
| `Lithuania_Moletu Rajonas` | Moletu Rajonas |
| `Lithuania_Neringa Pakruojo Rajonas` | Neringa Pakruojo Rajonas |
| `Lithuania_Palanga` | Palanga |
| `Lithuania_Panevezio Rajonas` | Panevezio Rajonas |
| `Lithuania_Panevezys` | Panevezys |
| `Lithuania_Pasvalio Rajonas` | Pasvalio Rajonas |
| `Lithuania_Plunges Rajonas` | Plunges Rajonas |
| `Lithuania_Prienu Rajonas` | Prienu Rajonas |
| `Lithuania_Radviliskio Rajonas` | Radviliskio Rajonas |
| `Lithuania_Raseiniu Rajonas` | Raseiniu Rajonas |
| `Lithuania_Rokiskio Rajonas` | Rokiskio Rajonas |
| `Lithuania_Sakiu Rajonas` | Sakiu Rajonas |
| `Lithuania_Salcininku Rajonas` | Salcininku Rajonas |
| `Lithuania_Siauliai` | Siauliai |
| `Lithuania_Siauliu Rajonas` | Siauliu Rajonas |
| `Lithuania_Silales Rajonas` | Silales Rajonas |
| `Lithuania_Silutes Rajonas` | Silutes Rajonas |
| `Lithuania_Sirvintu Rajonas` | Sirvintu Rajonas |
| `Lithuania_Skuodo Rajonas` | Skuodo Rajonas |
| `Lithuania_Svencioniu Rajonas` | Svencioniu Rajonas |
| `Lithuania_Taurages Rajonas` | Taurages Rajonas |
| `Lithuania_Telsiu Rajonas` | Telsiu Rajonas |
| `Lithuania_Traku Rajonas` | Traku Rajonas |
| `Lithuania_Ukmerges Rajonas` | Ukmerges Rajonas |
| `Lithuania_Utenos Rajonas` | Utenos Rajonas |
| `Lithuania_Varenos Rajonas` | Varenos Rajonas |
| `Lithuania_Vilkaviskio Rajonas` | Vilkaviskio Rajonas |
| `Lithuania_Vilniaus Rajonas` | Vilniaus Rajonas |
| `Lithuania_Vilnius` | Vilnius |
| `Lithuania_Zarasu Rajonas` | Zarasu Rajonas |
| `Netherlands_Drenthe` | Drenthe |
| `Netherlands_Flevoland` | Flevoland |
| `Netherlands_Friesland` | Friesland |
| `Netherlands_Gelderland` | Gelderland |
| `Netherlands_Groningen` | Groningen |
| `Netherlands_Limburg` | Limburg |
| `Netherlands_Noord-Brabant` | Noord-Brabant |
| `Netherlands_Noord-Holland` | Noord-Holland |
| `Netherlands_Overijssel` | Overijssel |
| `Netherlands_Utrecht` | Utrecht |
| `Netherlands_Zeeland` | Zeeland |
| `Netherlands_Zuid-Holland` | Zuid-Holland |
| `Poland_Dolnoslaskie` | Dolnoslaskie |
| `Poland_Kujawsko-Pomorskie` | Kujawsko-Pomorskie |
| `Poland_Lodzkie` | Lodzkie |
| `Poland_Lubelskie` | Lubelskie |
| `Poland_Lubuskie` | Lubuskie |
| `Poland_Malopolskie` | Malopolskie |
| `Poland_Mazowieckie` | Mazowieckie |
| `Poland_Opolskie` | Opolskie |
| `Poland_Podkarpackie` | Podkarpackie |
| `Poland_Podlaskie` | Podlaskie |
| `Poland_Pomorskie` | Pomorskie |
| `Poland_Slaskie` | Slaskie |
| `Poland_Swietokrzyskie` | Swietokrzyskie |
| `Poland_Warminsko-Mazurskie` | Warminsko-Mazurskie |
| `Poland_Wielkopolskie` | Wielkopolskie |
| `Poland_Zachodniopomorskie` | Zachodniopomorskie |
| `Romania_Alba` | Alba |
| `Romania_Arad` | Arad |
| `Romania_Arges` | Arges |
| `Romania_Bacau` | Bacau |
| `Romania_Bihor` | Bihor |
| `Romania_Bistrita-Nasaud` | Bistrita-Nasaud |
| `Romania_Botosani` | Botosani |
| `Romania_Braila` | Braila |
| `Romania_Brasov` | Brasov |
| `Romania_Bucuresti` | Bucuresti |
| `Romania_Buzau` | Buzau |
| `Romania_Calarasi` | Calarasi |
| `Romania_Caras-Severin` | Caras-Severin |
| `Romania_Cluj` | Cluj |
| `Romania_Constanta` | Constanta |
| `Romania_Covasna` | Covasna |
| `Romania_Dimbovita` | Dimbovita |
| `Romania_Dolj` | Dolj |
| `Romania_Galati` | Galati |
| `Romania_Giurgiu` | Giurgiu |
| `Romania_Gorj` | Gorj |
| `Romania_Harghita` | Harghita |
| `Romania_Hunedoara` | Hunedoara |
| `Romania_Ialomita` | Ialomita |
| `Romania_Iasi` | Iasi |
| `Romania_Maramures` | Maramures |
| `Romania_Mehedinti` | Mehedinti |
| `Romania_Mures` | Mures |
| `Romania_Neamt` | Neamt |
| `Romania_Olt` | Olt |
| `Romania_Prahova` | Prahova |
| `Romania_Salaj` | Salaj |
| `Romania_Satu Mare` | Satu Mare |
| `Romania_Sibiu` | Sibiu |
| `Romania_Suceava` | Suceava |
| `Romania_Teleorman` | Teleorman |
| `Romania_Timis` | Timis |
| `Romania_Tulcea` | Tulcea |
| `Romania_Vaslui` | Vaslui |
| `Romania_Vilcea` | Vilcea |
| `Romania_Vrancea` | Vrancea |
| `Russia_Республика Адыгея` | Республика Адыгея |
| `Russia_Республика Алтай` | Республика Алтай |
| `Russia_Амурская область` | Амурская область |
| `Russia_Архангельская область` | Архангельская область |
| `Russia_Астраханская область` | Астраханская область |
| `Russia_Республика Башкортостан` | Республика Башкортостан |
| `Russia_Белгородская область` | Белгородская область |
| `Russia_Брянская область` | Брянская область |
| `Russia_Республика Бурятия` | Республика Бурятия |
| `Russia_Чеченская Республика` | Чеченская Республика |
| `Russia_Челябинская область` | Челябинская область |
| `Russia_Чукотский АО` | Чукотский АО |
| `Russia_Чувашская Республика` | Чувашская Республика |
| `Russia_Республика Дагестан` | Республика Дагестан |
| `Russia_Республика Ингушетия` | Республика Ингушетия |
| `Russia_Иркутская область` | Иркутская область |
| `Russia_Ивановская область` | Ивановская область |
| `Russia_Камчатский край` | Камчатский край |
| `Russia_Кабардино-Балкарская Республика` | Кабардино-Балкарская Республика |
| `Russia_Карачаево-Черкесская Республика` | Карачаево-Черкесская Республика |
| `Russia_Краснодарский край` | Краснодарский край |
| `Russia_Кемеровская область` | Кемеровская область |
| `Russia_Калининградская область` | Калининградская область |
| `Russia_Курганская область` | Курганская область |
| `Russia_Хабаровский край` | Хабаровский край |
| `Russia_Ханты-Мансийский АО` | Ханты-Мансийский АО |
| `Russia_Кировская область` | Кировская область |
| `Russia_Республика Хакасия` | Республика Хакасия |
| `Russia_Республика Калмыкия` | Республика Калмыкия |
| `Russia_Калужская область` | Калужская область |
| `Russia_Республика Коми` | Республика Коми |
| `Russia_Костромская область` | Костромская область |
| `Russia_Республика Карелия` | Республика Карелия |
| `Russia_Курская область` | Курская область |
| `Russia_Красноярский край` | Красноярский край |
| `Russia_Ленинградская область` | Ленинградская область |
| `Russia_Липецкая область` | Липецкая область |
| `Russia_Алтайский край` | Алтайский край |
| `Russia_Магаданская область` | Магаданская область |
| `Russia_Республика Марий Эл` | Республика Марий Эл |
| `Russia_Республика Мордовия` | Республика Мордовия |
| `Russia_Московская область` | Московская область |
| `Russia_Москва` | Москва |
| `Russia_Мурманская область` | Мурманская область |
| `Russia_Ненецкий АО` | Ненецкий АО |
| `Russia_Новгородская область` | Новгородская область |
| `Russia_Нижегородская область` | Нижегородская область |
| `Russia_Новосибирская область` | Новосибирская область |
| `Russia_Омская область` | Омская область |
| `Russia_Оренбургская область` | Оренбургская область |
| `Russia_Орловская область` | Орловская область |
| `Russia_Пермский край` | Пермский край |
| `Russia_Пензенская область` | Пензенская область |
| `Russia_Приморский край` | Приморский край |
| `Russia_Псковская область` | Псковская область |
| `Russia_Ростовская область` | Ростовская область |
| `Russia_Рязанская область` | Рязанская область |
| `Russia_Республика Саха [Якутия]` | Республика Саха [Якутия] |
| `Russia_Сахалинская область` | Сахалинская область |
| `Russia_Самарская область` | Самарская область |
| `Russia_Саратовская область` | Саратовская область |
| `Russia_Республика Сев. Осетия-Алания` | Республика Сев. Осетия-Алания |
| `Russia_Смоленская область` | Смоленская область |
| `Russia_Санкт-Петербург` | Санкт-Петербург |
| `Russia_Ставропольский край` | Ставропольский край |
| `Russia_Свердловская область` | Свердловская область |
| `Russia_Республика Татарстан` | Республика Татарстан |
| `Russia_Тамбовская область` | Тамбовская область |
| `Russia_Томская область` | Томская область |
| `Russia_Тульская область` | Тульская область |
| `Russia_Тверская область` | Тверская область |
| `Russia_Республика Тыва` | Республика Тыва |
| `Russia_Тюменская область` | Тюменская область |
| `Russia_Удмуртская Республика` | Удмуртская Республика |
| `Russia_Ульяновская область` | Ульяновская область |
| `Russia_Волгоградская область` | Волгоградская область |
| `Russia_Владимирская область` | Владимирская область |
| `Russia_Вологодская область` | Вологодская область |
| `Russia_Воронежская область` | Воронежская область |
| `Russia_Ямало-Ненецкий АО` | Ямало-Ненецкий АО |
| `Russia_Ярославская область` | Ярославская область |
| `Russia_Еврейская АО` | Еврейская АО |
| `Russia_Забайкальский край` | Забайкальский край |
| `Slovenia_Ajdovscina` | Ajdovscina |
| `Slovenia_Beltinci` | Beltinci |
| `Slovenia_Bled` | Bled |
| `Slovenia_Bohinj` | Bohinj |
| `Slovenia_Borovnica` | Borovnica |
| `Slovenia_Bovec` | Bovec |
| `Slovenia_Brda` | Brda |
| `Slovenia_Brezice` | Brezice |
| `Slovenia_Brezovica` | Brezovica |
| `Slovenia_Cankova-Tisina` | Cankova-Tisina |
| `Slovenia_Celje` | Celje |
| `Slovenia_Cerklje na Gorenjskem` | Cerklje na Gorenjskem |
| `Slovenia_Cerknica` | Cerknica |
| `Slovenia_Cerkno` | Cerkno |
| `Slovenia_Crensovci` | Crensovci |
| `Slovenia_Crna na Koroskem` | Crna na Koroskem |
| `Slovenia_Crnomelj` | Crnomelj |
| `Slovenia_Destrnik-Trnovska Vas` | Destrnik-Trnovska Vas |
| `Slovenia_Divaca` | Divaca |
| `Slovenia_Dobrepolje` | Dobrepolje |
| `Slovenia_Dobrova-Horjul-Polhov Gradec` | Dobrova-Horjul-Polhov Gradec |
| `Slovenia_Dol pri Ljubljani` | Dol pri Ljubljani |
| `Slovenia_Domzale` | Domzale |
| `Slovenia_Dornava` | Dornava |
| `Slovenia_Dravograd` | Dravograd |
| `Slovenia_Duplek` | Duplek |
| `Slovenia_Gorenja Vas-Poljane` | Gorenja Vas-Poljane |
| `Slovenia_Gorisnica` | Gorisnica |
| `Slovenia_Gornja Radgona` | Gornja Radgona |
| `Slovenia_Gornji Grad` | Gornji Grad |
| `Slovenia_Gornji Petrovci` | Gornji Petrovci |
| `Slovenia_Grosuplje` | Grosuplje |
| `Slovenia_Hodos Salovci` | Hodos Salovci |
| `Slovenia_Hrastnik` | Hrastnik |
| `Slovenia_Hrpelje-Kozina` | Hrpelje-Kozina |
| `Slovenia_Idrija` | Idrija |
| `Slovenia_Ig` | Ig |
| `Slovenia_Ilirska Bistrica` | Ilirska Bistrica |
| `Slovenia_Ivancna Gorica` | Ivancna Gorica |
| `Slovenia_Izola` | Izola |
| `Slovenia_Jesenice` | Jesenice |
| `Slovenia_Jursinci` | Jursinci |
| `Slovenia_Kamnik` | Kamnik |
| `Slovenia_Kanal` | Kanal |
| `Slovenia_Kidricevo` | Kidricevo |
| `Slovenia_Kobarid` | Kobarid |
| `Slovenia_Kobilje` | Kobilje |
| `Slovenia_Kocevje` | Kocevje |
| `Slovenia_Komen` | Komen |
| `Slovenia_Koper` | Koper |
| `Slovenia_Kozje` | Kozje |
| `Slovenia_Kranj` | Kranj |
| `Slovenia_Kranjska Gora` | Kranjska Gora |
| `Slovenia_Krsko` | Krsko |
| `Slovenia_Kungota` | Kungota |
| `Slovenia_Kuzma` | Kuzma |
| `Slovenia_Lasko` | Lasko |
| `Slovenia_Lenart` | Lenart |
| `Slovenia_Lendava` | Lendava |
| `Slovenia_Litija` | Litija |
| `Slovenia_Ljubljana` | Ljubljana |
| `Slovenia_Ljubno` | Ljubno |
| `Slovenia_Ljutomer` | Ljutomer |
| `Slovenia_Logatec` | Logatec |
| `Slovenia_Loska Dolina` | Loska Dolina |
| `Slovenia_Loski Potok` | Loski Potok |
| `Slovenia_Luce` | Luce |
| `Slovenia_Lukovica` | Lukovica |
| `Slovenia_Majsperk` | Majsperk |
| `Slovenia_Maribor` | Maribor |
| `Slovenia_Medvode` | Medvode |
| `Slovenia_Menges` | Menges |
| `Slovenia_Metlika` | Metlika |
| `Slovenia_Mezica` | Mezica |
| `Slovenia_Miren-Kostanjevica` | Miren-Kostanjevica |
| `Slovenia_Mislinja` | Mislinja |
| `Slovenia_Moravce` | Moravce |
| `Slovenia_Moravske Toplice` | Moravske Toplice |
| `Slovenia_Mozirje` | Mozirje |
| `Slovenia_Murska Sobota` | Murska Sobota |
| `Slovenia_Muta` | Muta |
| `Slovenia_Naklo` | Naklo |
| `Slovenia_Nazarje` | Nazarje |
| `Slovenia_Nova Gorica` | Nova Gorica |
| `Slovenia_Novo Mesto` | Novo Mesto |
| `Slovenia_Odranci` | Odranci |
| `Slovenia_Ormoz` | Ormoz |
| `Slovenia_Osilnica` | Osilnica |
| `Slovenia_Pesnica` | Pesnica |
| `Slovenia_Piran` | Piran |
| `Slovenia_Pivka` | Pivka |
| `Slovenia_Podcetrtek` | Podcetrtek |
| `Slovenia_Podvelka-Ribnica` | Podvelka-Ribnica |
| `Slovenia_Postojna` | Postojna |
| `Slovenia_Preddvor` | Preddvor |
| `Slovenia_Ptuj` | Ptuj |
| `Slovenia_Puconci` | Puconci |
| `Slovenia_Race-Fram` | Race-Fram |
| `Slovenia_Radece` | Radece |
| `Slovenia_Radenci` | Radenci |
| `Slovenia_Radlje ob Dravi` | Radlje ob Dravi |
| `Slovenia_Radovljica` | Radovljica |
| `Slovenia_Ravne-Prevalje` | Ravne-Prevalje |
| `Slovenia_Ribnica` | Ribnica |
| `Slovenia_Rogasevci` | Rogasevci |
| `Slovenia_Rogaska Slatina` | Rogaska Slatina |
| `Slovenia_Rogatec` | Rogatec |
| `Slovenia_Ruse` | Ruse |
| `Slovenia_Semic` | Semic |
| `Slovenia_Sencur` | Sencur |
| `Slovenia_Sentilj` | Sentilj |
| `Slovenia_Sentjernej` | Sentjernej |
| `Slovenia_Sentjur pri Celju` | Sentjur pri Celju |
| `Slovenia_Sevnica` | Sevnica |
| `Slovenia_Sezana` | Sezana |
| `Slovenia_Skocjan` | Skocjan |
| `Slovenia_Skofja Loka` | Skofja Loka |
| `Slovenia_Skofljica` | Skofljica |
| `Slovenia_Slovenj Gradec` | Slovenj Gradec |
| `Slovenia_Slovenska Bistrica` | Slovenska Bistrica |
| `Slovenia_Slovenske Konjice` | Slovenske Konjice |
| `Slovenia_Smarje pri Jelsah` | Smarje pri Jelsah |
| `Slovenia_Smartno ob Paki` | Smartno ob Paki |
| `Slovenia_Sostanj` | Sostanj |
| `Slovenia_Starse` | Starse |
| `Slovenia_Store` | Store |
| `Slovenia_Sveti Jurij` | Sveti Jurij |
| `Slovenia_Tolmin` | Tolmin |
| `Slovenia_Trbovlje` | Trbovlje |
| `Slovenia_Trebnje` | Trebnje |
| `Slovenia_Trzic` | Trzic |
| `Slovenia_Turnisce` | Turnisce |
| `Slovenia_Velenje` | Velenje |
| `Slovenia_Velike Lasce` | Velike Lasce |
| `Slovenia_Videm` | Videm |
| `Slovenia_Vipava` | Vipava |
| `Slovenia_Vitanje` | Vitanje |
| `Slovenia_Vodice` | Vodice |
| `Slovenia_Vojnik` | Vojnik |
| `Slovenia_Vrhnika` | Vrhnika |
| `Slovenia_Vuzenica` | Vuzenica |
| `Slovenia_Zagorje ob Savi` | Zagorje ob Savi |
| `Slovenia_Zalec` | Zalec |
| `Slovenia_Zavrc` | Zavrc |
| `Slovenia_Zelezniki` | Zelezniki |
| `Slovenia_Ziri` | Ziri |
| `Slovenia_Zrece` | Zrece |
| `Spain_Albacete` | Albacete |
| `Spain_Alicante` | Alicante |
| `Spain_Almería` | Almería |
| `Spain_Asturias` | Asturias |
| `Spain_Badajoz` | Badajoz |
| `Spain_Balearic Islands` | Balearic Islands |
| `Spain_Barcelona` | Barcelona |
| `Spain_Biscay` | Biscay |
| `Spain_Burgos` | Burgos |
| `Spain_Cantabria` | Cantabria |
| `Spain_Castellón` | Castellón |
| `Spain_Ciudad Real` | Ciudad Real |
| `Spain_Cuenca` | Cuenca |
| `Spain_Cáceres` | Cáceres |
| `Spain_Cádiz` | Cádiz |
| `Spain_Córdoba` | Córdoba |
| `Spain_Gerona` | Gerona |
| `Spain_Granada` | Granada |
| `Spain_Guadalajara` | Guadalajara |
| `Spain_Guipúzcoa` | Guipúzcoa |
| `Spain_Huelva` | Huelva |
| `Spain_Huesca` | Huesca |
| `Spain_Jaén` | Jaén |
| `Spain_La Coruña` | La Coruña |
| `Spain_La Rioja` | La Rioja |
| `Spain_Las Palmas` | Las Palmas |
| `Spain_León` | León |
| `Spain_Lugo` | Lugo |
| `Spain_Lérida` | Lérida |
| `Spain_Madrid` | Madrid |
| `Spain_Murcia` | Murcia |
| `Spain_Málaga` | Málaga |
| `Spain_Navarre` | Navarre |
| `Spain_Orense` | Orense |
| `Spain_Palencia` | Palencia |
| `Spain_Pontevedra` | Pontevedra |
| `Spain_Salamanca` | Salamanca |
| `Spain_Santa Cruz` | Santa Cruz |
| `Spain_Segovia` | Segovia |
| `Spain_Sevilla` | Sevilla |
| `Spain_Soria` | Soria |
| `Spain_Tarragona` | Tarragona |
| `Spain_Teruel` | Teruel |
| `Spain_Toledo` | Toledo |
| `Spain_Valencia` | Valencia |
| `Spain_Valladolid` | Valladolid |
| `Spain_Zamora` | Zamora |
| `Spain_Zaragoza` | Zaragoza |
| `Spain_Álava` | Álava |
| `Spain_Ávila` | Ávila |
| `` |  |

### `app_list_strings.campaign_status_dom`

- Source: `app_list_strings.campaign_status_dom` (pt_PT)
- Used by: `sdmod_training.status`

| Key | Label |
|---|---|
| `` |  |
| `In Queue` | Pré-Planeamento |
| `Planning` | Planeamento |
| `Active` | Activa |
| `Inactive` | Cancelada |
| `Complete` | Finalizada |
| `Sending` | Outros |

### `app_list_strings.candidature_status_list`

- Source: `app_list_strings.candidature_status_list` (pt_PT)
- Used by: `sdmod_Training_control.candidature_status_c`

| Key | Label |
|---|---|
| `` |  |
| `review` | ANÁLISE |
| `APPROVED` | APROVADO |
| `canceled` | CANCELADO |
| `CONTRACTED` | CONTRATUALIZADO |
| `DECIDED` | DECIDIDO |
| `deferred` | DEFERIDO |
| `partial_deferred` | DEFERIMENTO PARCIAL |
| `closed` | ENCERRADO |
| `executed` | EXECUTADO |
| `Rejected` | INDEFERIDO |
| `intended_rejection` | INTENÇÃO INDEFERIMENTO |
| `NA` | NA (NÃO APLICÁVEL) |
| `data_request` | PEDIDO DE DADOS |
| `Verified` | VERIFICADO |
| `Alerta` | ALERTA - FALTA DADOS |

### `app_list_strings.case_status_dom`

- Source: `app_list_strings.case_status_dom` (pt_PT)
- Used by: `Cases.status`

| Key | Label |
|---|---|
| `New` | 0 - Aberto |
| `hold` | 1 - Em espera |
| `Pendente` | 2 - Pendente |
| `Closed` | 3 - Fechado |
| `Realized` | 4 - Realizado |
| `Finalized` | 5 - Finalizado |
| `Expirado` | 6 - Expirado |

### `app_list_strings.cases_mode_list`

- Source: `app_list_strings.cases_mode_list` (pt_PT)
- Used by: `Cases.mode_c`

| Key | Label |
|---|---|
| `Email` | Email |
| `Phone` | Telefone |
| `Presential` | Presencial |

### `app_list_strings.client_service_type_list`

- Source: `app_list_strings.client_service_type_list` (pt_PT)
- Used by: `Accounts.client_service_type_c`

| Key | Label |
|---|---|
| `` |  |
| `Mercadorias` | Mercadorias |
| `Passageiros` | Passageiros |

### `app_list_strings.code_list`

- Source: `app_list_strings.code_list` (pt_PT)
- Used by: `Cases.code_c`

| Key | Label |
|---|---|
| `` |  |
| `1` | 1 - Reinstalação |
| `2` | 2 - Instalação |
| `3` | 3 - Dúvidas Funcionais( Apoio Técnico) |
| `4` | 4 - Duvidas Legais( Apoio Jurídico) |
| `5` | 5 - Peritagens |
| `6` | 6 - Formação |
| `7` | 7 - Envio de equip. |
| `8` | 8 - Atualização |
| `9` | 9 - Reclamações/Sugestões |
| `10` | 10 - Correios/Doc/Fat |
| `11` | 11 - SI - Analise Infrações com renovação |
| `12` | 12 - Pós Formação |
| `13` | 13 - CRM |
| `14` | 14 - Receção/Avaria Hardware |
| `15` | 15 - Envio T2S |
| `16` | 16 - Envio SCR USB |
| `17` | 17 - Envio Micro USB-B |
| `18` | 18 - Envio Micro USB-C |
| `19` | 19 - Envio Scanner |
| `20` | 20 - Envio TTPRO2 |
| `21` | 21 - Solicitar dados Utilizador |
| `22` | 22 - Configurar Plataforma |
| `23` | 23 - Atualização nº utilizadores |
| `24` | 24 - Suporte técnico Online |
| `25` | 25 - Suporte técnico Bloqueante |
| `26` | 26 - Report de erros plataforma |
| `27` | 27 - Configurar APP |
| `28` | 28 - Ren Seeptrucker |
| `29` | 29 - Teste Plataforma |
| `40` | 40 – Dúvida de interpretação legal |
| `41` | 41 – Análise de Notificação GNR |
| `42` | 42- Análise de Notificação ACT |
| `43` | 43 – Excesso de condução 9h/10h |
| `44` | 44 – Minoração de repouso abaixo de 9h/11h |
| `45` | 45 – Excesso de condução contínua |
| `46` | 46 – Excesso de condução semanal e bissemanal |
| `47` | 47 – Âmbito de trabalho noturno |
| `48` | 48 – Má comutação |
| `49` | 49 – Minoração de repouso semanal |
| `50` | 50 – Períodos não atribuídos |
| `51` | 51 – Atividade desconhecida |
| `52` | 52 – Diversos |
| `53` | 53 – Análise de processo administrativo |
| `54` | 54 – Defesa/Resposta Escrita |
| `55` | 55 – Impugnação/Recurso Judicial |
| `56` | 56 – Outros Assuntos |
| `57` | 57 - Processos Trib.Trabalho |
| `60` | 60 - Cobranças Email Juridico |
| `61` | 61 - Cobranças Carta Advogado |
| `62` | 62 - Injunção de Cobrança |
| `70` | 70 - Fração de tempo |
| `71` | 71 - À peça |
| `72` | 72 - Avença |
| `90` | 90 - Contencioso |
| `91` | 91 - Execução |
| `100` | 100 - Consulta médica |
| `101` | 101 - Teste de visão |
| `102` | 102 - Outras biometrias |
| `103` | 103 - Urina II |
| `104` | 104 - Hemograma |
| `105` | 105 - Velocidade de sedimentação |
| `106` | 106 - Colesterol total |
| `107` | 107 - Glicémia |
| `108` | 108 - Audiometria |
| `109` | 109 - Espirometria |
| `110` | 110 - ECG (repouso). |
| `150` | 150 - Pack Administrativo |
| `151` | 151 - Pack Alimentar |
| `152` | 152 - Pack Industrial |
| `153` | 153 - Pack Rodoviário |
| `154` | 154 - Pack Plus |
| `155` | 155 - Pack Específico |
| `156` | 156 - Questionário de avaliação do serviço (SUT) |
| `200` | 200 - Avaliação de riscos do estabelecimento |
| `201` | 201 - Cronograma de implementação |
| `202` | 202 - Avaliação de riscos por atividade |
| `203` | 203 - Prestação de informação técnica |
| `204` | 204 - Preenchimento do anexo D do RU |
| `205` | 205 - Organização e compilação dos elementos relativos aos serviços prestados às empresas. |
| `206` | 206 - Avaliação de riscos psicossociais |
| `207` | 207 - Avaliação da iluminância |
| `208` | 208 - Avaliação de contaminantes químicos |
| `209` | 209 - Avaliação do ruído |
| `210` | 210 - Avaliação do ambiente térmico |
| `211` | 211 - Consulta dos trabalhadores |
| `220` | 220 - Medidas de autoproteção |
| `221` | 221 - Análise de incidentes |
| `222` | 222 - Plano de segurança e saúde |
| `223` | 223 - Fichas de procedimentos de segurança |
| `224` | 224 - Acompanhamento de segurança em obra |
| `225` | 225 - Coordenação de segurança em obra |
| `226` | 226 - Formação 8h |
| `227` | 227 - Formação 16h |
| `228` | 228 - Formação 24h |
| `229` | 229 - Formação 35h |
| `250` | 250 - Pack Confort |
| `251` | 251 - Pack Premium |
| `252` | 252 - Pack Excelência |
| `253` | 253 - Pack Personalizado |
| `254` | 254 - Sensibilização em contexto laboral |
| `255` | 255 - Questionário de avaliação do serviço (SGT) |
| `300` | 300 - Auditoria de diagnóstico |
| `301` | 301 - Implementação do sistema HACCP |
| `302` | 302 - Actualização do sistema HACCP |
| `303` | 303 - Analises Microbiológicas |
| `304` | 304 - Ação de sensibilização |
| `305` | 305 - Auditorias de acompanhamento |
| `330` | 330 - Questionário de avaliação do serviço (HACCP) |
| `350` | 350 - Pack HACCP |
| `500` | 500 - Auditoria |
| `501` | 501 - Código de Conduta |
| `502` | 502 - Formação |
| `503` | 503 - Preparação Técnica |
| `504` | 504 - DPO |

### `app_list_strings.contracts_status_list`

- Source: `app_list_strings.contracts_status_list` (pt_PT)
- Used by: `AOS_Contracts.pack_state_c`

| Key | Label |
|---|---|
| `Active` | Activo |
| `active_terminated` | Ativo mas rescindiu |
| `Finished` | Terminado |
| `Pendente` | Pendente |
| `Nao_quer` | Não Quer |
| `Awaiting_Payment` | Falta Contrato e pagamento |
| `Awaiting_Contract` | Falta Contrato |
| `Awiating_payment` | Falta Pagamento |
| `Awaiting_Payment_terminated` | Falta Pagamento mas Rescindiu |
| `nao_aplicavel` | Não aplicável |
| `Rescindiu` | Rescindiu |

### `app_list_strings.countries_list`

- Source: `app_list_strings.countries_list` (pt_PT)
- Used by: `Cases.billing_address_country`

| Key | Label |
|---|---|
| `` |  |
| `Germany` | Alemanha |
| `Argentina` | Argentina |
| `Belgium` | Bélgica |
| `Brazil` | Brazil |
| `Bulgaria` | Bulgaria |
| `Slovenia` | Eslovénia |
| `Spain` | Espanha |
| `France` | França |
| `Greece` | Grécia |
| `Ireland` | Irlanda |
| `Italy` | Itália |
| `Lithuania` | Lituania |
| `Russia` | Russia |
| `Romania` | Romenia |
| `Netherlands` | Países Baixos |
| `Portugal` | Portugal |
| `Poland` | Polonia |

### `app_list_strings.empresa_list`

- Source: `app_list_strings.empresa_list` (pt_PT)
- Used by: `AOS_Contracts.empresa_c`, `AOS_Invoices.empresa_c`, `AOS_Quotes.empresa_c`

| Key | Label |
|---|---|
| `` |  |
| `seepmode` | Seepmode |
| `seepmed` | Seepmed |

### `app_list_strings.exam_type_list`

- Source: `app_list_strings.exam_type_list` (pt_PT)
- Used by: `Project.medicine_exam_type_c`, `sdmod_capability.exam_type_c`

| Key | Label |
|---|---|
| `` |  |
| `admission` | Admissão |
| `periodical` | Periódico |
| `occasional_disease` | Ocasional - Após doença |
| `occasional_accident` | Ocasional - Após acidente |
| `occasional_worker_request` | Ocasional - A pedido do trabalhador |
| `occasional_service_request` | Ocasional - A pedido do serviço |
| `occasional_role_change` | Ocasional - Por mudança de função |
| `occasional_work_conditions` | Ocasional - Por alteração das condições de trabalho |
| `doctor_request` | Ocasional- A pedido do médico |
| `Inicial` | Inicial |
| `other` | Outro |

### `app_list_strings.gender_list`

- Source: `app_list_strings.gender_list` (pt_PT)
- Used by: `Contacts.contact_gender_c`

| Key | Label |
|---|---|
| `male` | Masculino |
| `female` | Feminino |

### `app_list_strings.industry_dom`

- Source: `app_list_strings.industry_dom` (pt_PT)
- Used by: `Accounts.industry`

| Key | Label |
|---|---|
| `` |  |
| `Transportation` | Transportes |
| `Construction` | Construção |
| `Government` | Governo |
| `Retail` | Retalho |
| `Restaurant` | Restaurantes e Bares |
| `Hospitality` | Hotelaria |
| `Apparel` | Vestuário |
| `Banking` | Banco |
| `Biotechnology` | Biotecnologia |
| `Chemicals` | Química |
| `Communications` | Comunicações |
| `Consulting` | Consultoria |
| `Education` | Educação |
| `Electronics` | Electrónicos |
| `Energy` | Energia |
| `Engineering` | Engenharia |
| `Entertainment` | Entretenimento |
| `Environmental` | Ambiental |
| `Finance` | Financeira |
| `Healthcare` | Saúde |
| `Insurance` | Seguros |
| `Machinery` | Maquinaria |
| `Manufacturing` | Manufatura |
| `Media` | Meios de comunicação |
| `Not For Profit` | Sem fins lucrativos |
| `Recreation` | Entretenimento |
| `Shipping` | Portes de envio |
| `Technology` | Tecnologia |
| `Telecommunications` | Telecomunicações |
| `Utilities` | Serviços de utilidade pública |
| `Other` | Outros |

### `app_list_strings.invoice_status_dom`

- Source: `app_list_strings.invoice_status_dom` (pt_PT)
- Used by: `AOS_Invoices.status`

| Key | Label |
|---|---|
| `Paid` | Liquidado |
| `Unpaid` | Por liquidar |
| `Cancelled` | Cancelado |
| `` |  |

### `app_list_strings.lead_source_dom`

- Source: `app_list_strings.lead_source_dom` (pt_PT)
- Used by: `Contacts.lead_source`

| Key | Label |
|---|---|
| `` |  |
| `Existing Customer` | Cliente existente |
| `Self Generated` | Existente no CRM |
| `Cold Call` | Telefonema espontâneo |
| `Employee` | Colaborador |
| `Partner` | Parceiro |
| `Public Relations` | Relações Públicas |
| `Direct Mail` | Correio direto |
| `Conference` | Conferência |
| `Trade Show` | Feira/Evento |
| `Web Site` | Sítio Web |
| `Word of mouth` | Boca-a-boca |
| `Email` | Email |
| `Campaign` | Campanha |
| `Other` | Outros |

### `app_list_strings.literary_abilities_list`

- Source: `app_list_strings.literary_abilities_list` (pt_PT)
- Used by: `Contacts.literary_abilities_c`

| Key | Label |
|---|---|
| `` |  |
| `None` | Não sabe ler/escrever |
| `canRead` | Ler-escrever s/grau ensino |
| `fourth` | 4º Ano |
| `sixth` | 6º Ano |
| `ninth` | 9º Ano |
| `eleventh` | 11º Ano |
| `Twelfth` | 12º Ano |
| `bachelor` | Bacharelato |
| `graduation` | Licenciatura |
| `master` | Mestrado |
| `phd` | Doutoramento |

### `app_list_strings.marital_status_list`

- Source: `app_list_strings.marital_status_list` (pt_PT)
- Used by: `Contacts.marital_status_c`

| Key | Label |
|---|---|
| `` |  |
| `Single` | Solteiro(a) |
| `Married` | Casado(a) |
| `Divorced` | Divorciado(a) |
| `Widower` | Viúvo(a) |

### `app_list_strings.medical_appreciation_list`

- Source: `app_list_strings.medical_appreciation_list` (pt_PT)
- Used by: `Project.medical_appreciation_c`, `sdmod_capability.ability_result_c`

| Key | Label |
|---|---|
| `` |  |
| `fit` | Apto |
| `fit_with_restrictions` | Apto com Restrições |
| `unfit_temporary` | Inapto Temporário |
| `unfit` | Inapto |
| `Marcado` | Marcado |
| `Remarcado` | Remarcar |
| `Marcar` | Marcar |
| `Inativo` | Inativo |

### `app_list_strings.nutsii_list`

- Source: `app_list_strings.nutsii_list` (pt_PT)
- Used by: `Accounts.nutsii_c`, `Contacts.nutsii_c`, `sdmod_training.nutsii_c`

| Key | Label |
|---|---|
| `` |  |
| `Portugal_Acores` | Região Autónoma dos Açores |
| `Portugal_Alentejo` | Alentejo |
| `Portugal_Algarve` | Algarve |
| `Portugal_CentroLitoral` | Centro Litoral |
| `Portugal_CentroInterior` | Centro Interior |
| `Portugal_Lisboa` | Lisboa e Vale do Tejo |
| `Portugal_Madeira` | Região Autónoma da Madeira |
| `Portugal_Nortelitoral` | Norte Litoral |
| `Portugal_NorteInterior` | Norte Interior |
| `Africa` | Africa |
| `Spain_Andalucia` | Andalucia |
| `Spain_Andorra` | Andorra |
| `Spain_Aragon` | Aragon |
| `Spain_Asturias` | Asturias |
| `Spain_Cantabria` | Cantabria |
| `Spain_CastilleMancha` | Castille - la Mancha |
| `Spain_CastilleLeon` | Castille y Leon |
| `Spain_Cataluna` | Cataluna |
| `Estrangeiro` | Estrangeiro |
| `Spain_Estremadura` | Estremadura |
| `Spain_Galicia` | Galicia |
| `Spain_Guipuzcoa` | Guipúzcoa |
| `Spain_IslasBaleares` | Islas Baleares |
| `Spain_IslasCanarias` | Islas Canarias |
| `Spain_LaRioja` | La Rioja |
| `Spain_Madrid` | Madrid |
| `Spain_Murcia` | Murcia |
| `Spain_Navarra` | Navarra |
| `Spain_Valencia` | Valencia |
| `Argentina_Antartica e Islas del Atlantico Sur` | Antartica e Islas del Atlantico Sur |
| `Argentina_Buenos Aires` | Buenos Aires |
| `Argentina_Buenos Aires Capital Federal` | Buenos Aires Capital Federal |
| `Argentina_Catamarca` | Catamarca |
| `Argentina_Chaco` | Chaco |
| `Argentina_Chubut` | Chubut |
| `Argentina_Cordoba` | Cordoba |
| `Argentina_Corrientes` | Corrientes |
| `Argentina_Entre Rios` | Entre Rios |
| `Argentina_Formosa` | Formosa |
| `Argentina_Jujuy` | Jujuy |
| `Argentina_La Pampa` | La Pampa |
| `Argentina_La Rioja` | La Rioja |
| `Argentina_Mendoza` | Mendoza |
| `Argentina_Misiones` | Misiones |
| `Argentina_Neuquen` | Neuquen |
| `Argentina_Rio Negro` | Rio Negro |
| `Argentina_Salta` | Salta |
| `Argentina_San Juan` | San Juan |
| `Argentina_San Luis` | San Luis |
| `Argentina_Santa Cruz` | Santa Cruz |
| `Argentina_Santa Fe` | Santa Fe |
| `Argentina_Santiago del Estero` | Santiago del Estero |
| `Argentina_Tierra del Fuego` | Tierra del Fuego |
| `Argentina_Tucuman` | Tucuman |
| `Belgium_Antwerpen` | Antwerpen |
| `Belgium_Limburg` | Limburg |
| `Belgium_Oost-Vlaanderen` | Oost-Vlaanderen |
| `Belgium_Vlaams-Brabant` | Vlaams-Brabant |
| `Belgium_West-Vlaanderen` | West-Vlaanderen |
| `Belgium_Henegouwen` | Henegouwen |
| `Belgium_Luik` | Luik |
| `Belgium_Luxemburg` | Luxemburg |
| `Belgium_Namen` | Namen |
| `Belgium_Waals-Brabant` | Waals-Brabant |
| `Belgium_Brussels-Capital` | Brussels-Capital |
| `Brazil_Acre` | Acre |
| `Brazil_Alagoas` | Alagoas |
| `Brazil_Amapa` | Amapa |
| `Brazil_Amazonas` | Amazonas |
| `Brazil_Bahia` | Bahia |
| `Brazil_Ceara` | Ceara |
| `Brazil_Distrito Federal` | Distrito Federal |
| `Brazil_Espirito Santo` | Espirito Santo |
| `Brazil_Goias` | Goias |
| `Brazil_Maranhao` | Maranhao |
| `Brazil_Mato Grosso` | Mato Grosso |
| `Brazil_Mato Grosso do Sul` | Mato Grosso do Sul |
| `Brazil_Minas Gerais` | Minas Gerais |
| `Brazil_Para` | Para |
| `Brazil_Paraiba` | Paraiba |
| `Brazil_Parana` | Parana |
| `Brazil_Pernambuco` | Pernambuco |
| `Brazil_Piaui` | Piaui |
| `Brazil_Rio de Janeiro` | Rio de Janeiro |
| `Brazil_Rio Grande do Norte` | Rio Grande do Norte |
| `Brazil_Rio Grande do Sul` | Rio Grande do Sul |
| `Brazil_Rondonia` | Rondonia |
| `Brazil_Roraima` | Roraima |
| `Brazil_Santa Catarina` | Santa Catarina |
| `Brazil_Sao Paulo` | Sao Paulo |
| `Brazil_Sergipe` | Sergipe |
| `Brazil_Tocantins` | Tocantins |
| `Bulgaria_Blagoevgrad` | Blagoevgrad |
| `Bulgaria_Burgas` | Burgas |
| `Bulgaria_Dobrich` | Dobrich |
| `Bulgaria_Gabrovo` | Gabrovo |
| `Bulgaria_Khaskovo` | Khaskovo |
| `Bulgaria_Kurdzhali` | Kurdzhali |
| `Bulgaria_Kyustendil` | Kyustendil |
| `Bulgaria_Lovech` | Lovech |
| `Bulgaria_Montana` | Montana |
| `Bulgaria_Pazardzhik` | Pazardzhik |
| `Bulgaria_Pernik` | Pernik |
| `Bulgaria_Pleven` | Pleven |
| `Bulgaria_Plovdiv` | Plovdiv |
| `Bulgaria_Razgrad` | Razgrad |
| `Bulgaria_Ruse` | Ruse |
| `Bulgaria_Shumen` | Shumen |
| `Bulgaria_Silistra` | Silistra |
| `Bulgaria_Sliven` | Sliven |
| `Bulgaria_Smolyan` | Smolyan |
| `Bulgaria_Sofiya` | Sofiya |
| `Bulgaria_Sofiya-Grad` | Sofiya-Grad |
| `Bulgaria_Stara Zagora` | Stara Zagora |
| `Bulgaria_Turgovishte` | Turgovishte |
| `Bulgaria_Varna` | Varna |
| `Bulgaria_Veliko Turnovo` | Veliko Turnovo |
| `Bulgaria_Vidin` | Vidin |
| `Bulgaria_Vratsa` | Vratsa |
| `Bulgaria_Yambol` | Yambol |
| `France_Alsace` | Alsace |
| `France_Aquitaine` | Aquitaine |
| `France_Auvergne` | Auvergne |
| `France_Basse-Normandie` | Basse-Normandie |
| `France_Bourgogne` | Bourgogne |
| `France_Bretagne` | Bretagne |
| `France_Centre` | Centre |
| `France_Champagne-Ardenne` | Champagne-Ardenne |
| `France_Corse` | Corse |
| `France_Franche-Comte` | Franche-Comte |
| `France_Haute-Normandie` | Haute-Normandie |
| `France_Ile-de-France` | Ile-de-France |
| `France_Languedoc-Roussillon` | Languedoc-Roussillon |
| `France_Limousin` | Limousin |
| `France_Lorraine` | Lorraine |
| `France_Midi-Pyrenees` | Midi-Pyrenees |
| `France_Nord-Pas-de-Calais` | Nord-Pas-de-Calais |
| `France_Pays de la Loire` | Pays de la Loire |
| `France_Picardie` | Picardie |
| `France_Poitou-Charentes` | Poitou-Charentes |
| `France_Provence-Alpes-Cote dAzur` | Provence-Alpes-Cote dAzur |
| `France_Rhone-Alpes` | Rhone-Alpes |
| `Germany_Brandenburg` | Brandenburg |
| `Germany_Berlin` | Berlin |
| `Germany_Baden-Württemberg` | Baden-Württemberg |
| `Germany_Bayern [Bavaria]` | Bayern [Bavaria] |
| `Germany_Bremen` | Bremen |
| `Germany_Hessen` | Hessen |
| `Germany_Hamburg` | Hamburg |
| `Germany_Mecklenburg-Vorpommern` | Mecklenburg-Vorpommern |
| `Germany_Niedersachsen [Lower Saxony]` | Niedersachsen [Lower Saxony] |
| `Germany_Nordrhein-Westfalen` | Nordrhein-Westfalen |
| `Germany_Rheinland-Pfalz [Palatinate]` | Rheinland-Pfalz [Palatinate] |
| `Germany_Schleswig-Holstein` | Schleswig-Holstein |
| `Germany_Saarland` | Saarland |
| `Germany_Sachsen [Saxony]` | Sachsen [Saxony] |
| `Germany_Sachsen-Anhalt [Saxony-Anhalt]` | Sachsen-Anhalt [Saxony-Anhalt] |
| `Germany_Thüringen [Thuringia]` | Thüringen [Thuringia] |
| `Greece_Achaea` | Achaea |
| `Greece_Aetolia-Acarnania` | Aetolia-Acarnania |
| `Greece_Arcadia` | Arcadia |
| `Greece_Argolis` | Argolis |
| `Greece_Arta` | Arta |
| `Greece_Athens` | Athens |
| `Greece_Boeotia` | Boeotia |
| `Greece_Chalcidice` | Chalcidice |
| `Greece_Chania` | Chania |
| `Greece_Chios` | Chios |
| `Greece_Corfu` | Corfu |
| `Greece_Corinthia` | Corinthia |
| `Greece_Cyclades` | Cyclades |
| `Greece_Dodecanese` | Dodecanese |
| `Greece_Drama` | Drama |
| `Greece_East Attica` | East Attica |
| `Greece_Elis` | Elis |
| `Greece_Euboea` | Euboea |
| `Greece_Evros` | Evros |
| `Greece_Evrytania` | Evrytania |
| `Greece_Florina` | Florina |
| `Greece_Grevena` | Grevena |
| `Greece_Heraklion` | Heraklion |
| `Greece_Imathia` | Imathia |
| `Greece_Ioannina` | Ioannina |
| `Greece_Karditsa` | Karditsa |
| `Greece_Kastoria` | Kastoria |
| `Greece_Kavala` | Kavala |
| `Greece_Kefalonia and Ithaka` | Kefalonia and Ithaka |
| `Greece_Kilkis` | Kilkis |
| `Greece_Kozani` | Kozani |
| `Greece_Laconia` | Laconia |
| `Greece_Larissa` | Larissa |
| `Greece_Lasithi` | Lasithi |
| `Greece_Lefkada` | Lefkada |
| `Greece_Lesbos` | Lesbos |
| `Greece_Magnesia` | Magnesia |
| `Greece_Messenia` | Messenia |
| `Greece_Pella` | Pella |
| `Greece_Phocis` | Phocis |
| `Greece_Phthiotis` | Phthiotis |
| `Greece_Pieria` | Pieria |
| `Greece_Piraeus` | Piraeus |
| `Greece_Preveza` | Preveza |
| `Greece_Rethymno` | Rethymno |
| `Greece_Rhodope` | Rhodope |
| `Greece_Samos` | Samos |
| `Greece_Serres` | Serres |
| `Greece_Thesprotia` | Thesprotia |
| `Greece_Thessaloniki` | Thessaloniki |
| `Greece_Trikala` | Trikala |
| `Greece_West Attica` | West Attica |
| `Greece_Xanthi` | Xanthi |
| `Greece_Zakynthos` | Zakynthos |
| `Ireland_Co. Carlow` | Co. Carlow |
| `Ireland_Co. Cavan` | Co. Cavan |
| `Ireland_Co. Clare` | Co. Clare |
| `Ireland_Co. Cork` | Co. Cork |
| `Ireland_Co. Donegal` | Co. Donegal |
| `Ireland_Co. Dublin` | Co. Dublin |
| `Ireland_Co. Galway` | Co. Galway |
| `Ireland_Co. Kerry` | Co. Kerry |
| `Ireland_Co. Kildare` | Co. Kildare |
| `Ireland_Co. Kilkenny` | Co. Kilkenny |
| `Ireland_Co. Laois` | Co. Laois |
| `Ireland_Co. Leitrim` | Co. Leitrim |
| `Ireland_Co. Limerick` | Co. Limerick |
| `Ireland_Co. Longford` | Co. Longford |
| `Ireland_Co. Louth` | Co. Louth |
| `Ireland_Co. Mayo` | Co. Mayo |
| `Ireland_Co. Meath` | Co. Meath |
| `Ireland_Co. Monaghan` | Co. Monaghan |
| `Ireland_Co. Offaly` | Co. Offaly |
| `Ireland_Co. Roscommon` | Co. Roscommon |
| `Ireland_Co. Sligo` | Co. Sligo |
| `Ireland_Co. Tipperary` | Co. Tipperary |
| `Ireland_Co. Waterford` | Co. Waterford |
| `Ireland_Co. Westmeath` | Co. Westmeath |
| `Ireland_Co. Wexford` | Co. Wexford |
| `Ireland_Co. Wicklow` | Co. Wicklow |
| `Italy_Agrigento` | Agrigento |
| `Italy_Alessandria` | Alessandria |
| `Italy_Ancona` | Ancona |
| `Italy_Aosta` | Aosta |
| `Italy_Ascoli Piceno` | Ascoli Piceno |
| `Italy_L Aquila` | L Aquila |
| `Italy_Arezzo` | Arezzo |
| `Italy_Asti` | Asti |
| `Italy_Avellino` | Avellino |
| `Italy_Bari` | Bari |
| `Italy_Bergamo` | Bergamo |
| `Italy_Biella` | Biella |
| `Italy_Belluno` | Belluno |
| `Italy_Benevento` | Benevento |
| `Italy_Bologna` | Bologna |
| `Italy_Brindisi` | Brindisi |
| `Italy_Brescia` | Brescia |
| `Italy_Barletta-Andria-Trani` | Barletta-Andria-Trani |
| `Italy_Bolzano-Bozen` | Bolzano-Bozen |
| `Italy_Cagliari` | Cagliari |
| `Italy_Campobasso` | Campobasso |
| `Italy_Caserta` | Caserta |
| `Italy_Chieti` | Chieti |
| `Italy_Carbonia-Inglesias` | Carbonia-Inglesias |
| `Italy_Caltanissetta` | Caltanissetta |
| `Italy_Cuneo` | Cuneo |
| `Italy_Como` | Como |
| `Italy_Cremona` | Cremona |
| `Italy_Cosenza` | Cosenza |
| `Italy_Catania` | Catania |
| `Italy_Catanzaro` | Catanzaro |
| `Italy_Enna` | Enna |
| `Italy_Forlì-Cesena` | Forlì-Cesena |
| `Italy_Ferrara` | Ferrara |
| `Italy_Foggia` | Foggia |
| `Italy_Firenze` | Firenze |
| `Italy_Fermo` | Fermo |
| `Italy_Frosinone` | Frosinone |
| `Italy_Genova` | Genova |
| `Italy_Gorizia` | Gorizia |
| `Italy_Grosseto` | Grosseto |
| `Italy_Imperia` | Imperia |
| `Italy_Isernia` | Isernia |
| `Italy_Crotone` | Crotone |
| `Italy_Lecco` | Lecco |
| `Italy_Lecce` | Lecce |
| `Italy_Livorno` | Livorno |
| `Italy_Lodi` | Lodi |
| `Italy_Latina` | Latina |
| `Italy_Lucca` | Lucca |
| `Italy_Monza e Brianza` | Monza e Brianza |
| `Italy_Macerata` | Macerata |
| `Italy_Messina` | Messina |
| `Italy_Milano` | Milano |
| `Italy_Mantova` | Mantova |
| `Italy_Modena` | Modena |
| `Italy_Massa-Carrara` | Massa-Carrara |
| `Italy_Matera` | Matera |
| `Italy_Napoli` | Napoli |
| `Italy_Novara` | Novara |
| `Italy_Nuoro` | Nuoro |
| `Italy_Ogliastra` | Ogliastra |
| `Italy_Oristano` | Oristano |
| `Italy_Olbia-Tempio` | Olbia-Tempio |
| `Italy_Palermo` | Palermo |
| `Italy_Piacenza` | Piacenza |
| `Italy_Padova` | Padova |
| `Italy_Pescara` | Pescara |
| `Italy_Perugia` | Perugia |
| `Italy_Pisa` | Pisa |
| `Italy_Pordenone` | Pordenone |
| `Italy_Prato` | Prato |
| `Italy_Parma` | Parma |
| `Italy_Pistoia` | Pistoia |
| `Italy_Pesaro e Urbino` | Pesaro e Urbino |
| `Italy_Pavia` | Pavia |
| `Italy_Potenza` | Potenza |
| `Italy_Ravenna` | Ravenna |
| `Italy_Reggio Calabria` | Reggio Calabria |
| `Italy_Reggio Elilia` | Reggio Elilia |
| `Italy_Ragusa` | Ragusa |
| `Italy_Rieti` | Rieti |
| `Italy_Roma` | Roma |
| `Italy_Rimini` | Rimini |
| `Italy_Rovigo` | Rovigo |
| `Italy_Salerno` | Salerno |
| `Italy_Siena` | Siena |
| `Italy_Sondrio` | Sondrio |
| `Italy_La Spezia` | La Spezia |
| `Italy_Siracusa` | Siracusa |
| `Italy_Sassari` | Sassari |
| `Italy_Savona` | Savona |
| `Italy_Taranto` | Taranto |
| `Italy_Teramo` | Teramo |
| `Italy_Trento` | Trento |
| `Italy_Torino` | Torino |
| `Italy_Trapani` | Trapani |
| `Italy_Terni` | Terni |
| `Italy_Trieste` | Trieste |
| `Italy_Treviso` | Treviso |
| `Italy_Udine` | Udine |
| `Italy_Varese` | Varese |
| `Italy_Verbano-Cusio-Ossola` | Verbano-Cusio-Ossola |
| `Italy_Vercelli` | Vercelli |
| `Italy_Venezia` | Venezia |
| `Italy_Vicenza` | Vicenza |
| `Italy_Verona` | Verona |
| `Italy_Medio Campidano` | Medio Campidano |
| `Italy_Viterbo` | Viterbo |
| `Italy_Vibo Valentia` | Vibo Valentia |
| `Lithuania_Akmenes Rajonas` | Akmenes Rajonas |
| `Lithuania_Alytaus Rajonas` | Alytaus Rajonas |
| `Lithuania_Alytus` | Alytus |
| `Lithuania_Anyksciu Rajonas` | Anyksciu Rajonas |
| `Lithuania_Birstonas` | Birstonas |
| `Lithuania_Birzu Rajonas` | Birzu Rajonas |
| `Lithuania_Druskininkai` | Druskininkai |
| `Lithuania_Ignalinos Rajonas` | Ignalinos Rajonas |
| `Lithuania_Jonavos Rajonas` | Jonavos Rajonas |
| `Lithuania_Joniskio Rajonas` | Joniskio Rajonas |
| `Lithuania_Jurbarko Rajonas` | Jurbarko Rajonas |
| `Lithuania_Kaisiadoriu Rajonas` | Kaisiadoriu Rajonas |
| `Lithuania_Kaunas` | Kaunas |
| `Lithuania_Kauno Rajonas` | Kauno Rajonas |
| `Lithuania_Kedainiu Rajonas` | Kedainiu Rajonas |
| `Lithuania_Kelmes Rajonas` | Kelmes Rajonas |
| `Lithuania_Klaipeda` | Klaipeda |
| `Lithuania_Klaipedos Rajonas` | Klaipedos Rajonas |
| `Lithuania_Kretingos Rajonas` | Kretingos Rajonas |
| `Lithuania_Kupiskio Rajonas` | Kupiskio Rajonas |
| `Lithuania_Lazdiju Rajonas` | Lazdiju Rajonas |
| `Lithuania_Marijampole` | Marijampole |
| `Lithuania_Marijampoles Rajonas` | Marijampoles Rajonas |
| `Lithuania_Mazeikiu Rajonas` | Mazeikiu Rajonas |
| `Lithuania_Moletu Rajonas` | Moletu Rajonas |
| `Lithuania_Neringa Pakruojo Rajonas` | Neringa Pakruojo Rajonas |
| `Lithuania_Palanga` | Palanga |
| `Lithuania_Panevezio Rajonas` | Panevezio Rajonas |
| `Lithuania_Panevezys` | Panevezys |
| `Lithuania_Pasvalio Rajonas` | Pasvalio Rajonas |
| `Lithuania_Plunges Rajonas` | Plunges Rajonas |
| `Lithuania_Prienu Rajonas` | Prienu Rajonas |
| `Lithuania_Radviliskio Rajonas` | Radviliskio Rajonas |
| `Lithuania_Raseiniu Rajonas` | Raseiniu Rajonas |
| `Lithuania_Rokiskio Rajonas` | Rokiskio Rajonas |
| `Lithuania_Sakiu Rajonas` | Sakiu Rajonas |
| `Lithuania_Salcininku Rajonas` | Salcininku Rajonas |
| `Lithuania_Siauliai` | Siauliai |
| `Lithuania_Siauliu Rajonas` | Siauliu Rajonas |
| `Lithuania_Silales Rajonas` | Silales Rajonas |
| `Lithuania_Silutes Rajonas` | Silutes Rajonas |
| `Lithuania_Sirvintu Rajonas` | Sirvintu Rajonas |
| `Lithuania_Skuodo Rajonas` | Skuodo Rajonas |
| `Lithuania_Svencioniu Rajonas` | Svencioniu Rajonas |
| `Lithuania_Taurages Rajonas` | Taurages Rajonas |
| `Lithuania_Telsiu Rajonas` | Telsiu Rajonas |
| `Lithuania_Traku Rajonas` | Traku Rajonas |
| `Lithuania_Ukmerges Rajonas` | Ukmerges Rajonas |
| `Lithuania_Utenos Rajonas` | Utenos Rajonas |
| `Lithuania_Varenos Rajonas` | Varenos Rajonas |
| `Lithuania_Vilkaviskio Rajonas` | Vilkaviskio Rajonas |
| `Lithuania_Vilniaus Rajonas` | Vilniaus Rajonas |
| `Lithuania_Vilnius` | Vilnius |
| `Lithuania_Zarasu Rajonas` | Zarasu Rajonas |
| `Netherlands_Drenthe` | Drenthe |
| `Netherlands_Flevoland` | Flevoland |
| `Netherlands_Friesland` | Friesland |
| `Netherlands_Gelderland` | Gelderland |
| `Netherlands_Groningen` | Groningen |
| `Netherlands_Limburg` | Limburg |
| `Netherlands_Noord-Brabant` | Noord-Brabant |
| `Netherlands_Noord-Holland` | Noord-Holland |
| `Netherlands_Overijssel` | Overijssel |
| `Netherlands_Utrecht` | Utrecht |
| `Netherlands_Zeeland` | Zeeland |
| `Netherlands_Zuid-Holland` | Zuid-Holland |
| `Poland_Dolnoslaskie` | Dolnoslaskie |
| `Poland_Kujawsko-Pomorskie` | Kujawsko-Pomorskie |
| `Poland_Lodzkie` | Lodzkie |
| `Poland_Lubelskie` | Lubelskie |
| `Poland_Lubuskie` | Lubuskie |
| `Poland_Malopolskie` | Malopolskie |
| `Poland_Mazowieckie` | Mazowieckie |
| `Poland_Opolskie` | Opolskie |
| `Poland_Podkarpackie` | Podkarpackie |
| `Poland_Podlaskie` | Podlaskie |
| `Poland_Pomorskie` | Pomorskie |
| `Poland_Slaskie` | Slaskie |
| `Poland_Swietokrzyskie` | Swietokrzyskie |
| `Poland_Warminsko-Mazurskie` | Warminsko-Mazurskie |
| `Poland_Wielkopolskie` | Wielkopolskie |
| `Poland_Zachodniopomorskie` | Zachodniopomorskie |
| `Romania_Alba` | Alba |
| `Romania_Arad` | Arad |
| `Romania_Arges` | Arges |
| `Romania_Bacau` | Bacau |
| `Romania_Bihor` | Bihor |
| `Romania_Bistrita-Nasaud` | Bistrita-Nasaud |
| `Romania_Botosani` | Botosani |
| `Romania_Braila` | Braila |
| `Romania_Brasov` | Brasov |
| `Romania_Bucuresti` | Bucuresti |
| `Romania_Buzau` | Buzau |
| `Romania_Calarasi` | Calarasi |
| `Romania_Caras-Severin` | Caras-Severin |
| `Romania_Cluj` | Cluj |
| `Romania_Constanta` | Constanta |
| `Romania_Covasna` | Covasna |
| `Romania_Dimbovita` | Dimbovita |
| `Romania_Dolj` | Dolj |
| `Romania_Galati` | Galati |
| `Romania_Giurgiu` | Giurgiu |
| `Romania_Gorj` | Gorj |
| `Romania_Harghita` | Harghita |
| `Romania_Hunedoara` | Hunedoara |
| `Romania_Ialomita` | Ialomita |
| `Romania_Iasi` | Iasi |
| `Romania_Maramures` | Maramures |
| `Romania_Mehedinti` | Mehedinti |
| `Romania_Mures` | Mures |
| `Romania_Neamt` | Neamt |
| `Romania_Olt` | Olt |
| `Romania_Prahova` | Prahova |
| `Romania_Salaj` | Salaj |
| `Romania_Satu Mare` | Satu Mare |
| `Romania_Sibiu` | Sibiu |
| `Romania_Suceava` | Suceava |
| `Romania_Teleorman` | Teleorman |
| `Romania_Timis` | Timis |
| `Romania_Tulcea` | Tulcea |
| `Romania_Vaslui` | Vaslui |
| `Romania_Vilcea` | Vilcea |
| `Romania_Vrancea` | Vrancea |
| `Russia_Республика Адыгея` | Республика Адыгея |
| `Russia_Республика Алтай` | Республика Алтай |
| `Russia_Амурская область` | Амурская область |
| `Russia_Архангельская область` | Архангельская область |
| `Russia_Астраханская область` | Астраханская область |
| `Russia_Республика Башкортостан` | Республика Башкортостан |
| `Russia_Белгородская область` | Белгородская область |
| `Russia_Брянская область` | Брянская область |
| `Russia_Республика Бурятия` | Республика Бурятия |
| `Russia_Чеченская Республика` | Чеченская Республика |
| `Russia_Челябинская область` | Челябинская область |
| `Russia_Чукотский АО` | Чукотский АО |
| `Russia_Чувашская Республика` | Чувашская Республика |
| `Russia_Республика Дагестан` | Республика Дагестан |
| `Russia_Республика Ингушетия` | Республика Ингушетия |
| `Russia_Иркутская область` | Иркутская область |
| `Russia_Ивановская область` | Ивановская область |
| `Russia_Камчатский край` | Камчатский край |
| `Russia_Кабардино-Балкарская Республика` | Кабардино-Балкарская Республика |
| `Russia_Карачаево-Черкесская Республика` | Карачаево-Черкесская Республика |
| `Russia_Краснодарский край` | Краснодарский край |
| `Russia_Кемеровская область` | Кемеровская область |
| `Russia_Калининградская область` | Калининградская область |
| `Russia_Курганская область` | Курганская область |
| `Russia_Хабаровский край` | Хабаровский край |
| `Russia_Ханты-Мансийский АО` | Ханты-Мансийский АО |
| `Russia_Кировская область` | Кировская область |
| `Russia_Республика Хакасия` | Республика Хакасия |
| `Russia_Республика Калмыкия` | Республика Калмыкия |
| `Russia_Калужская область` | Калужская область |
| `Russia_Республика Коми` | Республика Коми |
| `Russia_Костромская область` | Костромская область |
| `Russia_Республика Карелия` | Республика Карелия |
| `Russia_Курская область` | Курская область |
| `Russia_Красноярский край` | Красноярский край |
| `Russia_Ленинградская область` | Ленинградская область |
| `Russia_Липецкая область` | Липецкая область |
| `Russia_Алтайский край` | Алтайский край |
| `Russia_Магаданская область` | Магаданская область |
| `Russia_Республика Марий Эл` | Республика Марий Эл |
| `Russia_Республика Мордовия` | Республика Мордовия |
| `Russia_Московская область` | Московская область |
| `Russia_Москва` | Москва |
| `Russia_Мурманская область` | Мурманская область |
| `Russia_Ненецкий АО` | Ненецкий АО |
| `Russia_Новгородская область` | Новгородская область |
| `Russia_Нижегородская область` | Нижегородская область |
| `Russia_Новосибирская область` | Новосибирская область |
| `Russia_Омская область` | Омская область |
| `Russia_Оренбургская область` | Оренбургская область |
| `Russia_Орловская область` | Орловская область |
| `Russia_Пермский край` | Пермский край |
| `Russia_Пензенская область` | Пензенская область |
| `Russia_Приморский край` | Приморский край |
| `Russia_Псковская область` | Псковская область |
| `Russia_Ростовская область` | Ростовская область |
| `Russia_Рязанская область` | Рязанская область |
| `Russia_Республика Саха [Якутия]` | Республика Саха [Якутия] |
| `Russia_Сахалинская область` | Сахалинская область |
| `Russia_Самарская область` | Самарская область |
| `Russia_Саратовская область` | Саратовская область |
| `Russia_Республика Сев. Осетия-Алания` | Республика Сев. Осетия-Алания |
| `Russia_Смоленская область` | Смоленская область |
| `Russia_Санкт-Петербург` | Санкт-Петербург |
| `Russia_Ставропольский край` | Ставропольский край |
| `Russia_Свердловская область` | Свердловская область |
| `Russia_Республика Татарстан` | Республика Татарстан |
| `Russia_Тамбовская область` | Тамбовская область |
| `Russia_Томская область` | Томская область |
| `Russia_Тульская область` | Тульская область |
| `Russia_Тверская область` | Тверская область |
| `Russia_Республика Тыва` | Республика Тыва |
| `Russia_Тюменская область` | Тюменская область |
| `Russia_Удмуртская Республика` | Удмуртская Республика |
| `Russia_Ульяновская область` | Ульяновская область |
| `Russia_Волгоградская область` | Волгоградская область |
| `Russia_Владимирская область` | Владимирская область |
| `Russia_Вологодская область` | Вологодская область |
| `Russia_Воронежская область` | Воронежская область |
| `Russia_Ямало-Ненецкий АО` | Ямало-Ненецкий АО |
| `Russia_Ярославская область` | Ярославская область |
| `Russia_Еврейская АО` | Еврейская АО |
| `Russia_Забайкальский край` | Забайкальский край |
| `Slovenia_Ajdovscina` | Ajdovscina |
| `Slovenia_Beltinci` | Beltinci |
| `Slovenia_Bled` | Bled |
| `Slovenia_Bohinj` | Bohinj |
| `Slovenia_Borovnica` | Borovnica |
| `Slovenia_Bovec` | Bovec |
| `Slovenia_Brda` | Brda |
| `Slovenia_Brezice` | Brezice |
| `Slovenia_Brezovica` | Brezovica |
| `Slovenia_Cankova-Tisina` | Cankova-Tisina |
| `Slovenia_Celje` | Celje |
| `Slovenia_Cerklje na Gorenjskem` | Cerklje na Gorenjskem |
| `Slovenia_Cerknica` | Cerknica |
| `Slovenia_Cerkno` | Cerkno |
| `Slovenia_Crensovci` | Crensovci |
| `Slovenia_Crna na Koroskem` | Crna na Koroskem |
| `Slovenia_Crnomelj` | Crnomelj |
| `Slovenia_Destrnik-Trnovska Vas` | Destrnik-Trnovska Vas |
| `Slovenia_Divaca` | Divaca |
| `Slovenia_Dobrepolje` | Dobrepolje |
| `Slovenia_Dobrova-Horjul-Polhov Gradec` | Dobrova-Horjul-Polhov Gradec |
| `Slovenia_Dol pri Ljubljani` | Dol pri Ljubljani |
| `Slovenia_Domzale` | Domzale |
| `Slovenia_Dornava` | Dornava |
| `Slovenia_Dravograd` | Dravograd |
| `Slovenia_Duplek` | Duplek |
| `Slovenia_Gorenja Vas-Poljane` | Gorenja Vas-Poljane |
| `Slovenia_Gorisnica` | Gorisnica |
| `Slovenia_Gornja Radgona` | Gornja Radgona |
| `Slovenia_Gornji Grad` | Gornji Grad |
| `Slovenia_Gornji Petrovci` | Gornji Petrovci |
| `Slovenia_Grosuplje` | Grosuplje |
| `Slovenia_Hodos Salovci` | Hodos Salovci |
| `Slovenia_Hrastnik` | Hrastnik |
| `Slovenia_Hrpelje-Kozina` | Hrpelje-Kozina |
| `Slovenia_Idrija` | Idrija |
| `Slovenia_Ig` | Ig |
| `Slovenia_Ilirska Bistrica` | Ilirska Bistrica |
| `Slovenia_Ivancna Gorica` | Ivancna Gorica |
| `Slovenia_Izola` | Izola |
| `Slovenia_Jesenice` | Jesenice |
| `Slovenia_Jursinci` | Jursinci |
| `Slovenia_Kamnik` | Kamnik |
| `Slovenia_Kanal` | Kanal |
| `Slovenia_Kidricevo` | Kidricevo |
| `Slovenia_Kobarid` | Kobarid |
| `Slovenia_Kobilje` | Kobilje |
| `Slovenia_Kocevje` | Kocevje |
| `Slovenia_Komen` | Komen |
| `Slovenia_Koper` | Koper |
| `Slovenia_Kozje` | Kozje |
| `Slovenia_Kranj` | Kranj |
| `Slovenia_Kranjska Gora` | Kranjska Gora |
| `Slovenia_Krsko` | Krsko |
| `Slovenia_Kungota` | Kungota |
| `Slovenia_Kuzma` | Kuzma |
| `Slovenia_Lasko` | Lasko |
| `Slovenia_Lenart` | Lenart |
| `Slovenia_Lendava` | Lendava |
| `Slovenia_Litija` | Litija |
| `Slovenia_Ljubljana` | Ljubljana |
| `Slovenia_Ljubno` | Ljubno |
| `Slovenia_Ljutomer` | Ljutomer |
| `Slovenia_Logatec` | Logatec |
| `Slovenia_Loska Dolina` | Loska Dolina |
| `Slovenia_Loski Potok` | Loski Potok |
| `Slovenia_Luce` | Luce |
| `Slovenia_Lukovica` | Lukovica |
| `Slovenia_Majsperk` | Majsperk |
| `Slovenia_Maribor` | Maribor |
| `Slovenia_Medvode` | Medvode |
| `Slovenia_Menges` | Menges |
| `Slovenia_Metlika` | Metlika |
| `Slovenia_Mezica` | Mezica |
| `Slovenia_Miren-Kostanjevica` | Miren-Kostanjevica |
| `Slovenia_Mislinja` | Mislinja |
| `Slovenia_Moravce` | Moravce |
| `Slovenia_Moravske Toplice` | Moravske Toplice |
| `Slovenia_Mozirje` | Mozirje |
| `Slovenia_Murska Sobota` | Murska Sobota |
| `Slovenia_Muta` | Muta |
| `Slovenia_Naklo` | Naklo |
| `Slovenia_Nazarje` | Nazarje |
| `Slovenia_Nova Gorica` | Nova Gorica |
| `Slovenia_Novo Mesto` | Novo Mesto |
| `Slovenia_Odranci` | Odranci |
| `Slovenia_Ormoz` | Ormoz |
| `Slovenia_Osilnica` | Osilnica |
| `Slovenia_Pesnica` | Pesnica |
| `Slovenia_Piran` | Piran |
| `Slovenia_Pivka` | Pivka |
| `Slovenia_Podcetrtek` | Podcetrtek |
| `Slovenia_Podvelka-Ribnica` | Podvelka-Ribnica |
| `Slovenia_Postojna` | Postojna |
| `Slovenia_Preddvor` | Preddvor |
| `Slovenia_Ptuj` | Ptuj |
| `Slovenia_Puconci` | Puconci |
| `Slovenia_Race-Fram` | Race-Fram |
| `Slovenia_Radece` | Radece |
| `Slovenia_Radenci` | Radenci |
| `Slovenia_Radlje ob Dravi` | Radlje ob Dravi |
| `Slovenia_Radovljica` | Radovljica |
| `Slovenia_Ravne-Prevalje` | Ravne-Prevalje |
| `Slovenia_Ribnica` | Ribnica |
| `Slovenia_Rogasevci` | Rogasevci |
| `Slovenia_Rogaska Slatina` | Rogaska Slatina |
| `Slovenia_Rogatec` | Rogatec |
| `Slovenia_Ruse` | Ruse |
| `Slovenia_Semic` | Semic |
| `Slovenia_Sencur` | Sencur |
| `Slovenia_Sentilj` | Sentilj |
| `Slovenia_Sentjernej` | Sentjernej |
| `Slovenia_Sentjur pri Celju` | Sentjur pri Celju |
| `Slovenia_Sevnica` | Sevnica |
| `Slovenia_Sezana` | Sezana |
| `Slovenia_Skocjan` | Skocjan |
| `Slovenia_Skofja Loka` | Skofja Loka |
| `Slovenia_Skofljica` | Skofljica |
| `Slovenia_Slovenj Gradec` | Slovenj Gradec |
| `Slovenia_Slovenska Bistrica` | Slovenska Bistrica |
| `Slovenia_Slovenske Konjice` | Slovenske Konjice |
| `Slovenia_Smarje pri Jelsah` | Smarje pri Jelsah |
| `Slovenia_Smartno ob Paki` | Smartno ob Paki |
| `Slovenia_Sostanj` | Sostanj |
| `Slovenia_Starse` | Starse |
| `Slovenia_Store` | Store |
| `Slovenia_Sveti Jurij` | Sveti Jurij |
| `Slovenia_Tolmin` | Tolmin |
| `Slovenia_Trbovlje` | Trbovlje |
| `Slovenia_Trebnje` | Trebnje |
| `Slovenia_Trzic` | Trzic |
| `Slovenia_Turnisce` | Turnisce |
| `Slovenia_Velenje` | Velenje |
| `Slovenia_Velike Lasce` | Velike Lasce |
| `Slovenia_Videm` | Videm |
| `Slovenia_Vipava` | Vipava |
| `Slovenia_Vitanje` | Vitanje |
| `Slovenia_Vodice` | Vodice |
| `Slovenia_Vojnik` | Vojnik |
| `Slovenia_Vrhnika` | Vrhnika |
| `Slovenia_Vuzenica` | Vuzenica |
| `Slovenia_Zagorje ob Savi` | Zagorje ob Savi |
| `Slovenia_Zalec` | Zalec |
| `Slovenia_Zavrc` | Zavrc |
| `Slovenia_Zelezniki` | Zelezniki |
| `Slovenia_Ziri` | Ziri |
| `Slovenia_Zrece` | Zrece |

### `app_list_strings.pack_list`

- Source: `app_list_strings.pack_list` (pt_PT)
- Used by: `AOS_Contracts.pack_c`

| Key | Label |
|---|---|
| `standard` | Standard |
| `plus` | Plus |
| `avancado` | Avançado |
| `premium` | Premium |

### `app_list_strings.priority_list`

- Source: `app_list_strings.priority_list` (en_us)
- Used by: `Cases.priority`

| Key | Label |
|---|---|
| `1` | 1 |
| `2` | 2 |
| `3` | 3 |

### `app_list_strings.quote_invoice_status_dom`

- Source: `app_list_strings.quote_invoice_status_dom` (pt_PT)
- Used by: `AOS_Quotes.invoice_status`

| Key | Label |
|---|---|
| `Not Invoiced` | Não faturado |
| `Invoiced` | Faturado |

### `app_list_strings.quote_stage_dom`

- Source: `app_list_strings.quote_stage_dom` (pt_PT)
- Used by: `AOS_Quotes.stage`

| Key | Label |
|---|---|
| `On Hold` | Proposta |
| `Negotiation` | Revisão |
| `Closed Accepted` | Ganha |
| `Closed Lost` | Perdida |
| `credit_note` | Nota de Crédito |

### `app_list_strings.quote_term_dom`

- Source: `app_list_strings.quote_term_dom` (pt_PT)
- Used by: `AOS_Quotes.term`

| Key | Label |
|---|---|
| `` |  |
| `Net0` | Pronto Pagamento |
| `Net 15` | 15 dias sem desconto |
| `Net 30` | 30 dias sem desconto |
| `Net60` | 60 dias sem desconto |

### `app_list_strings.recommendations_list`

- Source: `app_list_strings.recommendations_list` (pt_PT)
- Used by: `sdmod_capability.recommendations_c`

| Key | Label |
|---|---|
| `no_recommendations` | Sem recomendações |
| `workplace_risk_factors` | Avaliação de fatores de risco no posto de trabalho |
| `working_conditions_correction` | Correção de condições de trabalho |
| `personal_protective_equipment` | Uso de equipamento de proteção individual |
| `proposal_work_organization` | Proposta de organização de trabalho |
| `training_and_information` | Formação e/ou informação do trabalhador |
| `other` | Outras |

### `app_list_strings.send_receive_list`

- Source: `app_list_strings.send_receive_list` (pt_PT)
- Used by: `Cases.send_receive_c`

| Key | Label |
|---|---|
| `Received` | Recebido |
| `Send` | Enviado |

### `app_list_strings.service_organization_list`

- Source: `app_list_strings.service_organization_list` (pt_PT)
- Used by: `sdmod_capability.service_organization_c`

| Key | Label |
|---|---|
| `Interno` | Interno |
| `Externo` | Externo |
| `Comum` | Comum |
| `Outro` | Outro |

### `app_list_strings.service_organization_name_c_list`

- Source: `app_list_strings.service_organization_name_c_list` (pt_PT)
- Used by: `sdmod_capability.service_organization_name_c`

| Key | Label |
|---|---|
| `seepmode_var` | Seepmode, Lda |
| `seepmed_var` | Seepmed, Lda |

### `app_list_strings.service_organization_nipc_c_list`

- Source: `app_list_strings.service_organization_nipc_c_list` (pt_PT)
- Used by: `sdmod_capability.service_organization_nipc_c`

| Key | Label |
|---|---|
| `507743997` | 507743997 |
| `515786390` | 515786390 |

### `app_list_strings.sexo_c_list`

- Source: `app_list_strings.sexo_c_list` (pt_PT)
- Used by: `sdmod_capability.sexo_c`

| Key | Label |
|---|---|
| `male` | Masculino |
| `female` | Feminino |

### `app_list_strings.training_types_list`

- Source: `app_list_strings.training_types_list` (pt_PT)
- Used by: `sdmod_Training_control.training_types_c`

| Key | Label |
|---|---|
| `` |  |
| `01` | TRP - Tacógrafos e Regulamentação Social |
| `10` | TRP - Acondicionamento de Carga |
| `18` | TRP - Acondicionamento de Carga e Segurança Rodoviária |
| `04` | TRP - CAM Continua dos Motoristas De Veículos Rodoviários Pesados De Passageiros |
| `09` | TRP - TCC Motoristas Transporte Coletivo Crianças - Complementar |
| `03` | TRP - CAM	  Continua dos Motoristas De Veículos Rodoviários Pesados De Mercadorias |
| `34` | TRP - ADR - Base |
| `35` | TRP - ADR - Reciclagem |
| `05` | TRP - Formação TS - TachoSpeed |
| `07` | TRP - Condução Económica e defensiva |
| `08` | TRP - Segurança e Saúde no Trabalho para Motoristas |
| `11` | TRP - Manipulação de Plataformas Elevatórias |
| `12` | TRP - Regulamentação Social |
| `13` | TRP - Condutor e Manobrador de Máquinas e Movimentação de Terras |
| `14` | TRP - Ecocondução |
| `15` | TRP - Condução de Empilhadores |
| `16` | TRP - Logística, Armazenagem e Distribuição |
| `17` | TRP - Prevenção Rodoviária |
| `19` | TRP - Movimentação de carga |
| `21` | TRP - Regulamentação Comunitária |
| `26` | TRP - Motoserras e Motorroçadoras |
| `23` | TRP - Livrete Individual de Controlo |
| `30` | TRP - Prevenção de Riscos Profissionais do Setor Florestal |
| `31` | TRP - Condutor e Manobrador de Gruas |
| `02` | SST - Segurança e Saúde no Trabalho |
| `22` | SST - Combate a incêndios |
| `33` | SST - Manobrador de Máquinas em Obra |
| `20` | SST - Primeiros Socorros |
| `27` | COMP - Qualidade e Excelência no Atendimento |
| `24` | COMP - Gestão do Tempo e Organização do Trabalho |
| `25` | COMP - Técnicas de Venda e Negociação Comercial |
| `28` | COMP - Relacionamento Interpessoal em Contexto Empresarial |
| `06` | COMP - Comunicação institucional |
| `32` | COMP - Gestão de Stress |
| `29` | IT - Formação Excel |

### `app_list_strings.type_invoice`

- Source: `app_list_strings.type_invoice` (pt_PT)
- Used by: `AOS_Invoices.type_c`

| Key | Label |
|---|---|
| `invoice` | Fatura |
| `credit_note` | Nota de Crédito |
| `` |  |

### `app_list_strings.type_list`

- Source: `app_list_strings.type_list` (pt_PT)
- Used by: `Contacts.contact_type_c`

| Key | Label |
|---|---|
| `` |  |
| `admin` | Administrador |
| `salesman` | Vendedor |
| `Nurse` | Enfermeiro |
| `Doctor` | Médico |
| `Technic` | Técnico |
| `Formando` | Formando |
| `Formador` | Formador |
| `Cliente` | Cliente |
| `Paciente` | Paciente |
| `distributer` | Distribuidor |
| `Salas` | Salas |
| `Colaborador` | Colaborador |
| `trainee` | Estagiário |
| `coordinator` | Coordenador |

### `app_list_strings.yes_no_list`

- Source: `app_list_strings.yes_no_list` (pt_PT)
- Used by: `AOS_Invoices.payment_reminder_c`, `Contacts.contacts_adr_c`, `sdmod_capability.analise_posto_trabalho_c`, `sdmod_capability.exposicao_profissional_c`, `sdmod_capability.fatores_risco_pro_c`, `sdmod_training.formation_check_checkbox_c`

| Key | Label |
|---|---|
| `` |  |
| `Sim` | Sim |
| `Não` | Não |

