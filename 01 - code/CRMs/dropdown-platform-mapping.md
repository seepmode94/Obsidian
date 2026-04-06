# Dropdown Platform Mapping

## Objetivo

Mapear as diferenças de dropdown entre `seepmode` e `tacovia` que interessam para a alteração multi-plataforma no LuxuryCRM.

## Fontes

- [seepmode-vs-tacovia-fields.md](/home/seepmode94/Documentos/work/IT/LuxuryCRM/documentation/suitecrm/seepmode-vs-tacovia-fields.md)
- [module_field_nature.md](/home/seepmode94/Documentos/work/IT/LuxuryCRM/documentation/module_field_nature.md)
- [022_quote_dropdown_field_metadata.sql](/home/seepmode94/Documentos/work/IT/LuxuryCRM/apps/api/src/database/migrations/022_quote_dropdown_field_metadata.sql)
- [028_unify_seepmode_tacovia.sql](/home/seepmode94/Documentos/work/IT/LuxuryCRM/apps/api/src/database/migrations/028_unify_seepmode_tacovia.sql)

## Como Ler Este Documento

| Classe | Significado |
|---|---|
| Partilhado sem diferença documentada | existe nos dois lados e não há divergência relevante registada |
| Partilhado com diferença confirmada | existe nos dois lados e há diferença documentada de opções, labels ou contagem |
| Identificado apenas numa fonte | aparece só nas fontes usadas para um dos lados; precisa validação adicional antes de assumir exclusividade real |

## 1. Diferenças Confirmadas Com Impacto Alto

| Dropdown | Seepmode | Tacovia | Impacto |
|---|---|---|---|
| `empresa_list` | `seepmode`, `seepmed` | `tacovia` | alto |
| `quote_stage_dom` | 5 estados | 9 estados | alto |
| `code_list` | 1 valor | 135+ valores | alto |
| `vat_list` | base PT | + `5.0`, `7.5`, `17.5`, `20.0` | alto |
| `product_code_dom` | 355 códigos | 317 códigos | alto |
| `products_list` | 214 produtos | 136 produtos | alto |
| `salesman_region_list` | 30 regiões | 15 regiões | alto |

### Notas

- `empresa_list` deve ser tratado por tenant.
- `quote_stage_dom` deve ser tratado como superset com filtro por plataforma.
- `code_list`, `product_code_dom`, `products_list` e `salesman_region_list` não devem ser assumidos como catálogos globais comuns.
- `vat_list` agrega regimes fiscais diferentes.

## 2. Diferenças Confirmadas Com Impacto Médio ou Baixo

| Dropdown | Diferença confirmada | Impacto |
|---|---|---|
| `anuidade_list` | `1/2 anos` vs `1/2 Anos` | baixo |
| `billing_state_list` | Tacovia acrescenta `Belgium_` | baixo |
| `nutsii_list` | Tacovia acrescenta `Belgium_` | baixo |
| `department_c_list` | Seepmode inclui `marketing` | médio |
| `exam_type_list` | `A pedido` vs `a pedido` | baixo |
| `type_list` | Seepmode inclui `admin` e `distributer` | médio |
| `yes_no_list` | diferença documentada no valor `Sim` | médio |
| `moduleList` | labels PT diferentes entre plataformas | baixo |

### Nota

- `department_c_list` aparece explicitamente como diferença na comparação entre instâncias e também foi unificado na migration `028`.

## 3. Diferença De Campo Associada A Dropdown

| Conceito | Seepmode | Tacovia | Nota |
|---|---|---|---|
| Anuidade do contrato | `anuidade_c` | `anuidade_list_c` | mesmo conceito, campo diferente |

Regra:

- na alteração, isto deve ser tratado como mapeamento de campo, não apenas como mapeamento de dropdown.

## 4. Campos Mais Sensíveis A Plataforma

| Módulo | Campo | Dropdown |
|---|---|---|
| `Quotes` | `company` | `empresa_list` |
| `Quotes` | `quote_stage` | `quote_stage_dom` |
| `Invoices` | `company` | `empresa_list` |
| `Contracts` | `empresa_c` | `empresa_list` |
| `Contracts` | `anuidade_c` | `anuidade_list` |
| `Cases` | `code_c` | `code_list` |

## 5. Dropdowns Confirmadas Como Usadas Pela Seepmode

Confirmadas em [module_field_nature.md](/home/seepmode94/Documentos/work/IT/LuxuryCRM/documentation/module_field_nature.md) como efetivamente ligadas a campos.

