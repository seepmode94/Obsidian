# Método: Construir e Vender Websites com IA

**Playbook extraído do vídeo** *"How I Build & Sell $8,000 AI Websites"* — Jack Roberts
🔗 https://www.youtube.com/watch?v=wr0bvxVyPEs · 1:19:47 · nota criada a 15-07-2026

---

## Ferramentas usadas no método

| Ferramenta | Papel no método |
|---|---|
| **Google AntiGravity** | IDE agêntico — o "centro de operações": leads, build, clonagem, publicação |
| **Google AI Studio** | Gerar o design inicial do site (é melhor a desenhar que o AntiGravity) |
| **Google Stitch** | Design de sites multi-página; liga-se ao AntiGravity por MCP |
| **Instant Data Scraper** (ext. Chrome) | Scraping rápido e manual do Google Maps |
| **Apify** | Scraping programático de leads (via MCP no AntiGravity) |
| **AnyMailFinder** | Enriquecimento: encontrar/validar emails dos leads (via API) |
| **UI/UX Pro skill** (repo GitHub) | Checklist automática de UI/UX, acessibilidade e SEO |
| **21st.dev** | Biblioteca de componentes bonitos para "UI sniping" |
| **GitHub** | Armazenar cada site num repo (via CLI autenticada no AntiGravity) |
| **Vercel** | Hosting; publicação programática via MCP (API token) |
| **Instantly** | Campanhas de cold email com sequências de follow-up |
| **GoHighLevel / WordPress** | (Opcional) destino alternativo do site, exportado como HTML/CSS |
| **VideoAsk** | Recolher testemunhos em vídeo dos clientes |

---

## FASE 1 — Escolher o nicho

1. Escolher um nicho **aborrecido, lucrativo e não tech-savvy**: limpeza comercial, AVAC/canalizadores, jardinagem/abate de árvores, detailing auto, controlo de pragas, vedações, manutenção de piscinas, remoção de entulho.
2. Validar com a checklist:
   - [ ] 20+ negócios desse tipo na zona-alvo
   - [ ] Websites maus ou desatualizados (verificar no Google)
   - [ ] Negócios com dinheiro (lucrativos)
   - [ ] De preferência, um setor onde já tenha alguma experiência

---

## FASE 2 — Obter e enriquecer leads

### Via rápida (manual)

1. Pesquisar o nicho no **Google Maps** (ex.: "pool cleaners Austin");
2. Ativar a extensão **Instant Data Scraper** → "infinite scroll" → "start crawling";
3. Exportar CSV com nome, telefone, website, morada, nº de reviews.

### Via programática (AntiGravity + Apify)

1. Criar conta **Apify** → Console → Settings → API & Integrations → copiar API key;
2. No AntiGravity: `... → MCP servers → manage MCP servers → view raw config`, e pedir ao agente para adicionar o MCP do Apify ao `mcp_config.json` com a key;
3. **Desativar ferramentas MCP não usadas** (manter < 50 ativas — poupa contexto);
4. Prompt de teste com **orçamento limitado**: *"scrape pool cleaners em Austin, gasta no máximo 0,20 $"* — validar que funciona antes de escalar (no vídeo: 71 negócios por 0,77 $);
5. Acompanhar a execução no console do Apify (separador "Runs").

### Enriquecimento de emails

1. Criar conta **AnyMailFinder** → API → copiar API key;
2. Prompt no AntiGravity: *"enriquece esta lista com a API do AnyMailFinder — valida os emails existentes e encontra os que faltam"* + colar a key;
3. Resultado esperado: taxa de emails passa de ~45% para 80%+, com contactos individuais verificados.

### Automatizar para sempre

Pedir ao AntiGravity para **transformar todo o pipeline numa skill reutilizável** (scraping → limpeza → enriquecimento). A partir daí basta: *"500 leads de empresas X em Y"*.

---

## FASE 3 — Construir o website modelo

### 3.1 Investigar o que funciona no nicho

