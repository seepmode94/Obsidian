# TAC-20 — Relatório de Sanitização de Dados (Formadores + higiene de contactos)

> Documento de fundamentação e reprodução. Branch `tac-20-sanitizacao`.
> Data: 2026-05-27 · Plataformas: **Seepmode** e **Tacovia**.
> Companheiros: `CONTEXT.md` (log de decisões), `scripts/tac17/SANITIZACAO.md` (método),
> `scripts/tac17/Notebook.ipynb` (auditoria executável).

---

## 1. Sumário executivo

O TAC-20 limpa a base de dados antes da integração cstaff (TAC-17 Fase 2/3). A importação a
partir do SuiteCRM deixou ruído nos `contacts`: sufixos `"- Formador"` no nome, títulos
(`Sr.`, `Eng.`) metidos no `first_name`, contactos duplicados, e engagements órfãos.

Resultado, **uma migration idempotente por plataforma**, gerada/validada a partir de uma
auditoria interativa (notebook), preservando rastreabilidade via tabela `data_quality_flags`
(nada é apagado sem registo):

| Plataforma | Migration | Cobre | Estado |
|---|---|---|---|
| **Seepmode** | `apps/api/src/database/migrations/020_tac20_sanitizacao_fase1.seepmode.sql` | títulos (1 630) + sufixos (23) + órfãos (10) + autolink (1) + NA-orphans (313) + reconcílio `is_trainer_c` + **5 merges** | gerada e validada estaticamente; **falta dry-run + aplicar** |
| **Tacovia** | `apps/api/src/database/migrations/021_tac20_sanitizacao_fase1.tacovia.sql` | títulos (1 691) + strip de 74 sufixos + flag de 8 atípicos | **dry-run real OK (0 erros)**; falta aplicar |

**Achado-chave:** a Tacovia quase não usa o módulo de Formadores (**1** formador real, 3
engagements), logo o grosso do TAC-20 (merges, NA-orphans, reconcílio) **não se aplica lá** —
só a higiene genérica de contactos (títulos + sufixos).

---

## 2. O problema (sujidade detetada)

Origem: migração SuiteCRM → LoungeCRM. Categorias encontradas (detalhe em `SANITIZACAO.md`):

- **Sufixos no nome** — `"Silva - Formador"`, `"(formador)"`, `"Formadora de Asetra Segovia"`.
- **Títulos no `first_name`** — `Sr.`/`Sra.`/`Eng.`/`Dr.` onde devia estar o nome próprio; o
  título pertence ao campo `salutation`.
- **Duplicados** — o mesmo formador em vários `contacts` (e homónimos: pessoas diferentes com
  o mesmo nome).
- **Órfãos NA** — 313 engagements (`trainers`) ligados a 2 contactos placeholder `"NA"`.
- **`is_trainer_c` dessincronizado** — quem dá formações reais sem a flag a `true`.

---

## 3. Método

Ciclo aplicado a cada categoria (no `Notebook.ipynb`):

```
descobrir → caracterizar → decidir (CONTEXT.md) → migration idempotente → verificar
```

1. **Descoberta** — uma célula isola o subconjunto e mostra contagens.
2. **Caracterização** — dimensões, exemplos, padrões.
3. **Decisão** — registada como `TAC20-Dxx` em `CONTEXT.md` (manter / mover / apagar / flag).
4. **Migration** — SQL idempotente (`ON CONFLICT DO NOTHING`, `IF NOT EXISTS`, filtros
   específicos). Sempre que aplicável, escreve `data_quality_flags` com a proveniência.
5. **Verificação** — re-correr a célula: a contagem desce para o esperado.

Princípio transversal (**TAC20-D3**): **não apagar dados de migração** — marcar com
`data_quality_flag` e manter rastreabilidade.

---

## 4. Decisões fundamentadas

Log completo em `CONTEXT.md` (TAC20-D1..D15). Destaques e racional:

### Modelo
- **D1/D2** — uma linha em `trainers` é um *engagement*, não uma pessoa. A pessoa vive em
  `contacts.is_trainer_c`. → A "lista de formadores" é `contacts WHERE is_trainer_c=true`.
- **D6** — `data_quality_flags` polimórfica (`parent_type`, `parent_id`, `flag_code`,
  `severity`, `details` JSONB, `resolved_at`). Reutilizável, sem FK formal (parent muda).

### Normalização de nomes/títulos
- **D12/D14** — títulos no `first_name` movem-se para `salutation` canónico; `Eng` (sem ponto)
  é o canónico porque já existiam centenas assim. `first_name` fica `''` (coluna `NOT NULL`).
- **D15** — promover `is_trainer_c=true` quando o sufixo "Formador" é evidência directa
  (seepmode). **Excepção:** quem é referenciado mas não é formador (P3-cross-ref).