| Dropdown |
|---|
| `account_type_dom` |
| `anuidade_list` |
| `approval_status_dom` |
| `area_list` |
| `attendances_list` |
| `billing_state_list` |
| `campaign_status_dom` |
| `candidature_status_list` |
| `case_status_dom` |
| `cases_mode_list` |
| `client_service_type_list` |
| `code_list` |
| `contracts_status_list` |
| `countries_list` |
| `empresa_list` |
| `exam_type_list` |
| `gender_list` |
| `industry_dom` |
| `invoice_status_dom` |
| `lead_source_dom` |
| `literary_abilities_list` |
| `marital_status_list` |
| `medical_appreciation_list` |
| `nutsii_list` |
| `pack_list` |
| `priority_list` |
| `quote_invoice_status_dom` |
| `quote_stage_dom` |
| `quote_term_dom` |
| `recommendations_list` |
| `send_receive_list` |
| `service_organization_list` |
| `service_organization_name_c_list` |
| `service_organization_nipc_c_list` |
| `sexo_c_list` |
| `training_types_list` |
| `type_invoice` |
| `type_list` |
| `yes_no_list` |

### 5.1 Dropdowns Usadas Só Ou Principalmente Pela Seepmode

Estas estão ligadas a customizações que a comparação entre instâncias identifica como Seepmode-specific ou fortemente associadas ao domínio Seepmode.

| Dropdown | Motivo |
|---|---|
| `service_organization_list` | usada em `sdmod_capability`, módulo altamente customizado em Seepmode |
| `service_organization_name_c_list` | usada em `sdmod_capability`, customização Seepmode |
| `service_organization_nipc_c_list` | usada em `sdmod_capability`, customização Seepmode |
| `sexo_c_list` | usada em `sdmod_capability`, customização Seepmode |
| `recommendations_list` | usada em `sdmod_capability`, customização Seepmode |

Nota:

- estas listas podem existir noutras instâncias após unificações/migrations, mas a sua utilização funcional confirmada nas fontes analisadas está associada sobretudo à Seepmode

## 6. Inventário Comparativo

### 6.1 Partilhados Com Diferença Confirmada

| Dropdown |
|---|
| `anuidade_list` |
| `billing_state_list` |
| `code_list` |
| `department_c_list` |
| `empresa_list` |
| `exam_type_list` |
| `moduleList` |
| `nutsii_list` |
| `product_code_dom` |
| `products_list` |
| `quote_stage_dom` |
| `salesman_region_list` |
| `type_list` |
| `vat_list` |
| `yes_no_list` |

### 6.2 Partilhados Sem Diferença Documentada

| Dropdown |
|---|
| `account_type_dom` |
| `approval_status_dom` |
| `area_list` |
| `attendances_list` |
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
| `service_organization_name_c_list` |
| `service_organization_nipc_c_list` |
| `sexo_c_list` |
| `training_types_list` |
| `type_invoice` |

### 6.3 Identificados Apenas Na Fonte Tacovia Usada

Estas listas aparecem no inventário `dropdown_lists` de `luxurycrm_tacovia`, mas não estão cobertas nas fontes Seepmode usadas para este documento.

| Dropdown |
|---|
| `call_direction_dom` |
| `call_status_dom` |
| `document_category_dom` |
| `document_status_dom` |
| `document_subcategory_dom` |
| `document_template_type_dom` |
| `dom_email_status` |
| `dom_email_types` |
| `eapm_list` |
| `email_category_dom` |
| `email_template_type_list` |
| `lead_status_dom` |
| `meeting_status_dom` |
| `pdf_orientation_dom` |
| `pdf_page_size_dom` |
| `pdf_template_module_dom` |
| `pdf_template_source_kind_dom` |
| `pdf_template_status_dom` |
| `reports_module_dom` |
| `sales_stage_dom` |
| `salutation_dom` |
| `task_priority_dom` |
| `task_status_dom` |
| `users_sales_region_list` |

### 6.4 Resumo Quantitativo

| Classe | Quantidade |
|---|---|
| Partilhados com diferença confirmada | 15 |
| Partilhados sem diferença documentada | 30 |
| Identificados apenas na fonte Tacovia usada | 24 |

## 7. Uso Recomendado Na Alteração

### Tratar como multi-tenant obrigatório

| Dropdown |
|---|
| `empresa_list` |
| `quote_stage_dom` |
| `code_list` |
| `vat_list` |
| `product_code_dom` |
| `products_list` |
| `salesman_region_list` |

### Tratar como override menor mas registado

| Dropdown |
|---|
| `anuidade_list` |
| `billing_state_list` |
| `nutsii_list` |
| `department_c_list` |
| `exam_type_list` |
| `type_list` |
| `yes_no_list` |
| `moduleList` |

### Validar antes de assumir exclusividade real

| Grupo |
|---|
| `identificados apenas na fonte Tacovia usada` |

## 8. Nota

Este documento é suficientemente forte para orientar a alteração dos casos principais:

- não é uma prova exaustiva linha-a-linha de todas as listas das duas instâncias
- o grupo `identificados apenas na fonte Tacovia usada` depende da cobertura das fontes Seepmode presentes no repositório
