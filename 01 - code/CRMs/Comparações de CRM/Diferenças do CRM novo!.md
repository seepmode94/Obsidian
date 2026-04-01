# Diferenças

## Clientes

### List View

**Só no Studio:**
- [ ] ID [id]
- [ ] Telefone alternativo [phone_alternate]
- [ ] Date Modified [date_modified]
- [ ] NUTS II [nutsii_c]

**Só na página real:**
- [ ] NIF [sic_code]
- [ ] Nome [name]
- [ ] Nº Func. [employees]
- [ ] Área de atividade [industry]
- [ ] Billing City [billing_address_city]
- [ ] Billing State [billing_address_state]
- [ ] Billing Country [billing_address_country]
- [ ] Telefone de trabalho [phone_office]
- [ ] Nº Estab. [employees_establishment_c]
- [ ] Nº Cond. [n_condutores_c]
- [ ] Pesados [ownership]
- [ ] Ligeiros [ticker_symbol]
- [ ] Atribuído a [assigned_user_id]

**Nota técnica:**
A listagem real mostra duas colunas `Date Created`, o que sugere duplicação na configuração visível da página.

### Create / Quickcreate

**Só no Studio:**
- [ ] Atribuído a [assigned_user_id]

**Só na página real:**
- Sem diferenças

## Fichas de Aptidão

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Estabelecimento [estabelecimento_c]
- [ ] CAE principal [cae_c]
- [ ] Endereço [endereco_c]

**Só na página real:**
- [ ] Paciente [contact_id]
- [ ] Data do exame [exam_date_c]
- [ ] Resultado de aptidão [ability_result_c]
- [ ] Gestor [assigned_user_id]

### List View

**Só no Studio:**
- [ ] ID [id]
- [ ] NIPC/NIF [nipc_c]
- [ ] Estabelecimento [estabelecimento_c]
- [ ] CAE principal [cae_c]
- [ ] Endereço [endereco_c]

**Só na página real:**
- [ ] Paciente [contact_id]
- [ ] Resultado de aptidão [ability_result_c]
- [ ] Tipo [exam_type_c]
- [ ] Localidade [localidade_c]
- [ ] Data do exame [exam_date_c]
- [ ] Gestor [assigned_user_id]
- [ ] Date Created [date_entered]

### Create / Quickcreate

**Só no Studio:**
- [ ] Gestor [assigned_user_id]

**Só na página real:**
- Sem diferenças

**Nota técnica:**
Não foi possível validar a página real de `Detail View` para este módulo devido ao erro: `Error: Invalid or expired token`.

## Assistências

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Enviar/Receber [send_receive_c]

**Só na página real:**
- [ ] Nome da conta: [account_id]
- [ ] Concelho [billing_address_state]
- [ ] Data Limite [deadline_c]
- [ ] Data resolução [resolutions_date_c]
- [ ] Aberto por [opened_by_c]
- [ ] Fechado por [closed_by_c]
- [ ] Situação: [status]
- [ ] Prioridade: [priority]
- [ ] Código [code_c]
- [ ] Área [area_c]
- [ ] Criado em [date_entered]
- [ ] Date Modified [date_modified]
- [ ] Atribuído a: [assigned_user_id]

### List View

**Só no Studio:**
- [ ] ID [id]
- [ ] Data do serviço/auditoria [service_date_c]
- [ ] Enviar/Receber [send_receive_c]

**Só na página real:**
- [ ] Código [code_c]
- [ ] Situação: [status]
- [ ] Prioridade: [priority]
- [ ] Nome da conta: [account_id]
- [ ] Concelho [billing_address_state]
- [ ] Contacto [who_contacted_c]
- [ ] Data Limite [deadline_c]
- [ ] Data resolução [resolutions_date_c]
- [ ] Fechado por [closed_by_c]
- [ ] Criado em [date_entered]
- [ ] Aberto por [opened_by_c]
- [ ] Criado por [created_by_name]
- [ ] Date Created [date_entered]

### Create / Quickcreate

**Só no Studio:**
- [ ] Country [billing_address_country]
- [ ] Concelho [billing_address_state]
- [ ] Atribuído a [assigned_user_id]

**Só na página real:**
- Sem diferenças

## Acessos IEFP

### Create / Quickcreate

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- Sem diferenças

## Medicinas Ocupacionais

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Nome [name]
- [ ] Nº Exame [medicine_exam_number_c]
- [ ] Cliente [account_id]
- [ ] Data Prevista [estimated_start_date]

