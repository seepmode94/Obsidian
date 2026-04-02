# Comparações entre os campos e módulos de toda a informação da pasta LuxuryCRM(pasta do projeto) e a pasta Comparações de CRM

## Objetivo

Cruzar a informação de:

- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/`
- `01 - code/CRMs/Comparações de CRM/`

para perceber, por módulo, se:

- a informação está em concordância
- está parcialmente em concordância
- ou ainda não está confirmada

## Tabela de Comparação

| Módulo | Comparações de CRM | LuxuryCRM(pasta do projeto) | Estado | Observações |
|---|---|---|---|---|
| Clientes | Estrutura muito próxima entre bases; alerta para diferença entre Studio e página real | `module_views.md` e `module_field_nature.md` refletem o conjunto principal de campos | Parcial | Estrutura geral coerente, mas ainda falta validar a fidelidade da página real face ao Studio |
| Propostas | Considerado sem diferenças relevantes entre bases, com alguns pontos de layout/filtro | `migration-matrix.md` e documentação técnica cobrem bem o módulo | Parcial | Estrutura técnica coerente; ainda falta confirmar alguns ids de filtro vs metadata real |
| Faturas | Considerado sem diferenças relevantes entre bases | `migration-matrix.md` cobre migração e relações principais | Parcial | Sem conflito forte identificado, mas ainda não foi feito fecho fino por checklist vs SQL |
| Contratos | Diferença técnica clara em `anuidade_c` vs `anuidade_list_c` | `seepmode-vs-tacovia-fields.md` e `migration-matrix.md` confirmam a divergência e o destino técnico | Confirmado | Caso de fusão claro e já sustentado por SQL |
| Contactos | Diferenças isoladas pequenas | `LuxuryCRM` mantém o módulo como estruturalmente equivalente | Parcial | Sem conflito crítico, mas ainda não foi fechado campo a campo |
| Telefonemas | Sem diferenças relevantes | Módulo tratado como equivalente | Não confirmado | Sem sinais de conflito, mas ainda não auditado em detalhe |
| Reuniões | Diferenças isoladas pequenas | Módulo tratado como equivalente | Não confirmado | Sem sinais de conflito forte, mas ainda não auditado em detalhe |
| Notas | Sem diferenças relevantes | Módulo tratado como equivalente | Não confirmado | Ainda não auditado em detalhe |
| Emails | Sem diferenças relevantes | Módulo tratado como equivalente | Não confirmado | Ainda não auditado em detalhe |
| Formandos | Diferenças pontuais e alguns campos isolados | `LuxuryCRM` trata o módulo como estruturalmente migrável | Parcial | Ainda não foi fechado ao nível de campos e vistas |
| Formadores | Diferenças pontuais | `migration-matrix.md` cobre a migração para `trainers` | Parcial | Estrutura técnica existe, mas ainda falta reconciliação fina com as check-lists |
| Assistências | Estruturalmente equivalente; diferenças pequenas nas listas e campos adicionais | `LuxuryCRM` confirma estrutura comum e destaca divergência forte em `code_list` | Parcial | Estrutura alinhada, mas dropdowns ainda não estão fechados |
| Acessos IEFP | Diferença documental em `icfp_email_c` vs `iefp_email_c` | `LuxuryCRM` assume normalização; dumps SQL consultados mostraram `iefp_email_c` | Parcial | Existe conflito entre documentação antiga e SQL |
| Sessões | Diferença crítica: formação vs relatórios agendados | `LuxuryCRM` está alinhado com o modelo de formação | Parcial | O lado relatórios agendados ainda não aparece com destino técnico explícito |
| Medicina Ocupacional | Diferenças relevantes de campos, painéis e rastreios | `LuxuryCRM` documenta o módulo com estrutura rica e superset funcional | Parcial | A direção técnica faz sentido, mas falta fecho fino com a review |
| Fichas de Aptidão | Modelo rico da Seepmode deve ser a base | `LuxuryCRM` confirma o modelo rico em `capabilities` | Confirmado | Um dos módulos mais coerentes entre review e destino técnico |
| Documentos | Precisa de union/superset de relações e revisões | `LuxuryCRM` já cobre parte das relações e revisões | Parcial | Ainda falta provar documentalmente que o superset está completo |
| Formações | Diferenças menores de layout e alguns campos | `LuxuryCRM` cobre schema e relações principais | Parcial | Estrutura técnica existe; falta reconciliação fina do layout |

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

## Pontos Críticos em Aberto

- `Assistências`
  - fechar dropdowns, sobretudo `code_list`
- `Acessos IEFP`
  - fechar a discrepância `icfp_email_c` vs `iefp_email_c`
- `Sessões`
  - perceber se o lado Seepmode de relatórios agendados tem destino técnico explícito
- `Documentos`
  - confirmar se o superset pedido pela review está totalmente refletido
- `Studio vs página real`
  - continuar a usar a página real como referência funcional quando houver conflito

## Fontes Base

- [[01 - code/CRMs/Comparações de CRM/review]]
- [[01 - code/CRMs/Comparações de CRM/Parecer tecnico]]
- [[01 - code/CRMs/Comparações de CRM/Comparação dos antigos CRMs]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/seepmode-vs-tacovia-fields]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-matrix]]
- [[01 - code/CRMs/LuxuryCRM(pasta do projeto)/Essenciais/migration-operation-plan]]
- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/Dados/`
