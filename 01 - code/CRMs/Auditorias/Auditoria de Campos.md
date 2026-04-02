# Auditoria de Campos

## Estado Atual

- `Matriz de Auditoria`: criada
- `Identificação de Gaps`: em curso
- `Campos a fundir`: primeiros casos identificados
- `Dropdowns divergentes por base`: em curso, com foco em `Assistências`
- `Testes no Studio`: pendentes

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
- Existe pelo menos uma discrepância entre documentação comparativa e dumps SQL:
  - a documentação antiga refere `icfp_email_c` na Seepmode
  - os dumps SQL lidos nesta fase mostram `iefp_email_c` em ambos os lados
  - este ponto deve ser tratado como conflito documental até validação final no sistema ativo

### Gaps de dropdown

- `Assistências.code_c` usa `code_list` com divergência forte:
  - `Seepmode`: 1 valor
  - `Tacovia`: 135 valores
- A evidência funcional dos workflows mostra que `code_list` não é residual:
  - há códigos ativos pelo menos em `1, 2, 3, 5, 6, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 23, 24, 25, 26, 28, 29, 33, 34, 35, 36, 38, 39, 40-57, 201, 250`
- Isto reforça que a harmonização de `Assistências.code_c` não pode ser tratada como detalhe cosmético.
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

### Assistências: leitura funcional já confirmada

- `code_c`
  - campo comum nas duas bases
  - dropdown comum por nome: `code_list`
  - divergência confirmada por documentação no conteúdo da lista
  - criticidade alta porque os workflows dependem diretamente de grupos de códigos
- `status`
  - campo comum nas duas bases
  - dropdown a validar: `case_status_dom`
  - valores observados funcionalmente nos workflows:
    - `Closed`
    - `Pendente`
    - `New`
    - `Expirado`
    - `Realized`
- `priority`
  - campo comum nas duas bases
  - dropdown a validar: `priority_list`
  - evidência funcional parcial:
    - workflow de duplicação usa `priority = 3`
- `area_c`
  - campo comum nas duas bases
  - dropdown a validar: `area_list`
- `mode_c`
  - campo comum nas duas bases
  - dropdown a validar: `cases_mode_list`
  - default observado em `fields_meta_data`: `Email`
- `send_receive_c`
  - campo comum nas duas bases
  - dropdown a validar: `send_receive_list`
  - default observado em `fields_meta_data`: `Send`

### Decisão provisória para Assistências

- `code_c` deve ser tratado como caso prioritário de harmonização
- o `LuxuryCRM` deve usar um superset de códigos capaz de absorver pelo menos os grupos já observados nos workflows
- antes de fechar a lista final, o Studio deve ser usado para confirmar:
  - valores ativos
  - ordem
  - labels
  - impacto real em criação, edição, filtro e workflows

## Testes a Executar no Studio

### Prioridade 1: Assistências

- Confirmar valores ativos de `code_c` no Studio.
- Alterar temporariamente ordem ou presença de um valor de teste em `code_list`.
- Verificar se a alteração reflete:
  - criação
  - edição
  - filtro
  - workflows
- Confirmar no Studio os valores ativos de:
  - `status`
  - `priority`
  - `area_c`
  - `mode_c`
  - `send_receive_c`
- Registar para cada campo:
  - lista visível no Studio
  - lista visível na página real
  - se a alteração no Studio propaga ou não para a UI real

### Prioridade 2: Módulos com divergência Studio vs página real

- `Clientes`
- `Medicina Ocupacional`
- `Fichas de Aptidão`
- `Propostas`

Objetivo:

- confirmar se `Default` no Studio governa mesmo a página real
- ou se a instância está a montar a UI por metadata ativa diferente do Studio

## Fontes Base

- [[01 - code/CRMs/Comparações de CRM/review]]
- [[01 - code/CRMs/Comparações de CRM/Parecer tecnico]]
- [[01 - code/CRMs/Comparações de CRM/Comparação dos antigos CRMs]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/seepmode-vs-tacovia-fields]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-matrix]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-operation-plan]]

