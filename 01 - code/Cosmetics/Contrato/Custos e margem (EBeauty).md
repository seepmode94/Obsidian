---
tags: [cosmetics, ebeauty, contrato, custos, margem, infra]
atualizado: 2026-06-18
status: rascunho
---

# EBeauty — Ficha de custos e margem

> [!warning] Rascunho de trabalho
> Os valores são **estimativas / placeholders** — confirma os preços atuais (mudam) e preenche com os teus números reais. Não é aconselhamento financeiro/fiscal — IVA e faturação → **contabilista**.

> 🔗 Liga a: [[Modelo de negócio e planos (avença)]] · [[Ponto de situação]]

---

## 🧭 Os 3 baldes de custo

1. **Fixo (infra)** — servidor/Vercel, Sanity, domínio, email, software de faturação. Pequeno e previsível.
2. **Variável** — API do Gemini (IA), overages de banda/compute, taxas de gateway. Escala com o uso.
3. **O teu tempo** — horas/mês × o teu **valor/hora**. ⭐ **É o custo dominante.** Sem isto, qualquer preço parece lucrativo e estás a perder.

> A conta que tem de fechar:
> **Preço do plano > infra repassada + variável esperado + (horas/mês × valor/hora) + margem**

---

## 🖥️ Infra — Opção A: Vercel (gerido)

| Item | Custo | Nota |
|---|---|---|
| Vercel **Pro** | **~$20 (~€19) / mês por _seat_** | ⚠️ 1 seat (eu) aloja **vários projetos**. Não é $20 por cliente. |
| Overage de uso | variável | banda/invocações; num catálogo pequeno → mínimo |
| **Custo marginal por cliente pequeno** | **≈ quase nada** | já tendo o seat Pro |

> [!note] Hobby é "non-commercial"
> O plano grátis do Vercel é para uso pessoal. Loja de cliente = **comercial** → precisa de **Pro**.

**Vantagem:** zero ops (updates, SSL, backups, uptime, deploys, preview URLs — tudo automático).
**Desvantagem:** custo de uso menos previsível; menos controlo.

## 🖥️ Infra — Opção B: VPS partilhado (todos os clientes)

| Item | Custo | Nota |
|---|---|---|
| VPS | **€7 / mês** (a partir de) | aloja **N** projetos; procurar **≥ 4–8 GB RAM** |
| Backups | ~+20% | normalmente extra — **não esquecer** |
| Coolify / Dokploy | grátis (open-source) | "Vercel self-hosted": git deploy + SSL auto + multi-app |
| **Custo por cliente** | **€7 ÷ N** | desce a pique com mais clientes |

> [!tip] Recomendação de fornecedor
> **Hetzner** (~€5–6, fiável) > Contabo (mais barato, mas suporte/perf variável). **Faz o build fora do servidor** (CI/local) — Next.js + build = muita RAM, dá OOM em VPS pequeno.

**Vantagem:** custo fixo previsível; controlo total; sem overages.
**Desvantagem:** ⭐ **eu viro o SRE** (OS, segurança, SSL, backups, uptime) + **ponto único de falha** (cai 1 → caem todos).

## ⚖️ Vercel vs VPS — quando trocar

A escolha **não é dinheiro** (ambos são baratos por cliente). É **tempo vs controlo**:

- A **cash**, o VPS (€7 flat) já bate o Vercel ($20 seat) a partir de 1–2 clientes — **se não valorizares o teu tempo de ops**.
- Mas o **tempo de ops** come essa poupança até teres clientes suficientes para o amortizar (e até automatizares com Coolify, que baixa o tempo por cliente).

| Nº de clientes | Recomendação |
|---|---|
| 1 | **Vercel Pro.** Não compres servidor para um site. |
| 2–4 | Zona cinzenta — depende de quanto vale o teu tempo |
| **5+** | **VPS + Coolify.** O servidor paga-se e o modelo de agência arranca. |

> [!info] O servidor só substitui o Vercel
> **Sanity** (CMS) e **Gemini** (IA) continuam **cloud** sempre. O VPS aloja só o front-end Next.js.

---

## 🤖 IA — Gemini (variável, a estimar)

| | Estimar |
|---|---|
| Modelo | `gemini-2.5-flash` (barato) |
| Custo por conversa (texto) | cêntimos |
| Custo por análise de **foto** | **mais alto** (imagem = mais tokens) |
| **Conversas/mês esperadas** | `____` |
| **Custo IA/mês ≈** | `custo/conversa × conversas/mês` = `____` |

> Por isso a IA fica no **plano de cima** com **limite justo** (N conversas/mês). Acima → extra.

---

## 📋 Outros custos fixos

| Item | Custo | Quem paga |
|---|---|---|
| Sanity | grátis (catálogo pequeno) → Growth ~$15/editor se crescer | eu (ou repassado) |
| Domínio | `.pt` ~€15–25/ano · `.com` ~€10/ano | **cliente (é dono)**, eu giro o DNS |
| Email no domínio | grátis a ~€5–6/mês (Google Workspace) | cliente |
| Software de faturação | Finanças = grátis · certificado ~€9–25/mês | eu |

---

## 🧮 Custo total por cliente / mês (preencher)

```
Infra (VPS÷N  ou  Vercel marginal) ......  €____
IA (Gemini esperado) ....................  €____
Sanity (se pago) ........................  €____
Outros repassados que eu absorvo ........  €____
-------------------------------------------------
SUBTOTAL custos "duros" .................  €____

O MEU TEMPO: ___ h/mês × €___/h .........  €____   ⭐ o que manda
-------------------------------------------------
CUSTO REAL POR CLIENTE / MÊS ............  €____
```

## 💰 Margem por plano (preencher com os preços de [[Modelo de negócio e planos (avença)]])

| Plano | Preço/mês | Custo real/mês | **Margem** |
|---|---|---|---|
| Mensal | €____ | €____ | €____ |
| Anual (÷12) | €____ | €____ | €____ |
| Performance | €base + Y% | €____ | €____ + % |

> [!danger] Regra do desconto anual
> O anual (≈ 2 meses grátis) **tem de continuar acima do custo real**. Não descontar até ao prejuízo.

---

## 💳 Repassar ao cliente (não absorver)

- **Domínio** — do cliente, em nome dele.
- **IA acima do limite** do plano.
- **Overages** de infra acima do incluído.
- **Taxas de gateway** (só Performance) — Stripe ~1.4% + €0.25 (cartão UE) → custo sobre as vendas **dele**, mas conta na matemática do %.

---

## ✅ A confirmar antes de propor

- [ ] **Valor/hora** meu (define isto primeiro — é o chão de tudo).
- [ ] **Horas/mês** estimadas de gestão por cliente.
- [ ] Fornecedor de VPS + specs (RAM ≥ 4–8 GB) + custo de backups.
- [ ] Conversas/mês esperadas da IA → custo Gemini.
- [ ] Decidir início: **Vercel (1 cliente)** vs **VPS (planear para 5+)**.
- [ ] Preços finais dos planos → preencher tabela de margem.
