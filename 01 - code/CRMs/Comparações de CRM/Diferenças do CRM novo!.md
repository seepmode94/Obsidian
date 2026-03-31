# Diferenças

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

### Create / Quickcreate

**Só no Studio:**
- Sem diferenças

**Só na página real:**
- Sem diferenças
