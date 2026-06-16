---
tags: [cosmetics, ebeauty, estado, handoff]
atualizado: 2026-06-16
---

# EBeauty — Ponto de situação (continuar aqui)

> 📌 **Começar por aqui amanhã de manhã.** Repo: `~/Documentos/Projects/Vendas`.
> Notas detalhadas: [[EBeauty - Catálogo (projeto Vendas)]] · [[Direções de design (protótipo)]] · [[Páginas legais]] · [[Sanity (Fase 1)]]

## ✅ Onde estamos (16/06/2026)

- **Design escolhido: B2 "Apple-modern"** — já é a **homepage real** (`app/page.tsx`). Protótipo (`app/_prototype/`) removido. Tiles full-bleed, banda preta, nav blur, animações simples (robustas, visíveis mesmo sem JS), **acento teal `#0d9488`** (const `ACCENT`). Mobile-first.
- **Páginas legais** prontas como rotas reais: `/termos-e-condicoes`, `/privacidade`, `/envios-e-devolucoes`, `/avisos-legais` + **banner de cookies** + **rodapé legal** (links + Livro de Reclamações). Dados em `lib/legal.ts` (nome = EBeauty; resto = "(a definir)").
- **Sanity (Fase 1)** arrancado: schemas escritos em `sanity/schemas/` (product/brand/category/storeSettings). Ainda **não instalado**.
- Tudo verificado a compilar (HTTP 200, sem erros). Catálogo ainda **hardcoded** em `lib/products.ts` (8 produtos).

## ▶️ Retomar o ambiente

```bash
cd ~/Documentos/Projects/Vendas
pnpm dev
# Computador: http://localhost:3000
# Telemóvel (mesma WiFi): http://192.168.0.124:3000
```
(o dev server de hoje já não deve estar a correr)

## ⏭️ Próximos passos (por ordem)

1. **[Sanity] Passo manual primeiro** — criar projeto Sanity e dar-me o Project ID:
   ```bash
   pnpm dlx sanity@latest login
   pnpm dlx sanity@latest projects create "EBeauty"
   ```
   Depois eu: instalo `next-sanity`+`sanity`, monto o **Studio em `/studio`**, migro a homepage/produto para **GROQ**, e semeio os 8 produtos. → [[Sanity (Fase 1)]]
2. **[Design] Alinhar a página de produto** (`/produtos/...`) com a B2 — ainda está no design antigo (cream/coral).
3. **[Legal] Preencher dados reais** em `lib/legal.ts`: NIF (quando existir), morada, email, **nº WhatsApp**, prazos/custos de envio, métodos de pagamento, datas. Trocar link do Livro de Reclamações pelo **selo oficial**. **Revisão jurídica.** → [[Páginas legais]]
4. **[Qualidade] Fotografia consistente** dos 8 produtos (mesmo fundo/luz/enquadramento) — é o que mais eleva o design.
5. *(opcional)* **Commit** do trabalho — está tudo por commitar no git.

## 🔒 Decisões fixadas

- Direção visual **B2 + acento teal** · Modelo de negócio **PRODUTO** · Fecho por **WhatsApp** (site não processa pagamento) · Multi-marca **sem variantes de cor** (ADR-0004).

## ⚠️ Notas técnicas

- **Next.js 16** tem breaking changes — consultar `node_modules/next/dist/docs/` antes de escrever código (ver `AGENTS.md`).
- Confirmar compatibilidade do **Sanity Studio com Next 16 / React 19** ao instalar.

## ❓ Decisão em aberto

- Acento ficou **teal** por defeito (o que viste). Alternativas: azul Apple `#0071e3`, verde menta, ou quase-preto sem acento. Trocar em `ACCENT` (`app/page.tsx`).
