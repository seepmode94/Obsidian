# Plano de Ação Consolidado: Evolução LuxuryCRM

**Objetivo:** Executar a migração e unificação total baseada na review técnica, garantindo a paridade funcional e a não perda de dados.

---

## Fase 0: Auditoria de Fidelidade de Campos (Segurança de Dados)
*Antes de qualquer alteração técnica, garantir o mapeamento SuiteCRM ➡️ LuxuryCRM.*

1.  **Matriz de Auditoria:** Criar `auditoria-fidelidade-campos.md` para mapear colunas SQL originais para o novo Schema.
2.  **Identificação de Gaps:** Listar campos da "Página Real" que não têm destino e decidir a sua inclusão no Superset.

---

## Fase 1: Resolver o split do módulo "Sessões"
*Decisão sobre a divergência de propósitos do módulo.*

1.  **Análise de Impacto:** Verificar dados existentes em ambos os dumps.
2.  **Implementação da Decisão (Reunião):** 
    *   **Opção B (Recomendada):** Criar `ReportSchedules` (Seepmode) e manter `Sessões` para Formação (Tacovia/Core).

---

## Fase 2: Construir o Superset Unificado de Campos
*Criar a união dos campos de ambas as plataformas.*

1.  **Baseline:** Partir do `module_field_nature.md`.
2.  **União (Union):** Adicionar campos em falta (ex: Documentos ricos da Tacovia + Fichas de Aptidão ricas da Seepmode).
3.  **Normalização:** Resolver conflitos de nomes (ex: `icfp_email_c` ➡️ `iefp_email_c`).

---

## Fase 3: Atualizar Documentos "Source-of-Truth"
*Atualizar a documentação técnica que serve de guia ao desenvolvimento.*

1.  **Metadados:** Atualizar `module_field_nature.md` com o Superset.
2.  **Layouts:** Atualizar `module_views.md` com layouts de vistas fundidos.
3.  **Relacionamentos:** Atualizar `module_relations.md` (ex: Documentos ↔ Faturas histórico).

---

## Fase 4: Gerar Migrações e Tipagem
*Traduzir os campos identificados para a base de dados PostgreSQL.*

1.  **Migrações SQL:** Criar ficheiros `.sql` para os novos campos e tabelas (`035_unify_fields_real_pages.sql`).
2.  **Types & Seeds:** Atualizar `database.types.ts` e dados de semente (seeds).

---

## Fase 5: Atualizar Scripts de Importação SuiteCRM
*Garantir que o motor de migração sabe onde colocar cada dado.*

1.  **Loaders (40-support-training.ts):** Lidar com divergência de Sessões e Formações.
2.  **Loaders (50-documents-emails.ts):** Implementar painel de revisões e relações complexas.
3.  **Mapeamento por Plataforma:** Criar lógica condicional para campos com chaves diferentes por dump.

---

## Fase 6: Reconciliação, Validação e Output
*A prova dos nove e os resultados finais.*

1.  **Dry Run:** Executar importações de ambos os dumps.
2.  **Reconciliação:** Verificar se todos os campos foram povoados sem perda.
3.  **Templates de Output:** Validar PDFs (Fichas de Aptidão e Faturas) com os novos dados.

---

### Próximo Passo Imediato:
- **Iniciar Fase 0:** Auditoria de Fidelidade para o módulo de Clientes.