**Só na página real:**
- [ ] Concelho [billing_address_state]
- [ ] Cidade [billing_address_city]
- [ ] Data de Nascimento [contacts_birthdate_c]
- [ ] Sexo [contact_gender_c]
- [ ] Tipo de exame [medicine_exam_type_c]
- [ ] Apreciação médica [medical_appreciation_c]
- [ ] Gestor de projeto [assigned_user_id]
- [ ] Data de alteração [date_modified]
- [ ] Data Presença [attendance_date_c]
- [ ] Data de admissão [admission_date_c]
- [ ] NUTS II [nutsii_c]
- [ ] Criado por [created_by]

**Nota técnica:**
Vários campos visíveis no filtro real não estão em `Default`, mas existem em `Available`.
Isto sugere que a página real pode estar a usar outra configuração para montar o filtro, em vez de respeitar apenas o `Filter View` do Studio.

### List View

**Só no Studio:**
- [ ] ID [id]
- [ ] Nº Exame [medicine_exam_number_c]
- [ ] Data Prevista [estimated_start_date]

**Só na página real:**
- [ ] Concelho [billing_address_state]
- [ ] Cidade [billing_address_city]
- [ ] NUTS II [nutsii_c]
- [ ] Tipo de exame [medicine_exam_type_c]
- [ ] Apreciação médica [medical_appreciation_c]
- [ ] Nome do Médico [nome_do_medico_c]

**Nota técnica:**
Várias colunas visíveis na listagem real não estão em `Default`, mas existem em `Available`.
Isto sugere que a listagem real pode estar a usar outra configuração para montar as colunas, em vez de respeitar apenas o `List View` do Studio.

### Create / Quickcreate

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- Sem diferenças

## Propostas

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Fase proposta [quote_stage]
- [ ] Válida até [valid_until]
- [ ] Condições de pagamento [payment_terms]

**Só na página real:**
- [ ] Contactos [contact_id]
- [ ] Data prevista fecho [data_prevista_fecho_c]
- [ ] Situação de aprovação [approval_status]
- [ ] Company [empresa_c]
- [ ] Date Modified [date_modified]
- [ ] Date Created [date_entered]
- [ ] Atribuído a [assigned_user_id]

### List View

**Só no Studio:**
- [ ] ID [id]
- [ ] Fase proposta [quote_stage]
- [ ] Válida até [valid_until]
- [ ] Condições de pagamento [payment_terms]

**Só na página real:**
- [ ] Company [empresa_c]
- [ ] Data prevista fecho [data_prevista_fecho_c]
- [ ] Situação de aprovação [approval_status]
- [ ] Atribuído a [assigned_user_id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]

**Nota técnica:**
A listagem real mostra duas colunas `Date Created`, o que sugere duplicação na configuração visível da página.

### Create / Quickcreate

**Só no Studio:**
- [ ] Subtotal [subtotal]
- [ ] Desconto [discount_amount]
- [ ] Taxa [tax_amount]
- [ ] Portes de envio [shipping_amount]
- [ ] Total [total]
- [ ] Atribuído a [assigned_user_id]
- [ ] Currency [currency]
- [ ] Taxa de envio [shipping_tax]
- [ ] Total final [grand_total]
- [ ] Data prevista fecho [data_prevista_fecho_c]
- [ ] Company [empresa_c]

**Só na página real:**
- Sem diferenças

## Faturas

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Situação [status]

**Só na página real:**
- [ ] Valor Aberto (€) [open_value_c]
- [ ] Valor Pago (€) [paid_value_c]
- [ ] Line Items [line_items]
- [ ] Vendedor [salesperson_c]
- [ ] Atribuído a [assigned_user_id]

### List View

**Só no Studio:**
- [ ] ID [id]
- [ ] Situação [status]

**Só na página real:**
- [ ] Descrição [description]
- [ ] Valor Aberto (€) [open_value_c]
- [ ] Valor Pago (€) [paid_value_c]
- [ ] Quote Date [quote_date]
- [ ] Renovation Value [renovation_value_c]
- [ ] Vendedor [salesperson_c]
- [ ] Data de criação [date_entered]
- [ ] Atribuído a [assigned_user_id]
- [ ] Date Created [date_entered]

**Nota técnica:**
A listagem real mostra `Data de criação` e `Date Created` em simultâneo, o que sugere duplicação semântica na configuração visível da página.

### Create / Quickcreate

**Só no Studio:**
- [ ] Atribuído a [assigned_user_id]

**Só na página real:**
- Sem diferenças

## Contratos

### Filtro

**Só no Studio:**
- [ ] ID [id]

