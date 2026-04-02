# SuiteCRM — Module Relationship Mapping

This map was completed from the current SuiteCRM metadata in this repo, using active detail-view subpanels rather than only screenshot text.

It focuses on user-visible and business-facing relations, and excludes system/audit links such as `created_by`, `modified_user_id`, and `assigned_user_id`.

## Naming Reference

| UI label | SuiteCRM module key |
|---|---|
| Organização / Cliente | `Accounts` |
| Propostas | `AOS_Quotes` |
| Propostas (Oportunidades / legado) | `Opportunities` |
| Faturas | `AOS_Invoices` |
| Contratos | `AOS_Contracts` |
| Assistências | `Cases` |
| Medicina Ocupacional | `Project` |
| Fichas de Aptidão | `sdmod_capability` |
| Formações | `sdmod_training` |
| Formadores | `sdmod_formation_trainers` |
| Formandos | `sdmod_Training_control` |
| Sessões | `sdmod_Sessions` |
| Presenças | `sdmod_attendances` |
| Grupos de Segurança | `SecurityGroups` |
| Anexos | `sdmod_Renewals` |
| Acessos IEFP | `sdmod_iefp_accesses` |

> **Note:** This instance has two parallel legacy/history domains besides the active `AOS_*` modules: `sdmod_Contracts` and `sdmod_contracts_manager`. To keep the list readable, they are referred to below as `Faturas (Histórico)` and `Contratos (Histórico)`.
>
> **Note:** I use `Propostas (Oportunidades / legado)` only to distinguish standard `Opportunities` from `AOS_Quotes`, since both are labeled as proposals in Portuguese metadata.

## Account (Organização)

- Atividades
- Histórico
- Documentos
- Contactos
- Propostas (Oportunidades / legado)
- Organizações Filiais
- Assistências
- Medicina Ocupacional
- Fichas de Aptidão
- Formações
- Formandos
- Propostas
- Faturas
- Contratos
- Faturas (Histórico)
- Contratos (Histórico)
- Produtos e Serviços Adquiridos
- Anomalias
- Base de Operações
- Grupos de Segurança

## Quotes (Propostas)

- Contratos
- Faturas
- Medicina Ocupacional
- Tarefas
- Telefonemas
- Reuniões
- Documentos

## Invoices (Faturas)

- Propostas
- Formações
- Assistências
- Anexos

## Contracts (Contratos)

- Documentos
- Propostas
- Faturas

## Contacts (Contactos)

- Atividades
- Histórico
- Documentos
- Propostas (Oportunidades / legado)
- Assistências
- Medicina Ocupacional
- Fichas de Aptidão
- Formandos
- Propostas
- Faturas
- Contratos
- Anomalias
- Acessos IEFP
- Supervisão direta
- Grupos de Segurança

> **Note:** I did not find active layout metadata for `Grupos e EPP`, `Fichas de Segurança`, or `Fichas de Controlo` in the current codebase. The active custom contact-side relations present today are `Acessos IEFP`, `Fichas de Aptidão`, `Formandos`, and `Medicina Ocupacional`.

## Formações

- Faturas
- Sessões

## Formadores

- Sessões

## Sessões

- Formadores
- Presenças

## Assistências

- Atividades
- Histórico
- Documentos
- Contactos
- Anomalias
- Medicina Ocupacional
- Grupos de Segurança

## Medicina Ocupacional

- Propostas
- Documentos
- Fichas de Aptidão
- Recursos do Projeto (Utilizadores + Contactos)
- Grupos de Segurança

## Fichas de Aptidão

- Documentos

> **Note:** Reverse links into `Fichas de Aptidão` are defined from `Accounts`, `Contacts`, and `Project`, even though the module itself only exposes `Documentos` as an explicit subpanel.

## Formandos

- No explicit detail-view subpanels are defined in the current `layoutdefs.ext.php`.
- Reverse relations exist from `Accounts` and `Contacts`.

## Detail View Fields

These are the active field ids from each module's current `DetailView` metadata.

- Included: fields rendered in the main detail view panels.
- Excluded: subpanels, action buttons, and sidebar widgets.
- Panel names below are the metadata panel keys used by SuiteCRM.

### Account (Organização)

Panel `lbl_account_information`

- `name`
- `phone_office`
- `website`
- `phone_alternate`
- `billing_address_street`
- `shipping_address_street`
- `nutsii_c`
- `place_of_visit_c`
- `email1`
- `description`

