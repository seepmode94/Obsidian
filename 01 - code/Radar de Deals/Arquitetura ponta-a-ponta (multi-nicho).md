---
tags: [projeto, radar-deals, arquitetura, ia, afiliados, gemini, telegram]
atualizado: 2026-06-22
status: desenho
---

# Radar de Deals — Arquitetura ponta-a-ponta (multi-nicho)

> Continuação de [[Validação da tese]]. Desenho de como juntar **gaming gear + produtos de casa + fitness** num só sistema. Pergunta central: **de que forma é que isto se junta?**

---

## 🔑 O princípio: junta-se o MOTOR, não as audiências

Meter gaming + casa + fitness no **mesmo canal/feed** falha — são compradores diferentes e um feed disperso cresce devagar (engagement < foco, conforme [[Validação da tese]]). A junção certa faz-se em **três camadas independentes**, que podes usar isoladas ou combinadas:

1. **Junção de infraestrutura (a base):** UM motor (radar + IA de conteúdo + app de aprovação + analytics) que alimenta **N canais por nicho**. Os nichos partilham o *código*, não a *audiência*. Lanças os 3, vês qual converte, dobras a aposta.
2. **Junção de audiência (o upside):** uma marca-chapéu **"o teu espaço / setup & bem-estar"** onde gaming + casa + fitness *genuinamente se cruzam* — quem monta a battlestation também quer secretária ergonómica (casa) e standing desk/halteres (fitness). Aqui são UM público.
3. **Junção comercial (o multiplicador):** **cross-sell** entre nichos — quem comprou cadeira gaming → sugerir secretária (casa) + tapete/halteres (fitness). Sobe o valor por utilizador mesmo com canais separados.

> [!tip] Recomendação
> Construir sempre a **camada 1** (motor partilhado — é o que torna "3 nichos" viável com um só código). Depois escolher: arrancar com **canais separados** (seguro, testa os 3) **ou** com a **marca-chapéu setup/lifestyle** (mais upside, mas obriga a focar cada nicho na fatia "setup": desk/ergonomia/movimento, não mobília pesada nem suplementação hardcore).

---

## 🗺️ Desenho ponta-a-ponta

```
 ┌──────────────────────── FONTES (pluggable por nicho) ────────────────────────┐
 │ GAMING        Amazon best-sellers · Razer/Logitech/Corsair feeds · PcComp/Worten │
 │ CASA          IKEA · El Corte Inglés · Awin home · Amazon casa · Pinterest        │
 │ FITNESS       Prozis · Myprotein (Awin) · Amazon desporto                          │
 │ TRANSVERSAL   Google Trends · Keepa (histórico de preço) · sinais sociais          │
 └───────────────────────────────────┬──────────────────────────────────────────┘
                                      ▼
 ┌──────────────── [1] RADAR ─────────────────┐   normaliza + deteta deal REAL
 │ workers/cron por fonte → tabela Product      │   (preço↓ vs histórico, não fake)
 └───────────────────────────────────┬─────────┘
                                      ▼
 ┌──────────────── [2] SCORING ───────────────┐   score = tendência + qualidade do
 │ ranking multi-sinal, thresholds POR NICHO    │   deal + margem (€/venda esperado)
 └───────────────────────────────────┬─────────┘
                                      ▼
 ┌──────────────── [3] APP (Flutter + web) ───┐   HUMANO APROVA
 │ feed por nicho · aprovar/rejeitar · agendar  │   (decisão tua de [[Validação da tese]])
 └───────────────────────────────────┬─────────┘
                                      ▼
 ┌──────────────── [4] CONTEÚDO (Gemini) ─────┐   brand voice + compliance POR NICHO
 │ copy + criativo + hashtags por plataforma    │   (fitness: zero claims de saúde)
 │ + gera deep-link afiliado do programa certo  │
 └───────────────────────────────────┬─────────┘
                                      ▼
 ┌──────────────── [5] DISTRIBUIÇÃO ──────────┐   Telegram = canal que converte
 │ Telegram (auto, 1 canal/nicho ou chapéu)     │   IG = funil → landing própria
 │ Instagram → landing própria (links no feed   │   (resolve "links não clicáveis")
 │ não clicam) · landing centraliza tracking    │
 └───────────────────────────────────┬─────────┘
                                      ▼
 ┌──────────────── [6] ANALYTICS + CROSS-SELL ┐   cliques/conversões via APIs
 │ dashboard unificado (por nicho + cruzado)    │   de reporting (Awin, Amazon, brand)
 │ motor de bundles cross-nicho                 │   → otimiza o que se promove
 └──────────────────────────────────────────────┘
```