**Só na página real:**
- [ ] Data Renovação [renewal_date_c]
- [ ] Versão [versao_c]
- [ ] Pack [pack_c]
- [ ] Estado do Pack [pack_state_c]
- [ ] Valor do Pack [renewal_value_c]
- [ ] Empresa [empresa_c]
- [ ] Assigned To [assigned_user_id]

**Nota técnica:**
O `Filtro` do Studio usa um conjunto mínimo de campos em `Default`, mas a página real mostra um conjunto alargado de campos contratuais, o que sugere uma configuração divergente do filtro visível.

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- [ ] Date Created [date_entered]

**Nota técnica:**
A listagem real mostra `Data criação` e `Date Created` em simultâneo, o que sugere duplicação semântica na configuração visível da página.

### Create / Quickcreate

**Só no Studio:**
- [ ] Annuity [annuity]
- [ ] Net Value € [net_value]
- [ ] Pack [pack]
- [ ] Version [version]
- [ ] Gestor do contrato [contract_manager_id]
- [ ] Renewal Date [renewal_date]
- [ ] Pack Value [pack_value]
- [ ] Pack Status [pack_status]
- [ ] Company [company]
- [ ] Currency [currency]
- [ ] Total [total]
- [ ] Subtotal [subtotal]
- [ ] Taxa de envio [shipping_tax]
- [ ] Total final [grand_total]

**Só na página real:**
- [ ] Data criação [date_entered]
- [ ] currency_id [currency_id]
- [ ] total_amt [total_amt]
- [ ] subtotal_amount [subtotal_amount]
- [ ] shipping_tax_amt [shipping_tax_amt]
- [ ] total_amount [total_amount]

**Nota técnica:**
O `Create / Quickcreate` mistura no Studio campos legacy em inglês com campos custom em português, enquanto a página real privilegia os campos custom e ainda expõe campos técnicos associados aos totais e à secção de `Line Items`.

## Telefonemas

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] End Date [date_end]
- [ ] Duration Hours [duration_hours]
- [ ] Duration Minutes [duration_minutes]

**Só na página real:**
- [ ] Direction [direction]
- [ ] Status [status]
- [ ] Assigned To [assigned_user_id]

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- [ ] Date Created [date_entered]

### Create / Quickcreate

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- Sem diferenças

## Contactos

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Data Nascimento [birthdate]
- [ ] Date Modified [date_modified]
- [ ] Endereço principal [primary_address_street]
- [ ] Endereço alternativo [alt_address_street]

**Só na página real:**
- [ ] Nome próprio [first_name]
- [ ] Apelido [last_name]
- [ ] Nome da conta [account_id]
- [ ] Departamento [department]
- [ ] NIF [vat_number_c]
- [ ] Tipo [contact_type_c]
- [ ] Cargo [title]
- [ ] Atribuído a [assigned_user_id]

### List View

**Só no Studio:**
- [ ] Nome [name]

**Só na página real:**
- [ ] Date Created [date_entered]

**Nota técnica:**
A listagem real não mostra a coluna `Nome [name]` que está em `Default` no Studio e apresenta duas colunas `Date Created`, o que sugere simultaneamente ocultação de um campo esperado e duplicação semântica na configuração visível da página.

### Create / Quickcreate

**Só no Studio:**
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]
- [ ] Modified By [modified_user_id]
- [ ] Created By [created_by]
- [ ] Deleted [deleted]
- [ ] Salutation [salutation]
- [ ] Home Phone [phone_home]
- [ ] Supervisionado por [report_to_id]
- [ ] É Formando? [is_trainee_c]
- [ ] É Formador? [is_trainer_c]

**Só na página real:**
- [ ] report_to_name [report_to_name]
- [ ] campaign_name [campaign_name]
- [ ] Fonte da pista [lead_source]
- [ ] Sincronizar contacto [sync_contact]
- [ ] Não telefonar [do_not_call]

**Nota técnica:**
O `Create / Quickcreate` de `Contactos` não replica integralmente o layout do Studio: a página real privilegia campos operacionais e visíveis para o utilizador final, enquanto o Studio mantém vários campos técnicos, de auditoria e relacionamento indireto.

## Reuniões

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Duration Hours [duration_hours]
- [ ] Duration Minutes [duration_minutes]

**Só na página real:**
- [ ] Location [location]
- [ ] Assigned To [assigned_user_id]
- [ ] Status [status]

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- [ ] Date Created [date_entered]

### Create / Quickcreate

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- Sem diferenças

## Documentos

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Name [name]
- [ ] Revision [revision]

**Só na página real:**
- [ ] Category [category_id]
- [ ] Subcategory [subcategory_id]
- [ ] Assigned To [assigned_user_id]
- [ ] Last Revision Date [last_rev_create_date]
- [ ] Expiration Date [exp_date]

