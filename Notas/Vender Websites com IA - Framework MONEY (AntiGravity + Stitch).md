# Vender Websites com IA — Framework M.O.N.E.Y.

**Resumo do vídeo** *"How I Build & Sell $8,000 AI Websites (AntiGravity + Stitch)"*

| | |
|---|---|
| **Canal** | Jack Roberts |
| **Duração** | 1:19:47 |
| **Publicado** | 18-02-2026 |
| **Link** | https://www.youtube.com/watch?v=wr0bvxVyPEs |
| **Nota criada** | 15-07-2026 |

---

## Sumário executivo

Jack Roberts (ex-fundador de uma startup com 60 mil clientes, hoje com uma agência de automação com IA) apresenta o sistema completo que usa para construir e vender websites a pequenos negócios — o primeiro vendeu-o por **8.000 £ com 2 dias de trabalho**. A tese central: oferecer um website excelente **de graça** a negócios "aborrecidos" com sites maus, e converter essa relação em **receita mensal recorrente** (hosting, SEO, chatbots, automações).

A ferramenta central é o **Google AntiGravity** (IDE agêntico da Google), combinado com **Google AI Studio** (design), **Google Stitch** (design multi-página) e vários serviços ligados por MCP. O processo segue um framework de 5 passos: **M.O.N.E.Y.**

---

## M — Mapear o nicho

**Evitar os nichos "sexy" saturados** (dentistas, ginásios, med spas, imobiliárias) e atacar nichos **aborrecidos, lucrativos e mal servidos**: limpeza comercial, AVAC/canalizadores, jardinagem e abate de árvores, detailing automóvel, controlo de pragas, vedações, manutenção de piscinas, remoção de entulho.

Porquê? Estes donos de negócio têm dinheiro, não são tech-savvy, quase nunca são abordados — e os websites deles são genuinamente maus (o vídeo mostra exemplos reais de empresas de piscinas em Austin).

**Checklist de validação do nicho:**

- Há pelo menos 20 negócios do tipo na tua zona? (quantos mais, melhor — o sistema de clonagem serve todos)
- Têm websites maus ou desatualizados?
- São lucrativos (têm dinheiro para pagar)?
- Tens alguma experiência prévia no setor ("1% skill") que possas alavancar?

**Filosofia do primeiro cliente:** não é receita, é **prova** — prova de que entregas, prova de que o mercado diz sim, prova a ti próprio. O website é a "porta de entrada" (gateway) para vender depois todos os outros serviços.

---

## O — Obter leads

Duas vias, da mais simples à mais poderosa:

**1. Manual rápida** — extensão Chrome **Instant Data Scraper** sobre resultados do Google Maps: extrai nome, telefone, website, morada e avaliações de centenas de negócios, exporta CSV.

**2. Programática com AntiGravity + Apify (MCP)** — liga-se o Apify ao AntiGravity via MCP (colar a API key na config) e pede-se em linguagem natural: "extrai-me todos os limpa-piscinas de Austin, gasta no máximo 20 cêntimos". Resultado no vídeo: **71 negócios por 0,77 $**, com telefones (96%), websites (89%) e emails (46%).

**3. Enriquecimento com AnyMailFinder** — via API, o AntiGravity valida os emails existentes e encontra os em falta: passou de 33 para 55+ negócios com email, **215 emails verificados**, incluindo contactos individuais.

**Dicas técnicas do vídeo:**

- Desativar ferramentas MCP não usadas (idealmente < 50 ativas) — poupam contexto e tokens;
- Transformar todo o processo numa **skill reutilizável** do AntiGravity: da próxima vez basta dizer "500 leads de empresas X em Y" e corre sozinho;
- Ligar pessoalmente aos leads também funciona — ninguém o faz, destaca-se logo.

---

## N — "Nail the build" (construir o website)

O passo mais longo do vídeo. O fluxo de construção:

**1. Investigar antes de construir** — pedir ao AntiGravity para analisar os websites dos 5-10 concorrentes locais com melhores avaliações Google e extrair o que têm em comum. Padrões encontrados: linguagem hiper-local ("os teus vizinhos em Austin"), listas granulares de serviços, secção "como funciona", FAQ, testemunhos com nomes reais e bairros, áreas de serviço extensas (ótimo para SEO local).

**2. Desenhar no Google AI Studio** — o AI Studio produz designs mais bonitos que o AntiGravity; o truque é dar-lhe **pouca informação** (só design, sem o estudo dos concorrentes) e referências visuais: screenshots do Dribbble ou HTML extraído de sites que se admira. Nota do autor: para vender a clientes, construir do zero com referências — não copiar código de terceiros.

**3. Passar para o AntiGravity via GitHub** — sincronizar o resultado do AI Studio com o GitHub e importá-lo no AntiGravity, que é melhor em engenharia/escala. Correr em localhost para iterar.

**4. Aplicar a skill "UI/UX Pro"** (repo público no GitHub com 31 mil estrelas) — checklist automática de acessibilidade, contraste, espaçamentos, lazy loading, responsividade mobile e SEO. Faz-se uma vez; os clones herdam tudo.

**5. Melhorar o copy com os dados** — aplicar agora os padrões dos concorrentes de topo: hero reescrito, barra de estatísticas, preços transparentes, testemunhos reais do Google, FAQ, CTA fixo "pedir orçamento grátis".

**6. (Opcional) "UI sniping"** — buscar componentes bonitos em 21st.dev e pedir ao AntiGravity para os integrar. Mas o autor avisa: nestes nichos, **menos é mais** — o trabalho do site é converter, não impressionar.

