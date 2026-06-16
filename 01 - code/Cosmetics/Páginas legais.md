---
tags: [cosmetics, ebeauty, legal, rgpd, ecommerce]
---

# EBeauty — Páginas legais (e-commerce cosmética · PT/UE)

> Ver [[EBeauty - Catálogo (projeto Vendas)]]. Páginas obrigatórias por lei, acessíveis pelo **rodapé**.
> ⚠️ **Conteúdo é template, não aconselhamento jurídico** — validar com apoio jurídico antes de publicar.

## ✅ O que já está construído (rotas Next.js)

| Página | Rota | Conteúdo |
|---|---|---|
| Termos e Condições de Venda | `/termos-e-condicoes` | preços, pagamento, entrega, **resolução 14 dias** + exceção higiene, garantias, lei aplicável |
| Política de Privacidade e Cookies | `/privacidade` | RGPD: dados, finalidades, base legal, direitos, **secção cookies** |
| Política de Envios e Devoluções | `/envios-e-devolucoes` | envios + **devoluções: cosméticos abertos/testados NÃO se devolvem** (higiene) |
| Avisos Legais (Imprint) | `/avisos-legais` | nome, NIF/NIPC, morada fiscal, email, Livro de Reclamações, RAL UE |

Extras construídos:
- **Banner de cookies** (`CookieBanner`) site-wide no `app/layout.tsx` (Só essenciais / Aceitar todos, guarda em localStorage).
- **Rodapé legal** (`SiteFooterLinks`) com dados da empresa + links das 4 páginas + **Livro de Reclamações** + RAL UE — pronto para encaixar no rodapé do design final.
- Dados centralizados em `lib/legal.ts` (editar placeholders num só sítio).

Adaptado ao **modelo real**: a venda fecha por **WhatsApp** (o site não processa pagamento) — os Termos refletem isso.

![[ebeauty-legal-termos.png]]

## 📝 O que o António tem de preencher (em `lib/legal.ts` e nos `[...]`)

- [ ] Nome da empresa / nome individual, **NIF/NIPC**, **morada fiscal**, **email**, WhatsApp
- [ ] Métodos de pagamento aceites (MB WAY, transferência, …)
- [ ] Prazos e **custos de envio** (e se há portes grátis acima de €X)
- [ ] Janelas de tempo (devolução de defeito, prazo de reembolso) e data de "última atualização"
- [ ] **Selo oficial do Livro de Reclamações** (descarregar em livroreclamacoes.pt) — substituir o link de texto
- [ ] Entidade RAL competente da região
- [ ] Se forem usados cookies de **analytics**, ligar ao consentimento do banner
- [ ] **Revisão jurídica** final

## Notas

- As páginas estão com chrome neutro (branco, legível) — vão herdar o branding quando o design final (B2) for aplicado; os links legais devem entrar no rodapé real.
