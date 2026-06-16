---
tags: [projeto, cosmetics, ebeauty, nextjs, sanity, ecommerce]
status: em desenvolvimento
repo: ~/Documentos/Projects/Vendas
---

# EBeauty — Catálogo de cosmética (projeto `Vendas`)

> Código em `~/Documentos/Projects/Vendas/`. Loja: **EBeauty** — _"Cosmética. Cuidado. Coração."_
> Nota: este é o **catálogo e-commerce real**. A app de análise de pele com IA é uma *ideia/feature separada* — ver [[Cosmetics]].

## 🎯 O que é

Catálogo de **parapharmácia/cosmética multi-marca**, mobile-first e responsivo. O **Cliente** (anónimo, sem conta) navega produtos de várias marcas, monta um **Carrinho** local, e finaliza o **Pedido fora do site** via **WhatsApp** (principal) ou **email** (fallback). O **Admin** (dono da loja) gere o catálogo via **Sanity Studio** em `/studio`.

**O site NÃO faz**: checkout, pagamento, cálculo de portes, nem guarda encomendas. Stock, pagamento e entrega resolvem-se todos no WhatsApp.

## 💼 Modelo de negócio — PRODUTO (não serviço)

Entrega-se um site + painel admin que o dono opera sozinho. Pagamento de **setup único**; manutenção pós-entrega só por pedido pontual (cobrada à parte). Codebase desenhada como **template reaproveitável**: cada cliente novo = fork + novo Sanity project + nova paleta. (Ver ADR-0003.)

## 🧱 Stack

| Camada | Tecnologia |
|---|---|
| Frontend | **Next.js 16.2.6** (App Router), React 19 |
| Estilo | **Tailwind CSS 4** |
| Linguagem | TypeScript |
| Package manager | **pnpm** (10.32.1) |
| CMS / BD | **Sanity** (Free) — embebido em `/studio` *(planeado, Fase 1)* |
| Hosting | **Netlify** |
| Locale / moeda | PT-PT / EUR (€) |

> ⚠️ `AGENTS.md` avisa: este Next.js (16) tem breaking changes — consultar `node_modules/next/dist/docs/` antes de escrever código.

## 🗣️ Domínio (glossário — ver `CONTEXT.md`)

- **Cliente** — visitante anónimo que navega e monta carrinho (sem login).
- **Admin** — dono da loja; único papel autenticado; gere tudo no Studio.
- **Marca** — multi-marca (Medicube, Tangle Teezer, ADEUS, Klorane, Nuxe, René Furterer…).
- **Produto** — item único (sem variantes de cor); 1 preço, 1 stock, 1 Marca, 1 Categoria. Opcionais: `sku`, `destaque`, `metaTitle/Description`, `hideWhenOutOfStock`.
- **Categoria** — flat, sem subcategorias: **Rosto, Cabelo, Corpo, Banho**.
- **Stock** — inteiro, **informativo não bloqueante**: pode encomendar com stock 0 (salvo `hideWhenOutOfStock`). Avisos: "últimas unidades" (1–3), "esgotado" (0).
- **Promoção** — `priceSale` + `onSaleUntil`; mostra preço riscado até à data.
- **Destaque** — boolean → aparece no hero.
- **Carrinho** — só `localStorage` do Cliente (não persiste no servidor). Label customer-facing: **"Adicionar ao pedido"**.
- **Pedido** — mensagem gerada do carrinho → WhatsApp/email. **Não é entidade do sistema.**

## 🎨 Identidade visual (EBeauty)

- Paleta quente: **coral / cream / pink** (+ teal, amber, green para estados), ink `#1a1a1a`, cream `#F4EFE8`.
- Tipografia: **DM Sans** (body) + **Playfair Display itálico** (display).
- Ícones: **Tabler** (`@tabler/icons-react`).
- Homepage: **hero** com decorações circulares + chips de Categoria + grid de Produtos.
- Carrinho: **página inteira** `/carrinho` (não drawer).

## 📐 Decisões (ADRs em `docs/adr/`)

| ADR | Decisão | Estado |
|---|---|---|
| 0001 | Stock por Produto, Preço por Cor | ❌ **SUPERSEDED** pelo 0004 |
| 0002 | Stack Next.js + Sanity + Netlify | ✅ válido |
| 0003 | Modelo de negócio = PRODUTO | ✅ válido |
| 0004 | **Pivot multi-marca + identidade EBeauty** (sem variantes de Cor) | ✅ **autoritativo** |

Funcionalidades rejeitadas no 0004: admin custom (mantém Sanity Studio), banners, cálculo de portes, subcategorias hierárquicas, dashboard de stats.

## 📦 Estado atual

- Catálogo **hardcoded** em `lib/products.ts` (pré-Sanity): 8 produtos seed (2× Medicube, Tangle Teezer, 2× ADEUS, Klorane, Nuxe, René Furterer). Helpers: `formatPrice`, `isOnSale`, `discountPercent`, `parseSize`, `unitPriceLabel`, `whatsappAskLink`.
- App implementada: homepage (`app/page.tsx`), página de produto (`app/produtos/[slug]/` com `Tabs`, `RelatedProducts`, `AddToCartButton`), componentes (`Header`, `ProductCard`, `Footer`).
- Certificações suportadas: `cruelty-free`, `vegan`, `sem-parabenos`, `stock-pt`.
- **Git**: na branch `main`; a implementação do catálogo ainda **não está commitada** (último commit = bootstrap). WhatsApp = placeholder `351912345678` (TODO: número real via Sanity storeSettings).

## 🛠️ Plano (8 fases — ver `PLAN.md`)

0. Setup Next.js + Git + Netlify
1. **Sanity Studio embebido** + schemas (Product, Category, StoreSettings) ← próximo grande passo (substituir `products.ts`)
2. Catálogo (homepage)
3. Página de produto
4. Carrinho
5. Integração WhatsApp/email
6. Polish mobile-first
7. Deploy final + onboarding ao cliente

> `PLAN.md` tem assumptions antigas (Cores, drawer) desatualizadas pelo ADR-0004 — o ADR é a fonte autoritativa.

## ▶️ Correr localmente

```bash
cd ~/Documentos/Projects/Vendas
pnpm install
pnpm dev   # http://localhost:3000
```

## ❓ Próximos passos / em aberto

- [ ] Migrar catálogo hardcoded (`lib/products.ts`) → schemas Sanity (Fase 1).
- [ ] Commitar a implementação atual do catálogo.
- [ ] Número de WhatsApp real + storeSettings.
- [ ] Decidir Netlify vs Vercel se houver quirks de App Router (nota no ADR-0002).
