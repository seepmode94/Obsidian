# Dropdown Platform Mapping

## Objetivo

Mapear as diferenças reais entre `seepmode` e `tacovia` ao nível de dropdowns:

- dropdowns partilhados sem diferença relevante
- dropdowns partilhados mas com valores/labels diferentes
- dropdowns usados em campos equivalentes mas com naming divergente
- dropdowns com impacto funcional no LuxuryCRM

## Leitura rápida

| Categoria | Significado |
|---|---|
| Partilhado igual | existe nas duas plataformas e pode ser tratado como comum |
| Partilhado diferente | existe nas duas plataformas, mas opções/labels/count divergem |
| Campo divergente | o conceito é o mesmo, mas o campo que usa o dropdown muda entre plataformas |

## 1. Dropdowns Partilhados Sem Diferença Relevante

Estes dropdowns existem nas duas plataformas e, com base na documentação disponível, não foram identificadas diferenças relevantes para lógica de tenant:

| Dropdown |
|---|
| `account_type_dom` |
| `approval_status_dom` |
| `area_list` |
| `attendances_list` |
| `call_direction_dom` |
| `call_status_dom` |
| `campaign_status_dom` |
| `candidature_status_list` |
| `case_status_dom` |
| `cases_mode_list` |
| `client_service_type_list` |
| `contracts_status_list` |
| `countries_list` |
| `gender_list` |
| `industry_dom` |
| `invoice_status_dom` |
| `lead_source_dom` |
| `literary_abilities_list` |
| `marital_status_list` |
| `medical_appreciation_list` |
| `pack_list` |
| `priority_list` |
| `quote_invoice_status_dom` |
| `quote_term_dom` |
| `recommendations_list` |
| `send_receive_list` |
| `service_organization_list` |
| `sexo_c_list` |
| `training_types_list` |
| `type_invoice` |

Regra:

- podem ser tratados como dropdowns comuns, sem filtro por `PLATFORM`, até prova em contrário

## 2. Dropdowns Partilhados Mas Diferentes Entre Plataformas

Estes são os dropdowns que interessam mais para comportamento multi-plataforma.

| Dropdown | Seepmode | Tacovia | Tipo de diferença | Impacto |
|---|---|---|---|---|
| `empresa_list` | `seepmode`, `seepmed` | `tacovia` | opções exclusivas por tenant | alto |
| `quote_stage_dom` | 5 estados | 9 estados | mais estados em Tacovia | alto |
| `code_list` | 1 valor | 135+ valores | catálogo funcional completamente diferente | alto |
| `vat_list` | 6 taxas | 10 taxas | regimes fiscais diferentes | alto |
| `product_code_dom` | 355 códigos | 317 códigos | catálogo diferente | alto |
| `products_list` | 214 produtos | 136 produtos | catálogo diferente | alto |
| `salesman_region_list` | 30 regiões | 15 regiões | estrutura comercial diferente | alto |
| `anuidade_list` | `1/2 anos` | `1/2 Anos` | label/capitalização | baixo |
| `billing_state_list` | base comum | + `Belgium_` | 1 valor extra em Tacovia | baixo |
| `nutsii_list` | base comum | + `Belgium_` | 1 valor extra em Tacovia | baixo |
| `department_c_list` | inclui `marketing` | sem `marketing` | 1 valor extra em Seepmode | médio |
| `exam_type_list` | `A pedido` | `a pedido` | capitalização/label | baixo |
| `type_list` | inclui `admin`, `distributer` | sem esses valores | opções diferentes | médio |
| `yes_no_list` | diferença documentada no valor `Sim` | diferença documentada no valor `Sim` | value/label divergence | médio |
| `moduleList` | labels PT próprios | labels PT próprios | naming/labels de módulos | baixo |

## 3. Detalhe dos Casos Mais Importantes

### 3.1 `empresa_list`

| Valor | Seepmode | Tacovia |
|---|---|---|
| `seepmode` | sim | não |
| `seepmed` | sim | não |
| `tacovia` | não | sim |

Campos principais:

| Módulo | Campo |
|---|---|
| `Quotes` | `company` |
| `Invoices` | `company` |
| `Contracts` | `empresa_c` |

Regra:

- este dropdown deve ser filtrado por `PLATFORM`

### 3.2 `quote_stage_dom`

