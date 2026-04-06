# Auditoria de Campos

## Âmbito desta fase

- Comparar a coerência da informação retirada do `Studio`
- Confirmar se os dados recolhidos por pessoas diferentes batem certo
- Usar `LuxuryCRM` e os dumps SQL como apoio técnico
- Não usar a página real como critério principal nesta fase

## Tarefas em Curso

- [x] Criar a matriz de auditoria de campos
- [/] Identificar gaps e listar campos em falta
- [/] Identificar quais campos se devem fundir entre os dois CRMs
- [/] Identificar campos partilhados com dropdown diferente por base, com prioridade para `Assistências`
- [x] Testar alterações no Studio ✅ 2026-04-06 (não responde)

## Matriz de Auditoria

| Módulo | Campo SQL Seepmode | Campo SQL Tacovia | Campo final no LuxuryCRM | Tabela destino | Decisão | Observações |
|---|---|---|---|---|---|---|
| Contratos | `anuidade_c` | `anuidade_list_c` | `anuidade_c` | `contracts` | fundir | Mesmo conceito. LuxuryCRM já usa `anuidade_c`. |
| Acessos IEFP | `icfp_email_c` | `iefp_email_c` | `iefp_email_c` | `iefp_accesses` | normalizar | Há conflito entre documentação antiga e dumps SQL. |
| Fichas de Aptidão | `sdmod_capability` + `sdmod_capability_cstm` | `sdmod_capability` | `capabilities` | `capabilities` | manter | O modelo rico da Seepmode deve ser a base final. |
| Fichas de Aptidão | `accounts_sdmod_capability_1_c` | — | `account_id` | `capabilities` | manter | Relação relevante já mapeada. |
| Fichas de Aptidão | `contacts_sdmod_capability_1_c` | — | `contact_id` | `capabilities` | manter | Relação relevante já mapeada. |
| Fichas de Aptidão | `project_sdmod_capability_1_c` | — | `project_id` ou join dedicada | `capabilities` / join | gap estrutural | Decidir coluna direta vs join. |
| Fichas de Aptidão | `sdmod_capability_documents_1_c` | — | `capabilities_documents` | join | manter | Relação relevante com Documentos. |
| Renovações | `aos_invoice_renawal_c` | — | `invoice_id` | `renewals` | manter | Relação extra do lado Seepmode. |
| Renovações | — | `sdmod_iefp_accesses_id_c` | `iefp_access_id` | `renewals` | manter | Relação extra do lado Tacovia. |
| Formações | `contact_id1_c` | — | `contact_id` | `trainings` | normalizar | FK criada por Studio. |
| Formações | — | `sdmod_iefp_accesses_id_c` | `iefp_access_id` | `trainings` | manter | LuxuryCRM já prevê este destino. |
| Assistências | `code_c` | `code_c` | `code_c` | `cases` | mapear direto | O campo é comum, mas a lista `code_list` diverge fortemente. |
| Assistências | `status` | `status` | `status` | `cases` | mapear direto | Validar `case_status_dom`. |
| Assistências | `priority` | `priority` | `priority` | `cases` | mapear direto | Validar `priority_list`. |
| Assistências | `area_c` | `area_c` | `area_c` | `cases` | mapear direto | Validar `area_list`. |
| Assistências | `mode_c` | `mode_c` | `mode_c` | `cases` | mapear direto | Validar `cases_mode_list`. |
| Assistências | `send_receive_c` | `send_receive_c` | `send_receive_c` | `cases` | mapear direto | Validar `send_receive_list`. |

## Gaps

### Schema

- `project_sdmod_capability_1_c`
  - decidir entre `capabilities.project_id`
  - ou join dedicada `projects_capabilities`

### Mapeamento

- Rever ids usados nos documentos operacionais de filtros quando não batem certo com a metadata técnica real.
- Confirmar se os nomes em `filter-fields-mapping.md` são nomes finais do alvo ou nomes reais do SuiteCRM.

### Dropdowns

- `Assistências.code_c`
  - `Seepmode`: 1 valor
  - `Tacovia`: 135 valores
- Validar também:
  - `case_status_dom`
  - `priority_list`
  - `area_list`
  - `cases_mode_list`
  - `send_receive_list`

## Campos a Fundir

- `anuidade_c` + `anuidade_list_c` -> `anuidade_c`
- `icfp_email_c` + `iefp_email_c` -> `iefp_email_c`