## Cruzamento: Comparações de CRM vs LuxuryCRM

### Alinhamentos Confirmados

- `Fichas de Aptidão`
  - `Comparações de CRM` conclui que o modelo rico da Seepmode deve ser a base final.
  - `LuxuryCRM` confirma essa direção:
    - `seepmode-vs-tacovia-fields.md` identifica 54 campos Seepmode-only em `sdmod_capability`
    - `migration-matrix.md` já mapeia `sdmod_capability` para `capabilities`
- `Contratos`
  - `Comparações de CRM` identifica divergência técnica `anuidade_c` vs `anuidade_list_c`
  - `LuxuryCRM` confirma essa divergência e já assume `anuidade_c` como convenção final
- `Assistências`
  - `Comparações de CRM` trata o módulo como funcionalmente equivalente entre bases
  - `LuxuryCRM` confirma equivalência estrutural de campos, mas acrescenta uma divergência crítica de conteúdo em `code_list`
- `Acessos IEFP`
  - `Comparações de CRM` sinaliza diferença técnica no email IEFP
  - `LuxuryCRM` já assume a necessidade de normalização de naming entre bases
- `Studio vs Página Real`
  - `Comparações de CRM` conclui que a página real tem prioridade funcional
  - `LuxuryCRM` ainda depende de documentos de metadata e mapeamentos, portanto esta regra deve continuar ativa na auditoria

### Divergências ou Tensões Entre os Dossiês

- `Sessões`
  - `Comparações de CRM` conclui que existe um split crítico:
    - `Tacovia` = sessões de formação
    - `Seepmode` = relatórios agendados
  - `LuxuryCRM` está claramente alinhado com o modelo de formação:
    - `module_field_nature.md`
    - `module_views.md`
    - `migration-matrix.md`
  - **Tensão:** no material lido não aparece ainda uma formalização equivalente de `ReportSchedules` como destino explícito para o lado Seepmode.
- `Documentos`
  - `Comparações de CRM` pede union/superset:
    - relação com `Fichas de Aptidão`
    - histórico de faturas
    - revisões e campos de revisão
  - `LuxuryCRM` já contempla parte disso:
    - `sdmod_capability_documents_1_c -> capabilities_documents`
    - `document_revisions -> document_revisions`
  - **Tensão:** a auditoria ainda não mostra evidência suficiente de que o superset de relações e metadados de revisão esteja fechado ponta a ponta.
- `Assistências`
  - `Comparações de CRM` chama o módulo de equivalente
  - `LuxuryCRM` acrescenta uma diferença operacional forte em `code_list`
  - **Leitura correta:** o módulo é equivalente na estrutura, mas não nos valores de dropdown.
- `Acessos IEFP`
  - `Comparações de CRM` fala em `icfp_email_c` vs `iefp_email_c`
  - o SQL consultado nesta fase mostra `iefp_email_c` em ambos os lados
  - **Tensão:** há conflito entre documentação comparativa e evidência dos dumps.
- `Formações`
  - `Comparações de CRM` regista diferenças menores de layout e alguns campos pontuais
  - `LuxuryCRM` concentra-se mais em schema/field diff e menos na reconciliação fina de layouts deste módulo
  - **Tensão:** ainda falta fechar se essas diferenças de vista precisam mesmo de schema ou apenas de layout/source-of-truth.

### Leitura Consolidada

- O dossiê `Comparações de CRM` é mais forte na leitura funcional por módulo e na distinção entre Studio e página real.
- O dossiê `LuxuryCRM` é mais forte na leitura estrutural, schema, relações, loaders e impacto técnico de migração.
- A auditoria deve combinar os dois assim:
  - `Comparações de CRM` define o problema funcional
  - `LuxuryCRM` define o destino técnico
  - `Dados/*.sql` validam se a diferença existe mesmo ao nível da base

## Validação com Dumps SQL

