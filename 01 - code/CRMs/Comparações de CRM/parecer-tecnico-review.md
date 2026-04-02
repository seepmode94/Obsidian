# Parecer Técnico: Review de Migração SuiteCRM vs LuxuryCRM

**Data:** 2026-04-02  
**Assunto:** Análise crítica das divergências entre as versões Seepmode e Tacovia e discrepâncias Studio vs. Página Real.

---

## 1. Validação das Decisões Críticas

### 1.1. O Conflito das "Sessões" (Aprovado)
A review identificou corretamente que o módulo `Sessões` é usado para fins opostos. 
- **Decisão:** Separar em dois módulos. O LuxuryCRM manterá `Sessões` para o domínio de Formação. Os "Relatórios Agendados" da Seepmode serão movidos para um novo módulo técnico/sistema (`ReportSchedules`). Misturar estes dados causaria falhas em filtros e relatórios globais.

### 1.2. Estratégia do "Superset" (Aprovado)
A unificação de campos nos módulos partilhados (Clientes, Propostas, Faturas) é a estratégia mais segura para a evolução do produto.
- **Campos Tacovia:** NUTS II, Nº Condutores, etc., devem ser integrados no core.
- **Campos Seepmode:** Tipologias específicas de clientes e campos de faturação detalhados devem ser integrados no core.
- **Resultado:** O LuxuryCRM torna-se uma plataforma mais capaz para ambos os "casos" sem perda de histórico.

### 1.3. Exclusividade Seepmode (Medicina & Fichas)
Confirmado que os módulos de **Medicina Ocupacional** e **Fichas de Aptidão** são exclusivos da Seepmode.
- **Decisão:** Adotar o "Modelo Rico" (mais campos e relações) identificado na review da Seepmode. Não haverá simplificação ou "downgrade" destes módulos para acomodar a Tacovia, uma vez que ela não os utiliza.

---

## 2. Correções de "Ruído" e Legado

### 2.1. Divergência Studio vs. Página Real
O SuiteCRM apresenta frequentemente campos no Studio que estão vazios na base de dados ou ocultos na interface real.
- **Diretriz:** A **Página Real** é a única fonte de verdade para a experiência do utilizador. Se um campo era visível e usado pelo utilizador, ele TEM de existir no LuxuryCRM. Se só existia no Studio e nunca foi povoado, será descartado para evitar poluição.

### 2.2. Duplicação de Campos de Auditoria
A review notou colunas duplicadas como `Date Created` e `Data de Criação`. 
- **Decisão:** Eliminar a redundância. O LuxuryCRM usará campos de auditoria standard (`createdAt`, `updatedAt`) traduzidos corretamente na interface, removendo campos customizados que apenas replicavam esta função.

### 2.3. Higiene de Dados (Typos)
- **Ação:** Corrigir erros históricos como `icfp_email_c` (IEFP) durante a migração dos metadados e scripts de importação.

---

## 3. Conclusão
A review é tecnicamente sólida e serve como base para a "não perda de funcionalidades". O foco agora deve ser a implementação do schema de base de dados que suporte este "Superset" de campos e a separação lógica das Sessões.
