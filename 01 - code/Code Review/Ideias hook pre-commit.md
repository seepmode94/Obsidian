# Ideias — Hook pre-commit com validação de issue, branch e commit

> Documento de ideias / rascunho. Não é spec final.
> Companion de [[Projeto code review]].

---

## Objetivo

Criar um hook que corre **antes do commit** e:

1. Lê a **issue associada** ao trabalho atual no repositório GitHub.
2. Verifica se existem **conflitos** entre a branch atual e a branch base (ex.: `dev`).
3. Se estiver tudo limpo, valida que:
   - O **nome da branch** segue a convenção.
   - O **título do commit** segue a convenção.
   - O **número da issue** referenciado existe e está aberto.
4. Bloqueia ou avisa, conforme decisão (ver "Decisões em aberto").

---

## Fluxo desejado

```
git commit
   │
   ▼
┌──────────────────────────────────────────┐
│ 1. Detetar branch atual                  │
│    git rev-parse --abbrev-ref HEAD       │
└──────────────────────────────────────────┘
   │
   ▼
┌──────────────────────────────────────────┐
│ 2. Extrair issue ID do nome da branch    │
│    tac-<id>-<slug> → id                  │
└──────────────────────────────────────────┘
   │
   ▼
┌──────────────────────────────────────────┐
│ 3. Verificar conflitos com base branch   │
│    git fetch origin dev                  │
│    git merge-tree HEAD origin/dev        │
└──────────────────────────────────────────┘
   │
   ▼
┌──────────────────────────────────────────┐
│ 4. Ler issue via GitHub API              │
│    GET /repos/:owner/:repo/issues/:id    │
└──────────────────────────────────────────┘
   │
   ▼
┌──────────────────────────────────────────┐
│ 5. Validar regras nominais               │
│    branch + commit message + issue ref   │
└──────────────────────────────────────────┘
   │
   ▼
   ✅ commit segue   |   ❌ aborta + mensagem clara
```

---

## Regras a aplicar (Guia de Boas Práticas — IT)

### Branches

- Sempre em **lowercase**.
- Formato: `tac-<issue_id>-<nome_da_feature_com_hifens>`
- Exemplo válido: `tac-99-fix-user-creation-bug`
- Criadas a partir de `dev` ou de uma release branch.

**Regex sugerida:**
```
^tac-\d+-[a-z0-9]+(-[a-z0-9]+)*$
```

### Primeiro commit da branch

- Formato: `<ISSUE_ID em uppercase>: <Commit message>`
- Exemplo: `TAC-99: Fix User Creation Bug`

**Regex sugerida (1º commit):**
```
^TAC-\d+: .{3,}$
```

### Commits seguintes

- Mensagens curtas, claras e descritivas.
- Não obrigatório repetir o `TAC-<id>:` (mas pode-se permitir).

### Pull Request (fora do scope do hook, mas registar)

- Título: `<ISSUE_ID>: <Resumo>` — ex.: `TAC-99: Add feature name`
- Descrição segue template: Intro → Alterações → Como Testar → Anexos → Alterações Visuais.
- Labels: Área, PR Complexity, Priority, Tipo (Feature/Enhancement/Bug), Status.

---

## Verificações concretas que o hook tem de fazer

- [ ] Branch atual **não é** `main`/`master`/`dev` (commit direto bloqueado).
- [ ] Nome da branch bate com regex acima.
- [ ] Existe `origin/<base>` atualizado — `git fetch` antes do diff.
- [ ] `git merge-tree` (ou `git merge --no-commit --no-ff` em árvore temporária) não devolve conflitos com `dev`.
- [ ] Issue ID extraído da branch existe na API e **está aberta** (`state == "open"`).
- [ ] Mensagem do commit (passada via `$1` no hook `commit-msg`) bate com a regex.
- [ ] Se for o **primeiro commit da branch**, exigir prefixo `TAC-<id>:`.
  - Detetar 1º commit: `git rev-list --count <base>..HEAD` == 0 antes deste commit.