O mesmo pipeline [1]→[6] serve os três nichos; o que muda por nicho é **configuração** (fontes, threshold de score, brand voice, programa de afiliado, canal de saída).

---

## 🧩 Componentes detalhados

- **[1] Radar** — um *worker* por fonte (interface comum `fetchTrending(niche) → Product[]`). Keepa/histórico para validar que o "deal" é real. Cron + fila.
- **[2] Scoring** — função niche-agnostic: `score = w1·tendência + w2·desconto_real + w3·€venda_esperado`. Pesos por nicho (ex.: fitness valoriza recompra; casa valoriza AOV).
- **[3] App** — Flutter (mobile-first) + Next.js (web/landing) sobre uma API partilhada. Feed segmentado por nicho; aprovar gera o job de conteúdo.
- **[4] Conteúdo** — Gemini com `systemInstruction` **por nicho** (reaproveita o [[Pipeline conteúdo IA + GEO (Gemini → Sanity)]]). Structured output → copy/hashtags/alt-text. Insere o deep-link afiliado do programa correto.
- **[5] Distribuição** — Telegram Bot API (1 canal por nicho, ou 1 chapéu com tópicos). IG como funil para a landing própria. Landing = página por deal com link + disclosure + tracking.
- **[6] Analytics + cross-sell** — puxa conversões das APIs (Awin tem; Amazon tem). Motor de bundles liga produtos de nichos diferentes pelo perfil "setup".

## 🔌 Fontes & programas por nicho

| Nicho | Fontes de tendência | Programas afiliados (PT/UE) | €/venda |
|---|---|---|---|
| **Gaming** | Amazon best-sellers, Keepa, sinais sociais | **brand-direct** Razer (10%), Logitech (7%), Corsair, SteelSeries (6–12%) — *não* marketplace (1–4%) | ~€5–15 (alto no high-ticket) |
| **Casa** | Pinterest, Amazon casa, saldos | IKEA (5%), El Corte Inglés, Awin home | ~€20–40 (AOV alto) |
| **Fitness** | Amazon desporto, lançamentos | **Prozis (PT!)**, Myprotein (Awin 8–20%) | ~€4–12 + **recompra mensal** |

## 🗃️ Modelo de dados (essencial)

`Niche` · `Source` · `Product(niche, program, affiliateLink, priceHistory, score)` · `Post(product, channel, status: suggested|approved|published, content)` · `Channel(niche, platform)` · `Click`/`Conversion(program, value)` · `Bundle(products[], crossNiche)`.

## ⚠️ Compliance (por nicho)

- **Fitness:** **nunca** claims de saúde/medicinais (mesma linha "não é médico" do [[Cosmetics]]) — bem-estar/desempenho, não cura.
- **Todos:** divulgar afiliado (#ad), RGPD no tracking da landing, ToS Amazon (declarar canais, cookie 24h, fecho por 180d sem vendas), IG só funil (auto-post agressivo = risco de ban).

## 🛠️ Stack
Flutter (mobile) · Next.js (web/landing) · API + cron/fila + Postgres (Supabase) · Gemini (conteúdo/scoring) · Telegram Bot API · APIs de reporting Awin/Amazon/brand.

## 🚦 Fases (MVP → escala)
- **F0 — motor mínimo, 1 nicho:** radar de 1 fonte → score → app aprova → Gemini → **1 canal Telegram** + landing. Provar conversão (segue [[Validação da tese]]).
- **F1 — 2º e 3º nicho:** plugar fontes/programas/canais no mesmo motor (valida a "junção de infraestrutura").
- **F2 — cross-sell + chapéu lifestyle:** bundles cross-nicho + testar a marca "setup & bem-estar" se os nichos partilharem público.
- **F3 — analytics fechado:** conversões reais das APIs → otimizar score por €/venda efetivo.

## 🔗 Relacionado
[[Validação da tese]] · [[Pipeline conteúdo IA + GEO (Gemini → Sanity)]] · [[Estudo - IA na Gestão de Dropshipping]] · [[Cosmetics]]
