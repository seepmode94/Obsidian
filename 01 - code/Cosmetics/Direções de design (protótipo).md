---
tags: [cosmetics, ebeauty, design, prototipo]
---

# EBeauty — Direções de design (protótipo)

> Prints das 4 variantes geradas no protótipo (`app/_prototype/`, alternáveis em `/?variant=`).
> Ver também [[EBeauty - Catálogo (projeto Vendas)]]. Objetivo: escolher uma direção de arte — o design atual parecia fraco/datado.

Como ver ao vivo:
```bash
cd ~/Documentos/Projects/Vendas && pnpm dev
# http://localhost:3000  → setas ←/→ ou a barra flutuante (só em dev)
```

> Nota: a barra preta no fundo dos prints é o **switcher do protótipo** (só aparece em dev), não faz parte do design.

---

## ⚪ Atual (baseline)

O design existente, para comparar. Cream + Playfair itálico + coral, hero só de texto, grelha de quadrados com gradiente. Limpo, mas genérico/"template de beleza por defeito"; imagens inconsistentes (uns produtos têm foto, outros mostram o nome da marca).

| Desktop | Mobile |
|---|---|
| ![[ebeauty-atual-desktop.png]] | ![[ebeauty-atual-mobile.png]] |

---

## 🅰️ Direção A — Editorial clean (Glossier / Aesop)

Branco/off-white, muito whitespace, **sans confiante** (sem serif itálico, sem MAIÚSCULAS-tracking), hero editorial com imagem grande, grelha arejada. Moderno e intemporal; deixa o produto respirar.

- ✅ Atual, premium, intemporal; foca no produto.
- ⚠️ Exige **boa fotografia** (com pouca foto, fica vazio); menos "quente".

| Desktop | Mobile |
|---|---|
| ![[ebeauty-A-desktop.png]] | ![[ebeauty-A-mobile.png]] |

---

## 🅱️ Direção B — Farmácia clínica premium (Typology / La Roche-Posay)

Branco, **estrutura com sidebar** (Categorias / Ativos / Certificações) + grelha densa de cards com badges, ativos e botão de ação. Acento clínico (teal). Transmite confiança e clareza.

- ✅ Confiança/credibilidade; ótimo para muitos produtos e para destacar **ativos e certificações**; navegação eficiente.
- ⚠️ Menos "boutique/emocional"; mais utilitário; sidebar só faz sentido com catálogo grande.

| Desktop | Mobile |
|---|---|
| ![[ebeauty-B-desktop.png]] | ![[ebeauty-B-mobile.png]] |

---

## ⭐ Direção B2 — B+ Apple-modern (favorita atual)

Evolução da **B** com a substância clínica (ativos, certificações, "Adicionar", stock) mas estudada a partir do **apple.com/pt real**:

- **Tiles full-bleed empilhados** com fundos alternados (branco / `#f5f5f7` / **preto**), um produto por bloco — o ritmo da homepage da Apple, não uma grelha.
- Nome **enorme centrado** (semibold, tracking apertado) + tagline cinza + **2 CTAs pill** (cheio + texto "›") + imagem grande em painel.
- Padrão de título assinatura **"Bold. Cinza."** (ex.: *"Catálogo. Encontra o teu cuidado."*).
- **Banda escura** "Encomenda simples." (o ritmo preto da Apple).
- Nav slim translúcida (blur), paleta neutra (`#1d1d1f`/`#f5f5f7`) + **acento teal** (`#0d9488` — Apple usa azul `#0071e3`, trocável numa linha).
- Sidebar da B → **chips de filtro** (categorias + ativos), mais mobile-first.
- **Animações simples**: reveal no scroll (fade + slide-up, com stagger), hover/zoom suave, botões `active:scale`. Respeita `prefers-reduced-motion`.

- ✅ Lê inequivocamente "Apple modern"; mantém confiança/ativos da B; mobile-first; motion tasteful.
- ⚠️ As animações e o ritmo dos tiles **só se sentem ao vivo** (`?variant=B2`); o acento é trocável; **depende muito de fotografia consistente** (os tiles são dominados pela imagem).

| Desktop | Mobile |
|---|---|
| ![[ebeauty-B2-desktop.png]] | ![[ebeauty-B2-mobile.png]] |

> 🎬 **Ver as animações:** `pnpm dev` → http://localhost:3000/?variant=B2 e faz scroll.

---

## 🅲 Direção C — Boutique quente refinada

Mantém o cream/coral mas **elevado**: profundidade (sombras suaves), hero com produto em destaque assimétrico, **secções por categoria em scroll horizontal**, cards com hover. Resolve o "flat/sem movimento" do atual sem perder a identidade quente.

- ✅ Mantém a identidade EBeauty mas com muito mais polish; acolhedor e curado.
- ⚠️ Risco de continuar a ler "template de beleza" se a fotografia não acompanhar; serif itálico ainda presente.

| Desktop | Mobile |
|---|---|
| ![[ebeauty-C-desktop.png]] | ![[ebeauty-C-mobile.png]] |

---

## Como decidir

- **Quer-se premium/intemporal e há boa fotografia?** → **A**.
- **Catálogo grande, foco em ativos/confiança (parapharmácia)?** → **B**.
- **Confiança da B + modernidade Apple, mobile-first, com animações?** → **B2** ⭐ (direção escolhida).
- **Manter a alma quente da marca mas com mais qualidade?** → **C**.

O feedback mais útil costuma ser **misturar** ("header da B + secções da C"). Decidida a direção, dobra-se no `app/page.tsx` real e apaga-se `app/_prototype/`.

> ⚠️ Independentemente da escolha: o maior salto de qualidade vem de **fotografia consistente** (mesmo fundo/luz/enquadramento). 4 dos 8 produtos ainda não têm foto.