### O sistema de clonagem (a peça central do vídeo)

1. Pedir ao AntiGravity para **decompor o site em componentes variáveis**: nome, logo, telefone, email, testemunhos, áreas de serviço, preços, esquema de cores;
2. Refatorar para uma **arquitetura config-driven** — um único ficheiro `site-config.ts` de onde tudo flui;
3. Criar uma **skill de clonagem**: dá-se o website de um lead e o agente extrai sozinho o logo, o telefone real, a nota Google verdadeira, os testemunhos e o esquema de cores da marca, e gera um site novo personalizado — no vídeo, sem tocar em nada;
4. Repetir para 50, 80, 100 negócios do nicho.

**Alternativa/complemento — Google Stitch:** agente de design da Google para websites **multi-página** (formulários, funis). Liga-se ao AntiGravity por MCP e também clona designs entre nichos ("duplica esta app de piscinas para remoção de resíduos").

**Exportação para GoHighLevel/WordPress:** pedir ao AntiGravity para converter o site num bloco HTML/CSS/JavaScript e colar num code block — útil para quem trabalha com funis.

---

## E — Executar o outreach

**Publicação automática** — o AntiGravity liga-se ao GitHub (cria os repos) e ao **Vercel via MCP** (publica cada site com URL única), tudo programático. Truque importante: adicionar uma coluna "novo website" aos dados de leads, preenchida automaticamente com a URL de cada clone — permite emails em massa com o link personalizado de cada negócio.

**Os emails de contacto** (3 templates no playbook grátis dele):

- Assunto em minúsculas ("parece escrito por um humano");
- Estrutura: "construí-te um website novo, aqui está o link, é teu, grátis, estou a construir portefólio" — **zero pedido, zero fricção**;
- Variantes: a local ("sou da tua cidade"), a do elogio ("reparei nisto no teu negócio, aqui vai um quick win").

**Follow-ups no Instantly** — "o dinheiro está todo no follow-up" (emails 3 a 7): sequência sugerida nos dias 3, 7, 14 e 28 (breakup email). Boas práticas: domínios pré-aquecidos para não cair em spam (não enviar de @gmail.com), parar a sequência à primeira resposta, enviar ao meio-dia do fuso do lead, limites diários baixos em contas novas, A/B testing das variantes.

---

## Y — Yield (monetizar)

O **modelo "razor blades"** (Harry's Razors): o website grátis é o descanso da lâmina; as lâminas vendem-se todos os meses. Só avançar quando o cliente demonstra gratidão genuína ("não acredito que fizeste isto de graça") — é o sinal de que a relação está construída.

**Menu de add-ons MRR** (valores do vídeo):

| Serviço | Preço/mês |
|---|---|
| Hosting + manutenção do site | ~50 $ |
| SEO local mensal | ~250 $ |
| Chatbot IA no site (responde a leads em segundos) | ~500 $ |
| Gestão de redes sociais | ~100+ $ |
| Automação de follow-up de emails | variável |
| Sistema de geração de reviews pós-serviço | variável |
| Marcação de serviços online / missed-call text-back | variável |

**Como vender o upsell:** perguntar como vai o site → perguntar qual é a maior dor do negócio → **ouvir mais do que falar** → propor UM add-on pequeno que resolva essa dor. Regras para o primeiro cliente: manter abaixo de 300 $/mês, acordo mês-a-mês sem contratos, cancelamento livre — "o teu primeiro cliente a pagar 150 $/mês vale infinitamente mais do que zero clientes a 2.000 $".

**Escalar a partir daí:**

- **Testemunhos sempre** (ferramenta sugerida: VideoAsk), mesmo de quem não compra — prova social é tudo;
- **Referências**: "conheces alguém que beneficiaria de um website grátis?" (menos vendedor que pedir diretamente);
- **Autoridade de nicho**: "somos a agência dos limpa-piscinas" vence sempre a agência generalista — e o pitch fica devastador: "estudámos os 10 melhores do Texas, fazem estas 10 coisas, tu não fazes 9 delas — já corrigi, aqui está o site";
- **Subir preços** quando houver 3+ clientes pagos com resultados, casos de estudo e procura acima da capacidade.

---

## Nota crítica (minha, não do vídeo)

O vídeo tem conteúdo técnico real e detalhado, mas é também marketing: o autor vende a comunidade paga dele, e a descrição está cheia de links de afiliado (Instantly, GoHighLevel, Apify — apesar de dizer no vídeo que não é afiliado). O valor de 8.000 £ é a melhor venda dele, não a típica. A tática de "grabar" logos, testemunhos e conteúdo dos sites dos leads para os clones levanta questões legais reais (direitos de autor, RGPD nos emails em massa na Europa — o Instantly configurado à americana não cumpre as regras de prospeção B2B portuguesas sem cuidado). Usar as ideias, filtrar a execução.

## Relevância pessoal

Este vídeo é praticamente o manual de vendas da minha ideia registada em "Ideia - Venda de sites com manutenção (VPS próprio)": o framework M.O.N.E.Y. cobre exatamente a parte que lá estava menos desenvolvida — **como arranjar clientes** (nicho aborrecido + site grátis + upsell para avença). As diferenças: eu planeava Astro + Coolify/Hetzner em vez de AntiGravity + Vercel, e o modelo dele confirma a lógica da avença mensal (hosting + manutenção + SEO) como produto principal. A ideia da arquitetura config-driven + clonagem é diretamente aproveitável para o meu template.
