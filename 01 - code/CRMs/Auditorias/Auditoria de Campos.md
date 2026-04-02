# Auditoria de Fidelidade de Campos

## Objetivo

Mapear os campos SQL originais de `Seepmode` e `Tacovia` para o schema final do `LuxuryCRM`, identificando:

- mapeamentos diretos
- campos a fundir
- gaps de schema
- gaps de mapeamento
- diferenças de dropdown entre bases
- pontos a validar no Studio

## Critério de decisão

- A `página real` tem prioridade funcional sobre o `Studio` quando houver divergência.
- Quando dois campos representam o mesmo conceito de negócio, a decisão deve ser `fundir` ou `normalizar`.
- Quando um campo só existe numa das bases mas é funcionalmente relevante, a decisão deve ser `manter` no schema final.
- Quando a dúvida é de relação e não de coluna simples, registar como `gap estrutural`.

## Legenda

- `Origem`
  - `comum`
  - `só Seepmode`
  - `só Tacovia`
  - `comum com nome diferente`
- `Decisão`
  - `mapear direto`
  - `fundir`
  - `normalizar`
  - `manter`
  - `criar no schema`
  - `gap estrutural`
  - `deferir`

## Matriz

| Módulo | Campo SQL Seepmode | Campo SQL Tacovia | Campo final no LuxuryCRM | Tabela destino | Tipo | Origem | Decisão | Observações |
|---|---|---|---|---|---|---|---|---|
| Contratos | `anuidade_c` | `anuidade_list_c` | `anuidade_c` | `contracts` | `enum` | comum com nome diferente | fundir | Mesmo conceito de negócio. LuxuryCRM já usa convenção Seepmode. |
| Acessos IEFP | `icfp_email_c` | `iefp_email_c` | `iefp_email_c` | `iefp_accesses` | `varchar` | comum com nome diferente | normalizar | Typo legado na Seepmode. |
| Fichas de Aptidão | `sdmod_capability` + `sdmod_capability_cstm` | `sdmod_capability` | `capabilities` | `capabilities` | módulo | só Seepmode no modelo rico | manter | O modelo rico da Seepmode deve ser a base final. |
| Fichas de Aptidão | `accounts_sdmod_capability_1_c` | — | `account_id` | `capabilities` | relação | só Seepmode | manter | Mapeado em `migration-matrix.md` para `capabilities.account_id`. |
| Fichas de Aptidão | `contacts_sdmod_capability_1_c` | — | `contact_id` | `capabilities` | relação | só Seepmode | manter | Mapeado em `migration-matrix.md` para `capabilities.contact_id`. |
| Fichas de Aptidão | `project_sdmod_capability_1_c` | — | `project_id` ou join dedicada | `capabilities` / join | relação | só Seepmode | gap estrutural | Ainda falta decidir coluna direta vs tabela `projects_capabilities`. |
| Fichas de Aptidão | `sdmod_capability_documents_1_c` | — | `capabilities_documents` | join | relação | só Seepmode | manter | Relação relevante com Documentos. |
| Renovações | `aos_invoice_renawal_c` | — | `invoice_id` | `renewals` | relação | só Seepmode | manter | Relação extra Seepmode com Faturas. |
| Renovações | — | `sdmod_iefp_accesses_id_c` | `iefp_access_id` | `renewals` | relação | só Tacovia | manter | Divergência funcional da base Tacovia. |
| Formações | `contact_id1_c` | — | `contact_id` | `trainings` | relação | só Seepmode | normalizar | FK de relação criada por Studio. |
| Formações | — | `sdmod_iefp_accesses_id_c` | `iefp_access_id` | `trainings` | relação | só Tacovia | manter | LuxuryCRM já prevê ambos os destinos. |
| Assistências | `code_c` | `code_c` | `code_c` | `cases` | `enum` | comum | mapear direto | O campo é comum, mas a lista `code_list` diverge fortemente entre bases. |
| Assistências | `status` | `status` | `status` | `cases` | `enum` | comum | mapear direto | Validar se `case_status_dom` usa as mesmas chaves nas duas bases. |
| Assistências | `priority` | `priority` | `priority` | `cases` | `enum` | comum | mapear direto | Validar diferenças de `priority_list`. |
| Assistências | `area_c` | `area_c` | `area_c` | `cases` | `enum` | comum | mapear direto | Validar diferenças de `area_list`. |
| Assistências | `mode_c` | `mode_c` | `mode_c` | `cases` | `enum` | comum | mapear direto | Validar diferenças de `cases_mode_list`. |
| Assistências | `send_receive_c` | `send_receive_c` | `send_receive_c` | `cases` | `enum` | comum | mapear direto | Validar diferenças de `send_receive_list`. |

## Gaps Identificados

### Gaps de schema

- `project_sdmod_capability_1_c` ainda não tem decisão final fechada:
  - `capabilities.project_id`
  - ou tabela dedicada `projects_capabilities`

### Gaps de mapeamento

- Rever documentação operacional de filtros onde os ids usados não batem certo com a metadata técnica real.
- Confirmar se os nomes usados em `filter-fields-mapping.md` são nomes finais do alvo ou nomes reais de metadata do SuiteCRM.

### Gaps de dropdown

- `Assistências.code_c` usa `code_list` com divergência forte:
  - `Seepmode`: 1 valor
  - `Tacovia`: 135 valores
- Validar também em `Assistências`:
  - `case_status_dom`
  - `priority_list`
  - `area_list`
  - `cases_mode_list`
  - `send_receive_list`

### Gaps funcionais

- Confirmar em módulos críticos se o `Studio` altera mesmo:
  - `List View`
  - `Filter View`
  - dropdowns visíveis na página real

## Campos a Fundir

- `anuidade_c` + `anuidade_list_c` -> `anuidade_c`
- `icfp_email_c` + `iefp_email_c` -> `iefp_email_c`

## Dropdowns Partilhados a Validar por Base

### Assistências

- `code_c` -> `code_list`
- `status` -> `case_status_dom`
- `priority` -> `priority_list`
- `area_c` -> `area_list`
- `mode_c` -> `cases_mode_list`
- `send_receive_c` -> `send_receive_list`

## Testes a Executar no Studio

### Prioridade 1: Assistências

- Confirmar valores ativos de `code_c` no Studio.
- Alterar temporariamente ordem ou presença de um valor de teste em `code_list`.
- Verificar se a alteração reflete:
  - criação
  - edição
  - filtro
  - workflows

### Prioridade 2: Módulos com divergência Studio vs página real

- `Clientes`
- `Medicina Ocupacional`
- `Fichas de Aptidão`
- `Propostas`

Objetivo:

- confirmar se `Default` no Studio governa mesmo a página real
- ou se a instância está a montar a UI por metadata ativa diferente do Studio

## Fontes Base

- `01 - code/CRMs/Comparações de CRM/review.md`
- `01 - code/CRMs/Comparações de CRM/Parecer tecnico.md`
- `01 - code/CRMs/Comparações de CRM/Comparação dos antigos CRMs.md`
- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/seepmode-vs-tacovia-fields.md`
- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-matrix.md`
- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-operation-plan.md`