### Órfãos
- **D3** — os 313 NA-orphans **mantêm-se** e ficam marcados (`na-orphan`), não se apagam.
- **D9/D10/D11** — órfãos com account: P1/P2 limpam nome+flag; P2 auto-liga à account quando o
  `affiliation_hint` casa único em `accounts.name`; P3 é cliente que referencia um formador.

### Merge de duplicados (**D13** — a decisão mais delicada, refinada durante a revisão)
Regra final: **só se funde quando há prova de IDENTIDADE; nunca por nome só.**

- **Vencedor** = o contacto com mais relações (FKs). Tie-break: `is_trainer_c` → `date_entered`
  mais antigo → `id`.
- **Prova de identidade (funde):** email pessoal de domínio **gratuito** igual (gmail/hotmail…),
  ou telemóvel com **fan-out baixo** (≤2 contactos).
- **NÃO prova identidade (não funde — só indica empregador):**
  - **telefone partilhado por muitos** = central da empresa;
  - **account partilhada** = mesma empresa, não mesma pessoa;
  - **`nome.apelido@empresa`** = convenção corporativa (qualquer homónimo a recebe).
- **Homónimos** (nomes iguais, emails/empresas diferentes) → **mantidos separados**.
- **Multi-empresa** (mesma pessoa, vários empregos) → um contacto com **vários emails + várias
  accounts**; `email1` = o **pessoal mais recente**; só por decisão manual com prova.

> *Porquê este cuidado:* a deteção inicial por nome canónico agrupou 307 contactos em 51 grupos
> — mas nomes comuns (`António Silva`, `João Silva`) misturavam **pessoas diferentes**. A
> clusterização por **email pessoal** colapsou isto para **5 merges reais** (16→5 absorções),
> e os restantes ficaram corretamente separados.

### Casos específicos
- **Miguel Mota** (seepmode) — accounts `…Teste`/`XPTO`, telefones placeholder `999999999` →
  **dados de teste**. Excluído do merge (`keep_separate`).
- **Tacovia** — 1 formador real → **não promover `is_trainer_c`** nos contactos sufixados
  (não há sessions que o justifiquem); só strip do nome + flag.

### Em aberto
- **D7** — lifecycle dos flags (quem resolve `manual-review-required` / `*-no-engagements`).
- **D8** — Tacovia: resolvido como higiene genérica (ver §5.2).

---

## 5. Resultados por plataforma

### 5.1 Seepmode (`020_…seepmode.sql`)

| Categoria | Qtd | Acção |
|---|---|---|
| Cat K — títulos em `first_name` | 1 630 | → `salutation` canónico (`Mr.` 1175, `Mrs.` 225, `Eng` 117, `Dr.` 113) |
| Cat B — RENAME-only | 23 | strip sufixo + `is_trainer_c=true` |
| Cat F.2 — órfãos sem sessions | 10 | P1/P2/P3/P4/P5/P-junk |
| Autolink P2 | 1 | `accounts_contacts` (Sonia ↔ Asetra) |
| Cat G — NA-orphans | 313 + 2 | flag `na-orphan` / `placeholder-contact-na` (mantidos) |
| Cat H — reconcílio `is_trainer_c` | ~132 | promove reais (cadeia sessions) + flag falsos |
| Merges | 5 (absorve 5) | repoint + soft-delete + flags `merged-into`/`merged-from` |

Validação estática: 0 `NaN`, 43 literais `::jsonb` válidos, contagens coerentes. **Pendente:
dry-run + `db:migrate`.**

### 5.2 Tacovia (`021_…tacovia.sql`)

Contexto: 56 035 contactos, 3 002 trainings, mas **apenas 3 `trainers` / 1 formador real**.

| Categoria | Qtd | Acção |
|---|---|---|
| Cat K — títulos em `first_name` | 1 691 | → `salutation` canónico (set-based) |
| Sufixo `- Formador` trailing | 74 | strip via regexp; **sem** promover `is_trainer_c` |
| Atípicos (parêntesis/afiliação/outros) | 8 | flag `name-contains-formador-token` (revisão manual) |

Sem merges / NA-orphans / reconcílio (moot na tacovia). **Validação: dry-run real (BEGIN/ROLLBACK,
`ON_ERROR_STOP=1`) → 0 erros, flags 1691/74/8, `first_name` pós-update = 0.**

---

## 6. Runbook (reprodução, passo a passo)

> Todos os comandos a partir da raiz do repo. Postgres em containers docker.

### 6.1 Levantar a infra
```bash
docker compose up -d            # postgres seepmode/tacovia, redis, etc.
```

