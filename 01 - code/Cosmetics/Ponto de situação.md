---
tags: [cosmetics, ebeauty, estado, handoff]
atualizado: 2026-06-17
---

# EBeauty — Ponto de situação (continuar aqui)

> 📌 **Começar por aqui.** Repo: `~/Documentos/Projects/Vendas`.
> Notas detalhadas: [[EBeauty - Catálogo (projeto Vendas)]] · [[Direções de design (protótipo)]] · [[Páginas legais]] · [[Sanity (Fase 1)]] · [[Carrinho + checkout (Fase 4-5)]] · [[Deploy (Vercel)]]
>
> 🌐 **LIVE:** https://ebeauty-pt.vercel.app · **Studio/Admin:** https://ebeauty-pt.vercel.app/studio

## ✅ Onde estamos (17/06/2026)

- **Sanity (Fase 1) CONCLUÍDA e verificada** — Studio embebido a funcionar em `http://localhost:3000/studio` (HTTP 200). Projeto Sanity criado: **Project ID `0qopudd2`**, dataset `production` (público), CORS de localhost configurado. Deps instaladas (`sanity@6`, `next-sanity@13`, etc.). `.env.local` preenchido. Detalhes + gotcha do `"use client"` → [[Sanity (Fase 1)]].
- **Design B2 "Apple-modern"** é a homepage real (`app/page.tsx`); acento teal `#0d9488`. Mobile-first.
- **Páginas legais** prontas (`/termos-e-condicoes`, `/privacidade`, `/envios-e-devolucoes`, `/avisos-legais`) + banner cookies + rodapé legal. Dados em `lib/legal.ts` (placeholders "(a definir)").
- **Migração mock → Sanity CONCLUÍDA** — homepage e página de produto leem do Sanity via GROQ (`lib/queries.ts`), com ISR (`revalidate = 30`). Catálogo semeado (8 produtos + marcas + categorias + imagens) via `sanity/seed.mjs`. Imagens servidas pelo CDN do Sanity. ⚠️ Leitura precisa de **token** (`SANITY_API_READ_TOKEN`) — novo modelo RBAC; detalhes → [[Sanity (Fase 1)]].
- **Carrinho + checkout CONCLUÍDO** — Zustand + persist (localStorage), drawer lateral, `CartButton` com badge nos headers, "Adicionar ao pedido" ligado, checkout por **WhatsApp/email** com a mensagem do pedido. Verificado end-to-end. → [[Carrinho + checkout (Fase 4-5)]]
- **DEPLOY no Vercel CONCLUÍDO** — live e público em **https://ebeauty-pt.vercel.app** (homepage, produto, `/studio`, legais — todas 200). Env vars + CORS + protection tratados. → [[Deploy (Vercel)]]
- ⚠️ **Tudo por commitar** no git (último commit = migração para pnpm). `.env.local` (com tokens) está gitignored — não commitar.

## ▶️ Retomar o ambiente

```bash
cd ~/Documentos/Projects/Vendas
pnpm dev
# Computador: http://localhost:3000   ·   Studio: http://localhost:3000/studio
# Telemóvel (mesma WiFi): http://192.168.0.124:3000
```

## ⏭️ Próximos passos (por ordem)

1. **[Sanity] Ligar `storeSettings`** ao rodapé/legal, ao **nº de WhatsApp** e **email** (substituir placeholders `STORE.whatsappDigits` / `STORE.email` em `lib/products.ts`).
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
