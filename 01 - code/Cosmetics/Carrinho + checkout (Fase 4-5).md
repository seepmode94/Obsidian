---
tags: [cosmetics, ebeauty, carrinho, checkout]
atualizado: 2026-06-17
---

# EBeauty — Carrinho + Checkout (Fase 4 + 5)

> Ver [[Ponto de situação]] · [[EBeauty - Catálogo (projeto Vendas)]]. O Carrinho vive só no
> dispositivo (localStorage); o Pedido sai por WhatsApp/email — o site nunca o guarda (CONTEXT.md).

## ✅ Concluído e verificado (17/06/2026)

Loop testado end-to-end (puppeteer headless): Adicionar → drawer abre → item + total corretos → persiste em localStorage → links de WhatsApp/email com a mensagem certa. Sem erros de hidratação.

**Stack:** `zustand@5` com `persist` (localStorage, chave `vendas-cart`).

**Ficheiros novos:**
- `lib/cart-store.ts` — store `useCart` (items + estado `open` do drawer). `partialize` persiste só os items; `skipHydration: true` + reidratação manual no `CartDrawer` (evita mismatch de SSR). Helpers `cartCount`/`cartTotal`.
- `lib/order.ts` — `buildOrderMessage` + `whatsappOrderLink` + `mailtoOrderLink` (Fase 5).
- `app/components/CartButton.tsx` — ícone saco + badge com contagem (guard `mounted` para SSR). Abre o drawer.
- `app/components/CartDrawer.tsx` — painel lateral (slide da direita): lista com stepper de qty + remover, estado vazio, total, botão **Encomendar via WhatsApp** (`bg-whatsapp`). Bloqueia scroll do body + fecha com Esc. **Checkout por email removido por agora** (decisão 17/06); `mailtoOrderLink` fica em `order.ts` para reativar.

**Ligações:**
- `app/layout.tsx` — `<CartDrawer/>` montado global (em todas as páginas).
- `Header.tsx` (páginas de produto) e header inline da homepage — usam `<CartButton/>` (substituíram o placeholder/"Saco").
- `AddToCartButton.tsx` — deixou de ser stub (`console.log`); agora `useCart().add(...)` + abre o drawer. Recebe `slug`, `brand`, `photo` além do resto.

## ⏭️ Pendente / a melhorar

- **Contactos reais:** `STORE.whatsappDigits` (`351912345678`) e `STORE.email` (`geral@ebeauty.pt`) são placeholders → ligar a `storeSettings` do Sanity.
- Badge do carrinho usa acento teal `#0d9488` fixo; uniformizar com o design final.
- Opcional: rota `/carrinho` dedicada (CONTEXT menciona-a) — por agora o **drawer** cobre a função.
- Página de produto ainda no design antigo (cream/coral) vs homepage B2 — alinhar.