## Dropdowns a Validar

### Contratos

- `annuity` / `anuidade_c` -> `anuidade_list`

### Assistências

- `code_c` -> `code_list`
- `status` -> `case_status_dom`
- `priority` -> `priority_list`
- `area_c` -> `area_list`
- `mode_c` -> `cases_mode_list`
- `send_receive_c` -> `send_receive_list`

## Registo de validação em curso: Contratos

Campos já confirmados no `Studio` / página real:

- `Annuity (annuity)` aparece como campo disponível no `Studio`
- `Anuidade` está visível no filtro da página real
- `Anuidade` está visível na detail view da página real

Leitura atual para `Contratos`:

- a interface visível trabalha com um único campo funcional de `Anuidade`
- não há evidência visual de dois campos distintos de anuidade expostos ao utilizador
- a decisão de fusão mantém-se correta:
  - `anuidade_c` + `anuidade_list_c` -> `anuidade_c`
- o alvo funcional final deve continuar a ser um único campo de anuidade
- falta apenas evidência complementar da dropdown para fechar o nome da lista com observação direta, mas isso já não bloqueia a decisão de fusão

## Registo de validação em curso: Acessos IEFP

Campos já confirmados no `Studio` / página real da `Tacovia`:

- `name`
- `contact_id`
- `access_date`
- `access_type`
- `status`
- `observations`

Leitura atual para `Acessos IEFP`:

- o módulo existe na `Tacovia`
- em `Edit View`, `Detail View`, `Quickcreate View`, `Filter View` e `List View` não há qualquer campo de email IEFP exposto
- em `Fields`, o módulo também não apresenta qualquer campo de email
- por isso, nesta base, a divergência `icfp_email_c` vs `iefp_email_c` não aparece no `Studio` atual
- a divergência fica, para já, localizada na documentação anterior e/ou nos dumps SQL
- mantém-se a normalização técnica prevista:
  - `icfp_email_c` + `iefp_email_c` -> `iefp_email_c`
- o SQL fecha a dúvida:
  - em `Tacovia`, existe `iefp_email_c` em `sdmod_iefp_accesses_cstm` e em `fields_meta_data`
  - em `Seepmode`, existe `iefp_email_c` em `sdmod_iefp_accesses_cstm` e em `fields_meta_data`
  - não apareceu evidência de `icfp_email_c` nos dumps consultados
- por isso, `icfp_email_c` deve ser tratado como erro documental antigo, e `iefp_email_c` como nome técnico correto

## Registo de validação em curso: Fichas de Aptidão

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista, detail view e edit view ativos
- o modelo rico está confirmado no `Studio`, com painéis de:
  - `Company Information`
  - `Service Organization`
  - `Worker Information`
  - `Work Analysis`
  - `Exam`
  - `Recommendations`
  - `Doctor`
  - `Assignment`
  - `Signatures`
- o registo real mostra o módulo preenchido com dados funcionais
- existem relações funcionais visíveis com:
  - `Documentos`
  - `Emails`

Leitura atual para `Fichas de Aptidão`:

- nesta base, o módulo não está apenas exposto; está efetivamente configurado e utilizável
- o modelo rico fica confirmado na `Tacovia`
- o campo `project_id` aparece em `Fields` com label `Medicina Ocupacional` e tipo `relate`
- isso reforça que existe uma ligação funcional relevante a preservar entre `Fichas de Aptidão` e `Medicina Ocupacional`
- o campo `project_sdmod_capability_1_name` está confirmado visualmente no layout e na detail view
- ficam ainda pendentes apenas as relações técnicas finas que não aparecem diretamente nesta vista de `Fields`:
  - `accounts_sdmod_capability_1_c`
  - `contacts_sdmod_capability_1_c`
  - `project_sdmod_capability_1_c`
  - `sdmod_capability_documents_1_c`
- o gap estrutural de `project_sdmod_capability_1_c` continua aberto, mas a evidência atual mostra que a ligação funcional ao projeto existe

