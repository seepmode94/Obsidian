# Parecer Técnico: Auditoria de Migração SuiteCRM vs LuxuryCRM

**Data:** 2026-04-02  
**Autor:** Gemini CLI (Consultor Técnico)  
**Assunto:** Veredito sobre a Review de Migração e Plano de Paridade Funcional.

---

## 1. Resumo Executivo
Após uma análise dos 4 comentários da Review técnica e dos check-lists granulares de campo (Seepmode e Tacovia), o parecer é **favorável à migração**, desde que seja adotada uma estratégia de **"Superset Unificado"**. A review identificou que o SuiteCRM original apresenta divergências críticas que poderiam causar perda de dados se não forem tratadas individualmente por módulo.

---

## 2. Análise da Review: Módulos e Funcionalidades

### 2.1. Zona de Segurança (13 Módulos)
A review confirma que **13 módulos** são funcionalmente equivalentes entre Seepmode e Tacovia:
- *Clientes, Propostas, Faturas, Contratos, Contactos, Telefonemas, Reuniões, Notas, Emails, Formandos, Formadores, Assistências, Acessos IEFP.*
- **Veredito:** Estes módulos estão prontos para migração direta, necessitando apenas de harmonização de etiquetas (labels) para um padrão comum.

### 2.2. Módulos com Diferenças Críticas 
Identificaram-se 5 módulos onde a paridade não é automática:

1.  **Sessões (Divergência Total):** A Tacovia usa para Formação; a Seepmode para Relatórios.
    - **Recomendação:** Não unificar. Seguir a separação em dois módulos distintos para evitar corrupção de dados.
2.  **Medicina Ocupacional (Superset de Rastreio):** Diferenças nos exames complementares (Oftalmológico vs. Otorrinolaringologia).
    - **Recomendação:** Adotar a união de todos os campos de rastreio no LuxuryCRM.
3.  **Fichas de Aptidão (Modelo Rico):** O modelo da Seepmode é significativamente mais completo (Postos de Trabalho, Assinaturas, Riscos).
    - **Recomendação:** O modelo Seepmode deve ser o padrão "Core" do LuxuryCRM.
4.  **Documentos (Relações Complexas):** Diferenças no histórico de faturas e relações com fichas de aptidão.
    - **Recomendação:** Implementar todas as relações identificadas na review para garantir que nenhum histórico se perde.

---

## 3. Descobertas Técnicas Fundamentais

### 3.1. "Studio vs. Página Real"
Esta é a descoberta mais importante da review: **o Studio do SuiteCRM não reflete a realidade.**
- Muitos campos críticos (NIF, Contagem de Veículos, NUTS II, Datas IEFP) aparecem na **Página Real** mas estão "escondidos" ou desalinhados no Studio.
- **Veredito:** O LuxuryCRM deve ser construído com base na **Página Real**. Ignorar a configuração teórica do Studio para evitar a perda de campos que os utilizadores usam diariamente.

### 3.2. Normalização de "Legacy Typos"
A review detetou erros de escrita em chaves de base de dados (ex: `icfp_email_c` vs `iefp_email_c`).
- **Ação:** Padronizar as chaves no LuxuryCRM, mas manter o mapeamento inteligente para ambos os dumps originais.

---

## 4. Recomendações Estratégicas (O Veredito)

### 4.1. Módulo "Sessões": As 3 Opções de Reunião
Deve ser decidido em reunião qual o caminho:
- **Opção A:** Sessões = Formação (Relatórios passam a funcionalidade de sistema).
- **Opção B (Recomendada):** Dois módulos: `Sessions` + `ReportSchedules`.
- **Opção C:** Um módulo com campo "Tipo" (Risco elevado de confusão de dados).

### 4.2. Auditoria de Fidelidade (Fase 0)
É imperativo criar uma **Matriz de Auditoria de Fidelidade** (SuiteCRM SQL ➡️ LuxuryCRM Schema) antes de qualquer migração final. Isto garante que 100% dos campos reais têm um destino mapeado.

---

## 5. Conclusão Final
A migração é viável e o LuxuryCRM sairá reforçado ao adotar o **Superset** de ambas as plataformas. A estratégia de priorizar a "Página Real" em vez do "Studio" é a única garantia contra a perda de funcionalidades críticas. O plano de ação em 6 fases é validado tecnicamente.