### List View

**Só no Studio:**
- [ ] Status [status_id]

**Só na página real:**
- [ ] Date Created [date_entered]

**Nota técnica:**
A listagem real não mostra `Status [status_id]`, embora esteja em `Default` no Studio, e apresenta duas colunas com `Date Created`, o que sugere ocultação de um campo esperado e duplicação semântica na configuração visível da página.

### Create / Quickcreate

**Só no Studio:**
- [ ] Name [name]
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]
- [ ] External ID [doc_id]
- [ ] File Extension [file_ext]
- [ ] Current Revision ID [document_revision_id]
- [ ] Related Revision ID [related_doc_rev_id]
- [ ] Last Revision Date [last_rev_create_date]

**Só na página real:**
- [ ] Document File [filename]

**Nota técnica:**
O `Create / Quickcreate` de `Documentos` no Studio inclui vários campos técnicos e de gestão documental, enquanto a página real expõe o carregamento direto do ficheiro na secção `FILE UPLOAD`, o que altera materialmente a experiência face ao layout configurado.

## Notas

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Descrição [description]
- [ ] Related To (Module) [parent_type]
- [ ] Related To [parent_id]

**Só na página real:**
- [ ] Attachment [filename]
- [ ] Assigned To [assigned_user_id]
- [ ] Date Created [date_entered]

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- Sem diferenças

### Create / Quickcreate

**Só no Studio:**
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]
- [ ] MIME Type [file_mime_type]

**Só na página real:**
- Sem diferenças

**Nota técnica:**
No `Create / Quickcreate`, a página real segue o núcleo funcional do formulário, enquanto o Studio mantém campos técnicos e de auditoria que não são expostos ao utilizador final.

## Emails

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] To [to_addrs_names]
- [ ] CC [cc_addrs_names]
- [ ] BCC [bcc_addrs_names]

**Só na página real:**
- [ ] Type [type]
- [ ] Status [status]
- [ ] Assigned To [assigned_user_id]
- [ ] Date Sent/Received [date_sent_received]

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- [ ] Date Created [date_entered]

### Create / Quickcreate

**Só no Studio:**
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]
- [ ] Raw Source [raw_source]
- [ ] Date Sent [date_sent]
- [ ] Reply To Status [reply_to_status]
- [ ] Message ID [message_id]
- [ ] UID [uid]
- [ ] Intent [intent]
- [ ] Mailbox ID [mailbox_id]
- [ ] Orphaned [orphaned]
- [ ] Related To [parent_name]

**Só na página real:**
- [ ] Related Record ID [parent_id]
- [ ] Flagged [flagged]

**Nota técnica:**
O `Create / Quickcreate` de `Emails` na página real privilegia campos operacionais do envio e relacionamento do registo, enquanto o Studio expõe um conjunto mais técnico associado ao processamento interno das mensagens.

## Formações

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Ação [formation_action]
- [ ] Ano [year]
- [ ] Tipo de ação [name]
- [ ] Estado [status]
- [ ] Data Formação [formation_date]

**Só na página real:**
- [ ] Cliente [account_id]
- [ ] Local [place]
- [ ] Data Pagamento [payment_date]
- [ ] Data Envio Email Info ao Cliente [cliente_email_info_date_c]
- [ ] Valor pago (€) [paid_value_c]
- [ ] Data envio certificados [sent_certificates_date]
- [ ] Data Análise Estatística [data_analise_estatistica_c]
- [ ] Data Fecho ação [data_fecho_acao_c]
- [ ] Data Digitalização [data_da_digitalizacao_c]
- [ ] NUTS II [nutsii_c]
- [ ] Com Cheque Formação [formation_check_checkbox_c]
- [ ] Date Created [date_entered]
- [ ] Atribuído a [assigned_user_id]
- [ ] Vendedor [salesperson_c]

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- Sem diferenças

### Create / Quickcreate

**Só no Studio:**
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]
- [ ] Invoice [invoice_id]

**Só na página real:**
- Sem diferenças

**Nota técnica:**
No `Create / Quickcreate`, a página real cobre o layout funcional configurado, mas não expõe os campos técnicos de auditoria nem o campo relacional `Invoice` que continuam presentes no Studio.

## Formandos

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] contacto [contact_id]
- [ ] Atribuído a [assigned_user_id]
- [ ] Cliente [account_id]
- [ ] N° acção [action_number_c]
- [ ] Nome da ação [description]

