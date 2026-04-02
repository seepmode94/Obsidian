# Plano de Ação Consolidado: Evolução LuxuryCRM

**Documento Relacionado:** [Parecer tecnico: Auditoria de Migração SuiteCRM vs LuxuryCRM](./Parecer%20tecnico.md)

**Objetivo:** Executar a migração e unificação total baseada na review técnica, garantindo a paridade funcional e a não perda de dados.

---

## Fase 0: Auditoria de Fidelidade de Campos (Segurança de Dados)
*Baseado no Ponto 4.2 do Parecer Técnico.*

1.  **Matriz de Auditoria:** Criar `auditoria-fidelidade-campos.md` para mapear colunas SQL originais para o novo Schema.
2.  **Identificação de Gaps:** Listar cam
3. identificar quais campos se devem fundir entre os dois:
    Campos partilhados que dependendo da base de dados apresenta dropdown diferentes(assistencias).
4. testar alterações no studio.

---

## Fase 1: Resolver o split do módulo "Sessões"
*Baseado no Ponto 1.1 do Parecer Técnico (Para decidir em Reunião).*

**O Problema:** O SuiteCRM usa o módulo `Sessões` para dois fins opostos: a Tacovia usa-o para **Sessões de Formação** (logística de aulas), enquanto a Seepmode usa-o para **Agendamento de Relatórios** (automação de sistema). Migrar ambos para o mesmo local causaria corrupção de dados e falhas nos filtros.

**Opções em Aberto:**
- **Opção A (Especialização):** `Sessões` = Apenas Formação. Relatórios passam a função interna de sistema.
- **Opção B (Recomendada):** Criar dois módulos: `Sessions` (Formação) + `ReportSchedules` (Relatórios Seepmode). É a solução mais limpa e escalável.
- **Opção C (Híbrida):** Um único módulo com campo "Tipo". (Risco elevado de confusão técnica).

1.  **Análise de Impacto:** Verificar volume de dados em ambos os dumps.
2.  **Preparação da Implementação:** Desenvolver estrutura para a opção escolhida.

---

## Fase 2: Construir o Superset Unificado de Campos
*Baseado no Ponto 1.2 do Parecer Técnico.*

1.  **Baseline:** Partir do `module_field_nature.md`.
2.  **União (Union):** Adicionar campos em falta da "Página Real" (Ponto 3.1 do Parecer) (ex: Documentos ricos da Tacovia + Fichas de Aptidão ricas da Seepmode).
3.  **Normalização:** Resolver conflitos de nomes e corrigir typos legado (Ponto 3.2 do Parecer).

---

## Fase 3: Atualizar Documentos "Source-of-Truth"
*Garantir que a documentação técnica reflete as decisões do Parecer.*

1.  **Metadados:** Atualizar `module_field_nature.md` com o Superset.
2.  **Layouts:** Atualizar `module_views.md` com layouts de vistas fundidos.
3.  **Relacionamentos:** Atualizar `module_relations.md` (ex: Documentos ↔ Faturas histórico).

---

## Fase 4: Gerar Migrações e Tipagem
*Traduzir as diretrizes do Parecer para a base de dados PostgreSQL.*

1.  **Migrações SQL:** Criar ficheiros `.sql` para os novos campos e tabelas (`035_unify_fields_real_pages.sql`).
2.  **Types & Seeds:** Atualizar `database.types.ts` e dados de semente (seeds).

---

## Fase 5: Atualizar Scripts de Importação SuiteCRM
*Executar a migração com inteligência por plataforma.*

1.  **Loaders (40-support-training.ts):** Lidar com divergência de Sessões e Formações.
2.  **Loaders (50-documents-emails.ts):** Implementar relações complexas de Documentos (Ponto 2.2 do Parecer).
3.  **Mapeamento por Plataforma:** Criar lógica condicional para dumps Seepmode e Tacovia.

---

## Fase 6: Reconciliação, Validação e Output
*A prova final de paridade e não perda de dados.*

1.  **Dry Run:** Executar importações de ambos os dumps.
2.  **Reconciliação:** Verificar se todos os campos foram povoados sem perda (Ponto 2.1 do Parecer).
3.  **Templates de Output:** Validar PDFs de Fichas de Aptidão (Modelo Rico Seepmode - Ponto 1.3 do Parecer).
