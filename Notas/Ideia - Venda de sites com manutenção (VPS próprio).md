# Ideia de negócio — Venda de sites simples com avença de manutenção

> 📅 Nota criada a 2026-07-15
> Origem: conversa sobre self-hosting a partir do vídeo [[10 Repos GitHub que substituem subscrições SaaS]]

## A ideia em uma frase

Construir e vender **sites simples** (montras digitais para pequenos negócios) com **avença mensal de manutenção**, alojados em infraestrutura própria (VPS + Coolify), onde o custo de infra é fixo e cada cliente novo é margem quase pura.

---

## O modelo de negócio

- **Receita**: valor de setup (construção do site) + **avença mensal de manutenção** (15-30 €/mês é o normal de mercado para sites simples).
- **Custo de infra fixo**: ~10 €/mês independentemente de ter 1 ou 20 sites.
- **Break-even**: o primeiro cliente com avença já paga a infra toda; do segundo em diante é margem.
- **Escala**: o esforço por site novo cai drasticamente com um template reutilizável — o 5.º site demora dias, não semanas.

A avença cobre: uptime/monitorização, atualizações, backups, pequenas alterações de conteúdo. Alterações maiores são orçamentadas à parte (ver secção "Riscos").

---

## Stack técnico

### Infraestrutura

| Componente | Escolha | Custo |
|---|---|---|
| VPS | **Hetzner** CX32 ou equivalente (8 GB RAM) | ~7-9 €/mês |
| Backups automáticos Hetzner | checkbox no painel, 7 backups diários em rotação | +20% do VPS (~1,50 €/mês) |
| PaaS self-hosted | **Coolify** (https://github.com/coollabsio/coolify) | grátis |
| Monitorização | **Uptime Kuma** (corre no mesmo Coolify) | grátis |
| DNS | Hetzner DNS (dns.hetzner.com) ou DNS do registrar | grátis |

**Total fixo: ~10 €/mês.**

### Desenvolvimento

- **Template/starter próprio em Astro** — para sites de montra, Astro gera HTML estático: rápido, seguro, quase zero manutenção. (Alternativa: Next.js, se o site precisar de mais dinâmica.)
- **Um repo GitHub por cliente** — isolado, histórico limpo; se o cliente sair, entrega-se o repo dele.
- **CMS para o cliente editar conteúdo** — evita ser o gargalo para mudanças triviais ("muda o horário na página"):
  - **Sanity** (já conheço do projeto [[Cosmetics|EBeauty]], tier grátis por projeto), ou
  - **Directus** / **Payload** self-hosted no mesmo VPS.

### Porquê Coolify e não Vercel/Netlify

- O Coolify replica o fluxo do Vercel: liga-se ao GitHub via GitHub App, **cada `git push` dispara deploy automático**, tem preview deployments para PRs, e trata do HTTPS (Let's Encrypt) sozinho. Nunca é preciso SSH para fazer deploy.
- No Vercel, cada site comercial a sério empurraria para o plano Pro (20 USD/mês *por seat*); no VPS o custo não cresce com o número de sites.
- Contras honestos do Coolify: builds correm no VPS (mais lentos), e se algo parte, sou eu que resolvo — mas é exatamente esse serviço que a avença vende.

---

## Fluxo de trabalho por cada cliente novo

1. **Clonar o template** para um repo novo → personalizar (conteúdo, cores, branding);
2. **Coolify**: criar projeto, ligar o repo GitHub → push = deploy;
3. **Domínio**: o **cliente compra/possui o domínio dele** (ou compro em nome dele) — nunca registar domínios de clientes em meu nome, evita conflitos se a relação acabar;
4. **DNS**: registo `A` a apontar para o IP do VPS; Coolify emite o certificado HTTPS;
5. **Uptime Kuma**: adicionar o site à monitorização (alerta no Discord/email se cair — saber antes do cliente ligar é meio negócio de manutenção);
6. Entregar acesso ao CMS ao cliente e fechar o projeto.

No dia a dia, manutenção e alterações = trabalhar no repo + `git push`.

---

## Riscos e cuidados

- **Acordo/contrato simples por escrito** que delimite o que a avença cobre (uptime, updates, pequenas alterações) vs. o que é orçamentado à parte — senão a "manutenção" vira desenvolvimento grátis infinito.
- **Cliente com tráfego/exigência a sério não mistura** com os outros no mesmo VPS: nesse caso, VPS dedicado para ele ou Vercel pago, com o custo passado ao cliente.
- **⚠️ Conflito com a Seepmode**: é trabalho por fora na mesma área — **confirmar o que o contrato de trabalho diz sobre atividade paralela ANTES de vender ao primeiro cliente**. (Relevante: ainda estou em [[Período experimental]].)
- **Backups são inegociáveis** quando os sites são de clientes — ligar os backups da Hetzner desde o dia 1 e testar um restore pelo menos uma vez.
- **RGPD**: sites de clientes com formulários/analytics precisam de política de privacidade; usar analytics leve tipo Plausible (self-hosted, sem cookies) simplifica.

---

## Custos resumidos

| Rubrica | Valor |
|---|---|
| VPS Hetzner 8 GB + backups | ~9-10 €/mês (fixo) |
| Domínio (por cliente, pago pelo cliente) | ~10-20 €/ano |
| Ferramentas (Coolify, Uptime Kuma, Astro) | 0 € |
| **Receita alvo por cliente** | **15-30 €/mês** + setup |

---

## Próximos passos

- [ ] Confirmar cláusulas de exclusividade/atividade paralela no contrato Seepmode
- [ ] Criar o template base em Astro (um site de montra genérico bem feito)
- [ ] Contratar VPS Hetzner + instalar Coolify + Uptime Kuma (tarde de trabalho)
- [ ] Fazer deploy do template como site demo num domínio meu (serve de portefólio)
- [ ] Definir tabela de preços (setup + avença) e o que a avença inclui
- [ ] Redigir minuta de acordo de manutenção simples
- [ ] Primeiro cliente piloto (idealmente alguém conhecido, com desconto, em troca de testemunho)

---
*Índice do tema: [[Negócios com IA (índice)]]*
