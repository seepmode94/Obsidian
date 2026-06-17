---
tags: [cosmetics, ebeauty, sanity, cms]
atualizado: 2026-06-17
---

# EBeauty — Sanity (Fase 1)

> Ver [[EBeauty - Catálogo (projeto Vendas)]]. Objetivo: substituir o catálogo hardcoded
> (`lib/products.ts`) por **Sanity**, dando ao vendedor um **Studio em `/studio`** para gerir
> produtos, stock, marcas e definições — sem código nem deploy.

## ✅ FASE 1 CONCLUÍDA E VERIFICADA (17/06/2026)

O Studio embebido **carrega em `http://localhost:3000/studio` (HTTP 200)**, pronto para login e criação de produtos.

**Dependências instaladas:** `sanity@6`, `next-sanity@13`, `@sanity/vision@6`, `@sanity/image-url@2`, `styled-components@6`.

**Projeto Sanity criado** (via API de gestão, após `sanity login`):
- **Project ID: `0qopudd2`** · Organização `o8SvRc9Li` (criada automaticamente)
- **Dataset `production`** (público — o catálogo lê via CDN sem token)
- **CORS:** `http://localhost:3000` (com credenciais) + `localhost:3333`

**Ficheiros escritos:**
- `sanity/env.ts` — projectId/dataset/apiVersion a partir de env vars (erro claro se faltar)
- `sanity/lib/client.ts` — client de leitura (`useCdn: true`)
- `sanity/lib/image.ts` — helper `urlFor()` (usa o **named export** `createImageUrlBuilder`; o default está deprecated)
- `sanity/structure.ts` — sidebar do Studio; **`storeSettings` é singleton** (abre direto, sem lista)
- `sanity.config.ts` — `defineConfig` (basePath `/studio`, structureTool + visionTool). **Tem `"use client"` no topo** (ver gotcha abaixo)
- `app/studio/[[...tool]]/page.tsx` — rota embebida, Server Component, `export const dynamic = "force-static"`, re-exporta `metadata`/`viewport` de `next-sanity/studio`
- `.env.local` — `NEXT_PUBLIC_SANITY_PROJECT_ID=0qopudd2`, dataset `production`, apiVersion `2024-10-01` (não vai para git, `.env*` ignorado)

Schemas (já existiam): `product`, `brand`, `category`, `storeSettings` em `sanity/schemas/` (objetos puros; em `sanity.config.ts` há um cast `as SchemaTypeDefinition[]` até os envolvermos em `defineType`).

## ⚠️ Gotcha resolvido (Next 16 + Turbopack)

`/studio` deu **500: `createContext only works in Client Components`** (vindo de `@sanity/ui`). Causa: o `sanity.config.ts` era avaliado no **servidor** (a página importa-o). **Fix:** `"use client"` no topo de `sanity.config.ts` → o grafo do Sanity só avalia no browser; a página continua Server Component (pode re-exportar `metadata`/`viewport`). Padrão confirmado no doc-comment do próprio `next-sanity@13`.

## ⏭️ A seguir (Fase 2 — ligar os dados)

1. **Migrar `lib/products.ts` mock → GROQ** usando o `client`: homepage e página de produto passam a fazer fetch real (server component + ISR, `revalidate` curto → stock propaga em ~1s).
2. **Semear** os 8 produtos atuais + marcas + categorias no Sanity (ou criar à mão no Studio).
3. Ligar `storeSettings` ao rodapé/legal e ao **nº de WhatsApp** (substituir o placeholder `STORE.whatsappDigits`).
4. Convidar o vendedor (Sanity → Members → Invite) + cheat sheet.

## 📝 Notas

- Para criar/gerir o projeto sem o CLI, dashboard em https://www.sanity.io/manage (Project ID `0qopudd2`).
- ADR-0002 = Sanity + Netlify; ADR-0003 = modelo PRODUTO (vendedor autónomo); ADR-0004 = multi-marca sem variantes.
