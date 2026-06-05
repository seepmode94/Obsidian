Plano para abrir o projeto do **bot de previsão ML (meteorologia/Kalshi)** numa pasta própria, fora do vault. Ver contexto e decisões em [[Polymarket]].

## 0. Onde e porquê (FORA do vault)

O vault faz auto-commit ("vault backup"). Um projeto de código **não pode** viver lá dentro: venv, datasets de GiB e `.env` com chaves seriam commitados. Por isso, pasta independente com git próprio.

- **Pasta sugerida:** `~/Documentos/code/kalshi-weather-bot` (irmã do vault, não dentro dele).
- Muda o caminho se preferires; o resto do plano não depende disso.

## 1. Pré-requisitos

- **Python 3.12** (o weather-bot pede 3.10+, o dataset Jon-Becker 3.9+ → 3.12 cobre os dois).
- **`uv`** como gestor de pacotes/venv (rápido; ambos os repos de referência já o usam). Instalar: `curl -LsSf https://astral.sh/uv/install.sh | sh`
- `git` + conta GitHub.
- **Mais tarde, não agora:** conta Kalshi verificada (residência PT) + chave API + RSA key — só para **dados reais em read-only**. Não é preciso depositar dinheiro.

## 2. Abordagem: forkar a base, não começar do zero

- **Base = fork de `suislanchez/polymarket-kalshi-weather-bot`** (licença MIT, podes forkar à vontade). Já te dá *de borla* o que seria o F0–F1: pipeline GFS/NWS, integração com os mercados KXHIGH da Kalshi, modo **simulação por defeito** e Brier tracking.
- **O teu trabalho** = acrescentar a **camada de calibração ML** que falta (eles usam só voto de ensemble cru).
- **Dados de backtest** = `Jon-Becker/prediction-market-analysis` (histórico real Kalshi).
- ⚠️ Não copiar código do `homerun` (é **AGPL-3.0**, copyleft).

## 3. Passos de setup (sequência)

1. Criar pasta e entrar nela; `git init`.
2. `uv init` → cria `pyproject.toml` e venv.
3. Criar `.gitignore` (ignorar `.venv/`, `.env`, `data/`, `*.parquet`, `__pycache__/`).
4. Criar `.env.example` (só os **nomes** das chaves, sem valores: `KALSHI_API_KEY_ID=`, `KALSHI_PRIVATE_KEY_PATH=`).
5. Trazer a base: forkar o weather-bot no GitHub e cloná-lo como ponto de partida (ou clonar para `reference/` se preferires manter a tua estrutura limpa e só copiar o pipeline).
6. Clonar para `reference/` (read-only): `Jon-Becker/prediction-market-analysis` e `arshka/pykalshi` (cliente Kalshi para o feed live, fase F4).
7. `uv sync` para instalar deps.
8. Primeiro commit: `git add -A && git commit -m "scaffold: base weather-bot + estrutura ML"`.

## 4. Estrutura-alvo (módulos a acrescentar à base)

```
kalshi-weather-bot/
├── .gitignore  .env.example  pyproject.toml  README.md
├── data/            # dados reais (gitignored)
├── src/
│   ├── data/        # (da base) ingestão GFS/NWS + mercados KXHIGH
│   ├── model/       # NOVO — a tua camada de calibração ML
│   ├── edge/        # p_modelo vs p_mercado, taxas, Kelly sizing
│   ├── backtest/    # NOVO — avaliação com dataset Jon-Becker
│   └── sim/         # (da base) paper trading / execução simulada
├── notebooks/       # exploração e calibração
├── reference/       # clones read-only (gitignored)
└── tests/
```

## 5. Roadmap por fases (= F0–F5 da nota Polymarket)

- **F0 — Correr a base:** weather-bot em simulação, com dados reais, para veres o fluxo ponta-a-ponta.
- **F1 — Dataset histórico:** integrar Jon-Becker; alinhar mercados KXHIGH com resoluções *point-in-time*.
- **F2 — Calibração:** medir Brier do voto de ensemble **vs Brier do mercado**; adicionar calibração (Platt/isotonic) e o teu modelo.
- **F3 — Backtest honesto:** incluir **taxas Kalshi + slippage**; reliability diagram + PnL simulado.
- **F4 — Paper trading live:** WebSocket Kalshi via `pykalshi`, execução simulada, métricas ao vivo.
- **F5 — (só se validado E houver venue legítimo):** capital real pequeno + limites de risco rígidos.

## 6. Regras de ouro (não negociáveis)

- Nunca commitar segredos (`.env` no `.gitignore` desde o primeiro commit).
- Read-only / paper **até o backtest provar edge**.
- Benchmark de sucesso = **Brier do modelo < Brier do mercado, líquido de taxas**. Não é "acertar X%".
- *Point-in-time* sempre (sem look-ahead).

## 7. "Arrancou" = Definition of Done do setup

Pasta criada fora do vault · `uv sync` ok · weather-bot a correr em simulação com dados reais · primeiro commit feito · `.env` fora do git.