## Registo de validação em curso: Medicina Ocupacional

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo existe na UI com filtro rico e volume real de registos
- a detail view mostra um modelo funcional muito extenso, com painéis de:
  - `Informação do Projeto`
  - `Antecedentes Familiares`
  - `Doenças Profissionais`
  - `Acidentes de Trabalho`
  - `Exposição a Perigos`
  - `Álcool`
  - `Tabaco`
  - `Café`
  - `Medicação`
  - `Passatempos`
  - `Biometrias`
  - `Vacinação`
  - `Exames Complementares`
  - `Patologias Apresentadas`
  - `Recomendações`
  - `Encaminhamento para Especialidades`
  - `Conselhos ao Trabalhador`
  - `Conclusão`
- na detail view aparecem relações funcionais com:
  - `Propostas`
  - `Assistências`
  - `Fichas de Aptidão`
  - `Security Groups`
  - `Documentos`
  - `Emails`
- o `Studio > Edit View` confirma modelo rico equivalente ao visível na página
- `Fields` confirmam um conjunto alargado de campos técnicos e funcionais

Leitura atual para `Medicina Ocupacional`:

- nesta base, o módulo está efetivamente configurado e utilizável
- a evidência disponível confirma um modelo rico também na `Tacovia`
- existe ligação funcional explícita com `Fichas de Aptidão`
- com a evidência atual, fica fechada a existência de estrutura e relações funcionais principais
- o que fica pendente não é a existência do módulo, mas sim a decisão funcional já assumida sobre primazia/destino técnico no projeto

## Registo de validação em curso: Documentos

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura base coerente com o `Studio`, incluindo:
  - `document_name`
  - `filename`
  - `status_id`
  - `revision`
  - `category_id`
  - `subcategory_id`
  - `active_date`
  - `exp_date`
  - `template_type`
  - `is_template`
  - `doc_type`
  - `doc_url`
  - `related_doc_id`
  - `assigned_user_id`
  - `description`
- existe secção de `Attachments` com ficheiro associado
- a detail view mostra relações funcionais visíveis com:
  - `Clientes`
  - `Contactos`
  - `Propostas (Histórico)`
  - `Assistências`
  - `Contratos`
  - `Propostas`
  - `Medicinas Ocupacionais`
  - `Fichas de Aptidão`
  - `Bases de Operações`
- o `Studio > Edit View` e `Fields` estão coerentes com a estrutura visível

Leitura atual para `Documentos`:

- a estrutura base do módulo fica confirmada
- a existência de `Attachments`, `Revision` e `Related Document` confirma que o módulo suporta anexos e cadeia básica de revisão/relacionamento
- a evidência atual reforça a ideia de superset relacional do módulo
- continua pendente apenas confirmar se este superset visível cobre integralmente tudo o que foi pedido pela review e pela documentação técnica

## Registo de validação em curso: Clientes

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a estrutura visível da detail view está globalmente coerente com o `Studio`, incluindo:
  - `name`
  - `phone_office`
  - `phone_alternate`
  - `website`
  - `billing_address_street`
  - `billing_address_city`
  - `billing_address_state`
  - `billing_address_country`
  - `shipping_address_street`
  - `nutsii_c`
  - `place_of_visit_c`
  - `description`
  - `account_type`
  - `industry`
  - `sic_code`
  - `accounts_cae_c`
  - `client_service_type_c`
  - `employees`
  - `n_condutores_c`
  - `ticker_symbol`
  - `ownership`
  - `employees_establishment_c`
  - `send_payment_reminder_c`
  - `assigned_user_id`
- o filtro real expõe também os campos operacionais principais do módulo
- o `Studio > Fields` confirma os campos custom relevantes que já estavam a ser analisados
- a detail view mostra relações funcionais visíveis com:
  - `Contactos`
  - `Propostas (Histórico)`
  - `Propostas`
  - `Faturas`
  - `Contratos`
  - `Assistências`
  - `Medicinas Ocupacionais`
  - `Fichas de Aptidão`
  - `Formações`
  - `Formandos`
  - `Reuniões`
  - `Telefonemas`
  - `Tarefas`
  - `Notas`
  - `Documentos`
  - `Emails`
  - `Bases de Operações`

Leitura atual para `Clientes`:

- a estrutura do módulo está confirmada como rica e operacional
- a coerência entre `Studio` e UI é globalmente boa neste módulo
- a evidência atual reduz o risco de gap estrutural relevante em `Clientes`
- ficam em aberto apenas diferenças finas de layout ou reconciliação documental com notas antigas

## Registo de validação em curso: Propostas

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `name`
  - `account_id`
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
  - `contact_id`
  - `assigned_user_id`