Prompt ao AntiGravity: *"pega nos 5-10 negócios com melhores reviews Google da nossa lista, faz scraping dos websites deles e dá-me 10 coisas acionáveis que os melhores fazem e os piores não."*

Padrões típicos encontrados: linguagem hiper-local, listas granulares de serviços, secção "como funciona", FAQ, testemunhos com nomes reais e bairros, listas extensas de áreas de serviço (SEO local).

### 3.2 Desenhar no Google AI Studio

- Dar **pouca informação** ao AI Studio (quanto mais contexto, pior o design) — só o pedido de design + referências visuais;
- Referências: screenshots do **Dribbble**, ou HTML extraído de um site admirado (pesquisar "HTML extractor") anexado ao prompt;
- Prompt-tipo: *"desenha um website lindo para uma empresa de limpeza de piscinas, foco total num hero gorgeous, segue o HTML anexo como guia de estilo."*

### 3.3 Passar para o AntiGravity

1. No AI Studio: **Sync to GitHub** → criar repo → stage & commit;
2. No AntiGravity: *"instala este website numa pasta própria e abre em localhost"* (colar o link do repo);
3. O AntiGravity vê o browser — se não carregar, corrige sozinho (tipicamente erros TypeScript).

### 3.4 Otimizar

1. Instalar a skill **UI/UX Pro** (repo GitHub c/ 31 mil estrelas): *"instala a skill abaixo neste projeto"* + colar o link;
2. Correr: *"passa o site pela checklist da skill sem alterar o design — acessibilidade, contraste, lazy loading, responsividade, SEO — e devolve a lista de melhorias feitas"*;
3. Aplicar o estudo da fase 3.1 ao copy: *"com base na análise dos top 10, edita o copy e acrescenta as secções que faltam"*;
4. Verificar a versão mobile no preview;
5. (Opcional) "UI sniping": escolher componentes no **21st.dev** ("best of the week") → copiar o código → *"implementa isto"*. Regra: nestes nichos, **menos é mais** — o site existe para converter.

Este trabalho de otimização **faz-se uma única vez** — os clones herdam tudo.

---

## FASE 4 — O sistema de clonagem

1. **Decompor**: *"decompõe o site nos componentes que mudam de negócio para negócio"* → tipicamente 7: nome/logo/branding, testemunhos, contactos, áreas de serviço, preços, esquema de cores, stats/FAQ;
2. **Refatorar para config-driven**: aceitar a sugestão de criar um `site-config.ts` único — muda-se o ficheiro, o site inteiro atualiza;
3. **Clonar o primeiro**: *"clona o site para [negócio X da lista]: extrai o logo, telefone, rating Google real, testemunhos e cores da marca a partir do site deles; usa placeholders onde não houver dados"*;
4. **Transformar em skill de clonagem** — a partir daí, cada novo clone é um prompt de uma linha, e pode correr para 50-100 negócios da lista.

### Alternativa multi-página: Google Stitch

- Para sites com várias páginas/formulários, desenhar no **Stitch** (escolher modo "web", não "app");
- Ligar ao AntiGravity: Stitch → settings → criar API key → *"adiciona o MCP do Stitch ao mcp_config.json"*;
- O AntiGravity consegue puxar os projetos do Stitch e cloná-los entre nichos: *"duplica este layout para [outro nicho]"*.

### (Opcional) Exportar para GoHighLevel/WordPress

*"converte o site num único bloco HTML/CSS/JavaScript pronto a colar num code block"* → GoHighLevel: Sites → new website → página → elemento "code block" → colar.

---

## FASE 5 — Publicar programaticamente

