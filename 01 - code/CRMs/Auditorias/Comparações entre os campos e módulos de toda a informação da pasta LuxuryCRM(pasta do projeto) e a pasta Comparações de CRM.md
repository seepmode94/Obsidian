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
| Clientes | Estrutura rica e operacional; diferenças entre extrações parecem cada vez mais finas e localizadas | `module_views.md` e `module_field_nature.md` refletem o conjunto principal de campos | Parcial | Coerência geral reforçada; faltam só diferenças finas e reconciliação documental |
| Propostas | Estrutura operacional confirmada; diferenças parecem residuais e mais ligadas a filtro/layout fino | `migration-matrix.md` e documentação técnica cobrem bem o módulo | Parcial | Coerência geral reforçada; faltam só confirmações finas de filtro vs metadata |
| Faturas | Estrutura operacional confirmada; diferenças parecem residuais e mais documentais do que estruturais | `migration-matrix.md` cobre migração e relações principais | Parcial | Coerência geral reforçada; falta só fecho fino por checklist vs SQL |
| Contratos | Diferença clara em `anuidade_c` vs `anuidade_list_c` | `seepmode-vs-tacovia-fields.md` e `migration-matrix.md` confirmam a divergência e o destino técnico | Confirmado | Caso de fusão claro e já sustentado por SQL |
| Contactos | Estrutura rica confirmada; diferenças parecem pequenas, isoladas e mais documentais do que estruturais | `LuxuryCRM` mantém o módulo como estruturalmente equivalente | Parcial | Coerência geral reforçada; falta só fecho fino campo a campo |
| Telefonemas | Estrutura simples e operacional confirmada; sem sinal de diferenças relevantes estruturais | Módulo tratado como equivalente | Parcial | Coerência geral reforçada; falta só reconciliação fina |
| Reuniões | Estrutura simples e operacional confirmada; diferenças parecem pequenas e residuais | Módulo tratado como equivalente | Parcial | Coerência geral reforçada; falta só reconciliação fina |
| Notas | Estrutura simples e operacional confirmada; sem sinal de diferenças relevantes estruturais | Módulo tratado como equivalente | Parcial | Coerência geral reforçada; falta só reconciliação fina |
| Emails | Estrutura simples e operacional confirmada; sem sinal de diferenças relevantes estruturais | Módulo tratado como equivalente | Parcial | Coerência geral reforçada; falta só reconciliação fina |
| Formandos | Estrutura rica e operacional confirmada; diferenças parecem pontuais e mais documentais do que estruturais | `LuxuryCRM` trata o módulo como estruturalmente migrável | Parcial | Coerência geral reforçada; falta só reconciliação fina ao nível de campos e vistas |
| Formadores | Estrutura operacional simples confirmada; existe incoerência entre `Studio > Filter View` e filtro real | `migration-matrix.md` cobre a migração para `trainers` | Parcial | Coerência estrutural reforçada, mas o filtro ainda precisa de reconciliação fina |
| Assistências | Estrutura equivalente; `send_receive_c` aparece nas duas extrações novas do `Studio`, mas não está visível no filtro real atual; diferenças concentram-se nas listas | `LuxuryCRM` confirma estrutura comum, fixa `send_receive_list` e destaca divergência forte em `code_list` | Parcial | Estrutura coerente; divergência funcional em `send_receive_c` e decisão final pendente sobre `code_list` |
| Acessos IEFP | Diferença documental em `icfp_email_c` vs `iefp_email_c` | `LuxuryCRM` assume normalização; dumps SQL consultados mostraram `iefp_email_c` | Parcial | Há conflito entre documentação antiga e SQL |
| Sessões | Diferença crítica: formação vs relatórios agendados | `LuxuryCRM` está alinhado com o modelo de formação | Parcial | O lado relatórios agendados ainda não aparece com destino técnico explícito |
| Medicina Ocupacional | Diferenças relevantes de campos, painéis e rastreios | `LuxuryCRM` documenta o módulo com estrutura rica e superset funcional | Parcial | A direção técnica faz sentido, mas falta fecho fino |
| Fichas de Aptidão | Modelo rico da Seepmode deve ser a base | `LuxuryCRM` confirma o modelo rico em `capabilities` | Confirmado | Um dos módulos mais coerentes entre as duas extrações |
| Documentos | Precisa de union/superset de relações e revisões | `LuxuryCRM` já cobre parte das relações e revisões | Parcial | Falta provar documentalmente que o superset está completo |
| Formações | Estrutura rica e operacional confirmada; diferenças parecem menores e mais documentais do que estruturais | `LuxuryCRM` cobre schema e relações principais | Parcial | Coerência geral reforçada; falta só reconciliação fina do layout e dos campos |

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

- nenhum módulo nesta lista

## Como Ler o Estado

- `Confirmado`
  - as duas fontes contam a mesma história ao nível de campos e estrutura do `Studio`
- `Parcial`
  - existe alinhamento geral, mas ainda há pontos por fechar
- `Não confirmado`
  - ainda não houve validação suficiente para concluir coerência

## Pontos Críticos em Aberto

- `Assistências`
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
