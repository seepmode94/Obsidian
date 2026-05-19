# Studio com mobile

Registo de verificações de paridade entre o **Studio** (web/admin) e o **mobile** (app), e divergências identificadas.

---

## 2026-05-19

### Propostas — vista de lista

**Ecrã:** Propostas → vista de lista (mobile)

![[propostas-lista-city-state-nao-traduzido.png]]

**Observações:**
- Paridade entre Studio e mobile **confirmada** — alterações feitas no Studio são apresentadas no mobile.
- **Divergência de tradução:** os campos `City` e `State` aparecem em inglês no Studio (e propagam para o mobile assim).

**Decisão / acção:** traduzir `City` → `Cidade` e `State` → `Distrito` (ou equivalente) no lado do Studio para que o mobile herde corretamente as labels em português.

---

### Contratos — resumo geral (totais a zero)

**Ecrã:** Contratos → vista de lista (mobile), bloco "Resumo Geral"

![[contratos-resumo-geral-totais-zero.png]]

**Observações:**
- O bloco "Resumo Geral" mostra `Total Ativos: 0` e `Valor Total: 0 €`, apesar de existirem contratos activos visíveis em baixo (ex.: contrato `509379990`, estado `ACTIVO`, com `Valor Líquido = 243,68 €`).
- Os valores **não estão a incrementar** porque os contratos não estão a ser contabilizados no total de itens de linha.

**Hipóteses:**
- A feature de agregação no mobile está partida (não soma os contratos activos).
- A feature pode não existir na web (Studio) — falta de paridade.

**Decisão pendente:** confirmar com o produto/PM qual o comportamento esperado:
1. **Corrigir** o cálculo no mobile (e implementar igual na web se não existir) — manter a feature.
2. **Retirar** o bloco "Resumo Geral" do mobile e criar paridade com a web (que não tem este resumo).

**Próximo passo:** validar com a web se o bloco existe; alinhar decisão antes de mexer no código.
