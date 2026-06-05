## O que é

Polymarket é um **mercado de previsões** (prediction market) descentralizado. Em vez de apostares em jogos, apostas no **resultado de eventos reais** — eleições, decisões económicas, desporto, tecnologia, etc. Compras "ações" (shares) de um resultado: se acertares, cada ação vale 1 dólar; se errares, vale 0.

O preço de cada ação, entre $0 e $1, funciona como uma **probabilidade**. Uma ação a $0,63 significa que o mercado atribui ~63% de hipóteses a esse resultado acontecer.

## Como funciona na prática

Imagina o mercado: *"O candidato X ganha a eleição?"* — com duas ações, **Sim** e **Não**.

- Compras **Sim** a $0,40 (mercado dá 40% de probabilidade).
- O evento acontece e o X ganha → cada ação **Sim** passa a valer $1.
- Lucro: $0,60 por ação. Quem comprou **Não** perde tudo.

O preço de Sim + Não soma sempre ~$1. À medida que entra dinheiro e informação nova, os preços ajustam-se em tempo real — daí ser visto como um "termómetro" de probabilidades.

## Conceitos principais

- **Share / outcome token:** ação que representa um resultado; resolve a $1 (acertou) ou $0 (errou).
- **USDC:** stablecoin (1 USDC ≈ 1 USD) usada para todas as transações. Não usas euros nem dólares diretamente.
- **Polygon:** blockchain (Layer 2 da Ethereum) onde tudo corre — taxas baixas e rápido.
- **CLOB (Central Limit Order Book):** livro de ordens estilo bolsa; combina compradores e vendedores em vez de teres um "banco" a fazer de contraparte.
- **Resolução / Oracle:** quem decide o resultado final. A Polymarket usa o **UMA Optimistic Oracle** — um sistema descentralizado onde alguém propõe o resultado e há uma janela para contestar antes de ficar definitivo.
- **Liquidez:** quantidade de dinheiro disponível para comprar/vender sem mexer muito no preço.

## Porque existe / o que tem de interessante

- **Sinal de probabilidade:** como há dinheiro real em jogo, a teoria diz que os preços tendem a refletir melhor a realidade do que sondagens ou opinião (as pessoas "votam com a carteira").
- **Descentralizado:** corre on-chain, sem uma casa de apostas tradicional a controlar tudo.
- **Mercados sobre quase tudo:** desde "quem ganha as eleições" até "vai chover em tal sítio".

## Pontos de atenção / riscos

- **Regulação:** mercados de previsões com dinheiro real são uma zona cinzenta legal em muitos países. Nos EUA a Polymarket teve um acordo com a **CFTC em 2022** e bloqueou (oficialmente) utilizadores americanos. Convém perceber a situação legal em Portugal/UE antes de mexer.
- **Risco de oracle:** a resolução depende do oracle; mercados mal definidos ou eventos ambíguos podem gerar disputas.
- **Volatilidade e perda total:** se erras o resultado, a ação vale 0. Não é poupança, é especulação.
- **Cripto:** precisas de carteira, USDC e lidar com Polygon — fricção e risco técnico próprios de cripto.

## Contexto

- Fundada por **Shayne Coplan** em 2020.
- Ganhou enorme visibilidade nas **eleições presidenciais dos EUA de 2024**, quando os seus mercados foram amplamente citados como indicador de probabilidades.

---

## Notas / discussão

> Espaço para irmos anotando dúvidas e pontos que queiras aprofundar.

### Ideia: bot de trading com a Kalshi API

Objetivo inicial: bot que prevê o mercado e aposta sozinho, com "ganhos garantidos", em conta americana "para ser legítima".

**Realidades que corrigem a premissa:**

- **"Ganhos garantidos" não existe** num bot de previsão. Previsão direcional = *edge* (vantagem estatística) no melhor caso, nunca garantia; se erra, a ação resolve a $0.
- A única coisa perto de "garantida" é **arbitragem** (comprar Sim numa plataforma + Não noutra quando a soma < $1 após taxas). É *market-neutral*, mas **não risk-free**: janelas de segundos (dominado por bots), taxas da Kalshi (~1,2% taker) comem a margem, risco de execução e de resolução divergente entre plataformas.
- **Conta americana é desnecessária e contraproducente.** A Kalshi abriu internacionalmente (~143 países) e **Portugal NÃO está na lista de restrições**. Logo, dá para abrir conta legítima como residente PT. Fingir residência nos EUA exigiria SSN + morada US e mentir no KYC → fraude, o oposto de "legítimo".
- ⚠️ UE volátil: Espanha bloqueou Polymarket/Kalshi a 26-mai-2026; SRIJ (regulador PT) é zona cinzenta. Confirmar situação legal/fiscal antes de capital real.

