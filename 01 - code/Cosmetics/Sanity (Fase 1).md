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

## ✅ FASE 2 — MIGRAÇÃO mock → Sanity CONCLUÍDA (17/06/2026)

Homepage e página de produto leem agora do Sanity (verificado: HTTP 200, imagens do CDN, 404 em slug inexistente).

- `lib/products.ts` — passou a conter **só** tipos/constantes/helpers puros (seguro em client components). Removidos o array `PRODUCTS` e o `getProductBySlug` sync. `Product.category` agora é `string` (categorias dinâmicas).
- `lib/queries.ts` (novo, server-only) — fetchers GROQ: `getAllProducts`, `getProductBySlug`, `getProductSlugs`, `getOtherProducts`. Projeção resolve `brand->name`, `category->name`, `photos[0].asset->url`, `coalesce(photoHue,"warm")`.
- `app/page.tsx`, `app/produtos/[slug]/page.tsx` — async + `export const revalidate = 30` (ISR). `generateStaticParams` vem dos slugs do Sanity. `RelatedProducts` async.
- Schema `product` ganhou campo opcional **`photoHue`** (dropdown, fallback visual).
- **Seed:** `sanity/seed.mjs` (idempotente, `createOrReplace` com `_id`s tipo `product.<slug>`). Correr: `node --env-file=.env.local sanity/seed.mjs`. Semeou 4 categorias, 6 marcas, 8 produtos, storeSettings + upload de 3 imagens (`public/produtos/`). Adicionado `@sanity/client` como dep direta (pnpm não hoista transitivas).

### ⚠️ Gotcha grande: leitura precisa de TOKEN (novo modelo RBAC)

Mesmo com o dataset `aclMode: public`, a **leitura anónima devolve 0 documentos** (testado com `perspective=raw/published`; com token devolve 8). Este projeto usa o novo modelo de acesso por grupos do Sanity (`_.groups.public` sem grant de leitura). **Fix:** o read client usa um **token de leitura (role `viewer`)** no servidor → `SANITY_API_READ_TOKEN` no `.env.local`; `sanity/lib/client.ts` com `useCdn: false` + `token`. O token é server-side, nunca chega ao browser. Há também `SANITY_API_TOKEN` (role `editor`) para o seed.

### ⚠️ Gotcha: Studio em branco no telemóvel (dev via IP)

Abrir `http://192.168.0.124:3000/studio` no telemóvel dava **ecrã em branco** (só o fallback `<noscript>`). Causa: o **Next 16 bloqueia por defeito recursos internos de dev** (`/_next/*`, HMR) vindos de origens não-localhost → o JS do Studio (SPA) não arranca. (Não era do telemóvel: reproduzia em qualquer browser via IP; via `localhost` funcionava.) **Fix:** `allowedDevOrigins: ["192.168.0.124"]` em `next.config.ts` + reiniciar o dev server. Só afeta `next dev` — em produção não existe. Se o IP da WiFi mudar, atualizar lá (e nos CORS do Sanity).

## ⏭️ Pendente

- Ligar `storeSettings` ao rodapé/legal e ao **nº de WhatsApp** (substituir placeholder `STORE.whatsappDigits` em `lib/products.ts`).
- Tornar os cards da homepage clicáveis (→ `/produtos/[slug]`) e ligar os botões "Adicionar" ao carrinho.
- Convidar o vendedor (Sanity → Members → Invite) + cheat sheet.

## 📝 Notas

- Para criar/gerir o projeto sem o CLI, dashboard em https://www.sanity.io/manage (Project ID `0qopudd2`).
- ADR-0002 = Sanity + Netlify; ADR-0003 = modelo PRODUTO (vendedor autónomo); ADR-0004 = multi-marca sem variantes.