- a secção `Line Items` está ativa e visível
- a estrutura financeira principal fica confirmada:
  - `currency_id`
  - `total_amt`
  - `subtotal_amount`
  - `shipping_tax_amt`
  - `line_items`
  - `discount_amount`
  - `shipping_amount`
  - `tax_amount`
  - `total_amount`
- `Fields` confirmam também:
  - `quote_stage`
  - `valid_until`
  - `payment_terms`
  - `subtotal`
  - `discount_amount`
  - `tax_amount`
  - `shipping_amount`
  - `total`
  - `quote_number`
  - `company`
  - `grand_total`

Leitura atual para `Propostas`:

- a estrutura do módulo está confirmada como operacional e coerente entre `Studio` e UI
- os campos de negócio, financeiros e de workflow principais estão presentes
- `Line Items` e totais confirmam que o módulo não está apenas exposto, mas funcionalmente ativo
- ficam em aberto apenas diferenças finas de filtro/layout ou reconciliação com documentação anterior

## Registo de validação em curso: Faturas

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `name`
  - `salesperson_c`
  - `number`
  - `account_id`
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
  - `contract_id`
  - `invoicing_notes_c`
  - `payment_reminder_c`
  - `status`
  - `assigned_user_id`
- a secção `Line Items` está ativa e visível
- a estrutura financeira principal fica confirmada:
  - `currency_id`
  - `total_amt`
  - `subtotal_amount`
  - `shipping_tax_amt`
  - `line_items`
  - `discount_amount`
  - `shipping_amount`
  - `tax_amount`
  - `total_amount`
  - `grand_total`
- `Fields` confirmam também:
  - `invoice_number`
  - `type`
  - `vendor`
  - `amount_open`
  - `renewal_value`
  - `advanced_pack`
  - `renewal_date`
  - `billing_notes`
  - `auto_email_reminder`
  - `company`

Leitura atual para `Faturas`:

- a estrutura do módulo está confirmada como operacional e coerente entre `Studio` e UI
- os campos financeiros, comerciais e de controlo principais estão presentes
- `Line Items` e totais confirmam atividade funcional real do módulo
- ficam em aberto apenas diferenças finas de layout/filtro ou reconciliação documental residual

## Registo de validação em curso: Contactos

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `first_name`
  - `last_name`
  - `data_de_admissao_c`
  - `phone_work`
  - `birthdate`
  - `phone_mobile`
  - `title`
  - `phone_fax`
  - `department`
  - `sessao_c`
  - `account_id`
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
  - `tipo_de_recurso_c`
  - `numero_do_beneficiario_c`
  - `ultimo_exame_c`
  - `proximo_exame_c`
  - `email1`
  - `description`
  - `assigned_user_id`
  - `report_to_id`
  - `sync_contact`
  - `do_not_call`
  - `lead_source`
- o filtro real confirma também os campos operacionais principais:
  - `first_name`
  - `last_name`
  - `account_id`
  - `department`
  - `vat_number_c`
  - `contact_type_c`
  - `title`
  - `assigned_user_id`
- a detail view mostra relações funcionais visíveis com:
  - `Clientes`
  - `Propostas (Histórico)`
  - `Assistências`
  - `Medicinas Ocupacionais`
  - `Fichas de Aptidão`
  - `Formandos`
  - `Acessos IEFP`
  - `Propostas`
  - `Faturas`
  - `Contratos`
  - `Reuniões`
  - `Telefonemas`
  - `Tarefas`
  - `Notas`
  - `Documentos`
  - `Emails`
  - `Utilizadores`
  - `Bases de Operações`
- o audit trail confirma ainda atividade real sobre campos do módulo

Leitura atual para `Contactos`:

- a estrutura do módulo está confirmada como rica e operacional
- a coerência entre `Studio` e UI é globalmente boa
- a evidência atual reduz o peso de diferenças estruturais e reforça que os gaps remanescentes são finos e documentais

