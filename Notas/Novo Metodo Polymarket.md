# Novo Método Polymarket

> Nota irmã de [[Polymarket]]. Foca-se em **(1)** como aceder ao Polymarket programaticamente (APIs) e **(2)** o método de funding discutido (Binance → Phantom → Poly). Inclui pesquisa feita em jun-2026.

---

## Contexto / objetivo

A nota [[Polymarket]] concluiu que a arbitragem cross-platform a partir de PT está morta (Polymarket bloqueada em PT desde jan-2026) e que o caminho técnico limpo é **modelo de previsão ML em paper trading**. Esta nota documenta o que seria preciso para tocar no Polymarket **a sério** (dados + execução real), e a realidade desse caminho.

Duas coisas separadas, não confundir:
1. **Aceder a DADOS do Polymarket** → totalmente público, sem login, sem carteira. Útil já hoje para backtest/análise.
2. **TRADING real no Polymarket** → exige carteira + USDC + contornar o bloqueio geográfico. É aqui que entram os riscos legais.

---

## As APIs do Polymarket

O Polymarket expõe **3 APIs principais + 1 de bridge**. As de leitura (Gamma e Data) são públicas e sem credenciais — dá para puxar tudo já.

### 1. Gamma API — descoberta de mercados (público)
- **Base:** `https://gamma-api.polymarket.com`
- **O que faz:** markets, events, tags, series, **comments**, sports, search, perfis públicos.
- **Auth:** nenhuma. É o ponto de entrada para explorar mercados e metadados.
- **Uso no projeto:** mapear universo de mercados, encontrar os equivalentes meteo, ir buscar metadados e critérios de resolução (importante para evitar o "resolution mismatch" referido em [[Polymarket]]).

### 2. Data API — analytics e utilizadores (maioritariamente público)
- **Base:** `https://data-api.polymarket.com`
- **O que faz:** posições de utilizadores, trades, activity logs, **holders / top traders**, **open interest**, volume, **leaderboards**, builder analytics, posições combinatórias (multi-mercado) com breakdown por perna.
- **Auth:** endpoints públicos sem credenciais; dados específicos de utilizador exigem API key.
- **Uso no projeto:** open interest + volume como features; leaderboard/holders para estudar fluxo de "smart money"; histórico para backtest.

### 3. CLOB API — orderbook e TRADING (auth para ordens)
- **Base:** `https://clob.polymarket.com`
- **O que faz:** orderbook (bid/ask em tempo real), preços, last trade, **midpoints**, **spreads**, tick sizes, fees, price history. **+ colocação/cancelamento de ordens** (até 15 por request), estado de ordens.
- **WebSocket:** canais live de orderbook, preço e lifecycle de mercado; canais autenticados para notificações de ordens/trades.
- **Auth:** leitura (orderbook/preços) é pública; **colocar ordens exige credenciais L2**.
- **Uso no projeto:** midpoint/spread = o **benchmark de mercado** a bater (Brier do modelo vs preço); WebSocket para dados live; ordens só na fase de execução real.

### 4. Bridge API — depósitos/levantamentos
- **Base:** `https://bridge.polymarket.com` (via proxy fun.xyz)
- Trata de mover fundos para dentro/fora. Relevante só na fase de capital real.

### Autenticação CLOB (quando se chega a ordens)
Esquema em camadas:
- **L1** — assinatura com a chave da carteira (setup, deriva as L2).
- **L2** — API key/secret/passphrase usadas em cada request de trading.
- **Builder key** — atribuição de volume (programas de builder).

> Para a fase de DADOS (F0–F3 do plano em [[Polymarket]]), **não é preciso nada disto**. Gamma + Data + CLOB-leitura chegam, tudo público.

---

## O método de funding discutido: Binance → Phantom → Poly

Fluxo proposto: comprar cripto na **Binance** → enviar para uma **carteira Phantom** ("que nem está associada a nada teu") → depositar no **Polymarket**.