| Estado | Seepmode | Tacovia |
|---|---|---|
| `On Hold` | sim | sim |
| `Negotiation` | sim | sim |
| `Closed Accepted` | sim | sim |
| `Closed Lost` | sim | sim |
| `credit_note` | sim | sim |
| `Draft` | não | sim |
| `Delivered` | não | sim |
| `Confirmed` | não | sim |
| `Closed Dead` | não | sim |
| `Closed Withdrawn` | sim | não |

Campo principal:

| Módulo | Campo |
|---|---|
| `Quotes` | `quote_stage` |

Regra:

- usar superset no backend
- filtrar no frontend/API se o tenant não deve ver todos os estados

### 3.3 `code_list`

| Plataforma | Situação |
|---|---|
| `seepmode` | lista praticamente vazia na origem |
| `tacovia` | lista extensa com 135+ códigos |

Campo principal:

| Módulo | Campo |
|---|---|
| `Cases` | `code_c` |

Regra:

- tratar como dropdown fortemente dependente da plataforma
- não assumir equivalência funcional entre tenants

### 3.4 `vat_list`

| Grupo | Seepmode | Tacovia |
|---|---|---|
| taxas PT | `0`, `6`, `13`, `23` | sim |
| taxas extra | não | `5.0`, `7.5`, `17.5`, `20.0` |

Regra:

- filtrar por plataforma

### 3.5 `product_code_dom` e `products_list`

| Dropdown | Seepmode | Tacovia | Observação |
|---|---|---|---|
| `product_code_dom` | 355 | 317 | códigos diferentes |
| `products_list` | 214 | 136 | nomes/catálogos diferentes |

Regra:

- estes catálogos não devem ser tratados como dropdown global único sem segmentação

### 3.6 `salesman_region_list`

| Plataforma | Estrutura |
|---|---|
| `seepmode` | regiões PT + expansão ES |
| `tacovia` | estrutura comercial simplificada |

Regra:

- dropdown dependente da organização comercial de cada tenant

## 4. Campos Equivalentes Com Naming Divergente

Nem sempre a diferença está no dropdown; às vezes está no campo que o consome.

| Conceito | Seepmode | Tacovia | Observação |
|---|---|---|---|
| Anuidade do contrato | `anuidade_c` | `anuidade_list_c` | mesmo conceito, campo diferente |

Regra:

- mapear ambos para o mesmo campo canónico no LuxuryCRM

## 5. Classificação Operacional

### Filtrar por plataforma

| Dropdown |
|---|
| `empresa_list` |
| `quote_stage_dom` |
| `code_list` |
| `vat_list` |
| `product_code_dom` |
| `products_list` |
| `salesman_region_list` |
| `type_list` |
| `department_c_list` |

### Permitir partilha global

| Dropdown |
|---|
| `approval_status_dom` |
| `quote_invoice_status_dom` |
| `quote_term_dom` |
| `campaign_status_dom` |
| `case_status_dom` |
| `pack_list` |
| `medical_appreciation_list` |
| `recommendations_list` |

### Manter override de label apenas

| Dropdown |
|---|
| `anuidade_list` |
| `exam_type_list` |
| `moduleList` |

## 6. Regra de Implementação Recomendada

| Situação | Estratégia |
|---|---|
| mesmo dropdown, opções diferentes | manter lista superset + filtro por `PLATFORM` |
| mesmo dropdown, labels diferentes | manter valores comuns + override de label por `PLATFORM` |
| catálogos muito diferentes | tratar como catálogo segmentado por tenant |
| campos equivalentes com nomes diferentes | mapear para um campo canónico na importação |

## Fonte

Fonte principal:

- [seepmode-vs-tacovia-fields.md](/home/seepmode94/Documentos/work/IT/LuxuryCRM/documentation/suitecrm/seepmode-vs-tacovia-fields.md)

Fontes complementares:

- [022_quote_dropdown_field_metadata.sql](/home/seepmode94/Documentos/work/IT/LuxuryCRM/apps/api/src/database/migrations/022_quote_dropdown_field_metadata.sql)
- [028_unify_seepmode_tacovia.sql](/home/seepmode94/Documentos/work/IT/LuxuryCRM/apps/api/src/database/migrations/028_unify_seepmode_tacovia.sql)