### 6.2 Restaurar os dumps de dev (fora do repo, em documentation/suitecrm/db/)
```bash
# Dumps disponíveis:
#   documentation/suitecrm/db/seepmode-pre-deploy-2026-05-18-1233.sql(.gz)
#   documentation/suitecrm/db/tacovia-pre-deploy-2026-05-18-1233.sql(.gz)

# Restore (dump 'clean' pg_dump 16; recria os objetos). Exemplo seepmode via container:
docker exec -i -e PGPASSWORD=loungecrm_dev loungecrm-postgres-seepmode \
  psql -U loungecrm -d loungecrm_seepmode -v ON_ERROR_STOP=0 \
  < documentation/suitecrm/db/seepmode-pre-deploy-2026-05-18-1233.sql

# Para garantir um restore limpo (evita conflitos de dependências, ex.: tabela users),
# dropar+recriar a BD antes:
docker exec -e PGPASSWORD=loungecrm_dev loungecrm-postgres-seepmode psql -U loungecrm -d postgres \
  -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='loungecrm_seepmode' AND pid<>pg_backend_pid();" \
  -c "DROP DATABASE IF EXISTS loungecrm_seepmode;" \
  -c "CREATE DATABASE loungecrm_seepmode OWNER loungecrm;"
```

> **Nota de ambiente local (2026-05-27):** neste host havia PostgreSQL **nativo** a ocupar as
> portas 5433/5434, em colisão com os containers docker. O notebook liga seepmode a
> `localhost:5432` (via `.env: SEEPMODE_DB_PORT=5432`). Para a tacovia ser auditada pelo notebook,
> o dump tem de ser restaurado **na BD que o notebook alcança** (`localhost:5433`); restaurar com
> `psql` descartável na rede do host:
> ```bash
> docker run --rm -i --network host -e PGPASSWORD=loungecrm_dev postgres:16-alpine \
>   psql -h 127.0.0.1 -p 5433 -U loungecrm -d loungecrm_tacovia \
>   < documentation/suitecrm/db/tacovia-pre-deploy-2026-05-18-1233.sql
> ```

### 6.3 Auditar e gerar o SQL (notebook)
```bash
cd scripts/tac17 && source .venv/bin/activate     # reativar venv em cada shell nova
code Notebook.ipynb                                # abrir no VS Code (kernel = .venv da pasta)
```
- Definir `PLATFORM = 'seepmode'` (ou `'tacovia'`) na 1ª célula.
- **Run All** → a última célula (**BUILD-FINAL**) escreve o `.sql` da plataforma.
- *(Tacovia: o `021_…tacovia.sql` é set-based e também pode ser mantido à mão — não exige notebook.)*

### 6.4 Dry-run (valida o SQL sem alterar nada)
```bash
{ echo "BEGIN;"; cat apps/api/src/database/migrations/020_tac20_sanitizacao_fase1.seepmode.sql; echo "ROLLBACK;"; } \
| docker exec -i -e PGPASSWORD=loungecrm_dev loungecrm-postgres-seepmode \
    psql -U loungecrm -d loungecrm_seepmode -v ON_ERROR_STOP=1
# Terminar em ROLLBACK sem ERROR = SQL válido.
```

### 6.5 Aplicar
```bash
PLATFORM=seepmode pnpm db:migrate      # aplica 020_…seepmode.sql
PLATFORM=tacovia  pnpm db:migrate      # aplica 021_…tacovia.sql
```
> O runner filtra por sufixo de plataforma (`.seepmode.sql` só corre com `PLATFORM=seepmode`).

### 6.6 Verificar (pós-aplicação)
```sql
-- lista canónica de formadores (seepmode)
SELECT * FROM contacts WHERE is_trainer_c = true AND deleted = false;
-- proveniência das normalizações
SELECT flag_code, count(*) FROM data_quality_flags GROUP BY 1 ORDER BY 2 DESC;
```

---

## 7. Artefactos

- **Migrations:** `apps/api/src/database/migrations/020_tac20_sanitizacao_fase1.seepmode.sql`,
  `…/021_tac20_sanitizacao_fase1.tacovia.sql`.
- **Auditoria:** `scripts/tac17/Notebook.ipynb` (limpar outputs antes de partilhar — contêm
  nomes/IDs reais).
- **Decisões:** `CONTEXT.md` (TAC20-D1..D15).
- **Método/categorias:** `scripts/tac17/SANITIZACAO.md`.
- **Dumps de dev:** `documentation/suitecrm/db/{seepmode,tacovia}-pre-deploy-2026-05-18-1233.sql(.gz)`.

---

## 8. Pendente / próximos passos

1. **Seepmode:** dry-run (§6.4) → `db:migrate` (§6.5).
2. **Tacovia:** `db:migrate` (dry-run já validado).
3. **Higiene:** limpar outputs do notebook + commit no branch `tac-20-sanitizacao`.
4. **Fora de scope desta migration (tracks à parte):**
   - **Cat I** — `trainers.training_id IS NULL` (2 634): investigação de FK.
   - **Cat J** — dropdown `salutation_dom` sem `Eng`: migration trivial.
   - **D7** — workflow de resolução dos flags.
