---
tags: [cosmetics, ebeauty, agencia, upsells, apis, ideias]
atualizado: 2026-06-18
status: ideias
---

# Upsells e APIs (cosmética)

> [!info] Origem
> Ideias a partir do vídeo do canal **"o Matheus da IA"** ("Use essas APIs grátis para ganhar dinheiro em 2026"). **Tese:** não vendes a API — vendes **o resultado e a poupança de tempo** a um **nicho específico**.

> [!tip] Leitura disciplinada
> Isto **não são negócios novos** — são um **menu de upsells** para pôr por cima da avença que já tens ([[Modelo de negócio e planos (avença)]]). Mais extras faturáveis + razões para subir clientes de plano. **Não disperses:** o foco é cosmética + EBeauty.

> 🔗 [[Modelo de negócio e planos (avença)]] · [[Custos e margem (EBeauty)]] · [[Ponto de situação]]

---

## Os 4 critérios de um bom micro-produto

1. **Resolver algo chato** (automatizar tarefas manuais de um nicho).
2. **Entrada barata/grátis** (tier grátis para validar sem custo).
3. **Custo que escala com o uso** (só pago mais quando o cliente paga mais).
4. **Contexto de nicho** (a tecnologia é commodity; o valor está em aplicá-la à regra de negócio do cliente).

> Já cumpro estes 4 com a consultora IA (Gemini): nicho cosmética, tier grátis→pago, custo repassado, valor na aplicação. **Estou dentro da tese.**

---

## As APIs, mapeadas ao meu caso

| API           | O que faz                              | Encaixe na cosmética                                                                               | Prioridade                  |
| ------------- | -------------------------------------- | -------------------------------------------------------------------------------------------------- | --------------------------- |
| **Firecrawl** | scraping → dados limpos p/ LLM         | **Monitor de preços da concorrência** (avisa quando concorrentes mudam preços dos mesmos produtos) | 🟢 alta                     |
| **Ayrshare**  | publicar/agendar redes sociais via API | **Redes sociais no automático** (cria + agenda posts do mês)                                       | 🟡 ideia boa, provider caro — ver alternativas (bundle.social/Postiz/Mixpost) |
| **bundle.social** | publicar/agendar + analytics/comentários via API (REST + SDK TS + CLI + MCP) | mesmo upsell **Redes sociais no automático**, multi-cliente numa só conta | 🟢 alta — **contas sociais ilimitadas** + tier grátis |
| **Exa**       | busca inteligente p/ IA                | (1) tendências/SEO de cosmética p/ conteúdo · (2) **encontrar clientes-alvo** p/ a minha agência   | 🟡 média                    |
| **Deepgram**  | transcrição/voz                        | atendente telefónico p/ clínicas — **outro nicho**                                                 | 🔴 parar (objeto brilhante) |

### 🟢 Firecrawl — Monitor de preços da concorrência
Upsell limpo para a EBeauty: alerta a dona quando um concorrente mexe no preço dos mesmos produtos (Medicube, etc.).
⚠️ **Scraping tem zonas cinzentas de ToS/legalidade** — usar com bom senso, respeitar `robots.txt`/termos.

### 🟢 Ayrshare — Redes sociais no automático
Resolve um problema que a EBeauty **já tem**: os ícones de Instagram/Facebook/TikTok no rodapé estão **mortos** (`href="#"`). Pequenos negócios penam com social. Modelo: a dona responde a 3 perguntas/mês → o sistema cria e agenda os posts. **Add-on ou tier premium.**

> 📖 **Docs (quickstart):** https://www.ayrshare.com/docs/quickstart

