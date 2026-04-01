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

## Conclusões

- [ ] Foram identificadas diferenças reais entre o Studio e as páginas visíveis nos módulos `Fichas de Aptidão`, `Assistências` e `Medicinas Ocupacionais`
- [ ] `Contratos` apresenta diferenças no `Filtro` e no `Create / Quickcreate`, e uma duplicação semântica na `List View`
- [ ] `Telefonemas` apresenta diferenças no `Filtro` e uma coluna adicional na `List View`
- [ ] Em `Medicinas Ocupacionais`, tanto o `Filtro` como a `List View` mostram um padrão consistente de divergência entre `Default` e comportamento real
- [ ] Em `Assistências`, o `Filtro`, a `List View` e o `Create / Quickcreate` também não coincidem totalmente com o Studio
- [ ] `Acessos IEFP` não apresentou diferenças no `Create / Quickcreate`

## Limitações

- [ ] A revisão global foi interrompida antes de cobrir todos os módulos
- [ ] Não foi possível validar a página real de `Detail View` de `Fichas de Aptidão` devido ao erro `Error: Invalid or expired token`
- [ ] Alguns módulos não foram comparados nesta fase

## Continuação

**Módulos já revistos:**
- [ ] Clientes
- [ ] Propostas
- [ ] Faturas
- [ ] Contratos
- [ ] Telefonemas
- [ ] Fichas de Aptidão
- [ ] Assistências
- [ ] Acessos IEFP
- [ ] Medicinas Ocupacionais

**Módulos por rever:**
- [ ] Contactos
- [ ] Reuniões
- [ ] Documentos
- [ ] Notas
- [ ] Emails
- [ ] Formações
- [ ] Formandos
- [ ] Formadores
- [ ] Sessões

**Plano para retomar:**
- [ ] Continuar por módulo
- [ ] Comparar apenas `Filtro`, `List View` e `Create / Quickcreate`
- [ ] Registar só diferenças reais entre Studio e página visível
