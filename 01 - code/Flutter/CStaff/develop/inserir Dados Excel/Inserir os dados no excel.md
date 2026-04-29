em falta 3 correspondências : 
- João Ribeiro Gomes
-  Luis Moura
  - Rita Teixeira

  Resumo:

  - 419 pedidos de férias planeados em OpsDock-development/apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/leave-import-plan/leave-requests-plan.csv
  - 79 linhas de saldo em OpsDock-development/apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/leave-import-plan/leave-balances-plan.csv
  - 70 saldos ready
  - 9 saldos review
  - 21 bloqueios em OpsDock-development/apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/leave-import-plan/blocked-items.json

  Bloqueios principais:

  - 6 colaboradores sem correspondência final: Inês Maia, João Mateus, João Ribeiro Gomes, Luis Moura, Miguel Angelo Pinto, Rita Teixeira
  - 9 colaboradores com diferença entre Total do Excel e dias marcados, por exemplo Paulo Livramento, Casimiro Gomes, José Lopez, Ricardo Pimentel

  Ponto importante: o plano assume que:

  - os pedidos entram como approved
  - o tipo é vacation
  - o carriedOver vem do valor único de <2026 por colaborador
  - os pedidos são agrupados por dias úteis consecutivos

  O próximo passo certo é:

  1. fechar o ficheiro de overrides dos 6 nomes
  2. decidir se os 9 casos com mismatch ficam para revisão manual ou se queres uma regra de import

				AQUI!!
				

• # Pending Leave Import Review

  Date: 2026-03-23

  ## Context

  Imported successfully:
  - 73 ready vacation balances for 2026
  - 435 approved vacation requests

  Still pending review:
  - 3 unmatched employees
  - 9 total mismatches between Excel `Total` and marked days

  ## Unmatched Employees

  These were **not imported** and still need a manual decision:

  1. `João Ribeiro Gomes`
     - Suggested matches:
     - `João Gomes` (`jgomes`, `joaogomes@seepmed.pt`)
     - `João Gomes Novo` (`jnovo`, `jgomes@tacovia.eu`)

  2. `Luis Moura`
     - No strong match
     - Closest names seen:
     - `Luis Arruda`
     - `Luis Barradas`
     - `Luis Candeias`
     - `Luis Monteiro`
     - `Luís Oliveira`

  3. `Rita Teixeira`
     - No strong match
     - Closest names seen:
     - `Ana Teixeira`
     - `Rita Fonseca`

  ## Balance Mismatches

  These employees were matched, but their Excel `Total` does not match the number of marked days. They were left out of the automatic import plan for balances/requests that depend on that exact count.

  | Employee | Employee Number | Excel Total | Marked Days |
  |----------|------------------|-------------|-------------|
  | Paulo Livramento | `plivramento` | 24.5 | 25 |
  | Casimiro Gomes | `cgomes` | 19 | 18 |
  | Filipe Folgado | `ffolgado` | 8 | 9 |
  | João Gomes | `jgomes` | 21 | 22 |
  | José Lopez | `jlopez` | 23 | 25 |
  | Ricardo Pimentel | `rpimentel` | 19 | 22 |
  | Susana Soares | `ssoares` | 18 | 20 |
  | Filipe Sousa | `fsousa` | 17 | 18 |
  | Susana Vaz | `svaz` | 10 | 12 |

  ## Useful Files

  - Normalization summary:
    - `apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/summary.json`
  - Match review:
    - `apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/employee-match-review/unmatched.json`
  - Import plan:
    - `apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/leave-import-plan/blocked-items.json`
  - Imported plan source:
    - `apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/leave-import-plan/leave-balances-plan.csv`
    - `apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/leave-import-plan/leave-requests-plan.csv`

  ## Recommended Next Step

  1. Resolve the 3 unmatched employees
  2. Decide how to handle the 9 mismatches:
     - trust Excel `Total`
     - trust marked days
     - correct case by case
  3. Generate a second import plan for the remaining blocked items

Vamos começar por fazer a leitura das férias marcadas e que os endpoints sejam consumidos dos dias supostos

criar um botao para importar ficheiros para fazer match do excel
e outro botao de exportar modelo