> [!warning] Ayrshare NÃO é grátis (verificado 2026-06-18)
> O **código do demo** ([social-api-demo](https://github.com/ayrshare/social-api-demo)) é **MIT/grátis**, mas o **serviço não tem tier grátis**: começa em **$149/mês (1 perfil social)**; multi-perfil $299–599/mês. A **$149/perfil NÃO dá para revender** a uma loja pequena (perdias dinheiro). Só compensa **à escala** (Business ~$20/perfil em 30 perfis).
>
> **Alternativas para o upsell:** **bundle.social** (cloud, abaixo) — recomendado; self-hosted no VPS — **Postiz** ou **Mixpost** (custo fixo, clientes ilimitados, encaixa no modelo de agência); ou **manual** no 1º cliente. A **ideia** mantém-se 🟢 — muda o **provider**.

### 🟢 bundle.social — alternativa cloud ao Ayrshare
API unificada de redes sociais (publicar/agendar + analytics + comentários) com **REST API, SDK TypeScript, CLI e servidor MCP** (integra direto com agentes IA tipo Claude). Encaixa no mesmo upsell **Redes sociais no automático** sem ter de gerir VPS (ao contrário do Postiz/Mixpost).

> 🌐 **Site/API:** https://bundle.social/

- **Plataformas:** TikTok, Instagram, Facebook, YouTube, LinkedIn, X, Pinterest, Reddit, Threads, Bluesky, Mastodon, Google Business, Discord, Slack.
- **Multi-cliente:** **contas sociais ilimitadas** sem custo por conta (pensado para agências/multi-tenant) — resolve a dor do Ayrshare ($149/perfil).

> [!note] Preços (verificado 2026-06-19)
> - **Free:** $0/mês — 20 posts/mês, 50 comentários/mês, **3 contas sociais** → bom para validar/POC na EBeauty.
> - **Pro:** **$100/mês por organização** — 10.000 posts/mês, 5.000 comentários, **contas ilimitadas**.
> - **Business:** $400/mês — 100.000 posts/mês.
> - **Enterprise:** sob orçamento.
>
> **Leitura de margem:** ao contrário do Ayrshare (paga-se por perfil), aqui o custo é **fixo por organização**. Com **vários clientes no mesmo Pro ($100/mês)**, o custo por cliente desce com a escala → coerente com o modelo de agência. Com 1 cliente, o tier **Free** chega para arrancar/validar antes de pagar.

### 🟡 Exa — duplo uso
1. Tendências e SEO de cosmética para alimentar conteúdo da loja.
2. **Meta-uso:** procurar **outras lojas de cosmética/parafarmácia em PT** para prospeção da minha agência.

### 🔴 Deepgram — parar
Boa ideia (atender chamadas perdidas de clínicas), mas é **outro nicho**. Anotar e não perseguir agora.

---

## O encadeamento (chaining) que faz sentido para mim

> **Exa** (tendências de cosmética) → **Gemini** (escreve post/dica no tom da marca) → **Ayrshare** (publica no Instagram da loja)

Reutiliza a IA que **já tenho**, dá presença social à loja, e é um **upsell premium difícil de copiar**. Quanto mais elos, mais difícil de copiar — mas o **moat real é a relação**, não a corrente.

---

## Execução (igual ao que já decidimos)

1. Escolher **1** API (sugestão: **Firecrawl** ou **Ayrshare**, que encaixam já).
2. Fazer **manual** a 1ª vez — não programar um sistema complexo antes de ter cliente.
3. **Vender** a um cliente (a EBeauty é o 1º candidato).
4. Só depois **automatizar** + produtizar (add-on no pacote / tier).

> Mesmo conselho do sistema de billing ([[Sistema de gestão de clientes (billing + kill-switch)]]): **manual primeiro, vende antes de automatizar.**

---

## ⚠️ Cuidados

- **Objeto brilhante:** 4 APIs = 4 tentações. Tens **uma** linha com tração (cosmética). Escolhe 1–2 que encaixem, ignora o resto.
- **"Grátis" é para validar** — a tier grátis acaba; ao escalar pagas. Mesma lógica de custo repassado de sempre.
- **Scraping (Firecrawl):** cuidado legal/ToS.
- **O moat é a relação + o produto que funciona**, não a API.

---

## 📺 Para ver depois

- **"Make Money from your API Tutorial"** — https://www.youtube.com/watch?v=MbqSMgMAzxU
  Ângulo **diferente**: monetizar a **minha própria API** (construir + cobrar), não usar APIs alheias. Encaixa na tese de **produtizar o motor** a longo prazo (ex.: expor a consultora IA de beleza, ou o motor "loja+IA", como produto). ⚠️ Direção **futura** — não desviar do foco cosmética/EBeauty agora.

---

## ❓ Decisões em aberto

- [ ] Qual atacar primeiro: **Firecrawl** (preços) ou **Ayrshare** (social)?
- [ ] Preço dos add-ons (€/mês) + limite de uso + setup inicial.
- [ ] Validar com a EBeauty se paga por um destes antes de automatizar.
- [ ] Onde entram: add-on à avença vs novo tier premium.
