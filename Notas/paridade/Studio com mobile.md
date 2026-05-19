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
