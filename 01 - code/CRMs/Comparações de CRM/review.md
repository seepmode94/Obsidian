# SuiteCRM (Seepmode + Tacovia) vs LuxuryCRM — Field Migration Review

Based on the comparative study in [Issue #1](https://github.com/CRM-Seepmode/LuxuryCRM/issues/1).

---

## Overview

The issue contains 4 comments with extensive documentation:

1. **Comment 1** — Comparative summary identifying differences between the two SuiteCRM flavors
2. **Comment 2** — Full Tacovia check-list (all modules, all views, all fields with SuiteCRM column names)
3. **Comment 3** — Full Seepmode check-list (same structure, first pass with Portuguese labels)
4. **Comment 4** — Second, more detailed Seepmode check-list extracted directly from the SuiteCRM API/DB (includes actual column names like `[field_name]`)

---

## Modules with NO meaningful differences between platforms (13 modules)

- Clientes
- Propostas
- Faturas
- Contratos
- Contactos
- Telefonemas
- Reuniões
- Notas
- Emails
- Formandos
- Formadores
- Assistências
- Acessos IEFP

These are functionally equivalent across both flavors. Fields, views, and filters match or have only cosmetic label differences.

---

## Modules with SIGNIFICANT differences (5 modules)

| Módulo | Natureza da Diferença | Impacto |
|--------|----------------------|---------|
| **Sessões** | Finalidade completamente diferente: Tacovia = sessões de formação (Formação, Abreviatura, Sessões, Atribuído a); Seepmode = relatórios agendados (Relatórios, Agendar, Última execução, Destinatários do email) | **Crítico** — requer decisão sobre modelo unificado |
| **Medicina Ocupacional** | Seepmode agrupa Passatempos, Recomendações, Observações Finais sob painéis "FMO"; Seepmode tem "Rastreio otorrinolingolo" vs "Rastreio oftalmológico" da Tacovia; Seepmode adiciona Data de Nascimento, Sexo, Criado por à lista/filtros | **Médio** — necessário union/superset |
| **Fichas de Aptidão** | Seepmode tem modelo muito mais rico (Posto de trabalho, Serviço de saúde do trabalho, Trabalhador, Recomendações, Médico do Trabalho, Assinaturas); Tacovia tem modelo simplificado (Nome, Atribuído a, Descrição) | **Médio** — usar modelo mais rico da Seepmode |
| **Documentos** | Seepmode tem relação "Fichas de Aptidão"; Tacovia tem "Faturas(Histórico)", LBL_REVISIONS_PANEL (Revisão criada por, Data criação última revisão), e "Nome do documento" na vista de lista | **Médio** — union/superset |
| **Formações** | Tacovia tem "Recursos Administrativos" na criação rápida; Seepmode não tem "Data entrega informação ao Formando", "Média dos Formandos(€)", "Valor pago(€)" em algumas vistas | **Baixo** — diferenças menores de layout |

---

## Diferenças isoladas noutros módulos

| Módulo | Campo / Bloco | Seepmode | Tacovia |
|--------|--------------|----------|---------|
| Medicina Ocupacional | Exame complementar | Rastreio otorrinolingolo | Rastreio oftalmológico |
| Medicina Ocupacional | Bloco após Patologia Apresentada | FMO | Recomendações |
| Medicina Ocupacional | Vista de Lista | Data de Nascimento, Sexo | — |
| Medicina Ocupacional | Filtro | Criado por | — |
| Medicina Ocupacional | Vista de Lista / Filtro | NUTS I: [nutsi] | — |
| Sessões | Estrutura do módulo | Relatórios agendados | Sessões de formação |
| Sessões | Campo principal | Relatórios | Sessões |
| Sessões | Campo | Situação | Abreviatura |
| Sessões | Campo | Agendar | — |
| Sessões | Campo | Última execução | — |
| Sessões | Campo | Destinatários do email | — |
| Sessões | Filtro | Meus itens | — |
| Sessões | Filtro | Todos os endereços de email | — |
| Sessões | Filtro | — | Atribuído a |
| Sessões | Campo | — | Formação |
| Sessões | Campo | — | Atribuído a |
| Formações | Criação rápida | — | Recursos Administrativos |
| Formações | Campo | — | Data entrega informação ao Formando |
| Formações | Campo | — | Média dos Formandos(€) |
| Formações | Campo | — | Valor pago(€) |
| Documentos | Vista de detalhe | Fichas de Aptidão | — |
| Documentos | Vista de detalhe | — | Faturas(Histórico) |
| Documentos | Vista de detalhe | — | (preencher) |
| Documentos | Vista de detalhe | — | Revisão criada por |
| Documentos | Vista de detalhe | — | Data de criação da última revisão |
| Documentos | Vista de detalhe | — | Data de alteração |
| Documentos | Vista de Lista | — | Nome do documento: [document_name] |
| Contactos | Campo | — | ADR |
| Contactos | Campo | Todos os endereços: [address_street] | — |
| Contactos | Campo | Código postal: [address_postalcode] | — |
| Reuniões | Campo | — | Notificações auditoria ao cliente |
| Formandos | Campo | Data Verificação portal IEPF - Estado da Candidatura | — |
| Acessos IEFP | Campo técnico | Email- IEFP: [icfp_email_c] | Email - IEFP: [iefp_email_c] |
| Assistências | Campo | Criado por | — |
| Assistências | Campo | Criado em | — |

---

## Plano de Ação

### Fase 1: Resolver o split do módulo "Sessões" (Decisão Crítica)

O módulo `Sessões` serve **propósitos completamente diferentes** em cada plataforma.

**Opções:**

- **A)** Manter o modelo de sessões de formação da Tacovia (alinhado com o domínio Formações/Formandos) e tratar os relatórios agendados da Seepmode como módulo/funcionalidade separada
- **B)** Criar dois módulos distintos: `Sessões` (formação) + `ReportSchedules` (Seepmode)
- **C)** Unificar ambos num único módulo com discriminador `type`