## Registo de validação em curso: Formações

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `formation_action`
  - `year`
  - `name`
  - `status`
  - `formation_date`
  - `end_date_c`
  - `account_id`
  - `trainer_c`
  - `contact_id`
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
- a secção `Follow-up` está ativa e coerente com `Fields`, incluindo:
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
- as secções `Location`, `Invoice` e `Assignment` também estão ativas e coerentes com `Studio` / `Fields`, incluindo:
  - `place`
  - `local_invoice_number_c`
  - `address`
  - `local_value_c`
  - `room`
  - `local_payment_date_c`
  - `projector`
  - `invoice_number_new_c`
  - `payment_date`
  - `invoice_value`
  - `paid_value_c`
  - `invoice_date`
  - `assigned_user_id`
  - `salesperson_c`
  - `invoice_id`
- a detail view mostra relações funcionais visíveis com:
  - `Sessões`
  - `Formadores`
  - `Faturas`
- o audit trail confirma atividade real sobre o módulo

Leitura atual para `Formações`:

- a estrutura do módulo está confirmada como rica e operacional
- a coerência entre `Studio` e UI é globalmente boa
- o módulo já evidencia ligação funcional a `Sessões`, `Formadores` e `Faturas`
- a evidência atual reduz o peso de gaps estruturais e deixa sobretudo pendências finas de reconciliação documental

## Registo de validação em curso: Formandos

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `contact_id`
  - `assigned_user_id`
  - `account_id`
  - `action_number_c`
  - `description`
  - `formation_hours_c`
  - `training_types_c`
  - `formation_place_c`
- a secção `IEFP` está ativa e coerente com `Fields`, incluindo:
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
- as secções `Certificates`, `SIGO` e `IMTT` também estão ativas e coerentes com `Studio` / `Fields`, incluindo:
  - `internal_certificate_date`
  - `certificate_sent_date`
  - `intern_certificate_number_c`
  - `intern_reference_c`
  - `intern_date_start_c`
  - `intern_evaluation_c`
  - `intern_date_end_c`
  - `certificate_issue_date`
  - `sigo_training_date`
  - `sigo_formation_code`
  - `sigo_training_date_new_c`
  - `iefp_upload_date`
  - `sigo_n_c`
  - `imtt_action_code`
  - `application_start_date`
  - `certificate_submission_date`
  - `application_closing_date`
  - `process_closed`
- o audit trail confirma atividade real sobre o módulo

Leitura atual para `Formandos`:

- a estrutura do módulo está confirmada como rica e operacional
- a coerência entre `Studio` e UI é globalmente boa
- a evidência atual reforça a componente de acompanhamento administrativo e certificação do módulo
- os gaps remanescentes parecem finos e mais documentais do que estruturais

## Registo de validação em curso: Formadores

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
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
- `Fields` confirmam também:
  - `training_id`
  - `assigned_user_id`
  - `contact_id`
  - `receipt_value`
  - `currency_id`
- a detail view mostra relação funcional visível com:
  - `Sessões`
- o módulo apresenta secção de `Attachments` e `Audit Trail`

Leitura atual para `Formadores`:

- a estrutura do módulo está confirmada como operacional e coerente entre `Studio` e UI
- trata-se de um módulo mais simples do que `Formações` e `Formandos`, mas com propósito funcional claro
- a evidência atual reduz o peso de gaps estruturais e deixa sobretudo pendências finas de reconciliação documental

## Registo de validação em curso: Reuniões

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `name`
  - `status`
  - `date_start`
  - `date_end`
  - `duration_hours`
  - `duration_minutes`
  - `location`
  - `reminder_time`
  - `parent_type`
  - `parent_id`
  - `assigned_user_id`
  - `description`
  - `date_entered`
- a detail view mostra relações funcionais visíveis com:
  - `Contactos`
  - `Utilizadores`
  - `Propostas`
- `Fields` confirmam ainda campos adicionais de suporte:
  - `jjwg_maps_lng_c`
  - `jjwg_maps_lat_c`
  - `jjwg_maps_geocode_status_c`
  - `jjwg_maps_address_c`
  - `notificacao_de_auditoria_c`
- existe secção de `Attachments`

Leitura atual para `Reuniões`:

- a estrutura do módulo está confirmada como operacional e coerente entre `Studio` e UI
- trata-se de um módulo relativamente simples, com diferenças residuais e pouco sinal de gap estrutural relevante
- os campos adicionais de geolocalização/notificação parecem acessórios e não alteram a coerência funcional principal

## Registo de validação em curso: Telefonemas

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `name`
  - `status`
  - `date_start`
  - `date_end`
  - `duration_hours`
  - `duration_minutes`
  - `direction`
  - `reminder_time`
  - `parent_type`
  - `parent_id`
  - `assigned_user_id`
  - `description`
  - `date_entered`
