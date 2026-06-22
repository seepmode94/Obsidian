---
tags: [cosmetics, ebeauty, ia, gemini, sanity, seo, geo, pipeline]
atualizado: 2026-06-22
status: esboço
---

# EBeauty — Pipeline de conteúdo IA + GEO (Gemini → Sanity)

> Ver [[EBeauty - Catálogo (projeto Vendas)]] · [[Sanity (Fase 1)]]. Estudo de origem: [[Estudo - IA na Gestão de Dropshipping]] (Fases 2 e 3 — conteúdo + SEO/GEO).
> Objetivo: gerar **descrições + SEO + dados GEO** de produtos com a **Gemini API** e escrevê-los no **Sanity como rascunho**, para o vendedor rever e publicar no Studio. IA rascunha, **humano publica**.

> [!info] Porquê Gemini (e não on-device)
> Aqui é **geração de conteúdo em cloud** (texto estruturado a partir de specs), não a perceção on-device do [[Cosmetics]]. Cloud é o sítio certo para esta tarefa; o requisito "tudo local" só se aplica à análise de pele, não à geração de catálogo.

---

## 🎯 Objetivo & encaixe no fluxo existente

O EBeauty já tem o modelo "vendedor gere o catálogo no Studio" ([[Sanity (Fase 1)]]). Este pipeline encaixa lá:

```
Produto novo/cru  →  Gemini (gera GEO)  →  DRAFT no Sanity  →  vendedor revê no /studio  →  Publish
```

- **Draft-first** = nada vai ao site sem revisão humana → evita conteúdo AI genérico (penalização SEO) e erros factuais.
- Reaproveita o padrão idempotente do `seed.mjs`: `createOrReplace` com `_id` determinístico.
- O `_id` no espaço `drafts.` faz o documento aparecer como **rascunho** no Studio — exatamente onde o vendedor já trabalha.

## 🧠 O que é "GEO" aqui (a parte que dá edge)