### Como funcionaria, na prática (factual)
1. **Binance:** comprar USDC (ou USDT/POL). Levantar **na rede Polygon** (POL/MATIC). ⚠️ Confirmar sempre a rede — Polygon, não Ethereum/BSC.
2. **Phantom:** carteira não-custodial, multi-chain, com suporte nativo de Polygon e do próprio Polymarket; tem "Crosschain Swapper" (Polygon/Solana/Ethereum/Base/Sui). Recebe o USDC em Polygon.
3. **Polymarket:** ligar a Phantom **ou** usar `Deposit → Transfer Crypto` para obter o endereço de depósito; escolher asset+rede (USDC em Polygon). O USDC/USDC.e recebido é embrulhado em **pUSD** via Collateral Onramp — pUSD é o que se detém e negoceia.
4. **Gas:** é preciso uma pitada de **POL/MATIC** (~$0,50) para gas. A maioria das exchanges que suporta USDC-Polygon também dá POL.
5. **Teste primeiro:** enviar 20–50 USDC de teste, confirmar que chega, só depois escalar. Rede errada = perda permanente.

### ⚠️ Por que este método NÃO é o que parece

Esta é a parte honesta que o instinto inicial não cobre:

- **A carteira "não associada" não contorna o bloqueio geográfico.** O bloqueio do Polymarket é ao nível da aplicação: deteção geográfica que **vai além do IP e identifica uso de VPN** (ToS §2.1.4). Uma carteira limpa só quebra a *ligação de identidade* — não quebra o *geo-block*. Para entrar de PT continuarias a precisar de contornar a deteção geográfica, que eles **detetam ativamente**.
- **"Não associada a nada teu" é meio-verdade.** A Binance é KYC: regista a tua identidade **e** o endereço para onde levantaste. Logo a cadeia Binance→Phantom está gravada sob o teu nome. E a blockchain é pública: tudo o que essa carteira faz é rastreável. Resultado = **pseudonimato, não anonimato**.
- **Viola a ToS do Polymarket explicitamente** (§2.1.4 proíbe circumvenção de restrições geográficas). Contas apanhadas a contornar são **congeladas ou terminadas** — e o saldo pode ficar preso.
- **Viola a lógica legal em PT.** Apostar em eventos (sobretudo políticos) é jogo não licenciado; o SRIJ proíbe. PT entrou na lista de bloqueios em jan-2026, dando 48h ao Polymarket para cessar (depois de ~$120M em apostas nas presidenciais PT).
- **Fiscal:** ganhos não declarados em PT são problema à parte, independente do resto.

### O ângulo tecnicamente relevante (para o bot)
Um bot que negoceie via **CLOB API + carteira Polygon** interage com os endpoints/contratos diretamente, **não** com o front-end web bloqueado. Isto contorna o geo-block *do site*, mas **a ToS e a lei continuam a aplicar-se** — não muda o estatuto legal, só o caminho técnico. Não resolve nada do que está acima; apenas evita o IP-block do browser.

---

## Como encaixa no projeto ML

Nada disto desbloqueia capital real limpo a partir de PT — o que [[Polymarket]] já dizia mantém-se:

- **F0–F3 (dados, calibração, backtest):** 100% possíveis e legais **agora**, com as APIs públicas (Gamma + Data + CLOB-leitura). Nenhuma carteira, nenhum funding, nenhum risco.
- **F4 (paper trading):** simular ordens contra o orderbook real (CLOB WebSocket) sem dinheiro. Legal.
- **F5 (capital real):** é o único ponto onde o funding acima importaria — e é exatamente onde o ToS + lei PT bloqueiam o caminho limpo.

**Recomendação:** usar o Polymarket como **fonte de dados rica** (mercados, midpoints, open interest, fluxo de holders) para alimentar/validar o modelo meteo, e manter a **execução real na Kalshi**, que opera legitimamente em PT (ver [[Polymarket]]). Assim aproveita-se a riqueza de dados do Polymarket sem tocar no problema legal dele.

---

## Fontes

- Polymarket API — Introduction: https://docs.polymarket.com/api-reference/introduction
- Gamma API docs (markets/events/comments/tags): https://gamma-api.polymarket.com/docs
- Data API: https://data-api.polymarket.com
- CLOB API: https://clob.polymarket.com
- Polymarket — Deposit (bridge): https://docs.polymarket.com/trading/bridge/deposit
- Polymarket — Geographic Restrictions: https://help.polymarket.com/en/articles/13364163-geographic-restrictions
- Phantom — Polymarket prediction market: https://phantom.com/learn/crypto-101/polymarket-prediction-market
- Portugal crackdown (CoinDesk, jan-2026): https://www.coindesk.com/policy/2026/01/20/portugal-joins-growing-list-of-countries-cracking-down-on-polymarket
- Países bloqueados (CCN): https://www.ccn.com/education/crypto/countries-banned-restricted-polymarket-kalshi/
