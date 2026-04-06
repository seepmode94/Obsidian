# Plano de Validação

## Objetivo

Obter informação suficiente para validar, por módulo, o que:

- é igual entre `Seepmode` e `Tacovia`
- se deve fundir
- diverge por dropdown
- exige ajuste no `LuxuryCRM`
- precisa de confirmação no `Studio`

## Âmbito desta fase

- O foco desta fase é a coerência entre informação retirada por pessoas diferentes a partir do `Studio`.
- A `página real` não é referência principal nesta fase.
- A `página real` só deve ser usada mais tarde, se for necessário resolver conflitos que o `Studio` não explique.

## Ordem de Trabalho

- [/] `Assistências` em validação
- [x] `Contratos`
- [ ] `Acessos IEFP`
- [ ] `Fichas de Aptidão`
- [ ] `Medicina Ocupacional`
- [ ] `Documentos`
- [ ] `Clientes`
- [ ] `Propostas`
- [ ] `Faturas`
- [ ] `Contactos`
- [ ] `Formações`
- [ ] `Formandos`
- [ ] `Formadores`
- [ ] `Reuniões`
- [ ] `Telefonemas`
- [ ] `Notas`
- [ ] `Emails`

## Checklist por Módulo

### Quando o módulo existe nas duas bases

Validar:

- [ ] Campos comuns entre as duas bases
- [ ] Campos exclusivos da `Seepmode`
- [ ] Campos exclusivos da `Tacovia`
- [ ] Campos com nome técnico diferente mas mesmo significado
- [ ] Campos que se devem fundir
- [ ] Campos com dropdown associado
- [ ] Dropdowns com conteúdo diferente por base
- [ ] Relações relevantes
- [ ] Gaps de schema no `LuxuryCRM`
- [ ] Gaps de mapeamento no `LuxuryCRM`
- [ ] Necessidade de teste no `Studio`

### Quando o módulo existe só numa base

Validar:

- [ ] Confirmar que o módulo é exclusivo de uma base
- [ ] Confirmar os campos do módulo nessa base
- [ ] Confirmar relações relevantes
- [ ] Confirmar dropdowns internos do módulo
- [ ] Confirmar destino técnico no `LuxuryCRM`
- [ ] Identificar gaps de schema ou mapeamento
- [ ] Decidir se precisa de teste no `Studio`

## Como Validar

### 1. Comparações de CRM

Usar para:

- perceber a diferença funcional que já foi estudada
- perceber se a divergência é de:
  - campo
  - layout
  - relação
  - dropdown

Validação prática:

- [ ] Ler os check-lists antigos
- [ ] Ler os check-lists novos
- [ ] Ler a `review`
- [ ] Ler o `Parecer tecnico`
- [ ] Registar na auditoria só o que afeta decisão técnica

### 2. LuxuryCRM: Essenciais e Analises

Usar para:

- perceber qual é o destino técnico previsto
- confirmar se o `LuxuryCRM` já absorveu a diferença
- identificar gaps de schema ou relação

Validação prática:

- [ ] Ver `seepmode-vs-tacovia-fields.md`
- [ ] Ver `migration-matrix.md`
- [ ] Ver `migration-operation-plan.md`
- [ ] Ver `module_field_nature.md`
- [ ] Ver `module_views.md`
- [ ] Ver `module_relations.md`

### 3. Dumps SQL

Usar para:

- confirmar se a coluna existe mesmo
- confirmar nome técnico real
- confirmar tabelas de relação
- confirmar o nome lógico do dropdown em `fields_meta_data`

Validação prática:

- [ ] Procurar a coluna na tabela base
- [ ] Procurar a coluna na tabela `_cstm`, quando aplicável
- [ ] Procurar o campo em `fields_meta_data`
- [ ] Procurar a tabela de relação, quando for uma relação
- [ ] Registar na auditoria se a evidência é:
  - estrutural
  - documental
  - funcional

Nota:

- os dumps SQL não são suficientes para confirmar o conteúdo completo dos dropdowns
- os dumps confirmam melhor:
  - nomes de campos
  - nomes de listas
  - relações

### 4. Metadata / Language Files

Usar para:

- obter os valores completos dos dropdowns
- comparar listas entre bases sem depender da UI

Validação prática:

- [ ] Procurar `app_list_strings`
- [ ] Procurar ficheiros de language relevantes
- [ ] Procurar overrides customizados
- [ ] Registar diferenças de valores e labels

### 5. Studio

Usar apenas quando necessário para:

- confirmar o que está configurado no `Studio`
- validar coerência entre duas extrações diferentes do `Studio`
- confirmar dropdowns ativos quando a documentação e o SQL não chegam
- separar `dropdowns` de negócio de operadores de filtro

Validação prática:

- [ ] Abrir o módulo
- [ ] Ver criação
- [ ] Ver edição
- [ ] Ver detalhe
- [ ] Ver filtro
- [ ] Ver list view
- [ ] Separar campos de lista de negócio de campos com operador de pesquisa
- [ ] Alterar temporariamente algo no `Studio`
- [ ] Confirmar a alteração dentro do próprio `Studio`

## Critério de Fecho de um Módulo

Só considerar um módulo fechado quando:

- [ ] Os campos comuns estão identificados
- [ ] Os campos exclusivos estão identificados
- [ ] Os campos a fundir estão decididos
- [ ] Os dropdowns críticos estão comparados
- [ ] Os gaps técnicos estão registados
- [ ] Está decidido se precisa de teste no `Studio`

## Foco Inicial

### Assistências

- [/] Confirmar `code_c`
- [x] Confirmar `status` ✅ 2026-04-02
- [x] Confirmar `priority` ✅ 2026-04-02
- [x] Confirmar `area_c` ✅ 2026-04-02
- [x] Confirmar `mode_c` ✅ 2026-04-02
- [x] Confirmar `send_receive_c` documentalmente; existe no `Studio`, mas não está visível no filtro real atual
- [x] Confirmar que os campos de data usam operadores de filtro comuns
- [/] Confirmar se `code_list` deve usar superset `Tacovia`
- [ ] Confirmar impacto nos workflows

### Contratos

- [x] Confirmar `anuidade_c` vs `anuidade_list_c`
- [/] Confirmar dropdown `anuidade_list`
- [x] Confirmar decisão final de fusão

### Acessos IEFP

- [x] Confirmar `icfp_email_c` vs `iefp_email_c` no `Studio` atual da `Tacovia`: o campo não existe nas vistas nem em `Fields`
- [/] Confirmar se a divergência existe mesmo no SQL ou só na documentação
- [x] Confirmar campo final normalizado

### Fichas de Aptidão

- [x] Assinalar como módulo exclusivo da `Seepmode` ✅ 2026-04-02
- [ ] Confirmar modelo rico da `Seepmode`
- [ ] Confirmar relações:
  - `accounts_sdmod_capability_1_c`
  - `contacts_sdmod_capability_1_c`
  - `project_sdmod_capability_1_c`
  - `sdmod_capability_documents_1_c`
- [ ] Confirmar gap estrutural de `project_sdmod_capability_1_c`

### Medicina Ocupacional

- [x] Assinalar como módulo exclusivo da `Seepmode`, se essa ausência na `Tacovia` se confirmar ✅ 2026-04-02
- [ ] Confirmar campos e relações do módulo
- [ ] Confirmar dropdowns internos relevantes
- [ ] Confirmar destino técnico no `LuxuryCRM`
- [ ] Identificar gaps de schema ou mapeamento

## Resultado Esperado

No fim desta validação, cada módulo deve ficar com:

- decisão de fusão ou não fusão
- decisão sobre dropdowns
- gaps registados
- necessidade ou não de alteração no `LuxuryCRM`
- necessidade ou não de teste adicional no `Studio`