Panel `LBL_PANEL_ADVANCED`

- `account_type`
- `employees`
- `industry`
- `n_condutores_c`
- `sic_code`
- `ticker_symbol`
- `parent_name`
- `ownership`
- `accounts_cae_c`
- `employees_establishment_c`
- `client_service_type_c`
- `send_payment_reminder_c`

Panel `LBL_PANEL_ASSIGNMENT`

- `assigned_user_name`

### Quotes (Propostas)

Panel `lbl_account_information`

- `name`
- `billing_account`
- `number`
- `stage`
- `expiration`
- `data_prevista_fecho_c`
- `invoice_status`
- `term`
- `approval_status`
- `empresa_c`
- `approval_issue`
- `invoicing_notes_c`
- `billing_contact`
- `assigned_user_name`

Panel `lbl_line_items`

- `currency_id`
- `line_items`
- `total_amt`
- `discount_amount`
- `subtotal_amount`
- `shipping_amount`
- `shipping_tax_amt`
- `tax_amount`
- `total_amount`

### Invoices (Faturas)

Panel `LBL_PANEL_OVERVIEW`

- `name`
- `salesperson_c`
- `number`
- `billing_account`
- `type_c`
- `description`
- `invoice_date`
- `paid_value_c`
- `due_date`
- `open_value_c`
- `legal_pack_c`
- `renovation_value_c`
- `quote_date`
- `empresa_c`
- `aos_contracts_aos_invoices_1_name`
- `invoicing_notes_c`
- `payment_reminder_c`
- `status`
- `date_entered`
- `assigned_user_name`

Panel `lbl_line_items`

- `currency_id`
- `line_items`
- `total_amt`
- `discount_amount`
- `subtotal_amount`
- `shipping_amount`
- `shipping_tax_amt`
- `tax_amount`
- `total_amount`

### Contracts (Contratos)

Panel `default`

- `name`
- `assigned_user_name`
- `anuidade_c`
- `versao_c`
- `start_date`
- `end_date`
- `contract_account`
- `renewal_date_c`
- `net_value_c`
- `renewal_value_c`
- `pack_c`
- `pack_state_c`
- `description`
- `empresa_c`
- `contact`
- `date_entered`

Panel `lbl_line_items`

- `currency_id`
- `line_items`
- `total_amt`
- `discount_amount`
- `subtotal_amount`
- `shipping_amount`
- `shipping_tax_amt`
- `tax_amount`
- `total_amount`

### Contacts (Contactos)

Panel `lbl_contact_information`

- `first_name`
- `data_de_admissao_c`
- `last_name`
- `phone_work`
- `birthdate`
- `phone_mobile`
- `title`
- `phone_fax`
- `department`
- `sessao_c`
- `account_name`
- `profissao_c`
- `primary_address_street`
- `alt_address_street`
- `cc_number_c`
- `cc_expiration_date_c`
- `vat_number_c`
- `nutsii_c`
- `marital_status_c`
- `contact_nationality_c`
- `contact_gender_c`
- `literary_abilities_c`
- `contacts_adr_c`
- `is_trainee_c`
- `is_trainer_c`
- `contact_type_c`
- `email1`
- `description`
- `tipo_de_recurso_c`
- `numero_do_beneficiario_c`
- `ultimo_exame_c`
- `proximo_exame_c`

Panel `LBL_PANEL_ADVANCED`

- `report_to_name`
- `sync_contact`
- `lead_source`
- `do_not_call`
- `campaign_name`

Panel `LBL_PANEL_ASSIGNMENT`

- `assigned_user_name`

### Formações

Panel `default`

- `formation_action`
- `year`
- `name`
- `status`
- `formation_date`
- `end_date_c`
- `accounts_sdmod_training_1_name`
- `trainer_c`
- `contact`
- `sessions`
- `hours_number`
- `adjudication_date`
- `formation_value`
- `nutsii_c`
- `trainees_number`
- `trainees_average`
- `trainees_number_action_c`
- `formation_check_checkbox_c`
- `formation_check_quantity_c`
- `data_candidatura_c`

Panel `lbl_editview_panel4`

