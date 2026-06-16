---
tags: [cosmetics, ebeauty, sanity, cms]
---

# EBeauty — Sanity (Fase 1)

> Ver [[EBeauty - Catálogo (projeto Vendas)]]. Objetivo: substituir o catálogo hardcoded
> (`lib/products.ts`) por **Sanity**, dando ao vendedor um **Studio em `/studio`** para gerir
> produtos, stock, marcas e definições — sem código nem deploy.

## ✅ Já feito (não precisa do teu projeto Sanity)

Schemas escritos em `sanity/schemas/` (objetos puros, não partem o build):
- `product` — espelha o tipo `Product` (nome, slug, marca↗, categoria↗, preço, promoção, fotos, **stock**, hideWhenOutOfStock, destaque, sku, descrição, ingredientes, certificações, SEO…)
- `brand`, `category`
- `storeSettings` (singleton) — identidade + contactos + **dados legais** (NIF, morada, Livro de Reclamações)

## 🔑 Passo MANUAL (só tu — precisa de conta Sanity)

Criar um projeto Sanity grátis para obter o **projectId**:

```bash
# no terminal (ou com ! aqui na sessão):
pnpm dlx sanity@latest login        # abre o browser para login/registo
pnpm dlx sanity@latest projects create "EBeauty"   # cria projeto → dá um Project ID
# alternativa: criar em https://www.sanity.io/manage e copiar o Project ID
```

Depois diz-me o **Project ID** (ou põe em `.env.local`):

```
NEXT_PUBLIC_SANITY_PROJECT_ID=xxxxxxxx
NEXT_PUBLIC_SANITY_DATASET=production
```

## ⏭️ A seguir (eu faço, assim que houver Project ID)

1. `pnpm add next-sanity sanity @sanity/vision @sanity/image-url styled-components`
2. `sanity.config.ts` + cliente (`lib/sanity.ts`) + helper de imagens
3. Studio embebido em **`/studio`** (rota `app/studio/[[...tool]]/page.tsx`)
4. Migrar o fetch da **homepage** e da **página de produto** de `lib/products.ts` → **GROQ** (server component com ISR, `revalidate` curto → stock propaga em ~1s)
5. Semear os **8 produtos** atuais + marcas + categorias no Sanity
6. Ligar `storeSettings` ao rodapé/legal e ao número de WhatsApp
7. Convidar o vendedor (Sanity → Members → Invite) + cheat sheet

## ⚠️ Notas de compatibilidade

- Projeto é **Next.js 16 + React 19**. Verificar a versão do **Sanity Studio** compatível
  (testar `pnpm dev` e `/studio` após instalar; resolver peer-deps se aparecerem).
- ADR-0002 mantém Sanity + Netlify; ADR-0003 = modelo PRODUTO (vendedor autónomo).