- a detail view mostra relações funcionais visíveis com:
  - `Contactos`
  - `Utilizadores`
  - `Propostas`
- existe secção de `Attachments`

Leitura atual para `Telefonemas`:

- a estrutura do módulo está confirmada como operacional e coerente entre `Studio` e UI
- trata-se de um módulo simples, com baixo sinal de gap estrutural
- as diferenças remanescentes parecem finas e pouco relevantes do ponto de vista técnico

## Registo de validação em curso: Notas

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `name`
  - `contact_id`
  - `parent_type`
  - `parent_id`
  - `filename`
  - `assigned_user_id`
  - `description`
  - `file_mime_type`
  - `date_entered`
- existe secção de `Attachments`
- o módulo mostra a relação funcional básica através de `Related To (Module)` / `Related To`

Leitura atual para `Notas`:

- a estrutura do módulo está confirmada como simples, operacional e coerente entre `Studio` e UI
- não há sinal forte de gap estrutural relevante
- as diferenças remanescentes parecem residuais e de baixo impacto técnico

## Registo de validação em curso: Emails

Campos já confirmados no `Studio` / página real da `Tacovia`:

- o módulo tem filtro, lista e detail view ativos
- a detail view confirma estrutura principal coerente com o `Studio`, incluindo:
  - `name`
  - `type`
  - `from_addr_name`
  - `to_addrs_names`
  - `status`
  - `cc_addrs_names`
  - `bcc_addrs_names`
  - `reply_to_addr`
  - `date_sent_received`
  - `category_id`
  - `parent_type`
  - `parent_id`
  - `assigned_user_id`
  - `description`
  - `description_html`
  - `date_entered`
- a detail view confirma também:
  - `Related Module`
  - `Related To`
  - `HTML Body`
  - `Body`
- existe secção de `Attachments`
- `Fields` confirmam ainda campos adicionais de suporte:
  - `raw_source`
  - `date_sent`
  - `flagged`
  - `reply_to_status`
  - `parent_name`
  - `message_id`
  - `uid`
  - `intent`
  - `mailbox_id`
  - `orphaned`

Leitura atual para `Emails`:

- a estrutura do módulo está confirmada como operacional e coerente entre `Studio` e UI
- o módulo preserva corretamente a componente de conteúdo (`Body` / `HTML Body`) e a relação contextual com outros módulos
- não há sinal forte de gap estrutural relevante
- as diferenças remanescentes parecem residuais e de baixo impacto técnico
- no entanto, foi confirmada uma incoerência específica no filtro:
  - o `Studio > Filter View` tem como campos default:
    - `ID`
    - `Nome`
    - `Valor/Hora`
    - `Valor Total`
    - `Número da Fatura`
    - `Data de pagamento`
  - o filtro real na UI mostra:
    - `Nome`
    - `Valor/Hora`
    - `Valor Total`
    - `Valor do recibo (€)`
    - `Número da Fatura`
    - `Data da factura`
    - `Data Entrega Recibo`
    - `Data de pagamento`
- isto confirma divergência entre o `Filter View` do `Studio` e o filtro realmente exposto ao utilizador

### Registo de validação em curso: Assistências

Campos já confirmados no filtro do `Studio`:

- `Assunto`
- `Nome da conta`
- `Concelho`
- `Data Limite`
- `Data`
- `Data resolução`
- `Data do serviço/auditoria`
- `Aberto por`
- `Fechado por`
- `Situação`
- `Prioridade`
- `Modo`
- `Código`
- `Área`
- `Criado em`
- `Date Modified`
- `Atribuído a`

### Tabela de validação: Assistências

