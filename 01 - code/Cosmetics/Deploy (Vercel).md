---
tags: [cosmetics, ebeauty, deploy, vercel]
atualizado: 2026-06-17
---

# EBeauty — Deploy (Vercel)

> Ver [[Ponto de situação]]. Stack passou de Netlify (ADR-0002) para **Vercel** a pedido (17/06).

## 🌐 Live (17/06/2026)

- **Site (público):** https://ebeauty-pt.vercel.app
  (`ebeauty.vercel.app` está ocupado por outra conta; `ebeauty-pt` é o alias limpo reclamado.)
- **Studio / Admin:** https://ebeauty-pt.vercel.app/studio — mesmo domínio, rota `/studio`. Online (200). Acesso com a **conta Sanity** (ou o editor convidado `antonio.santos2467@gmail.com`). A rota é pública mas o login do Sanity protege a edição; **publicar aqui mexe no catálogo live**. Studio é desktop-first (ver [[Sanity (Fase 1)]]).
- Projeto Vercel: **ebeauty** · scope `seepmode94s-projects` · framework Next.js auto-detetado.
- Verificado público: homepage (produtos + imagens CDN), página de produto, `/studio`, páginas legais — todas 200.

## Como ficou montado

- **Env vars (Production)** no Vercel: `NEXT_PUBLIC_SANITY_PROJECT_ID`, `NEXT_PUBLIC_SANITY_DATASET`, `NEXT_PUBLIC_SANITY_API_VERSION`, `SANITY_API_READ_TOKEN`. **NÃO** foi posto o token de escrita do seed (`SANITY_API_TOKEN`) — o site não precisa.
- **CORS Sanity** inclui `https://ebeauty-pt.vercel.app` (para o `/studio` autenticar em produção).
- **Deployment Protection (Vercel Authentication/SSO) DESATIVADA** — senão dava 401 ao público. Comando: `vercel project protection disable ebeauty --sso` (foi o user a correr; o agente não tem permissão p/ expor publicamente).
- Build: `next build` (Turbopack), 15 páginas, 8 produtos via `generateStaticParams` (lê do Sanity no build com o read token).

## Redeploy

```bash
cd ~/Documentos/Projects/Vendas
vercel --prod --yes
```

## ⚠️ Antes de partilhar largamente

- O checkout WhatsApp usa **número placeholder** `351912345678` (`STORE.whatsappDigits`) — ligar ao real / `storeSettings` antes de divulgar.
- Se um futuro `vercel --prod` não atualizar o alias `ebeauty-pt`, re-apontar: `vercel alias set <deployment-url> ebeauty-pt.vercel.app`.
- `.env.local` (com tokens) está gitignored — as chaves vivem nas Env Vars do Vercel.
