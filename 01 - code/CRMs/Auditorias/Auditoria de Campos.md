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
- [ ] Testar alterações no Studio

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

### Assistências

- `code_c` -> `code_list`
- `status` -> `case_status_dom`
- `priority` -> `priority_list`
- `area_c` -> `area_list`
- `mode_c` -> `cases_mode_list`
- `send_receive_c` -> `send_receive_list`

## Testes no Studio

### Assistências

- Confirmar valores ativos de `code_c`
- Alterar temporariamente um valor em `code_list`
- Verificar impacto em:
  - criação
  - edição
  - filtro
  - workflows

- Confirmar também os valores ativos de:
  - `status`
  - `priority`
  - `area_c`
  - `mode_c`
  - `send_receive_c`

### Módulos com extrações do Studio a rever

- `Clientes`
- `Medicina Ocupacional`
- `Fichas de Aptidão`
- `Propostas`

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