| Campo                   | Tipo                | Estado atual | Levantamento                                                                                                                                    |
| ----------------------- | ------------------- | ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `code_c`                | dropdown de negócio | parcial      | confirmado no filtro; apresenta valores com `label` e outros só numéricos                                                                       |
| `status`                | dropdown de negócio | parcial      | confirmado no filtro, lista uniforme de `0` a `6`                                                                                               |
| `priority`              | dropdown de negócio | parcial      | confirmado no filtro; lista `1`, `2`, `3` sem label textual                                                                                     |
| `mode_c`                | dropdown de negócio | parcial      | confirmado no filtro; `Email`, `Telefone`, `Presencial`                                                                                         |
| `area_c`                | dropdown de negócio | parcial      | confirmado no filtro; `Suporte`, `Jurídico`, `SGT`, `SUT`, `HACCP`                                                                              |
| `send_receive_c`        | dropdown de negócio | parcial      | confirmado documentalmente em ambas as extrações do `Studio` e na metadata técnica; nesta ronda ficou por confirmar visualmente no filtro atual |
| `assistence_datetime_c` | operador de filtro  | confirmado   | operador comum de data                                                                                                                          |
| `resolution_date`       | operador de filtro  | confirmado   | operador comum de data                                                                                                                          |
| `service_date_c`        | operador de filtro  | confirmado   | operador comum de data                                                                                                                          |
| `date_due`              | operador de filtro  | confirmado   | operador comum de data                                                                                                                          |
| `date_entered`          | operador de filtro  | confirmado   | operador comum de data                                                                                                                          |
| `date_modified`         | operador de filtro  | confirmado   | operador comum de data                                                                                                                          |

Leituras já confirmadas:

- os campos de data usam um `dropdown` de operador de filtro comum
- esse comportamento está coerente entre:
  - `Data`
  - `Data resolução`
  - `Data do serviço/auditoria`
  - `Data Limite`
  - `Criado em`
  - `Date Modified`
- `send_receive_c` não corresponde aos botões `Search` e `Clear`
- os botões `Search` e `Clear` são ações do filtro, não campos do módulo

Levantamento atual para `case_status_dom`:

- `0 - Aberto`
- `1 - Em espera`
- `2 - Pendente`
- `3 - Fechado`
- `4 - Realizado`
- `5 - Finalizado`
- `6 - Expirado`

Leitura provisória para `Situação`:

- o `dropdown` está legível e uniformizado
- os valores observados no `Studio` são coerentes com a lógica funcional do módulo
- falta ainda cruzar esta lista com a recolha da outra fonte para fechar coerência entre extrações

Levantamento atual para `priority_list`:

- `1`
- `2`
- `3`

Leitura provisória para `Prioridade`:

- o `dropdown` está ativo e uniforme
- os valores observados aparecem sem label descritiva
- nesta fase não é erro por si só, mas deve ser cruzado com a outra recolha do `Studio` para perceber se:
  - a lista foi documentada só com números
  - ou se noutro levantamento existem labels associadas

Levantamento atual para `cases_mode_list`:

- `Email`
- `Telefone`
- `Presencial`

Leitura provisória para `Modo`:

- o `dropdown` está ativo e uniforme
- os valores estão descritos com label textual
- à partida não há sinal de falha estrutural
- falta apenas cruzar com a outra recolha do `Studio`

Levantamento atual para `area_list`:

- `Suporte`
- `Jurídico`
- `SGT`
- `SUT`
- `HACCP`

Leitura provisória para `Área`:

- o `dropdown` está ativo e uniforme
- os valores estão descritos com label textual
- não há, para já, sinal de valores vazios ou numéricos sem label
- falta ainda cruzar com a outra recolha do `Studio`

Leitura atual para `send_receive_c`:

- o campo aparece nas duas extrações de `Check-list` do `Studio`
- o `LuxuryCRM` confirma o dropdown técnico `send_receive_list`
- a lista técnica identificada é:
  - `Received` -> `Recebido`
  - `Send` -> `Enviado`
- o campo existe no `Studio > Layouts > Filter View`
- no filtro real atual do módulo, o campo não está visível
- isto confirma uma divergência entre layout configurado no `Studio` e campos expostos no filtro atual
- o campo não corresponde aos botões `Search` e `Clear`

Levantamento atual para `code_list`:

- exemplos com `label`:
  - `106 - Colesterol total`
  - `107 - Glicémia`
  - `108 - Audiometria`
  - `109 - Espirometria`
  - `110 - ECG (repouso).`
- exemplos só com valor numérico:
  - `63`
  - `64`
  - `65`
  - `66`
  - `67`
  - `68`
  - `69`
  - `73`

Leitura atual:

- o `dropdown` `code_list` não está uniformizado ao nível de labels
- isto deve ser tratado como ponto crítico de coerência entre recolhas do `Studio`
- a evidência documental disponível aponta para divergência real entre bases
- a decisão técnica mais segura continua a ser usar o superset da `Tacovia`