1. **GitHub**: *"liga-te ao GitHub para poderes criar repos"* → o AntiGravity instala a CLI, gera um código de autorização → colar em github.com/login/device → a partir daí cria e publica repos sozinho;
2. **Vercel**: criar token em `vercel.com/account/settings/tokens` → *"adiciona o MCP do Vercel ao mcp_config.json"* → **ativar só ~10 das 100 ferramentas** do MCP (deploy + essenciais);
3. *"publica o repo X no Vercel e devolve-me a URL"* → site live em `<nome>.vercel.app`;
4. Erros visuais (ex.: logo em falta): screenshot → colar no chat → *"corrige isto"*;
5. Transformar também isto numa **skill GitHub→Vercel**;
6. **Crucial**: pedir para acrescentar uma coluna "novo website" aos dados dos leads, preenchida com a URL de cada clone — é o que permite o email em massa personalizado.

> Bónus: alterações feitas no AntiGravity propagam-se automaticamente (código → GitHub → Vercel).

---

## FASE 6 — Outreach automatizado

### O email (a oferta é o site grátis, sem pedido)

- Assunto **em minúsculas** (parece escrito por humano);
- Corpo-tipo: *"Olá [nome], sou [X] de [cidade]. Vi a [empresa] e achei que o vosso site podia fazer mais por vocês. Construí-vos um novo: [link único]. É vosso, grátis — estou a construir portefólio e o vosso negócio destacou-se. Se quiserem afinar algo, digam."*
- 3 variantes para A/B test: a direta, a local, a do elogio + quick win.

### Campanha no Instantly

1. Conta de envio: **domínio pré-aquecido** (comprado no Instantly) ou o próprio email se o volume for baixo (30-40/semana). Nunca @gmail.com;
2. Upload do CSV enriquecido (limpar antes: 1 email por célula, localidades escritas de forma natural — o AntiGravity trata disso);
3. Email 1 com variável `{{website}}` para o link único de cada lead;
4. **Sequência de follow-ups: dias 3, 7, 14 e 28** (o último é o "breakup email") — o dinheiro está nos emails 3-7;
5. Definições: parar ao primeiro reply, envio ao meio-dia do fuso do lead, limite diário baixo em contas novas, A/B das 3 variantes.

---

## FASE 7 — Monetizar (modelo "razor blades")

O site grátis é o suporte; as lâminas são os **add-ons mensais**. Só avançar quando o cliente demonstra gratidão genuína.

| Add-on MRR | Preço/mês (referência do vídeo) |
|---|---|
| Hosting + manutenção | 50 $ |
| SEO local mensal | 250 $ |
| Chatbot IA no site | 500 $ |
| Gestão de redes sociais | 100+ $ |
| Automação de follow-up de emails | variável |
| Geração automática de reviews pós-serviço | variável |
| Marcações online / missed-call text-back | variável |

**Script do upsell**: como vai o site? → qual é a maior dor do negócio agora? → **ouvir mais do que falar** → propor UM add-on pequeno que resolva essa dor.

**Regras para o 1.º cliente**: < 300 $/mês, acordo mês-a-mês, cancelamento livre, sim fácil. Um cliente a 150 $/mês > zero clientes a 2.000 $.

**Escalar**: testemunhos sempre (VideoAsk), mesmo de quem não compra; pedir referências ("conheces alguém que beneficiaria de um site grátis?"); posicionar como especialista do nicho ("a agência dos limpa-piscinas"); subir preços com 3+ clientes pagos e casos de estudo.

O pitch com autoridade de nicho: *"estudámos os 10 melhores do setor na tua região — fazem estas 10 coisas no site, tu não fazes 9. Já corrigi: aqui está o teu site novo."*

---

## ⚠️ Notas para adaptação (minhas)

- As ferramentas são substituíveis em quase todos os passos — o que interessa é o pipeline: **nicho → leads → site modelo → config-driven + clonagem → publicação automática → email com link único → avença**;
- Em Portugal/UE, o cold email em massa à americana precisa de filtro RGPD (prospeção B2B tem regras), e extrair logos/testemunhos dos sites dos leads para os clones tem implicações de direitos de autor — rever antes de usar;
- Cruzar com a nota "Ideia - Venda de sites com manutenção (VPS próprio)" — este método preenche a parte comercial que lá faltava.

---
*Índice do tema: [[Negócios com IA (índice)]]*
