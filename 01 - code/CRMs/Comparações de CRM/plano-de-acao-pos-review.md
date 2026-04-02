# Plano de Ação: Evolução LuxuryCRM (Pós-Review)

**Objetivo:** Garantir a paridade funcional total, integrando as necessidades da Seepmode e Tacovia sem perda de dados históricos.

---

## Fase 1: Sincronização de Schema (Base de Dados)
*O foco aqui é preparar as tabelas para suportar o "Superset" de campos identificados na Página Real.*

1.  **Migração SQL (Superset):** Criar ficheiro de migração (ex: `035_unify_fields_real_pages.sql`) para:
    *   Adicionar campos de veículos em **Clientes** (Pesados, Ligeiros, Nº Condutores).
    *   Adicionar campos biográficos e de rastreio em **Medicina Ocupacional** (Data Nascimento, Sexo, Rastreios).
    *   Adicionar campos financeiros em **Faturas** (Valor Pago, Valor Aberto).
    *   Adicionar campos técnicos em **Formações** e **Formandos** (Datas IEFP, SIGO, etc.).
2.  **Módulo Sessões (Separação):**
    *   Criar tabela `report_schedules` para os relatórios da Seepmode.
    *   Limpar a tabela `sessions` para ser usada apenas para Formação.

---

## Fase 2: Metadados e Interface (Vistas & Filtros)
*Ajustar a interface para que reflita a experiência que os utilizadores tinham no sistema antigo.*

1.  **Atualização de `module_field_nature.md`:** Refletir os novos campos e correções de nomes.
2.  **Ajuste de List Views e Filtros:**
    *   Configurar os filtros no LuxuryCRM para incluir os campos da "Página Real" (ex: filtro por Concelho nas Assistências).
    *   Remover colunas duplicadas (ex: as várias colunas de "Date Created").
3.  **Configuração Multi-Tenant:**
    *   Garantir que os módulos de Medicina Ocupacional e Fichas de Aptidão estão configurados como visíveis apenas para o "caso" Seepmode.

---

## Fase 3: Enriquecimento e Validação de Dados Existentes
*Trabalhar sobre os dados que já estão no sistema para garantir que estão completos.*

1.  **Scripts de Cura de Dados:**
    *   Preencher os novos campos (ex: NUTS II) a partir das tabelas originais, se possível.
    *   Corrigir os tipos de dados (casts) para campos numéricos que estavam como varchar no SuiteCRM.
2.  **Verificação de Totais:**
    *   Executar script de validação de cálculos financeiros (Propostas/Faturas) para garantir que os valores migrados batem certo com o LuxuryCRM.

---

## Fase 4: Templates e Certificados (Output)
*Garantir que os documentos gerados pelo CRM são idênticos ou superiores aos antigos.*

1.  **Fichas de Aptidão (Modelo Rico):** Implementar o template de PDF baseado no modelo da Seepmode (Trabalhador, Posto, Riscos, etc.).
2.  **Faturas e Propostas:** Testar os templates com os novos campos de "Itens de Linha" e taxas/impostos unificados.

---

## Fase 5: Testes Cruzados e Lançamento
1.  **UAT (User Acceptance Testing):**
    *   Teste de fluxo completo Seepmode (Medicina Ocupacional -> Fichas de Aptidão).
    *   Teste de fluxo completo Tacovia (Formação -> Faturação).
2.  **Resolução de "To-Dos" Residuais:** Atacar a lista de pequenas correções de interface identificadas no ficheiro de diferenças da Seepmode.

---

### Próximo Passo Imediato:
- **Executar a Fase 1.1:** Criar a migração SQL com o superset de campos da "Página Real".