### Âmbito validado nesta fase

- `aos_contracts_cstm`
- `fields_meta_data`
- `contacts_audit`
- `sdmod_iefp_accesses_cstm`
- evidência documental cruzada com `seepmode-vs-tacovia-fields.md`

### 1. Contratos: `anuidade_c` vs `anuidade_list_c`

**Confirmado nos dumps SQL**

- `Seepmode`:
  - em `aos_contracts_cstm`, existe a coluna `anuidade_c`
  - em `fields_meta_data`, o campo aparece como:
    - `AOS_Contractsanuidade_c`
    - tipo `enum`
    - dropdown `anuidade_list`
- `Tacovia`:
  - em `aos_contracts_cstm`, existe a coluna `anuidade_list_c`
  - em `fields_meta_data`, o campo aparece como:
    - `AOS_Contractsanuidade_list_c`
    - tipo `enum`
    - dropdown `anuidade_list`

**Conclusão**

- Os dois lados usam o mesmo conceito funcional e o mesmo dropdown lógico.
- A diferença é apenas o nome técnico da coluna.
- A decisão correta mantém-se:
  - `anuidade_list_c` -> `anuidade_c`

### 2. Acessos IEFP: `icfp_email_c` vs `iefp_email_c`

**Resultado da validação SQL**

- Nos dumps lidos nesta fase, aparece `iefp_email_c` dos dois lados:
  - em `fields_meta_data`
  - em `sdmod_iefp_accesses_cstm`
  - e também em `contacts_audit` do dump Tacovia

**Discrepância detetada**

- A documentação comparativa anterior refere:
  - `Seepmode` = `icfp_email_c`
  - `Tacovia` = `iefp_email_c`
- O SQL agora consultado não confirma essa diferença com a mesma clareza.

**Conclusão provisória**

- Manter a normalização final em `iefp_email_c`
- Assinalar o caso como `discrepância documental`
- Antes de fechar a auditoria definitiva, validar:
  - se o typo existiu apenas em metadata antiga
  - ou se surgiu em outro dump / outra extração histórica

### 3. Assistências: dropdowns partilhados

**Confirmado nos dumps SQL**

Em ambos os dumps, `fields_meta_data` confirma os mesmos campos e os mesmos nomes lógicos de dropdown:

- `Casescode_c` -> `code_list`
- `Casesarea_c` -> `area_list`
- `Casesmode_c` -> `cases_mode_list`
- `Casessend_receive_c` -> `send_receive_list`

**Limite da evidência SQL**

- Os dumps SQL desta fase não incluem:
  - tabela `dropdownlists`
  - definição `app_list_strings`
  - conteúdo completo das listas
- Ou seja:
  - o SQL confirma que o campo aponta para uma lista com esse nome
  - mas não confirma os valores concretos dessa lista

**Conclusão**

- A estrutura do campo é comum nas duas bases.
- O ponto de divergência não está no nome do campo nem no nome da lista.
- O ponto de divergência está no conteúdo dos dropdowns.

**Evidência documental complementar**

- `seepmode-vs-tacovia-fields.md` confirma:
  - `code_list`
    - `Seepmode`: 1 valor
    - `Tacovia`: 135 valores

**Decisão**

- `Assistências.code_c` continua a ser o principal caso de harmonização de dropdown
- O alvo deve usar pelo menos o superset de `Tacovia` para `code_list`
- Os workflows mostram que a lista funcional ativa inclui códigos distribuídos por vários domínios de negócio, incluindo CRM, suporte técnico, jurídico e segurança
- Falta ainda validar conteúdo de:
  - `area_list`
  - `case_status_dom`
  - `priority_list`
  - `cases_mode_list`
  - `send_receive_list`

**Evidência funcional adicional**

- `suitecrm_workflows.md` demonstra uso operacional de `code_c` em grupos concretos:
  - suporte técnico: `1-29` com subset funcional explícito
  - CRM recorrente: `13`
  - jurídico: `40-57`
  - segurança/SST: `201`, `250`