**Estratégias viáveis:** arbitragem (baixo risco, margens minúsculas) · market-making (médio, risco de inventário) · modelo ML de previsão (alto risco, edge no melhor caso).

**Plano recomendado:** começar em **read-only + paper trading / backtesting**, sem dinheiro real, para aprender a API (REST + WebSocket, gratuita para verificados) e validar edge antes de arriscar capital.

### Direção escolhida: modelo de previsão (ML)

> O António já usa ML no trabalho → seguimos por aqui.

**O que estamos mesmo a tentar fazer:** produzir probabilidades *melhor calibradas que o preço de mercado*. O preço da Kalshi já é uma previsão agregada forte (quase eficiente em mercados líquidos). Ganhar = o modelo ter **Brier score < Brier do mercado, líquido de taxas**. O benchmark a bater é o próprio mercado, não um baseline ingénuo.

**Onde há edge plausível (do mais tratável ao mais difícil):**
- **Meteorologia/clima** — dados físicos duros, ensembles públicos (GFS/ECMWF/NOAA), menos sharps. Melhor 1º alvo para demonstrar calibração.
- **Macro/dados económicos** (CPI, emprego, Fed) — nowcasting; mercados sharp.
- **Nichos de baixa liquidez** — edge possível, mas liquidez limita capital e spreads comem retorno.
- **Desporto/política** — eficientes, muitos profissionais.
- Regra: o melhor edge costuma ser *adjacente a dados/expertise que já se tem*.

**Arquitetura (camadas):**
1. **Dados** — Kalshi via API (REST snapshots + WebSocket live); histórico de preços + resoluções *point-in-time* + sinais externos do domínio.
2. **Modelo** — `p_modelo` calibrado por mercado.
3. **Decisão** — apostar só quando `edge = p_modelo − p_mercado` cobre taxas + margem; sizing por **Kelly fracionário**.
4. **Validação** — backtest + paper trading com taxas/slippage realistas (Brier, reliability diagram, PnL simulado).
5. **Execução** — ordens via API, limites de risco, kill switch.

**Armadilhas de ML específicas:** look-ahead / point-in-time · calibração > accuracy · amostras pequenas (ruído) · não-estacionariedade · benchmark = o mercado · taxas+slippage+spread = papel vs prejuízo real.

**Fases:**
- **F0** — API read-only: puxar e guardar mercados + resoluções → dataset histórico.
- **F1** — escolher domínio + recolher sinais externos.
- **F2** — baseline + calibração (Brier, reliability vs mercado).
- **F3** — backtest com taxas/slippage realistas.
- **F4** — paper trading live.
- **F5** — (só se validado) capital real pequeno + limites de risco.

### Repos analisados (GitHub) e decisão

> Análise dos READMEs em jun-2026. Nenhum tem "ganhos garantidos"; os LLM-puros admitem perdas e não têm edge validado; só o `homerun` modela fills/slippage a sério.

| Repo | ★ | O que é | Método de previsão | Backtest / paper | Custo APIs | Licença | Veredicto |
|---|---|---|---|---|---|---|---|
| **suislanchez/polymarket-kalshi-weather-bot** | 424 | Bot weather Kalshi (KXHIGH) + Poly | Ensemble GFS 31 membros (voto simples, **sem calibração**) | Só simulação/paper, com Brier tracking | **Grátis** (Open-Meteo/NWS) | MIT | **BASE recomendada** — domínio tratável; a calibração ML que falta é o *teu* valor a acrescentar |
| **Jon-Becker/prediction-market-analysis** | 3466 | Dataset + análise (36 GiB Poly+Kalshi) | — (só dados) | Sem engine própria | Grátis | MIT | **Camada de DADOS** para treino + backtest histórico |
| **braedonsaunders/homerun** | 79 | Plataforma completa (estratégias em Python) | Escreves tu; tem treino ML + 25 estratégias | Backtest L2 sofisticado + shadow→live | Grátis (precisa Postgres/Docker) | **AGPL-3.0** ⚠️ | "Graduar para" quando precisares de infra séria; copyleft importa se distribuíres |
| **arshka/pykalshi** | 101 | Cliente Python Kalshi (ws, pandas, orderbook) | — | — | Grátis | MIT | Camada de API se construíres de raiz |
| **pmxt-dev/pmxt** | 1846 | Cliente unificado multi-plataforma | — | — | Grátis | MIT | Útil p/ cross-platform/arb; TS-primário |
| ryanfrigo/kalshi-ai-trading-bot | 426 | Toolkit LLM | 1 LLM via OpenRouter | Paper (SQLite), sem backtest histórico | **OpenRouter pago** | MIT | Honesto, mas LLM ≠ edge; roubar padrões de risco (quarter-Kelly, circuit breakers) |
| OctagonAI/kalshi-trading-bot-cli | 313 | CLI IA, edge vs orderbook, half-Kelly, 5 gates | Octagon Research API (IA) | Backtest 15d (Brier, skill score) — sem fees/slippage | **Octagon + LLM pagos** | MIT | Bem feito, mas núcleo depende de API paga |
| 0mnjb/Kalshi-AI-Trading-Bot | 83 | Ensemble de 5 LLMs | 5 LLMs (Grok/Claude/GPT/Gemini/DeepSeek) | Paper, sem backtest formal | **xAI + OpenRouter pagos** | MIT | LLM-as-forecaster não calibrado; só admite edge em NCAAB |

