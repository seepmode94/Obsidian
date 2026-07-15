# Construir Apps a Solo que Geram Dinheiro

**Resumo do vídeo** *"How I Build Apps SOLO That ACTUALLY Make Money in 2026"*

| | |
|---|---|
| **Canal** | Erik Cupsa (ex-engenheiro da Amazon, 22 anos) |
| **Duração** | 8:51 |
| **Publicado** | 15-06-2026 |
| **Link** | https://www.youtube.com/watch?v=KKWS0bSiCT4 |
| **Nota criada** | 15-07-2026 |

---

## Sumário executivo

O autor construiu em **23 dias** uma app de geração e revisão de currículos com IA que, 4 meses depois, faz **1.400 $/mês de receita recorrente** (16.500 $ acumulados) — sem tocar no código nem fazer marketing desde o lançamento. O vídeo é o playbook dele em 4 passos: escolher a ideia (copiando o que já dá dinheiro), construir com um stack simples, blindar a app, e — a parte onde diz que 99% falham — a distribuição.

---

## 1. Escolher a ideia — "a originalidade morreu"

- **Ideias não valem nada em 2026** — com IA, construir ficou fácil; o que vale é **shipar depressa**;
- Não inventar: **replicar o que já está validado**. Duas fontes:
  - **YC Requests for Startups** — a Y Combinator publica os problemas que quer ver resolvidos (ideia pré-validada);
  - **TrustMRR** — lista apps existentes com a receita que fazem; escolher uma que interesse e replicar (foi assim que ele escolheu a dele);
- "Já existe" não é objeção: o Zoom não impediu o Google Meet; como solo dev basta **capturar uma fatia minúscula** de um mercado que já existe;
- Critério de escolha: a ideia tem de estar ligada a uma **dor humana real** (tracking de calorias, procura de emprego) — é isso que garante que as pessoas pagam.

## 2. Construir — o stack recomendado

Antes de tudo: mesmo com no-code (Lovable, Replit), defende que é preciso perceber o básico de programação. Percurso de aprendizagem sugerido: **JavaScript primeiro** (crash course da freeCodeCamp) → **Full Stack Open** para aprender por projetos (rotas de React, Node e React Native).

| Camada | Escolha dele |
|---|---|
| Web app | **Next.js**, hosting no **Vercel** |
| App mobile | **React Native + Expo**, só iOS — "o poder de compra no Android é tão baixo que é irrelevante" |
| Base de dados | **Supabase** (tier grátis generoso) |
| Autenticação | **Clerk** ou Firebase |
| Pagamentos | **Stripe** |
| Ferramentas de dev | **Warp** (terminal IA) + **Claude Code** para "basicamente todo o desenvolvimento" |

## 3. Blindar a app antes de escalar

- **Rate limits** nos endpoints de login, signup e IA (evitar spam/abuso);
- Autenticação com provider a sério (Clerk/Firebase), não caseira;
- **Row-level security** na base de dados — cada utilizador só vê os dados dele;
- **Nunca expor API keys no frontend** — sempre server-side em variáveis de ambiente;
- Ao escalar: cache de pedidos repetidos com **Redis**, tarefas pesadas (emails, pedidos de IA, parsing de PDFs) em **jobs assíncronos**, e **load testing** antes do lançamento.

> "Shipar a app é uma coisa; garantir que não se desmorona quando os utilizadores a usam é a parte mais importante."

## 4. Distribuição — "o verdadeiro fosso competitivo"

É aqui que 99% falham: em 2026 construir não é difícil, **distribuir é**. O playbook dele para os primeiros 1.000 utilizadores:

1. **UGC é rei** — publicar vídeos curtos nas redes sociais próprias;
2. **Não tentar ser original no marketing**: ir ao TikTok, encontrar os vídeos virais do nicho, **copiá-los com um twist próprio** e mudar o call-to-action para a app dele (um vídeo copiado de um concorrente deu-lhe 117.000 visualizações e 900 registos);
3. Para quem não quer aparecer na câmara:
   - Pagar a **micro-influencers** (1.000-10.000 seguidores do nicho) 30-50 $ por vídeo curto;
   - Ou criar **slideshows sem rosto** a mostrar a app em situações reais;
4. Quando um vídeo funciona, **amplificar com ads**: 30-50 $ em TikTok Ads / Meta Ads a impulsionar o vídeo vencedor. Nas contas dele: por cada 50 $ gastos, ~130 $ de retorno — **repetir até deixar de ser lucrativo**;
5. Marketing é um jogo de números: cabeça baixa e continuar.

---

## Nota crítica (minha, não do vídeo)

Os números da app dele não são verificáveis e o vídeo tem um segmento patrocinado (JetBrains/Kotlin, que ignorei por ser publicidade). Dois pontos discutíveis: descartar Android por completo é uma opinião polémica (válida talvez para apps de subscrição no mercado americano, menos na Europa), e o ROI de 130 $ por 50 $ em ads é o melhor caso dele, não uma expectativa realista. A parte mais sólida e reutilizável é a secção 3 (hardening) — é uma checklist técnica correta — e a lógica de validar ideias com TrustMRR/YC em vez de inventar do zero.

---
*Índice do tema: [[Negócios com IA (índice)]]*