### Observação sobre filtros com data

No `Studio` e no filtro do módulo `Assistências` existem dois tipos de campos com comportamento diferente:

- `dropdowns` de negócio
  - exemplos: `Código`, `Situação`, `Prioridade`, `Modo`, `Área`
  - servem para escolher valores do próprio campo
- `dropdowns` de operador de filtro
  - exemplos: `Data`, `Data resolução`, `Data do serviço/auditoria`, `Data Limite`, `Criado em`, `Date Modified`
  - servem para escolher o operador da pesquisa, como:
    - `Igual`
    - `Antes`
    - `Depois`
    - `Entre`

Leitura desta validação:

- os campos de data no filtro estão a funcionar de forma coerente entre si
- o `dropdown` associado a estes campos não representa uma lista de negócio
- representa antes uma lógica comum de operadores de pesquisa
- por isso, nesta auditoria, estes campos devem ser tratados separadamente dos `dropdowns` funcionais do módulo

Conclusão para `Assistências`:

- validar como `dropdowns críticos de negócio`:
  - `code_c`
  - `status`
  - `priority`
  - `mode_c`
  - `area_c`
- validar como `operadores de filtro`:
  - `assistence_datetime_c`
  - `service_date_c`
  - `date_due`
  - `date_entered`
  - `date_modified`
  - `resolution_date`

Fecho documental atual para `Assistências`:

- as duas extrações novas do `Studio` estão alinhadas ao nível de estrutura do módulo
- `send_receive_c` deixou de ser um campo apenas inferido por SQL, porque aparece explicitamente nas duas recolhas documentais
- `send_receive_c` existe no `Studio`, mas não está visível no filtro real atual
- essa diferença deve ser registada como divergência entre configuração e exposição funcional do filtro
- a grande divergência relevante entre bases continua a ser `code_list`
- a UI real confirma que `code_c` é funcional no filtro, na lista e na detail view
- a lista `code_list` mostra mistura estrutural entre:
  - valores com label descritiva
  - valores apenas numéricos
- essa mistura repete-se em várias zonas da dropdown e deve ser tratada como divergência real, não como erro pontual de recolha
- `priority_list` não mostra labels descritivas e deve continuar assinalado como ponto de atenção, mas a metadata confirma que a lista esperada é mesmo `1`, `2`, `3`
- a recomendação técnica atual continua a ser tratar `code_list` como superset da `Tacovia`
- não há, nesta fase, evidência de impacto crítico em workflows que altere a decisão técnica para `LuxuryCRM`
- o tema `workflow` fica marcado como não bloqueante nesta fase

## Testes no Studio

### Assistências

- [x] Confirmar valores ativos de `code_c` ✅ 2026-04-06
- [/] Confirmar valores ativos de `status`
- [/] Confirmar valores ativos de `priority`
- [/] Confirmar valores ativos de `mode_c`
- [/] Confirmar valores ativos de `area_c`
- [x] Confirmar divergência estrutural de `code_list` ✅ 2026-04-06
- [x] Fechar `code_list` como superset `Tacovia` ✅ 2026-04-06
- [x] Classificar tema `workflow` como não bloqueante ✅ 2026-04-06

- [/] Confirmar também os valores ativos de:
  - `send_receive_c`

### Módulos com extrações do Studio a rever

- `Clientes`
- `Medicina Ocupacional`
- `Fichas de Aptidão`
- `Propostas`



Anexos / observações:

- os campos de data usam operadores de filtro comuns
- `code_c` mostra valores com label e valores só numéricos
- `status` apresenta valores uniformizados de `0` a `6`
- `priority` apresenta valores `1`, `2`, `3` sem label textual


## Fontes Base

- [[01 - code/CRMs/Auditorias/Plano de Validação]]
- [[01 - code/CRMs/Auditorias/Comparações entre os campos e módulos de toda a informação da pasta LuxuryCRM(pasta do projeto) e a pasta Comparações de CRM]]
- [[01 - code/CRMs/Comparações de CRM/review]]
- [[01 - code/CRMs/Comparações de CRM/Parecer tecnico]]
- [[01 - code/CRMs/Comparações de CRM/Comparação dos antigos CRMs]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/seepmode-vs-tacovia-fields]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-matrix]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-operation-plan]]
- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/Dados/`