**Decisão:**
- **Base:** `suislanchez/polymarket-kalshi-weather-bot` — dá o pipeline de dados meteo (Open-Meteo GFS, NWS), integração com mercados KXHIGH da Kalshi, Brier tracking e Kelly, **em modo simulação por defeito** (alinha com o nosso paper-first). A fraqueza dele (voto de ensemble sem calibração) é exatamente o que a tua camada de ML resolve → projeto de aprendizagem com hipótese real de edge.
- **Dados p/ backtest:** `Jon-Becker/prediction-market-analysis` (histórico Kalshi).
- **Graduar para:** `homerun` se precisares de infra séria (atenção à AGPL).
- **De raiz, se preferires:** `pykalshi` como cliente.
- **Evitar como núcleo preditivo:** os LLM-puros (ryanfrigo/Octagon/0mnjb) — servem só para *roubar padrões de gestão de risco*.

**Domínio alvo resolvido:** meteorologia (séries KXHIGH), por ser o mais tratável e por a melhor base já o cobrir.

**Próximo passo (F0):** clonar o weather-bot, correr em simulação, e mapear onde entra a camada de calibração ML.

### Alternativa explorada: bot de arbitragem (autónomo)

**Instinto correto:** na arbitragem a autonomia é obrigatória (janelas de segundos, humano não chega a tempo) — mas "só de certa forma" = autonomia com travões rígidos.

⚠️ **Bloqueio crítico para Portugal:** a arbitragem clássica é *cross-platform* (Kalshi↔Polymarket). Mas a **Polymarket está bloqueada em PT desde jan-2026** (lei PT proíbe apostas em eventos políticos; prediction markets = jogo não licenciado; bloqueou utilizadores PT por completo). Logo a perna Polymarket é inacessível de forma legítima. A Kalshi ainda não está na lista de bloqueio dela, mas pela mesma lógica legal o estatuto em PT é **frágil** (Espanha já bloqueou ambas). → **Sem caminho limpo para arb com dinheiro real a partir de PT agora.** Falsificar residência US = fraude (fora de questão).

**Caminho legítimo:** construir tudo em **paper/simulação com dados reais** (legal, sem dinheiro em risco, projeto técnico real). O mesmo código vai a live se/quando houver jurisdição/venue legítimo.

**A "certa forma" (autonomia com guardrails):**
- Disparar só quando o edge *líquido de todas as taxas* + buffer > limiar; sem edge → não age.
- Ordens **FOK/IOC** para evitar ficar preso a uma só perna (leg risk).
- **Matching de critério de resolução** — o killer silencioso: mercados "iguais" que resolvem diferente pelo texto. Só pares pré-validados (whitelist).
- Caps: $ por oportunidade, exposição total, posições concorrentes, capital bloqueado até resolução.
- Kill switch / circuit breakers (perda diária, falhas consecutivas, "arb bom demais → provável mismatch, ignora").
- Tier humano: auto abaixo de $X, aprovação acima.
- Dry-run primeiro; ordens idempotentes (falhas de rede / fills parciais).

**Realidades honestas:** dominado por HFT (apanhas as sobras), taxas comem a margem, capital preso até resolução baixa o retorno anualizado.

**Tools:** `pmxt` (execução unificada — mas perna Polymarket bloqueada limita-o em PT), `Jon-Becker` (backtest: medir quão frequentes/duradouras foram as arbs → decidir se vale a pena).

Fontes:
- Kalshi — International access & eligibility: https://help.kalshi.com/en/articles/14026044-international-access-eligibility
- Kalshi — Where is Kalshi (disponibilidade por país): https://where.kalshi.com/
- Kalshi API docs: https://docs.kalshi.com/welcome
- Arbitragem Kalshi/Polymarket (realidade e taxas): https://www.trevorlasn.com/blog/how-prediction-market-polymarket-kalshi-arbitrage-works