- `verificarion_date_c`
- `cliente_email_info_date_c`
- `trainee_info_deliver_date`
- `client_tele_confirm_date_c`
- `trainer_info_deliver_date_c`
- `formation_reminder_date_c`
- `number_certificates_sent`
- `sent_certificates_date`
- `followup_client_c`
- `observations_c`
- `data_da_digitalizacao_c`
- `data_analise_estatistica_c`
- `closed_training_c`
- `data_fecho_acao_c`
- `issued_by_c`

Panel `lbl_editview_panel1`

- `place`
- `local_invoice_number_c`
- `address`
- `local_value_c`
- `room`
- `local_payment_date_c`
- `projector`

Panel `lbl_editview_panel2`

- `invoice_number_new_c`
- `payment_date`
- `invoice_value`
- `paid_value_c`
- `invoice_date`

Panel `lbl_editview_panel3`

- `assigned_user_name`
- `salesperson_c`

### Formadores

Panel `default`

- `trainer_name`
- `hour_value`
- `total_amount`
- `receipt_number`
- `payment_date`
- `receipt_date`
- `registration_cost`
- `receipt_delivery_date_c`
- `trainer_info_date_c`
- `info_verification_date_c`
- `observations`

### Sessões

Panel `default`

- `sdmod_sessions_sdmod_training_name`
- `name`
- `abbreviation`
- `session`
- `description`

### Assistências

Panel `lbl_case_information`

- `name`
- `assistence_datetime_c`
- `mode_c`
- `service_date_c`
- `send_receive_c`
- `who_contacted_c`
- `area_c`
- `account_name`
- `billing_address_country`
- `billing_address_state`
- `deadline_c`
- `priority`
- `code_c`
- `inspectio_simulaction_c`
- `status`
- `resolutions_date_c`
- `opened_by_c`
- `closed_by_c`
- `assigned_user_name`
- `automatic_email_sending_c`
- `aos_invoices_cases_1_name`
- `date_entered`

Panel `LBL_PANEL_ASSIGNMENT`

- `problem_description_c`
- `suggestion_box`
- `resolution`
- `update_text`
- `hardware_c`
- `units_c`
- `internal`
- `created_by_name`

### Medicina Ocupacional

Panel `lbl_project_information`

- `contacts_project_1_name`
- `medicine_exam_number_c`
- `accounts_project_1_name`
- `estimated_start_date`
- `cat_profissional_c`
- `medicine_exam_type_c`
- `admission_date_c`
- `assigned_user_name`

Panel `lbl_editview_panel1`

- `family_history_irrelevant_c`
- `family_history_relevant_c`
- `family_history_which_c`

Panel `lbl_editview_panel2`

- `occupational_pro_disease_c`
- `occupational_pro_declared_c`
- `occupational_pro_declared_t_c`
- `occupational_pro_detected_c`
- `occupational_pro_disease_t_c`

Panel `lbl_editview_panel3`

- `work_accidents_no_c`
- `work_accidents_yes_c`
- `work_accidents_which_c`

Panel `lbl_editview_panel4`

- `hazards_exposure_no_c`
- `hazards_exposure_yes_c`
- `hazards_exposure_which_c`
- `occupational_pro_exposure_c`

Panel `lbl_editview_panel5`

- `alcohol_no_c`
- `alcohol_yes_c`
- `alcohol_frequency_c`

Panel `lbl_editview_panel6`

- `tobacco_no_c`
- `tobacco_yes_c`
- `tobacco_frequency_c`

Panel `lbl_editview_panel7`

- `coffee_no_c`
- `coffee_yes_c`
- `coffee_frequency_c`

Panel `lbl_editview_panel8`

- `medication_no_c`
- `medication_yes_c`
- `medication_frequency_c`

Panel `lbl_editview_panel9`

- `hobbies_c`

Panel `lbl_editview_panel10`

- `height_c`
- `weight_c`
- `pulse_c`
- `blood_pressure_min_c`
- `blood_pressure_max_c`

Panel `lbl_editview_panel18`

- `vaccination_yes_c`
- `vaccination_no_c`
- `vaccination_which_c`
- `vaccination_observations_c`

Panel `lbl_editview_panel11`

- `blood_test_c`
- `ecg_c`
- `urine_tests_c`
- `rx_torax_c`
- `stool_analyzes_c`
- `ophthalmologi_tracking_c`
- `glycaemia_analyses_c`
- `cholesterol_analyses_c`
- `audiometry_c`
- `spirometry_c`
- `others_c`
- `observations_c`

