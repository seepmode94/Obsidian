# SuiteCRM — Module View Mapping

This document maps the active metadata-backed views for the main business modules in this instance.

Conventions:

- `Table view` = default-visible list view columns from `listviewdefs.php`.
- `Edit view` = panel fields from `editviewdefs.php`.
- `Detail view` = panel fields from `detailviewdefs.php`.
- `Popup view` = popup search fields, popup result columns, and popup search input order from `popupdefs.php`.
- `Filter view` = basic and advanced search fields from `searchdefs.php`.
- Field ids are kept as metadata names.

## Account (Organização)

### Table View

- `sic_code`
- `name`
- `employees`
- `industry`
- `billing_address_city`
- `billing_address_state`
- `billing_address_country`
- `place_of_visit_c`
- `phone_office`
- `employees_establishment_c`
- `n_condutores_c`
- `ownership`
- `ticker_symbol`
- `date_entered`
- `assigned_user_name`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- `name`
- `account_type`
- `industry`
- `billing_address_city`
- `billing_address_state`
- `billing_address_country`
- `email`
- `assigned_user_id`

Popup result columns

- `name`
- `account_type`
- `billing_address_city`
- `billing_address_state`
- `billing_address_country`
- `assigned_user_name`

Popup search inputs order

- `name`
- `billing_address_city`
- `account_type`
- `industry`
- `billing_address_state`
- `billing_address_country`
- `email`
- `assigned_user_id`

### Filter View

Basic filter fields

- `name`
- `current_user_only`

Advanced filter fields

- `name`
- `sic_code`
- `phone_office`
- `ownership`
- `billing_address_street`
- `address_city`
- `billing_address_state`
- `place_of_visit_c`
- `billing_address_country`
- `n_condutores_c`
- `nutsii_c`
- `employees`
- `assigned_user_id`
- `date_entered`

## Quotes (Propostas)

### Table View

- `number`
- `name`
- `billing_account`
- `empresa_c`
- `data_prevista_fecho_c`
- `billing_address_city`
- `billing_address_state`
- `total_amount`
- `total_amt`
- `stage`
- `approval_status`
- `assigned_user_name`
- `date_entered`
- `date_modified`
- `created_by_name`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- None defined in active metadata.

Popup result columns

- None defined in active metadata.

Popup search inputs order

- `name`
- `billing_address_city`
- `phone_office`
- `industry`

### Filter View

Basic filter fields

- `name`
- `current_user_only`
- `favorites_only`

Advanced filter fields

- `name`
- `stage`
- `billing_account`
- `billing_address_state`
- `billing_address_city`
- `billing_contact`
- `expiration`
- `data_prevista_fecho_c`
- `approval_status`
- `total_amount`
- `term`
- `empresa_c`
- `date_modified`
- `date_entered`
- `assigned_user_id`

## Invoices (Faturas)

### Table View

- `number`
- `name`
- `billing_account`
- `invoice_date`
- `description`
- `total_amount`
- `subtotal_amount`
- `open_value_c`
- `paid_value_c`
- `due_date`
- `quote_date`
- `renovation_value_c`
- `salesperson_c`
- `date_entered`
- `assigned_user_name`
- `created_by_name`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- None defined in active metadata.

Popup result columns

- None defined in active metadata.

Popup search inputs order

- `name`
- `billing_address_city`
- `phone_office`
- `industry`

### Filter View

Basic filter fields

- `name`
- `current_user_only`
- `favorites_only`

Advanced filter fields

- `open_value_c`
- `invoice_date`
- `due_date`
- `name`
- `billing_account`
- `paid_value_c`
- `total_amount`
- `product_category`
- `product_name_filter`
- `line_items`
- `salesperson_c`
- `assigned_user_id`

## Contracts (Contratos)

### Table View

- `name`
- `contract_account`
- `anuidade_c`
- `versao_c`
- `start_date`
- `renewal_date_c`
- `end_date`
- `net_value_c`
- `pack_c`
- `pack_state_c`
- `renewal_value_c`
- `assigned_user_name`
- `date_entered`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- `name`
- `status`
- `start_date`
- `end_date`

Popup result columns

- None defined in active metadata.

Popup search inputs order

- `name`
- `status`
- `total_contract_value`
- `start_date`
- `end_date`

### Filter View

Basic filter fields

- `current_user_only`
- `favorites_only`

Advanced filter fields

- `name`
- `contract_account`
- `anuidade_c`
- `renewal_date_c`
- `start_date`
- `total_contract_value`
- `versao_c`
- `end_date`
- `pack_c`
- `pack_state_c`
- `renewal_value_c`
- `empresa_c`
- `contract_type`
- `assigned_user_id`

## Contacts (Contactos)

### Table View

- `name`
- `contact_type_c`
- `title`
- `account_name`
- `department`
- `email1`
- `phone_work`
- `assigned_user_name`
- `date_entered`

### Edit View

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
- `birth_village_c`
- `contacts_adr_c`
- `birth_county_c`
- `contact_type_c`
- `literary_abilities_c`
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

### Detail View

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

### Popup View

Popup search fields

