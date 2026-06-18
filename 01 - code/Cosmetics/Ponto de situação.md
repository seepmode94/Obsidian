---
tags: [cosmetics, ebeauty, estado, handoff]
atualizado: 2026-06-17
---

# EBeauty — Ponto de situação (continuar aqui)

> 📌 **Começar por aqui.** Repo: `~/Documentos/Projects/Vendas`.
> Notas detalhadas: [[EBeauty - Catálogo (projeto Vendas)]] · [[Direções de design (protótipo)]] · [[Páginas legais]] · [[Sanity (Fase 1)]] · [[Carrinho + checkout (Fase 4-5)]] · [[Deploy (Vercel)]] · [[Chat-IA (assistente de beleza)]]
>
> 🌐 **LIVE:** https://ebeauty-pt.vercel.app · **Studio/Admin:** https://ebeauty-pt.vercel.app/studio

## ✅ Onde estamos (17/06/2026)

- **Sanity (Fase 1) CONCLUÍDA e verificada** — Studio embebido a funcionar em `http://localhost:3000/studio` (HTTP 200). Projeto Sanity criado: **Project ID `0qopudd2`**, dataset `production` (público), CORS de localhost configurado. Deps instaladas (`sanity@6`, `next-sanity@13`, etc.). `.env.local` preenchido. Detalhes + gotcha do `"use client"` → [[Sanity (Fase 1)]].
- **Design B2 "Apple-modern"** é a homepage real (`app/page.tsx`); acento teal `#0d9488`. Mobile-first.
- **Páginas legais** prontas (`/termos-e-condicoes`, `/privacidade`, `/envios-e-devolucoes`, `/avisos-legais`) + banner cookies + rodapé legal. Dados em `lib/legal.ts` (placeholders "(a definir)").
- **Migração mock → Sanity CONCLUÍDA** — homepage e página de produto leem do Sanity via GROQ (`lib/queries.ts`), com ISR (`revalidate = 30`). Catálogo semeado via `sanity/seed.mjs` e depois **limpo para 4 produtos reais** (Medicube TXA / PDRN / Azelaic + ADEUS Tratamento), removidos 5 de exemplo + 4 marcas órfãs. Imagens servidas pelo CDN do Sanity. ⚠️ Leitura precisa de **token** (`SANITY_API_READ_TOKEN`) — novo modelo RBAC; detalhes → [[Sanity (Fase 1)]].
- **Carrinho + checkout CONCLUÍDO** — Zustand + persist (localStorage), drawer lateral, `CartButton` com badge nos headers, "Adicionar ao pedido" ligado, checkout por **WhatsApp/email** com a mensagem do pedido. Verificado end-to-end. → [[Carrinho + checkout (Fase 4-5)]]
- **DEPLOY no Vercel CONCLUÍDO** — live e público em **https://ebeauty-pt.vercel.app** (homepage, produto, `/studio`, legais — todas 200). Env vars + CORS + protection tratados. → [[Deploy (Vercel)]]
- **Catálogo limpo + filtro** — reduzido a **4 produtos reais** (todos com foto); filtro de categorias da homepage agora **funcional** e esconde categorias vazias (`app/components/Catalog.tsx`).
- **Chat-IA (assistente de beleza) CONCLUÍDO** — bolha flutuante estilo iMessage, tom girly, guard-rails (só cosmética, sem diagnóstico), recomenda produtos reais com cartões (foto + link) e **análise de pele por foto** (📸 + consentimento RGPD, Gemini multimodal, sem guardar). Provider **Gemini** tier pago. ⚠️ **Ainda NÃO deployado** (falta `vercel --prod`). → [[Chat-IA (assistente de beleza)]]
- **Git: commitado e no GitHub** — repo **privado** novo `github.com/seepmode94/ebeauty` (remote `origin`). Commit `35e1026` (loja + catálogo + filtro + chat texto) **pushed**; `d95452c` (análise de pele por foto) committed mas **ainda não pushed**. `.env.local` (tokens Sanity + key Gemini) gitignored. GOTCHA: o classificador do Claude Code bloqueia o agente de criar remoto/fazer push → foi o user a correr `gh repo create ebeauty --private --source=. --remote=origin --push`.

## ▶️ Retomar o ambiente

```bash
cd ~/Documentos/Projects/Vendas
pnpm dev
# Computador: http://localhost:3000   ·   Studio: http://localhost:3000/studio
# Telemóvel (mesma WiFi): http://192.168.0.124:3000
```

## ⏭️ Próximos passos (por ordem)

1. **[Deploy] Pôr o chat-IA online** — `git push` (falta o commit `d95452c`) + `vercel --prod`. A env var `GOOGLE_GENERATIVE_AI_API_KEY` já está no Vercel. (Ou ligar Vercel↔GitHub para auto-deploy a cada push.) → [[Chat-IA (assistente de beleza)]]
2. 🔒 **[Segurança] Rodar a API key do Gemini** — esteve em texto no chat (não foi para o git).
3. **[Sanity] Ligar `storeSettings`** ao rodapé/legal, ao **nº de WhatsApp** e **email** (substituir placeholders `STORE.whatsappDigits` / `STORE.email` em `lib/products.ts`).
2. **[Design] Alinhar a página de produto** (`/produtos/...`) com a B2 — ainda no design antigo (cream/coral); o drawer usa tokens cream/coral.
5. **[Legal] Preencher dados reais** em `lib/legal.ts`: NIF, morada, email, nº WhatsApp, prazos/custos de envio, pagamento. Selo oficial do Livro de Reclamações. **Revisão jurídica.** → [[Páginas legais]]
6. **[Qualidade] Fotografia consistente** dos 8 produtos (mesmo fundo/luz/enquadramento).
7. *(opcional)* **Commit** do trabalho.

## 🔒 Decisões fixadas

- Direção visual **B2 + acento teal** · Modelo de negócio **PRODUTO** · Fecho por **WhatsApp** (site não processa pagamento) · Multi-marca **sem variantes de cor** (ADR-0004).
- **Gestão do catálogo no Studio em desktop**; telemóvel só para ver. (Sanity Studio é desktop-first; editar/publicar em mobile não é fiável. Backend/permissões verificados OK — não é bug nosso. Decisão 17/06: não construir admin mobile próprio por agora.)

## ⚠️ Notas técnicas

- **Next.js 16** tem breaking changes — consultar `node_modules/next/dist/docs/` antes de escrever código (ver `AGENTS.md`). `params` é agora **async** (Promise).
- **Studio:** o `sanity.config.ts` precisa de `"use client"` (senão `/studio` dá 500 com `createContext` em Turbopack).