Panel `lbl_editview_panel12`

- `health_problems_no_c`
- `health_problems_yes_c`
- `presented_patholog_obs_c`

Panel `lbl_editview_panel13`

- `recommendations_c`

Panel `lbl_editview_panel14`

- `specialty_medical_assistant_c`
- `specialty_gynecology_c`
- `specialty_cardiology_c`
- `specialty_neurology_c`
- `specialty_surgery_c`
- `specialty_ophthalmology_c`
- `specialty_dermatology_c`
- `specialty_orthopedy_c`
- `specialty_endocrinology_c`
- `specialty_otorrino_c`
- `specialty_stomatology_c`
- `specialty_others_c`

Panel `lbl_editview_panel15`

- `advice_reduce_weight_c`
- `advice_reduce_tobacco_c`
- `advice_reduce_alcohol_c`
- `advice_exercice_c`
- `advice_vaccines_c`
- `advice_others_c`

Panel `lbl_editview_panel16`

- `final_observations_c`

Panel `lbl_editview_panel17`

- `attendances_c`
- `attendance_date_c`
- `medical_appreciation_c`
- `nome_do_medico_c`
- `n_cedula_profissional_c`
- `medic_signature_c`
- `am_projecttemplates_project_1_name`
- `date_entered`
- `date_modified`
- `override_business_hours`

### Fichas de Aptidão

Panel `lbl_editview_panel6`

- `accounts_sdmod_capability_1_name`
- `nipc_c`
- `estabelecimento_c`
- `cae_c`
- `endereco_c`
- `zip_code_c`
- `localidade_c`
- `telefone_c`
- `email_c`
- `project_sdmod_capability_1_name`

Panel `lbl_editview_panel4`

- `service_organization_c`
- `service_organization_other_c`
- `service_organization_name_c`
- `service_organization_nipc_c`
- `dgs_authorization_process_c`

Panel `lbl_editview_panel1`

- `contacts_sdmod_capability_1_name`
- `nacionalidade_c`
- `sexo_c`
- `data_nascimento_c`
- `data_admissao_c`
- `cat_profissional_c`
- `posto_trabalho_c`
- `atividade_funcao_c`
- `data_admissao_atividade_c`

Panel `lbl_editview_panel2`

- `analise_posto_trabalho_c`
- `analise_posto_trabalho_justi_c`
- `fatores_risco_pro_c`
- `fatores_risco_pro_especifica_c`
- `exposicao_profissional_c`
- `exposicao_profissional_espec_c`

Panel `lbl_editview_panel3`

- `exam_date_c`
- `ability_result_c`
- `exam_type_c`
- `outras_funcoes_c`
- `exam_type_other_c`

Panel `lbl_editview_panel5`

- `recommendations_c`
- `other_recommendations_c`

Panel `lbl_detailview_panel8`

- `nome_do_medico_c`
- `n_cedula_profissional_c`

Panel `lbl_editview_panel7`

- `assigned_user_name`

### Formandos

Panel `default`

- `contacts_sdmod_training_control_1_name`
- `assigned_user_name`
- `accounts_sdmod_training_control_1_name`
- `action_number_c`
- `description`
- `formation_hours_c`
- `training_types_c`
- `formation_place_c`

Panel `lbl_editview_panel4`

- `iefp_submission_date`
- `iefp_application_number`
- `trainee_application_date`
- `candidature_status_c`
- `iefp_verification_date`
- `notification_changes_date`
- `answer_deadline`
- `refusal_reasons`
- `additional_data_date`
- `additional_sent_data_date`
- `iefp_approved_value`
- `customers_result_date`
- `refusal_date`
- `iefp_process_closed`

Panel `lbl_editview_panel3`

- `internal_certificate_date`
- `certificate_sent_date`
- `intern_certificate_number_c`
- `intern_reference_c`
- `intern_date_start_c`
- `intern_evaluation_c`
- `intern_date_end_c`

Panel `lbl_editview_panel2`

- `certificate_issue_date`
- `sigo_training_date`
- `sigo_formation_code`
- `sigo_training_date_new_c`
- `iefp__upload_date`
- `sigo_n_c`

Panel `lbl_editview_panel1`

- `imtt_action_code`
- `application_start_date`
- `certificate_submission_date`
- `application_closing_date`
- `process_closed`