- `name`
- `vat_number_c`
- `account_name`
- `title`
- `phone_work`
- `is_trainee_c`
- `is_trainer_c`
- `lead_source`
- `email`
- `campaign_name`
- `assigned_user_id`

Popup result columns

- `name`
- `account_name`
- `phone_work`
- `title`
- `lead_source`

Popup search inputs order

- `account_name`
- `email`
- `name`
- `vat_number_c`
- `title`
- `lead_source`
- `campaign_name`
- `assigned_user_id`
- `is_trainee_c`
- `is_trainer_c`
- `phone_work`

### Filter View

Basic filter fields

- `search_name`
- `current_user_only`

Advanced filter fields

- `first_name`
- `last_name`
- `email`
- `phone`
- `address_street`
- `account_name`
- `department`
- `vat_number_c`
- `address_city`
- `address_state`
- `address_postalcode`
- `primary_address_country`
- `contact_type_c`
- `title`
- `assigned_user_id`

## Formações

### Table View

- `formation_action`
- `name`
- `accounts_sdmod_training_1_name`
- `contact`
- `year`
- `followup_client_c`
- `formation_date`
- `invoice_value`
- `payment_date`
- `status`
- `place`
- `paid_value_c`
- `trainees_number`
- `trainees_number_action_c`
- `hours_number`
- `data_candidatura_c`
- `formation_check_quantity_c`
- `salesperson_c`
- `assigned_user_name`
- `date_entered`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- `formation_number`
- `accounts_sdmod_training_1_name`
- `training_contact`
- `year`
- `formation_date`

Popup result columns

- `formation_number`
- `name`
- `accounts_sdmod_training_1_name`
- `contact`
- `year`
- `formation_date`
- `status`
- `place`
- `trainees_number`
- `hours_number`
- `created_by_name`
- `date_entered`
- `assigned_user_name`

Popup search inputs order

- `formation_number`
- `accounts_sdmod_training_1_name`
- `training_contact`
- `year`
- `formation_date`

### Filter View

Basic filter fields

- `formation_number`
- `name`
- `training_contact`
- `year`
- `formation_date`

Advanced filter fields

- `formation_action`
- `accounts_sdmod_training_1_name`
- `year`
- `place`
- `payment_date`
- `name`
- `formation_date`
- `cliente_email_info_date_c`
- `paid_value_c`
- `application_start_date_c`
- `client_info_reception_date_c`
- `sent_certificates_date`
- `data_analise_estatistica_c`
- `data_fecho_acao_c`
- `data_da_digitalizacao_c`
- `status`
- `nutsii_c`
- `formation_check_checkbox_c`
- `date_entered`
- `assigned_user_name`
- `salesperson_c`

## Formadores

### Table View

- `name`
- `training_rel_c`
- `trainer_name`
- `training_client_c`
- `training_date_c`
- `training_trainees_c`
- `hour_value`
- `total_amount`
- `registration_cost`
- `receipt_number`
- `receipt_date`
- `receipt_delivery_date_c`
- `payment_date`
- `trainer_info_date_c`
- `info_verification_date_c`
- `observations`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- None defined in active metadata.

Popup result columns

- None defined in active metadata.

Popup search inputs order

- `sdmod_formation_trainers_number`
- `name`
- `priority`
- `status`

### Filter View

Basic filter fields

- `trainer_name`
- `current_user_only`

Advanced filter fields

- `trainer_name`
- `receipt_date`
- `trainer_info_date_c`
- `training_related`
- `training_date`
- `trainees_number`
- `payment_date`
- `receipt_delivery_date_c`
- `total_amount`

## Sessões

### Table View

- `session`
- `name`
- `abbreviation`

### Edit View

Panel `default`

- `sdmod_sessions_sdmod_training_name`
- `name`
- `abbreviation`
- `session`
- `description`
- `assigned_user_name`

### Detail View

Panel `default`

- `sdmod_sessions_sdmod_training_name`
- `name`
- `abbreviation`
- `session`
- `description`

### Popup View

Popup search fields

- None defined in active metadata.

Popup result columns

- None defined in active metadata.

Popup search inputs order

- `sdmod_sessions_number`
- `name`
- `priority`
- `status`

### Filter View

Basic filter fields

- `current_user_only`

Advanced filter fields

- `assigned_user_id`

## Assistências

### Table View

- `code_c`
- `status`
- `priority`
- `name`
- `account_name`
- `phone_office`
- `billing_address_state`
- `billing_address_city`
- `who_contacted_c`
- `assistence_datetime_c`
- `deadline_c`
- `resolutions_date_c`
- `closed_by_c`
- `date_entered`
- `opened_by_c`
- `created_by_name`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- `account_name`
- `assigned_user_id`

Popup result columns

- `case_number`
- `name`
- `account_name`
- `priority`
- `status`
- `assigned_user_name`

Popup search inputs order

- None defined in active metadata.

### Filter View

Basic filter fields

- `current_user_only`
- `open_only`

Advanced filter fields