- Isto mostra que a harmonização de `code_list` deve preservar comportamento de workflows, não apenas labels de interface.

### 4. Fichas de Aptidão: modelo rico e relações

**Confirmado nos dumps SQL**

- O dump `Seepmode` mostra explicitamente campos ricos em `sdmod_capability`, por exemplo:
  - `ability_result_c`
  - `exam_date_c`
  - `recommendations_c`
- A evidência documental do projeto já dizia que este modelo rico existe na Seepmode e foi absorvido pelo `LuxuryCRM`.

**Relações**

- Os dumps mostram presença de tabelas de relação ligadas a `sdmod_capability`, incluindo:
  - `accounts_sdmod_capability_1_c`
- A documentação do projeto mantém ainda como relevantes:
  - `contacts_sdmod_capability_1_c`
  - `project_sdmod_capability_1_c`
  - `sdmod_capability_documents_1_c`

**Conclusão**

- O modelo rico de `Fichas de Aptidão` continua validado como base final do schema.
- O único ponto ainda em aberto é estrutural:
  - relação `project_sdmod_capability_1_c`
  - decidir `project_id` direto ou join dedicada

## Estado da Evidência

### Confirmado por SQL

- diferença técnica entre `anuidade_c` e `anuidade_list_c`
- existência comum dos campos de `Assistências`
- existência de `code_list`, `area_list`, `cases_mode_list`, `send_receive_list` como dropdowns associados aos campos de `Cases`
- existência do modelo rico `sdmod_capability` na Seepmode
- existência de `iefp_email_c` no SQL consultado
- limite dos dumps: confirmam referência à lista, não o conteúdo dos dropdowns

### Confirmado só por documentação nesta fase

- divergência quantitativa real do conteúdo de `code_list`
- necessidade de usar o superset Tacovia em `Assistências.code_c`
- discrepância antiga `icfp_email_c` vs `iefp_email_c`

### Em aberto

- validar o conteúdo completo das listas fora dos dumps SQL, através de metadata/language files ou da instância ativa:
  - `area_list`
  - `case_status_dom`
  - `priority_list`
  - `cases_mode_list`
  - `send_receive_list`
- fechar a decisão estrutural de `project_sdmod_capability_1_c`

## Levantamentos Desta Tarefa

- A matriz de auditoria já existe e já consegue suportar:
  - mapeamentos diretos
  - campos a fundir
  - gaps de schema
  - gaps de dropdown
- O cruzamento entre `Comparações de CRM` e `LuxuryCRM` confirma que:
  - `Fichas de Aptidão` está bem encaminhado no alvo técnico
  - `Contratos` tem um caso de fusão claro e já sustentado por SQL
  - `Assistências` precisa de ser tratado como caso prioritário de harmonização de dropdown
- `Assistências` não deve ser lido apenas como “sem diferenças relevantes”:
  - a estrutura é equivalente
  - o conteúdo do dropdown `code_list` não é equivalente
  - os workflows mostram uso operacional forte de grupos de códigos
- `Sessões` continua a ser um ponto de decisão incompletamente refletido no destino técnico:
  - o lado formação está representado
  - o lado relatórios agendados ainda não apareceu aqui como destino técnico explícito
- `Documentos` ainda precisa de levantamento mais fino para provar que o superset pedido na review está completo
- O caso `icfp_email_c` vs `iefp_email_c` não está fechado:
  - a documentação comparativa aponta diferença
  - os dumps consultados nesta fase apontam uniformização
- Os dumps SQL confirmam:
  - colunas e tabelas
  - referências a dropdowns em `fields_meta_data`
  - alguns nomes técnicos e relações
- Os dumps SQL não confirmam por si só:
  - conteúdo completo das listas de dropdown
  - fidelidade da página real face ao Studio
- A regra “usar a página real como referência funcional quando divergir do Studio” mantém-se válida e deve continuar a guiar a auditoria
