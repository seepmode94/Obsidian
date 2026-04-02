# Parecer Técnico: Review de Migração SuiteCRM vs LuxuryCRM

**Data:** 2026-04-02  
**Assunto:** Análise crítica das divergências entre as versões Seepmode e Tacovia e discrepâncias Studio vs. Página Real.

---

## 1. Pontos Críticos para Decisão Estratégica

### 1.1. O Conflito do Módulo "Sessões" (Para Decidir em Reunião)
A review identificou que o módulo `Sessões` é usado para fins opostos em cada plataforma. Precisamos de escolher uma abordagem para evitar a mistura de dados de domínios diferentes:

*   **Opção A - Especialização:** Manter o módulo `Sessões` exclusivamente para a formação da Tacovia e tratar os relatórios agendados da Seepmode como uma funcionalidade técnica/interna do sistema.
*   **Opção B - Separação Clara (Recomendada):** Criar dois módulos distintos: `Sessões` (para o domínio de Formação) e `ReportSchedules` (para os agendamentos da Seepmode). Esta opção é a mais limpa arquiteturalmente.
*   **Opção C - Unificação com Discriminador:** Manter um único módulo `Sessões` para tudo, usando um campo "tipo" para distinguir o que é formação do que é relatório. **Nota:** Esta opção é a mais arriscada para a integridade dos dados.

### 1.2. Estratégia do "Superset" (Aprovado)
A unificação de campos nos módulos partilhados (Clientes, Propostas, Faturas) é a estratégia mais segura para a evolução do produto.
- **Justificação da Review:** Foram detetadas divergências em nomes de colunas (ex: `icfp_email_c` vs `iefp_email_c`) e campos operacionais exclusivos de cada "flavor". O Superset garante que nenhum dado fica "orfão" durante a migração.
- **Resultado:** O LuxuryCRM torna-se uma plataforma mais capaz para ambos os "casos" sem perda de histórico.

### 1.3. Exclusividade Seepmode (Medicina & Fichas)
Confirmado que os módulos de **Medicina Ocupacional** e **Fichas de Aptidão** são exclusivos da Seepmode.
- **Decisão:** Adotar o "Modelo Rico" (mais campos e relações) identificado na review da Seepmode. Não haverá simplificação ou "downgrade" destes módulos para acomodar a Tacovia, uma vez que ela não os utiliza.

---

## 2. Garantia de "Não Perda de Dados" (Nova Diretriz)

### 2.1. Auditoria de Fidelidade (SuiteCRM ➡️ LuxuryCRM)
Identificou-se a necessidade de um ficheiro comparativo entre o modelo antigo (SuiteCRM SQL) e o novo modelo (LuxuryCRM Schema).
- **Objetivo:** Garantir que 100% dos campos relevantes do legado têm um destino mapeado no novo sistema.
- **Ação:** Criar a "Matriz de Auditoria de Fidelidade" por módulo antes de avançar para a Fase 2 do Plano de Ação.

### 2.2. Divergência Studio vs. Página Real
- **Diretriz:** A **Página Real** é a única fonte de verdade. Ignorar configurações teóricas do Studio que não se traduzam em uso real ou dados povoados.

### 2.3. Limpeza de Redundâncias
- **Ação:** Eliminar duplicações de campos de auditoria (ex: múltiplas colunas de data de criação) em favor de campos de sistema standard.

---

## 3. Conclusão
A review é tecnicamente sólida e serve como base para a "não perda de funcionalidades". O foco prioritário agora é a **Auditoria de Fidelidade** para validar o mapeamento completo dos campos entre o modelo antigo e o novo.