- `name`
- `account_name`
- `billing_address_city`
- `billing_address_state`
- `phone_office`
- `deadline_c`
- `assistence_datetime_c`
- `resolutions_date_c`
- `service_date_c`
- `opened_by_c`
- `closed_by_c`
- `status`
- `priority`
- `mode_c`
- `code_c`
- `area_c`
- `date_entered`
- `date_modified`
- `assigned_user_id`

## Medicina Ocupacional

### Table View

- `name`
- `contacts_project_1_name`
- `accounts_project_1_name`
- `billing_address_state`
- `billing_address_city`
- `nutsii_c`
- `medicine_exam_type_c`
- `medical_appreciation_c`
- `nome_do_medico_c`
- `admission_date_c`
- `estimated_start_date`
- `contacts_birthdate_c`
- `contact_gender_c`
- `assigned_user_name`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- None defined in active metadata.

Popup result columns

- None defined in active metadata.

Popup search inputs order

- `name`

### Filter View

Basic filter fields

- `current_user_only`

Advanced filter fields

- `accounts_project_1_name`
- `billing_address_state`
- `billing_address_city`
- `contacts_birthdate_c`
- `contact_gender_c`
- `medicine_exam_type_c`
- `medical_appreciation_c`
- `contacts_project_1_name`
- `assigned_user_name`
- `estimated_start_date`
- `date_modified`
- `attendance_date_c`
- `admission_date_c`
- `nutsii_c`
- `created_by`

## Fichas de Aptidão

### Table View

- `name`
- `contacts_sdmod_capability_1_name`
- `accounts_sdmod_capability_1_name`
- `ability_result_c`
- `exam_type_c`
- `localidade_c`
- `exam_date_c`
- `assigned_user_name`

### Edit View

Panel `lbl_editview_panel2`

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

Panel `lbl_editview_panel1`

- `service_organization_c`
- `service_organization_other_c`
- `service_organization_name_c`
- `service_organization_nipc_c`
- `dgs_authorization_process_c`

Panel `lbl_editview_panel4`

- `contacts_sdmod_capability_1_name`
- `nacionalidade_c`
- `sexo_c`
- `data_nascimento_c`
- `data_admissao_c`
- `cat_profissional_c`
- `posto_trabalho_c`
- `atividade_funcao_c`
- `data_admissao_atividade_c`

Panel `lbl_editview_panel5`

- `analise_posto_trabalho_c`
- `analise_posto_trabalho_justi_c`
- `fatores_risco_pro_c`
- `fatores_risco_pro_especifica_c`
- `exposicao_profissional_c`
- `exposicao_profissional_espec_c`

Panel `lbl_editview_panel6`

- `exam_date_c`
- `ability_result_c`
- `exam_type_c`
- `outras_funcoes_c`
- `exam_type_other_c`

Panel `lbl_editview_panel7`

- `recommendations_c`
- `other_recommendations_c`

Panel `lbl_editview_panel10`

- `nome_do_medico_c`
- `n_cedula_profissional_c`

Panel `lbl_editview_panel8`

- `assigned_user_name`

Panel `lbl_editview_panel9`

- `medic_signature_c`
- `medic_signature_date_c`
- `worker_signature_c`
- `worker_signature_date_c`
- `manager_signature_c`
- `manager_signature_date_c`

### Detail View

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

### Popup View

Popup search fields

- None defined in active metadata.

Popup result columns

- None defined in active metadata.

Popup search inputs order

- `sdmod_capability_number`
- `name`
- `priority`
- `status`

### Filter View

Basic filter fields

- `current_user_only`

Advanced filter fields

- `accounts_sdmod_capability_1_name`
- `nipc_c`
- `contacts_sdmod_capability_1_name`
- `exam_date_c`
- `ability_result_c`
- `assigned_user_id`

## Formandos

### Table View

- `name`
- `description`
- `formation_hours_c`
- `action_number_c`
- `contacts_sdmod_training_control_1_name`
- `accounts_sdmod_training_control_1_name`
- `iefp_submission_date`
- `iefp_application_number`
- `candidature_status_c`
- `iefp_verification_date`
- `intern_certificate_number_c`
- `certificate_sent_date`
- `sigo_formation_code`
- `sigo_n_c`
- `iefp__upload_date`
- `date_entered`

### Edit View

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

### Detail View

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

### Popup View

Popup search fields

- None defined in active metadata.

Popup result columns

- None defined in active metadata.

Popup search inputs order

- `sdmod_training_control_number`
- `name`
- `priority`
- `status`

### Filter View

Basic filter fields

- `action_number_c`
- `accounts_sdmod_training_control_1_name`
- `contacts_sdmod_training_control_1_name`
- `iefp_application_number`

Advanced filter fields

- `action_number_c`
- `accounts_sdmod_training_control_1_name`
- `iefp_application_number`
- `formationAccountsNIF`
- `internal_certificate_date`
- `sigo_formation_code`
- `certificate_sent_date`
- `certificate_issue_date`
- `sigo_training_date`
- `sigo_training_date_new_c`
- `intern_date_start_c`
- `intern_date_end_c`
- `candidature_status_c`
- `training_types_c`
- `assigned_user_id`

