# Comparações entre os campos e módulos de toda a informação da pasta LuxuryCRM(pasta do projeto) e a pasta Comparações de CRM

## Objetivo

Cruzar a informação de:

- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/`
- `01 - code/CRMs/Comparações de CRM/`

para confirmar, por módulo, se as extrações feitas a partir do `Studio` estão coerentes entre si.

## O que está a ser comparado

- informação retirada do `Studio` por pessoas diferentes
- check-lists e notas produzidas a partir dessas extrações
- documentação técnica do `LuxuryCRM` usada como referência de apoio

## O que não está a ser comparado nesta fase

- comportamento da `página real`
- diferenças visuais fora do `Studio`
- validação funcional em produção

## Tabela de Comparação

| Módulo | Studio / Comparações de CRM | Studio / LuxuryCRM | Estado | Levantamento |
|---|---|---|---|---|
| Clientes | Estrutura próxima entre bases; existem diferenças entre extrações | `module_views.md` e `module_field_nature.md` refletem o conjunto principal de campos | Parcial | Falta fechar coerência entre extrações do `Studio` |
| Propostas | Sem diferenças relevantes, com alguns pontos de filtro | `migration-matrix.md` e documentação técnica cobrem bem o módulo | Parcial | Falta confirmar ids de filtro vs metadata do `Studio` |
| Faturas | Sem diferenças relevantes entre bases | `migration-matrix.md` cobre migração e relações principais | Parcial | Falta fecho fino por checklist vs SQL |
| Contratos | Diferença clara em `anuidade_c` vs `anuidade_list_c` | `seepmode-vs-tacovia-fields.md` e `migration-matrix.md` confirmam a divergência e o destino técnico | Confirmado | Caso de fusão claro e já sustentado por SQL |
| Contactos | Diferenças pequenas e isoladas | `LuxuryCRM` mantém o módulo como estruturalmente equivalente | Parcial | Falta fecho campo a campo |
| Telefonemas | Sem diferenças relevantes | Módulo tratado como equivalente | Não confirmado | Ainda não auditado em detalhe |
| Reuniões | Diferenças isoladas pequenas | Módulo tratado como equivalente | Não confirmado | Ainda não auditado em detalhe |
| Notas | Sem diferenças relevantes | Módulo tratado como equivalente | Não confirmado | Ainda não auditado em detalhe |
| Emails | Sem diferenças relevantes | Módulo tratado como equivalente | Não confirmado | Ainda não auditado em detalhe |
| Formandos | Diferenças pontuais e alguns campos isolados | `LuxuryCRM` trata o módulo como estruturalmente migrável | Parcial | Falta reconciliação ao nível de campos e vistas |
| Formadores | Diferenças pontuais | `migration-matrix.md` cobre a migração para `trainers` | Parcial | Estrutura técnica existe, mas falta reconciliação fina |
| Assistências | Estrutura equivalente; `send_receive_c` aparece nas duas extrações novas do `Studio`; diferenças concentram-se nas listas | `LuxuryCRM` confirma estrutura comum, fixa `send_receive_list` e destaca divergência forte em `code_list` | Parcial | Estrutura coerente; falta fecho visual no filtro e decisão final sobre `code_list` |
| Acessos IEFP | Diferença documental em `icfp_email_c` vs `iefp_email_c` | `LuxuryCRM` assume normalização; dumps SQL consultados mostraram `iefp_email_c` | Parcial | Há conflito entre documentação antiga e SQL |
| Sessões | Diferença crítica: formação vs relatórios agendados | `LuxuryCRM` está alinhado com o modelo de formação | Parcial | O lado relatórios agendados ainda não aparece com destino técnico explícito |
| Medicina Ocupacional | Diferenças relevantes de campos, painéis e rastreios | `LuxuryCRM` documenta o módulo com estrutura rica e superset funcional | Parcial | A direção técnica faz sentido, mas falta fecho fino |
| Fichas de Aptidão | Modelo rico da Seepmode deve ser a base | `LuxuryCRM` confirma o modelo rico em `capabilities` | Confirmado | Um dos módulos mais coerentes entre as duas extrações |
| Documentos | Precisa de union/superset de relações e revisões | `LuxuryCRM` já cobre parte das relações e revisões | Parcial | Falta provar documentalmente que o superset está completo |
| Formações | Diferenças menores de layout e alguns campos | `LuxuryCRM` cobre schema e relações principais | Parcial | Falta reconciliação fina do layout e dos campos |

## Leitura Rápida

### Confirmado

- `Contratos`
- `Fichas de Aptidão`

### Parcial

- `Clientes`
- `Propostas`
- `Faturas`
- `Contactos`
- `Formandos`
- `Formadores`
- `Assistências`
- `Acessos IEFP`
- `Sessões`
- `Medicina Ocupacional`
- `Documentos`
- `Formações`

### Não confirmado

- `Telefonemas`
- `Reuniões`
- `Notas`
- `Emails`

## Como Ler o Estado

- `Confirmado`
  - as duas fontes contam a mesma história ao nível de campos e estrutura do `Studio`
- `Parcial`
  - existe alinhamento geral, mas ainda há pontos por fechar
- `Não confirmado`
  - ainda não houve validação suficiente para concluir coerência

## Pontos Críticos em Aberto

- `Assistências`
  - fechar visualmente `send_receive_c` no filtro atual
  - fechar dropdowns, sobretudo `code_list`
- `Acessos IEFP`
  - fechar a discrepância `icfp_email_c` vs `iefp_email_c`
- `Sessões`
  - perceber se o lado Seepmode de relatórios agendados tem destino técnico explícito
- `Documentos`
  - confirmar se o superset pedido pela review está totalmente refletido
- coerência entre extrações do `Studio`
  - continuar a tratar o `Studio` como referência principal nesta fase

## Fontes Base

- [[01 - code/CRMs/Comparações de CRM/review]]
- [[01 - code/CRMs/Comparações de CRM/Parecer tecnico]]
- [[01 - code/CRMs/Comparações de CRM/Comparação dos antigos CRMs]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/seepmode-vs-tacovia-fields]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-matrix]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-operation-plan]]
- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/Dados/`
