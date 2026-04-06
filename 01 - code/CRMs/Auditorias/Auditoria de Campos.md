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

| Campo | Tipo | Estado atual | Levantamento |
|---|---|---|---|
| `code_c` | dropdown de negócio | parcial | confirmado no filtro; apresenta valores com `label` e outros só numéricos |
| `status` | dropdown de negócio | parcial | confirmado no filtro; lista uniforme de `0` a `6` |
| `priority` | dropdown de negócio | parcial | confirmado no filtro; lista `1`, `2`, `3` sem label textual |
| `mode_c` | dropdown de negócio | parcial | confirmado no filtro; `Email`, `Telefone`, `Presencial` |
| `area_c` | dropdown de negócio | parcial | confirmado no filtro; `Suporte`, `Jurídico`, `SGT`, `SUT`, `HACCP` |
| `send_receive_c` | dropdown de negócio | parcial | confirmado documentalmente em ambas as extrações do `Studio` e na metadata técnica; nesta ronda ficou por confirmar visualmente no filtro atual |
| `assistence_datetime_c` | operador de filtro | confirmado | operador comum de data |
| `resolution_date` | operador de filtro | confirmado | operador comum de data |
| `service_date_c` | operador de filtro | confirmado | operador comum de data |
| `date_due` | operador de filtro | confirmado | operador comum de data |
| `date_entered` | operador de filtro | confirmado | operador comum de data |
| `date_modified` | operador de filtro | confirmado | operador comum de data |

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
- `priority_list` não mostra labels descritivas e deve continuar assinalado como ponto de atenção, mas a metadata confirma que a lista esperada é mesmo `1`, `2`, `3`
- a recomendação técnica atual continua a ser tratar `code_list` como superset da `Tacovia`

## Testes no Studio

### Assistências

- [/] Confirmar valores ativos de `code_c`
- [/] Confirmar valores ativos de `status`
- [/] Confirmar valores ativos de `priority`
- [/] Confirmar valores ativos de `mode_c`
- [/] Confirmar valores ativos de `area_c`
- Alterar temporariamente um valor em `code_list`
- Verificar impacto em:
  - criação
  - edição
  - filtro
  - workflows

- [/] Confirmar também os valores ativos de:
  - `send_receive_c`

### Módulos com extrações do Studio a rever

- `Clientes`
- `Medicina Ocupacional`
- `Fichas de Aptidão`
- `Propostas`

## Evidência a Anexar

### Assistências

- [x] Screenshot do filtro com os campos visíveis
- [x] Screenshot dos operadores de data no filtro
- [x] Screenshot do `Studio > Layouts > Filter View`
- [x] Notas sobre coerência entre extrações do `Studio`

Anexos / observações:

- os campos de data usam operadores de filtro comuns
- `code_c` mostra valores com label e valores só numéricos
- `status` apresenta valores uniformizados de `0` a `6`
- `priority` apresenta valores `1`, `2`, `3` sem label textual

## Critérios para Registo por Imagem

Registar imagem sempre que apareça uma destas situações:

- valores mistos no mesmo `dropdown`
  - exemplo: alguns com `código + label` e outros só com número
- valores sem label quando seria expectável haver descrição
- diferenças entre o que aparece no filtro e o que aparece no `Studio`
- campos presentes numa extração e ausentes noutra
- nomes diferentes para o que parece ser o mesmo campo
- ordem estranha ou quebra de sequência na lista
- labels truncadas, vazias ou tecnicamente incorretas
- um `dropdown` que parece incompleto face ao que está documentado
- qualquer caso em que não seja óbvio se a diferença vem de:
  - configuração
  - recolha
  - base de dados

Aplicação já identificada em `Assistências`:

- `code_c`
  - deve ter sempre registo por imagem, porque mostra valores mistos
- `priority`
  - convém ter registo por imagem, porque a lista aparece só com números
- `mode_c`
  - imagem útil como evidência de lista uniforme e legível
- `area_c`
  - imagem útil como evidência de lista uniforme e legível

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