---

## Casos de erro e mensagens

| Situação | Mensagem proposta |
|---|---|
| Branch fora do padrão | `❌ Nome da branch inválido. Esperado: tac-<id>-<slug>. Recebido: <branch>` |
| Issue não encontrada | `❌ Issue TAC-<id> não existe no repositório` |
| Issue fechada | `⚠️ Issue TAC-<id> está fechada — confirma se faz sentido continuar` |
| Conflito com `dev` | `❌ Conflitos detetados com origin/dev. Faz rebase antes de commitar` |
| Commit sem prefixo (1º) | `❌ Primeiro commit deve começar por TAC-<id>:` |
| API GitHub indisponível | `⚠️ Sem rede — a saltar validação de issue` (não bloquear) |

---

## Estrutura de ficheiros sugerida

```
.githooks/
  pre-commit              # bash: orquestra, chama o validador
  commit-msg              # bash: valida formato da mensagem
scripts/
  validate-branch.py      # regex + extração de issue ID
  check-conflicts.sh      # git fetch + merge-tree
  github-issue.py         # GET issue via API, devolve estado
.env                      # GITHUB_TOKEN, REPO_OWNER, REPO_NAME, BASE_BRANCH
.env.example              # mesmo, sem valores
```

Ativar hooks locais (uma vez por clone):
```bash
git config core.hooksPath .githooks
```

---

## Tokens e segurança

- `GITHUB_TOKEN` (fine-grained, scope: `Issues: read`) **apenas em `.env`**, nunca commitado.
- `.env` no `.gitignore`. `.env.example` versionado com placeholders.
- Hook lê `.env` via `source` ou `python-dotenv`.
- Se o token expirar/falhar, o hook deve degradar para warn-only — **não** quebrar o fluxo de quem está só a commitar localmente sem rede.

---

## Decisões em aberto

- **Hook pre-commit ou pre-push?**
  - `pre-commit`: feedback imediato, mas corre a cada commit (custo de rede para chamar GitHub).
  - `pre-push`: corre 1× antes de empurrar — mais barato, valida o lote todo.
  - **Sugestão:** `commit-msg` (validação local: regex branch + msg, instantâneo) + `pre-push` (chamadas à API GitHub + check de conflitos).

- **Bloqueia ou avisa?**
  - Erros estruturais (regex falha, conflito) → **bloqueia**.
  - Issue fechada / API offline → **avisa**.

- **Como detetar o primeiro commit da branch?**
  - `git rev-list --count origin/dev..HEAD` antes do commit.
  - Alternativa: forçar sempre prefixo `TAC-<id>:` (mais simples, menos mágico).

- **Base branch fixa ou configurável?**
  - Para já assumir `dev`. Ler de `.env` (`BASE_BRANCH=dev`) para flexibilidade.

- **Repos múltiplos / prefixo `tac-`:**
  - O guia usa `tac-` (provavelmente um projeto específico). Tornar prefixo configurável via `.env` (`ISSUE_PREFIX=TAC`) para reutilizar noutros projetos.

---

## MVP mínimo

1. `commit-msg` em bash que aplica as duas regex (branch + mensagem). Sem rede, sem GitHub. Custo zero.
2. Adicionar `pre-push` em Python que chama a API GitHub e o `git merge-tree`.
3. Documentar setup no README do repo (1 linha: `git config core.hooksPath .githooks`).

A partir daqui, ligar à camada DeepSeek descrita em [[Projeto code review]] como passo seguinte (revisão de código LLM, separada da validação estrutural).

---

## Fora de scope (por agora)

- Análise semântica do diff (fica no fluxo DeepSeek do outro doc).
- Validação de labels da issue (Area, Priority, Complexity) — pode entrar numa v2.
- Bloqueio de PRs sem template — isso é GitHub Action, não hook local.