Em 2026 não se escreve só para o Google — escreve-se para **agentes de compra** (Rufus, ChatGPT Search, Sidekick). Eles leem **dados estruturados**, não prosa. Logo o Gemini não devolve um parágrafo bonito: devolve **factos citáveis** (specs, FAQ, resumo factual) que o front-end emite como `structured data` (JSON-LD). Ver [[Estudo - IA na Gestão de Dropshipping#Fase 3 — SEO **e GEO** (a mudança grande de 2026)]].

---

## 🏗️ Arquitetura (fluxo)

```
Input do produto            ┌─────────────────────────┐
(specs, marca, categoria,──►│ 1. Normalizar + _id       │
 preço, imagens)            │    estável (slug/sku)     │
                            └────────────┬─────────────┘
                                         ▼
                            ┌─────────────────────────┐
                            │ 2. Gemini API            │ ◄── systemInstruction =
                            │    structured output      │     brand voice EBeauty + regras GEO
                            │    (responseSchema JSON)  │     (vocabulário cosmético, sem claims médicos)
                            └────────────┬─────────────┘
                                         ▼
                            ┌─────────────────────────┐
                            │ 3. Validar (Zod) +        │ ◄── re-tenta se inválido;
                            │    checar unicidade        │     rejeita duplicados
                            └────────────┬─────────────┘
                                         ▼
                            ┌─────────────────────────┐
                            │ 4. Escrever Sanity DRAFT  │ ◄── createOrReplace,
                            │    (SANITY_API_TOKEN)     │     _id = drafts.product.<slug>
                            └────────────┬─────────────┘
                                         ▼
                            ┌─────────────────────────┐
                            │ 5. /studio: vendedor revê │
                            │    e PUBLICA              │
                            └────────────┬─────────────┘
                                         ▼
                            ┌─────────────────────────┐
                            │ 6. Next.js emite JSON-LD  │ ◄── Product + FAQPage + Offer
                            │    (GEO no front-end)     │
                            └─────────────────────────┘
```

> [!warning] Vocabulário cosmético, não médico
> O `systemInstruction` herda a regra do [[Cosmetics]]: **nunca** claims de saúde/diagnóstico ("trata acne", "elimina dermatite"). Linguagem de bem-estar/cosmética. Isto vale também para conteúdo gerado, não só para a análise de pele.

---

## 📐 1. Campos GEO a adicionar ao schema `product`

Adicionar a `sanity/schemas/product.*` (junto aos existentes brand/category/photos/photoHue):

```ts
defineField({ name: "seoTitle", title: "SEO title", type: "string",
  validation: r => r.max(60) }),
defineField({ name: "metaDescription", type: "text", rows: 2,
  validation: r => r.max(155) }),
defineField({ name: "keyFeatures", title: "Destaques", type: "array",
  of: [{ type: "string" }] }),
defineField({ name: "specs", title: "Especificações", type: "array", of: [{
  type: "object",
  fields: [{ name: "label", type: "string" }, { name: "value", type: "string" }],
}]}),
defineField({ name: "faq", type: "array", of: [{
  type: "object",
  fields: [{ name: "question", type: "string" }, { name: "answer", type: "text" }],
}]}),
defineField({ name: "citableSummary", title: "Resumo factual (GEO)", type: "text", rows: 3 }),
defineField({ name: "aiGenerated", type: "boolean", initialValue: true,
  description: "Gerado por IA — rever antes de publicar" }),
```

## 📋 2. Contrato de output (Zod) — define a qualidade GEO

```ts
// scripts/geo/schema.ts
import { z } from "zod";

export const GeoContent = z.object({
  seoTitle: z.string().max(60),
  metaDescription: z.string().max(155),
  descriptionHtml: z.string(),                 // brand voice (vai p/ corpo da página)
  keyFeatures: z.array(z.string()).min(3).max(7),
  specs: z.array(z.object({ label: z.string(), value: z.string() })),
  faq: z.array(z.object({ question: z.string(), answer: z.string() })).min(3).max(8),
  citableSummary: z.string().max(300),         // resposta factual direta p/ LLMs
  imageAltTexts: z.array(z.string()),
  keywords: z.array(z.string()),
});
export type GeoContent = z.infer<typeof GeoContent>;
```

## 🤖 3. Geração com Gemini (structured output)

SDK: `@google/genai` (o unificado). `pnpm add @google/genai zod`.

```ts
// scripts/geo/generate.ts
import { GoogleGenAI } from "@google/genai";
import { GeoContent } from "./schema";

const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY! });

const SYSTEM = `És copywriter da EBeauty (cosmética). Tom: <definir — ex. caloroso, claro, sem hype>.
REGRAS:
- Vocabulário cosmético/bem-estar. NUNCA claims médicos (tratar/curar/diagnosticar).
- specs SEMPRE factuais e completas (volume, ingredientes-chave, tipo de pele, modo de uso...).
- citableSummary: resposta direta a "o que é e para quem é", citável por um assistente de IA, sem marketing.
- faq: dúvidas reais de comprador (tipo de pele, envio, devolução 14 dias, ingredientes).
- Se um dado não vier no input, OMITE — não inventes.`;

export async function generate(product: unknown): Promise<GeoContent> {
  const res = await ai.models.generateContent({
    model: "gemini-2.5-flash",          // bulk barato; usar -pro nos produtos-âncora
    contents: JSON.stringify(product),  // nome, marca, categoria, specs cruas, preço
    config: {
      systemInstruction: SYSTEM,
      responseMimeType: "application/json",
      responseSchema: GEMINI_SCHEMA,    // espelha o Zod (ver nota de modelos)
      temperature: 0.4,
    },
  });
  return GeoContent.parse(JSON.parse(res.text!)); // valida → lança se inválido
}
```

> [!note] Confirmar model IDs
> `gemini-2.5-flash` / `-pro` eram os atuais à data de corte (jan-2026). **Confirmar no AI Studio** — pode haver versões mais recentes (3.x). Flash para os ~90% bulk; Pro para hero/coleções.

## 💾 4. Escrita no Sanity — draft-first + idempotente

Reaproveita o estilo do `seed.mjs` (correr com `node --env-file=.env.local`). Usa o **token de escrita** (role editor) já existente: `SANITY_API_TOKEN`.

```ts
// scripts/geo/write.ts
import { createClient } from "@sanity/client";
import type { GeoContent } from "./schema";

const sanity = createClient({
  projectId: "0qopudd2",
  dataset: "production",
  apiVersion: "2024-10-01",
  token: process.env.SANITY_API_TOKEN!,  // editor; server-side only, nunca no browser
  useCdn: false,
});

export async function writeDraft(slug: string, base: object, c: GeoContent) {
  await sanity.createOrReplace({
    _id: `drafts.product.${slug}`,   // aparece como RASCUNHO no Studio
    _type: "product",
    aiGenerated: true,
    ...base,                         // brand, category, photos, price, slug (refs já resolvidas)
    seoTitle: c.seoTitle,
    metaDescription: c.metaDescription,
    description: c.descriptionHtml,
    keyFeatures: c.keyFeatures,
    specs: c.specs,
    faq: c.faq,
    citableSummary: c.citableSummary,
  });
}
```

> O `drafts.product.<slug>` casa com a convenção `product.<slug>` do seed: ao publicar no Studio, o Sanity promove o draft para o `_id` publicado automaticamente.

## 🌐 5. Camada GEO no front-end (Next.js) — JSON-LD

Na página de produto (`app/produtos/[slug]/page.tsx`), emitir `structured data` a partir dos campos GEO:

```tsx
function ProductJsonLd({ p }: { p: Product }) {
  const product = {
    "@context": "https://schema.org", "@type": "Product",
    name: p.title, description: p.citableSummary,
    brand: { "@type": "Brand", name: p.brand },
    image: p.photos?.map(urlFor),
    additionalProperty: p.specs?.map(s => ({
      "@type": "PropertyValue", name: s.label, value: s.value })),
    offers: { "@type": "Offer", price: p.price, priceCurrency: "EUR",
      availability: "https://schema.org/InStock" },
  };
  const faq = {
    "@context": "https://schema.org", "@type": "FAQPage",
    mainEntity: p.faq?.map(f => ({ "@type": "Question", name: f.question,
      acceptedAnswer: { "@type": "Answer", text: f.answer } })),
  };
  return <>
    <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(product) }} />
    {p.faq?.length ? <script type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(faq) }} /> : null}
  </>;
}
```

E na GROQ (`lib/queries.ts`) acrescentar os novos campos à projeção de `getProductBySlug`: `seoTitle, metaDescription, keyFeatures, specs, faq, citableSummary`. Usar `seoTitle`/`metaDescription` no `generateMetadata` da página.

---

## ⚙️ 6. Operações

- **Batch + concorrência:** processar o feed com limite (`p-limit` a ~5) — respeita rate limits do Gemini e da API do Sanity.
- **Custo:** Flash no bulk, Pro só nos âncora; logar tokens por produto.
- **Unicidade (anti duplicate-content):** antes de escrever, comparar `descriptionHtml`/`citableSummary` com os existentes (hash ou embedding); se demasiado parecido, re-gerar com ângulo diferente. Conteúdo AI clonado = penalização SEO.
- **Retry:** se o `Zod.parse` falhar, re-pedir ao Gemini com o erro de validação no prompt (auto-correção).
- **Alt-text multimodal:** opcionalmente, passar a própria imagem ao Gemini (é multimodal) para gerar `imageAltTexts` a partir da foto, não só do nome.

## 🔑 Setup / env vars

| Var | Papel | Já existe? |
|---|---|---|
| `GEMINI_API_KEY` | Gemini API | **novo** (AI Studio) |
| `SANITY_API_TOKEN` | escrita (editor) | ✅ ([[Sanity (Fase 1)]]) |
| `SANITY_PROJECT_ID` / dataset | `0qopudd2` / `production` | ✅ |

Deps: `pnpm add @google/genai zod p-limit` (o `@sanity/client` já é dep direta).
Correr: `node --env-file=.env.local scripts/geo/run.mjs` (mesmo padrão do `seed.mjs`).

## ⏭️ Pendente / questões em aberto

- [ ] Definir a **brand voice** da EBeauty no `systemInstruction` (tom, do/don't).
- [ ] Espelhar o Zod no `responseSchema` do Gemini (helper zod→schema ou schema à mão).
- [ ] Decidir input: feed de fornecedor (JSON) vs. enriquecer produtos já no Sanity sem campos GEO.
- [ ] Estratégia de unicidade (hash simples vs. embeddings).
- [ ] Atualizar projeção GROQ + `generateMetadata` com os campos novos.
- [ ] Confirmar model IDs atuais do Gemini no AI Studio.

## 🔗 Relacionado

- [[Estudo - IA na Gestão de Dropshipping]] — estudo de origem (Fases 2/3)
- [[EBeauty - Catálogo (projeto Vendas)]] · [[Sanity (Fase 1)]] · [[Chat-IA (assistente de beleza)]]
- [[Cosmetics]] — regra "cosmético, não médico" (herdada no systemInstruction)
