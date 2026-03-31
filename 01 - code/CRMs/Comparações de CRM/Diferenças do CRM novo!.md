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

### Create / Quickcreate

**Só no Studio:**
- [ ] Gestor [assigned_user_id]

**Só na página real:**
- Sem diferenças

## Assistências

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