**Recomendação:** Opção A ou B. O LuxuryCRM já tem um módulo `Sessões` em `module_field_nature.md` alinhado com formação. Os "relatórios agendados" da Seepmode são uma funcionalidade de sistema, não um módulo de negócio.

### Fase 2: Construir o superset unificado de campos

Para cada módulo, pegar na **união** dos campos de ambas as plataformas:

1. Partir do `module_field_nature.md` existente como baseline
2. Cruzar cada campo dos Comments 2 & 4 contra o baseline
3. Adicionar campos em falta (especialmente do Documentos mais rico da Tacovia e Fichas de Aptidão mais ricas da Seepmode)
4. Resolver conflitos de nomes (e.g., `icfp_email_c` vs `iefp_email_c` → padronizar para `iefp_email_c`)

### Fase 3: Atualizar documentos source-of-truth

Atualizar estes ficheiros com o superset unificado:

- `module_field_nature.md` — adicionar campos em falta
- `module_views.md` — fundir layouts de vistas (superset de colunas)
- `module_relations.md` — adicionar relações em falta (e.g., Documents ↔ Fichas de Aptidão, Documents ↔ Faturas histórico)

### Fase 4: Gerar migrações para novos campos

Para cada campo recém-identificado que não esteja no schema da BD:

- Adicionar ficheiros SQL de migração
- Atualizar `database.types.ts` com o schema Kysely
- Atualizar seed data se necessário

### Fase 5: Atualizar scripts de importação SuiteCRM

Atualizar as 6 fases de load para lidar com mapeamentos de campos específicos por plataforma:

- `40-support-training.ts` — lidar com divergência das Sessões, diferenças menores das Formações
- `50-documents-emails.ts` — lidar com painel de revisões dos Documentos e relações
- Mapeamento de colunas consciente da plataforma para campos com chaves diferentes (typo do email IEFP, etc.)

### Fase 6: Reconciliação & validação

- Executar importações de ambos os dumps SuiteCRM
- Verificar cobertura de campos com relatórios de reconciliação
- Validar que não há perda de dados de nenhuma das plataformas
