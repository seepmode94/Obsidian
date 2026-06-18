---
tags: [cosmetics, ebeauty, chat-ia, gemini, ai-sdk]
atualizado: 2026-06-17
---

# EBeauty — Chat-IA (assistente de beleza)

> Ver [[Ponto de situação]]. Consultora de cosmética dentro da loja, numa bolha flutuante.

## O que é

Bolha de chat flutuante em **todas as páginas** (montada em `app/layout.tsx`) — uma "consultora de beleza" que:
- Conversa **só sobre cosmética** (guard-rails); recusa off-topic com jeito e reconduz.
- Recomenda **produtos reais do catálogo** (Sanity), em **cartões com foto + link** para `/produtos/<slug>`.
- **Analisa a pele por foto** (botão 📸) com consentimento RGPD — **sem guardar** a imagem.
- Tom **girly em PT-PT**, visual **estilo iMessage** (balões rosa/cinza), e **notificação proativa** ~9s depois de navegar (1x por sessão, `sessionStorage`).

## Stack / modelo

- **Vercel AI SDK v6:** `ai`, `@ai-sdk/react` (`useChat`), `@ai-sdk/google`, `zod`.
- **Provider: Google Gemini** (`gemini-2.5-flash`) via `@ai-sdk/google` — key **própria** do user, **tier PAGO** (no free tier a Google pode usar as fotos para treino → incompatível com RGPD; só por isso a câmara avançou).
- **Env var:** `GOOGLE_GENERATIVE_AI_API_KEY` — em `.env.local` (gitignored) e nas Env Vars **Production** do Vercel.
- ⚠️ A memória do modelo sobre o AI SDK é **stale** — confirmar APIs em `node_modules/ai/docs/` antes de escrever código.

## Ficheiros

- `app/api/chat/route.ts` — POST; `streamText` + `google('gemini-2.5-flash')` + `stopWhen: stepCountIs(5)` + `toUIMessageStreamResponse()`. Faz fetch do catálogo (`getAllProducts`) e injeta-o no system prompt.
- `lib/ai/system-prompt.ts` — `buildSystemPrompt(catalog)`: regras (só cosmética, sem diagnóstico, foto estética não-médica) + lista do catálogo com **slugs** + tom girly.
- `lib/ai/tools.ts` — tool `recommendProducts({ slugs })` → devolve os produtos reais (nome, marca, preço, **foto** via CDN Sanity `?w=200&auto=format`, link, stock).
- `app/components/ChatWidget.tsx` — `"use client"`, `useChat`, bolha + painel iMessage, teaser, botão 📸 + gate de consentimento + `<input type=file accept=image/* capture=user>`, render de texto / foto / cartões.
- `app/globals.css` — keyframe `fadeIn` (entrada do teaser).

## Recomendação (anti-alucinação)

1. O catálogo (4 produtos) vai no **system prompt** com os slugs.
2. A IA escolhe e chama `recommendProducts({ slugs })`.
3. A tool devolve os dados reais → **cartões com foto**, alinhados ao texto. `stopWhen: stepCountIs(5)` deixa a IA escrever a recomendação **depois** da tool.

## Câmara / análise de pele

- 📸 → consentimento (foto **não guardada**, análise **estética**, **não** substitui médico) → abre câmara no telemóvel / seletor no desktop.
- Imagem enviada via `useChat` `sendMessage({ text, files })` → **Gemini multimodal**. A foto aparece como balão na conversa. **Nada é persistido** (processada em memória, enviada, descartada).
- Guard-rail confirmado: com imagem que não é pele, pede uma foto adequada e **não** diagnostica.

## Verificado ao vivo (17/06)

- "pele seca" → ADEUS + PDRN (cartões). "manchas" → TXA Niacinamide. Off-topic → recusa. "borbulha com pus" → sem diagnóstico, encaminha a dermatologista. Foto (~5 MB) → `POST /api/chat` 200, Gemini vê a imagem.

## ⚠️ Pendente

- **Deploy:** o chat **ainda não está online** — o Vercel deploya por **CLI** (`vercel --prod`), não está ligado ao git, por isso o push para o GitHub **não** deploya. Env var já está no Vercel; falta correr o deploy. → [[Deploy (Vercel)]]
- 🔒 **Rodar a API key do Gemini** — esteve em texto no chat (não foi para o git, mas convém).
- **Ideias futuras:** filtro de "ativos" funcional na homepage; resize client-side da foto antes de enviar (payload mais leve); ligar Vercel↔GitHub para auto-deploy a cada push.