**Só na página real:**
- [ ] N° de candidatura IEFP [iefp_application_number]
- [ ] Data Emissão certificado Internos [internal_certificate_date]
- [ ] Código da Ação - SIGO [sigo_formation_code]
- [ ] Data envio certificado [certificate_submission_date]
- [ ] Data Emissão Certificado SIGO [certificate_issue_date]
- [ ] Data inicial certificados SIGO [sigo_training_date]
- [ ] Data final certificados SIGO [sigo_training_date_new_c]
- [ ] Data da Acção - Inicio [intern_date_start_c]
- [ ] Data da Acção - Fim [intern_date_end_c]
- [ ] Estado Candidatura [candidature_status_c]
- [ ] Tipos de Formação [training_types_c]

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- [ ] Date Created [date_entered]

**Nota técnica:**
A listagem real apresenta duas colunas `Date Created`, o que sugere duplicação semântica na configuração visível da página.

### Create / Quickcreate

**Só no Studio:**
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]

**Só na página real:**
- Sem diferenças

**Nota técnica:**
No `Create / Quickcreate`, a página real replica o layout funcional do Studio, mas não expõe os campos técnicos de auditoria.

## Formadores

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Nome [trainer_name]
- [ ] Valor/Hora [hour_value]
- [ ] Número da Factura [receipt_number]
- [ ] Data de pagamento [payment_date]

**Só na página real:**
- [ ] Data da factura [receipt_date]
- [ ] Dossier entregue pelo formador/a [trainer_info_date_c]
- [ ] Data Entrega Recibo [receipt_delivery_date_c]

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- Sem diferenças

### Create / Quickcreate

**Só no Studio:**
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]

**Só na página real:**
- Sem diferenças

**Nota técnica:**
No `Create / Quickcreate`, a página real segue o layout funcional do Studio, mas não expõe os campos técnicos de auditoria.

## Sessões

### Filtro

**Só no Studio:**
- [ ] ID [id]
- [ ] Formação [training_id]
- [ ] Nome [name]
- [ ] Abreviatura [abbreviation]
- [ ] Sessões [session]
- [ ] Descrição [description]

**Só na página real:**
- Sem diferenças

### List View

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- [ ] Date Created [date_entered]

### Create / Quickcreate

**Só no Studio:**
- [ ] ID [id]
- [ ] Date Created [date_entered]
- [ ] Date Modified [date_modified]
- [ ] Session Identifier [session_identifier_c]

**Só na página real:**
- [ ] assigned_user_id [assigned_user_id]

**Nota técnica:**
O `Create / Quickcreate` de `Sessões` na página real expõe `assigned_user_id`, enquanto o Studio mantém o campo técnico `Session Identifier` e os campos de auditoria.

## Conclusões

- [ ] A revisão ficou concluída para todos os módulos previstos nesta fase
- [ ] O padrão mais frequente foi divergência entre o `Filtro` do Studio e os campos realmente visíveis na página
- [ ] Vários módulos apresentam também diferenças no `Create / Quickcreate`, sobretudo por exposição de campos técnicos no Studio que não aparecem na página real
- [ ] Foram detetados casos de divergência na `List View`, incluindo colunas adicionais na página real e, nalguns módulos, duplicação semântica de `Date Created`
- [ ] `Medicinas Ocupacionais` e `Assistências` mantêm-se como módulos com divergências mais consistentes entre configuração do Studio e comportamento visível
- [ ] `Acessos IEFP` foi o único módulo revisto sem diferenças no `Create / Quickcreate`

## Limitações

- [ ] A comparação foi limitada a `Filtro`, `List View` e `Create / Quickcreate`
- [ ] Não foi possível validar a página real de `Detail View` de `Fichas de Aptidão` devido ao erro `Error: Invalid or expired token`
- [ ] A sessão de `admin` perde validade ao navegar na plataforma, sendo necessário fazer `logout` e `login` novamente para voltar a abrir páginas de detalhe
- [ ] As diferenças foram registadas com base no que estava visível nos prints e no Studio, sem validação adicional de lógica interna ou metadados fora desses ecrãs

## Continuação

**Módulos já revistos:**
- [ ] Clientes
- [ ] Propostas
- [ ] Faturas
- [ ] Contratos
- [ ] Telefonemas
- [ ] Contactos
- [ ] Reuniões
- [ ] Documentos
- [ ] Notas
- [ ] Emails
- [ ] Formações
- [ ] Formandos
- [ ] Formadores
- [ ] Sessões
- [ ] Fichas de Aptidão
- [ ] Assistências
- [ ] Acessos IEFP
- [ ] Medicinas Ocupacionais

**Módulos por rever:**
- [ ] Nenhum

**Estado:**
- [ ] Revisão desta fase concluída
