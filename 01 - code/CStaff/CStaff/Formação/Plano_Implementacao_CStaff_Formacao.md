# Plano de Implementação — Módulo Formação no CStaff

**Objetivo:** clonar exatamente o `form.seepmode.com` dentro do CStaff (OpsDock). **Paridade total** — mesmos campos, mesmas páginas, mesmos relatórios, mesmos perfis. Sem normalizações criativas, sem cortes.

**Como usar este plano:** está organizado em **fases incrementais**. Cada fase tem um *prompt pronto a colar* dentro do repo OpsDock para o Claude trabalhar. As fases podem (e devem) ser feitas uma de cada vez — valida cada uma antes de avançar.

---

## 0. Stack do CStaff/OpsDock

| Camada | Tecnologia | Localização |
|---|---|---|
| Backend API | NestJS + TypeScript + PostgreSQL + BullMQ | `OpsDock-development/apps/api` |
| Frontend Web | Next.js 14 (App Router) + React 18 + Tailwind + shadcn/ui | `OpsDock-development/apps/web` |
| Mobile (futuro) | Flutter | `OpsDock-mobile/` |
| Storage de ficheiros | MinIO (S3-compatible) | `OpsDock-development/infra` |
| Auth | JWT + Refresh Tokens | já existente |
| Tipos partilhados | TypeScript shared package | `OpsDock-development/packages/shared` |

**Convenção:** o módulo chama-se `formacao` no backend e `/formacao/*` no frontend.

---

## 1. Inventário do que existe em `form.seepmode.com`

> **Nota (snapshot xlsx 2026-04-21):** o ficheiro `04_2_Produtividade Formação_20260421_IM.xlsx` tem 12 folhas (não 2). Para além de `02 - 2025` (2078 ações) e `02 - 2026` (799 ações), tem `01 - Tx Crescimento`, `GLOBAIS` (mapa semanal por parelha), `202602`/`202603` (apuramento real de prémios — secção 1.6 → Prémios), `Analise`, `ROTAS` (50 vendedores com Zona/OP/ADM/contacto), `Divisão Rotas` (cálculo de zonas), `INES` (working draft pessoal), e `Passwords`/`pass recrutamento` (credenciais externas — **não migrar**).

### 1.1 Áreas principais (top nav)

| Tab | Função |
|---|---|
| **Home** | Listagem + CRUD de ações de formação (815 registos atualmente) |
| **Dashboard** | 3 widgets: Produção por mês, Tipologia de ações, Resumo analítico |
| **Relatórios** | 5 sub-relatórios: Taxa de crescimento, Relatório de atividades, Prémios, Operador, ADM |
| **Utilizadores** | Gestão de utilizadores e perfis |

**Toggle global:** `Plano 2026` / `Plano 2025` (separa registos por ano-plano).

### 1.2 Perfis de utilizador (do form)

`Admin`, `Coordenação`, `ADM`, `Gestor`.

Exemplo: `acastanheira → ADM`, `admin → Admin`, `asalgueiro → Coordenação`, `imaia → Gestor`.

### 1.3 Listagem (Home)

**Filtros básicos** (12): N.º ação, Curso, Número, Nome formador, Formador/Estado, Data início, Data fim, Localidade, Tipo, Estado, OP, ADM.

**Atalhos:** 7 dias | 1 mês | 1 ano | Limpar | Pesquisar.

**Filtro rápido:** filtra apenas resultados já carregados (client-side).

**Ordenação:** dropdown "Ordenar por coluna" + Ascendente/Descendente.

**Tabela:** Empresa (P01) · Tipo (A) · Número (B) · Cliente (P07) · N.º ação (C) · Curso (D) · Data (E) · Localidade (F) · Participantes (G) · OP (H) · Admin (I) · Ações [Ver | Editar | Eliminar].

**Paginação:** "1 - 100 de 815", botões « ‹ › ».

**Ações em lote** + checkbox por linha + checkbox "selecionar todos".

**Botão `Novo registo`.**

### 1.4 Detalhe do Registo — 65 campos

Os campos estão organizados em grelha 3 colunas. Lista completa (na ordem em que aparecem no form):

| # | Campo | Tipo sugerido | Notas |
|---:|---|---|---|
| 1 | EMPRESA | FK Empresa | "Seepmed", "Seepmode", "Tacovia" |
| 2 | TIPO | enum | Presencial \| E-learning |
| 3 | NÚMERO | int | sequencial |
| 4 | N.º AÇÃO | text | ex.: M216/26 |
| 5 | CURSO | FK Curso | enum/lookup (~70 cursos) |
| 6 | DATA | date | |
| 7 | LOCALIDADE | text | |
| 8 | PARTICIPANTES | int | |
| 9 | OP | FK Utilizador | iniciais |
| 10 | NOME DO FORMADOR | FK Formador (opcional text) | |
| 11 | EXTERNO/INTERNO | enum | Interno \| Externo |
| 12 | HORAS | int | |
| 13 | VALOR HORA | currency (€) | |
| 14 | TOTAL HONORÁRIOS | currency | |
| 15 | CLIENTE | FK Cliente | |
| 16 | KMS/DIESEL | currency | |
| 17 | VALOR DESPESA | currency | |
| 18 | IVA DESPESA | currency | |
| 19 | ADMIN | FK Utilizador | iniciais |
| 20 | IRS | currency | |
| 21 | VALOR FINAL | currency | |
| 22 | DTP ENTREGUE | text/Sim-Não | |
| 23 | N.º RECIBO | text | |
| 24 | DATA DE PAGAMENTO | date | |
| 25 | TESOURARIA | text | |
| 26 | IVA TESOURARIA | currency | |
| 27 | NOME DA SALA | text | |
| 28 | VALOR DA SALA | currency | |
| 29 | DATA PAG. SALA | date | |
| 30 | VER/OBS. | text livre | |
| 31 | TIPO 2 | text | |
| 32 | FORMADOR/ESTADO | enum | Confirmado, Pendente, Recusado, … |
| 33 | CONFIRMACAO | text | ex.: "SQ #18.02.2026 Enviada" |
| 34 | ADJUDICACAO | text | idem (data tipicamente posterior) |
| 35 | SALA | text livre | |
| 36 | ACIMA DE 15 | enum Sim/Não | |
| 37 | FECHADA | enum Sim/Não | |
| 38 | DATA FECHO | date | |
| 39 | OP FECHO | FK Utilizador | |
| 40 | FALTAM DADOS | enum Sim/Não/text | |
| 41 | N. CERTIFICADOS | int | |
| 42 | OP ENVIO | FK Utilizador | |
| 43 | DATA ENVIO | date | |
| 44 | ENTRADA DTP | enum Sim/Não | |
| 45 | FOLHA DE PRESENÇAS | enum Sim/Não | |
| 46 | DIGITALIZADO | enum Sim/Não | |
| 47 | CV | enum Sim/Não | |
| 48 | FICHA CURRICULAR | enum Sim/Não | |
| 49 | CCP | enum Sim/Não | |
| 50 | TESTE | enum Sim/Não | |
| 51 | QUESTIONÁRIOS FORMANDOS | enum Sim/Não | |
| 52 | RELATÓRIOS AVALIATIVOS | enum Sim/Não | |
| 53 | REGISTOS E RESULTADOS | enum Sim/Não | |
| 54 | AVALIAÇÃO FORMADOR | enum Sim/Não | |
| 55 | PAUTA | enum Sim/Não | |
| 56 | SF | text/iniciais | |
| 57 | MD | text/iniciais | |
| 58 | TS | text/iniciais | |
| 59 | CB | text/iniciais | |
| 60 | JM | text/iniciais | |
| 61 | SF 2 | text | |
| 62 | MD 2 | text | |
| 63 | TS 2 | text | |
| 64 | CB 2 | text | |
| 65 | JM 2 | text | |

> **Regra:** todos os campos são opcionais por defeito (o form atual aceita "Sem valor" em quase tudo). Apenas `Tipo`, `N.º Ação`, `Data` são obrigatórios. **Não cortar campos**, mesmo os sub-utilizados.

> **Schema divergente entre anos:** o Excel não tem o mesmo conjunto de colunas em `02 - 2025` e `02 - 2026`. 2026 acrescenta `> acima de 15`, `Folha presenças`, `Digitalizado`, `CV`, `Ficha curricular`, `CCP`, `Teste`, `Quest. formandos`, `Rel. Estatística`, `Registos e resultados`, `Aval. Formador`, `Pauta`, e flags por pessoa `SF/MD/TS/CB/JM` em duas passagens. 2025 só tem `PP/LS/MJF`. **O importer (F14) tem de usar mapeamento de colunas por ano**, não único. No CStaff a tabela é única (todas as colunas existem); para ações de 2025 os campos novos ficam null.

### 1.5 Dashboard

3 widgets lado a lado:

1. **Produção por mês** — gráfico de barras empilhadas mensais (Presencial / E-Learning / Outros). Ex.: 01/26=184, 02/26=151, 03/26=192…
2. **Tipologia de ações** — top 10 cursos por nº de ações, gráfico de barras horizontais com valor à direita (TC=138, PS=48, HST=47…).
3. **Resumo analítico** — 5 cards: Total de ações, Presencial, E-Learning, Outros tipos, Tipologias ativas. + barra horizontal "Peso do presencial" com %.

### 1.6 Relatórios

**Tabs:** Taxa de crescimento · Relatório de atividades · Prémios · Operador · ADM.
Cada tab tem botão **Exportar** no canto superior direito.
Header comum: `Fonte atual: 02 - 2026`.

#### Taxa de crescimento
- Cards: Total Ações, Total Formandos, Meses com dados, Último período.
- Tabela "Evolução mensal" (Mês / Ações / Formandos).

#### Relatório de atividades
- Cards: Total Ações, Participantes, Fechadas, Por Fechar, Dados em falta, Envios, Certificados.
- Tabela "Tipologia de ações" (Tipologia / Ações / Fechadas / Dados em falta).

#### Prémios
- **Não é placeholder.** A regra oficial existe nas folhas `202602` e `202603` do Excel e é aplicada manualmente todos os meses.
- **Variáveis de input** (por mês de referência):
  - Por parelha (4 equipas): cada parelha = OP + ADM. Equipas vistas no Excel: `SF/MC`, `MD/FG`, `JM/MS`, `CB/IF`, `TS/SD`.
  - Por OP individual: contagem de ações no mês.
  - Por equipa de OPs (grupo): soma das ações dos colegas da mesma zona.
  - Dias de mês trabalhados por cada pessoa (presença).
  - Ações que **contam para o prémio** (≥15 alunos por ação).
- **Tabela de prémios** (cabeçalhos vistos em `202602!A4:H8`):
  - Faixas individuais: 1–4 ações = 0€, 5–10 = 3€/ação, 11–15 = 6€/ação, 16+ = 9€/ação.
  - Faixas de grupo: 4–16 ações = 0€, 17–40 = 3€, 41–60 = 6€, 61+ = 9€.
  - Total por pessoa = (parelha + grupo) × dias trabalhados/dias úteis.
- **Condições obrigatórias** (todas têm de ser verdadeiras):
  - Fecho completo das ações até ao último dia do mês seguinte.
  - Área administrativa, pedagógica e operacional/vendas em dia.
  - Média mensal ≥15 alunos por ação.
  - Pessoa presente nos 2 meses de operacionalização.
  - Todas as ações do mês fechadas (não apenas as que contam para o prémio).
  - **O prémio de parelha só é atribuído se o de grupo também o for.**
  - Valor mínimo a pagar: 50€ (abaixo disso não há pagamento).
- **Output esperado**: por mês, lista `{ pessoa, parelha, equipa, ações, ações≥15, diasÚteis, diasTrabalhados, prémioParelha, prémioGrupo, total€, atribuído }`.

#### Operador
- Cards: Operadores, Ações mensais listadas, Ações semanais listadas, Top ranking.
- Duas tabelas lado-a-lado: "Ações por mês" (Período / Operador / Ações) + "Ações por semana" (Período / Operador / Ações). Toggle Mensal/Semanal.

#### ADM
- Cards: ADM ativos, Certificados listados, Envios listados, Top ranking.
- Tabela "Indicadores por mês" (Período / ADM / Ações / Fechos / Envios / Certificados).

### 1.7 Utilizadores

- Filtro por Perfil.
- Botões `Limpar filtro`, `Novo utilizador`, `Atualizar`.
- Tabela: Utilizador (link) / Perfil / Contacto / Estado (toggle Ativo) / Criado em / Ações [Editar].

---

## 2. Modelo de dados (TypeORM/Prisma — adaptar à convenção do repo)

### 2.1 Tabelas auxiliares (popular antes da tabela principal)

```ts
Empresa { id, nome, ativo }                      // Seepmed, Seepmode, Tacovia
Curso { id, codigo, nome, tipoDefault, ativo }   // TC, HST, PS, e-Tacógrafos…
Cliente { id, nome, ativo }                      // ~centenas
Formador { id, nome, tipo: INTERNO|EXTERNO, valorHoraDefault?, ativo }
Localidade { id, nome }                          // opcional — pode ser text livre
PerfilUtilizador { ADMIN, COORDENACAO, ADM, GESTOR }

// Decorrente da folha ROTAS / Divisão Rotas:
Zona { id, nome }                                // Centro Sul, Centro, NORTE, Norte Med, Taco
Parelha { id, codigo, opUserId: FK, admUserId: FK, equipaNum: int, zonaId: FK }
                                                 // SF/MC, MD/FG, JM/MS, CB/IF, TS/SD
Vendedor { id, nome, empresaId: FK, zonaId: FK,
           parelhaId: FK,                        // OP/ADM responsáveis
           rotaNome: string,                     // ex.: "Vendas SST Lx Centro"
           telemovel?, email?, ativo }
```

> **Origem dos dados:** `ROTAS` (50 vendedores → Empresa, Zona, OP, ADM, contacto, email) e `Divisão Rotas` (alocação de vendedores por zona/coordenador). O seed da F1 importa daqui — não inventar listas.

### 2.2 Tabela principal `acao_formacao`

Os 65 campos do detalhe + auditoria:

```ts
AcaoFormacao {
  id: uuid
  planoAno: int                  // 2025, 2026 (toggle)
  numeroAcao: string             // "M216/26" — único por planoAno
  numeroSequencial: int          // sequencial dentro do plano
  empresaId: FK
  tipo: enum (PRESENCIAL | ELEARNING)
  cursoId: FK
  data: date
  localidade: string
  participantes: int

  // Pessoas
  opId: FK Utilizador
  adminId: FK Utilizador
  formadorId: FK? Formador
  formadorNomeLivre: string?     // fallback se não FK
  formadorTipo: enum (INTERNO | EXTERNO)
  formadorEstado: enum (PENDENTE|CONFIRMADO|RECUSADO|null)

  // Logística
  horas: int?
  salaTexto: string?
  salaNome: string?
  salaValor: decimal?
  salaDataPagamento: date?
  confirmacao: string?           // texto livre, ex. "SQ #18.02.2026 Enviada"
  adjudicacao: string?
  tipo2: string?

  // Cliente / financeiro
  clienteId: FK?
  valorHora: decimal?
  totalHonorarios: decimal?
  kmsDiesel: decimal?
  valorDespesa: decimal?
  ivaDespesa: decimal?
  irs: decimal?
  valorFinal: decimal?
  dtpEntregue: string?
  numRecibo: string?
  dataPagamento: date?
  tesouraria: string?
  ivaTesouraria: decimal?

  // Estado/fecho
  acimaDe15: bool                // auto = participantes >= 15 OU manual
  fechada: bool
  dataFecho: date?
  opFechoId: FK?
  faltamDados: string?           // texto/Sim/Não
  numCertificados: int?
  opEnvioId: FK?
  dataEnvio: date?

  // Dossier (Sim/Não — futuro: file)
  entradaDTP: bool
  folhaPresencas: bool
  digitalizado: bool
  cv: bool
  fichaCurricular: bool
  ccp: bool
  teste: bool
  questionariosFormandos: bool
  relatoriosAvaliativos: bool
  registosResultados: bool
  avalFormador: bool
  pauta: bool

  // Flags equipa (replicar exatamente o form, mesmo que pouco usados)
  sf: string?
  md: string?
  ts: string?
  cb: string?
  jm: string?
  sf2: string?
  md2: string?
  ts2: string?
  cb2: string?
  jm2: string?

  // Outros
  observacoes: string?           // VER/OBS.

  // Auditoria
  criadoEm: timestamp
  criadoPorId: FK
  atualizadoEm: timestamp
  atualizadoPorId: FK
}
```

**Índices recomendados:** `(planoAno, numeroAcao)` único · `(planoAno, data)` · `(opId)` · `(adminId)` · `(cursoId)` · `(empresaId)` · `(fechada)`.

---

## 3. API — endpoints necessários

Convenção REST sob `/api/v1/formacao/*`:

```
# Ações
GET    /acoes                    # paginado, filtros via query
GET    /acoes/:id
POST   /acoes
PATCH  /acoes/:id
DELETE /acoes/:id
POST   /acoes/bulk-delete        # ações em lote
POST   /acoes/bulk-update        # ações em lote

# Lookups
GET    /empresas
GET    /cursos
GET    /clientes
GET    /formadores
GET    /utilizadores             # já existe → reusar

# Dashboard
GET    /dashboard?planoAno=2026
       → { producaoPorMes, tipologiaAcoes, resumoAnalitico }

# Relatórios
GET    /relatorios/taxa-crescimento?planoAno=2026
GET    /relatorios/atividades?planoAno=2026
GET    /relatorios/operador?planoAno=2026&granularidade=mensal|semanal
GET    /relatorios/adm?planoAno=2026
GET    /relatorios/premios?planoAno=2026&mes=2026-02   # cálculo real
POST   /relatorios/premios/recalcular?mes=2026-02       # força recompute
GET    /relatorios/:tipo/exportar  # CSV/XLSX

# Importação (migração inicial)
POST   /import/xlsx              # upload do Excel atual
GET    /import/preview/:jobId
POST   /import/confirm/:jobId
```

**Permissões** (RBAC):
- `Admin`: tudo.
- `Coordenação`: leitura/escrita ações + relatórios; sem gestão de utilizadores.
- `ADM`: leitura/escrita campos administrativos (fecho, certificados, envio); leitura geral.
- `Gestor`: leitura geral + escrita restrita aos seus registos.

---

## 4. Roteiro por fases

Cada fase é uma unidade entregável. Estimativa em horas só para sentido de ordem de grandeza.

| Fase | Conteúdo | Estimativa |
|---|---|---:|
| **F0** | Setup do módulo + scaffolding | 2h |
| **F1** | Tabelas auxiliares + seeds | 4h |
| **F2** | CRUD da `AcaoFormacao` (API) | 6h |
| **F3** | Listagem (Home) com filtros + paginação | 6h |
| **F4** | Detalhe e formulário de criação/edição | 8h |
| **F5** | Toggle Plano 2025/2026 + estado global | 2h |
| **F6** | Dashboard (3 widgets) | 6h |
| **F7** | Relatório: Taxa de crescimento | 3h |
| **F8** | Relatório: Atividades | 3h |
| **F9** | Relatório: Operador | 4h |
| **F10** | Relatório: ADM | 4h |
| **F11** | Relatório: Prémios (cálculo real — ver 1.6.3) | 6h |
| **F12** | Exportação CSV/XLSX dos relatórios | 4h |
| **F13** | Utilizadores (reusar módulo existente; adicionar perfis se faltarem) | 3h |
| **F14** | Migração: importer XLSX | 8h |
| **F15** | Polimento UI (filtro rápido, ordenação, ações em lote) | 4h |
| **F16** | Testes E2E + correção de bugs | 6h |

**Total ≈ 79h** (~2 sprints semanais).

---

## 5. Prompts prontos para o Claude no repo

> Coloca-te na raiz do `OpsDock-development` antes de colar cada prompt.
> Cada prompt é **independente** — Claude pode executá-lo sem contexto anterior.
> Após cada um, valida e só depois passa ao seguinte.

### F0 — Scaffolding

```
Cria um novo módulo "formacao" no monorepo OpsDock:

- Backend: gera apps/api/src/formacao/ com módulo NestJS standard
  (formacao.module.ts, formacao.controller.ts, formacao.service.ts,
  pasta entities/, pasta dto/). Regista o módulo no AppModule.
- Frontend: cria apps/web/app/formacao/ com layout próprio, e
  páginas placeholder em app/formacao/page.tsx (Home),
  app/formacao/dashboard/page.tsx, app/formacao/relatorios/page.tsx,
  app/formacao/utilizadores/page.tsx.
- Adiciona um item de navegação "Formação" no sidebar/topbar.
- Cria packages/shared/src/formacao/ para tipos partilhados.

Não implementes lógica ainda — só estrutura. Verifica que pnpm dev arranca sem erros.
```

### F1 — Tabelas auxiliares + seeds

```
Cria as entidades auxiliares para o módulo formacao em apps/api/src/formacao/entities/:

- Empresa { id, nome, ativo }
- Curso { id, codigo, nome, tipoDefault, ativo }
- Cliente { id, nome, ativo }
- Formador { id, nome, tipo: 'INTERNO'|'EXTERNO', valorHoraDefault?, ativo }
- Zona { id, nome }
- Parelha { id, codigo, opUserId, admUserId, equipaNum, zonaId }
- Vendedor { id, nome, empresaId, zonaId, parelhaId, rotaNome, telemovel?, email?, ativo }

Cria as migrations correspondentes e endpoints GET (read-only por agora) em
/api/v1/formacao/{empresas,cursos,clientes,formadores,zonas,parelhas,vendedores}.

Cria seed em apps/api/src/seeds/formacao-lookups.seed.ts que lê o ficheiro
"04_2_Produtividade Formação_20260421_IM (1).xlsx" (path passado por env
FORMACAO_SEED_XLSX) e popula:

1. Empresas (folha ROTAS, coluna A): Seepmed, Seepmode, Tacovia.
2. Zonas (folha ROTAS, coluna E): Centro Sul, Centro, NORTE, Norte Med, Taco.
3. Vendedores (folha ROTAS, linhas 3–50): nome (D), zona (E), rota (F),
   operacional/OP (G), administrativa/ADM (H), telemóvel (I), email (J),
   empresa (A).
4. Parelhas (deduzidas das colunas G/H da ROTAS): SF/MC, MD/FG, JM/MS, CB/IF,
   TS/SD — equipaNum vem do número (B) da ROTAS.
5. Cursos: lê os valores únicos da coluna D ("Curso") em "02 - 2026" e "02 - 2025".
   Para cada um, cria { codigo, nome }. Se o valor parece já um nome longo
   (>5 chars), usa como nome e gera código a partir da primeira maiúscula.
6. Clientes: lê valores únicos da coluna R em "02 - 2026" (campo CLIENTE).
7. Formadores: lê valores únicos da coluna J/K (formador) em ambas as folhas.
   Marca tipo INT/EXT conforme a coluna seguinte (K em 2026).

Verifica que o seed corre limpo num docker compose down/up. Imprime contagens
no final (ex.: "50 vendedores, 5 zonas, 5 parelhas, 70 cursos, ...").
```

### F2 — CRUD da AcaoFormacao (API)

```
Cria a entidade AcaoFormacao em apps/api/src/formacao/entities/ com TODOS os 65
campos listados no documento "Plano_Implementacao_CStaff_Formacao.md" secção 2.2.
Não cortes nem renomeies — mantém paridade com o form.seepmode.com.

Adiciona:
- Migration com os índices: (planoAno, numeroAcao) UNIQUE, (planoAno, data),
  (opId), (adminId), (cursoId), (empresaId), (fechada).
- DTOs: CreateAcaoFormacaoDto, UpdateAcaoFormacaoDto, FilterAcaoFormacaoDto
  (com TODOS os filtros listados na secção 1.3 — N.º ação, Curso, Número,
  Nome formador, Formador/Estado, Data início, Data fim, Localidade, Tipo,
  Estado, OP, ADM).
- Endpoints REST em /api/v1/formacao/acoes:
    GET / (paginado, query filters) ; GET /:id ; POST ; PATCH /:id ;
    DELETE /:id ; POST /bulk-delete ; POST /bulk-update.
- Validação com class-validator.
- Permissões com guards já existentes no projeto (Admin, Coordenação, ADM, Gestor)
  — usa as roles que já existem; se faltar alguma, regista-a.

Escreve testes unitários para o service e e2e para os endpoints CRUD principais.
```

### F3 — Listagem (Home)

```
Implementa a página app/formacao/page.tsx replicando exatamente o layout de
form.seepmode.com (tab "Home"):

1. Toggle no topo: "Plano 2026" / "Plano 2025" (estado global via context ou Zustand).
2. Card "Filtro básico" colapsável com 12 inputs em grid 4 colunas:
   N.º ação, Curso (select), Número, Nome formador, Formador/Estado (select),
   Data início, Data fim, Localidade (select), Tipo (select), Estado (select),
   OP (select), ADM (select).
3. Linha de ações: botões "7 dias", "1 mês", "1 ano", "Limpar", "Pesquisar".
4. Card "Filtro rápido" + "Ordenar por coluna" + Direção Asc/Desc + botão "Novo registo".
5. Tabela paginada (100 por página) com colunas:
   checkbox · Empresa (P01) · Tipo (A) · Número (B) · Cliente (P07) · N.º ação (C)
   · Curso (D) · Data (E) · Localidade (F) · Participantes (G) · OP (H) · Admin (I)
   · Ações (Ver | Editar | Eliminar).
6. Acima da tabela: dropdown "Ação em lote" + botão "Aplicar".
7. Paginação: "(1 - 100 de N)" + botões « ‹ › ».

Usa shadcn/ui (Table, Card, Select, Input, Button). Usa React Query para fetching
contra GET /api/v1/formacao/acoes. Escreve em TypeScript estrito.

Não implementes ainda o detalhe — apenas links que vão para /formacao/[id].
```

### F4 — Detalhe + formulário

```
Implementa duas páginas:

1. app/formacao/[id]/page.tsx — modo VER:
   Replica o layout do "Detalhe do registo" do form.seepmode.com: grid 3 colunas
   com TODOS os 65 campos da secção 2.2 do "Plano_Implementacao_CStaff_Formacao.md".
   Cada campo num card, label em maiúsculas + valor abaixo. Quando vazio mostra
   "Sem valor" em itálico cinzento. Botão "Fechar" no topo direito.

2. app/formacao/[id]/edit/page.tsx (e app/formacao/novo/page.tsx) — modo EDITAR:
   Mesmo layout mas com inputs editáveis. FKs com Combobox (shadcn) puxando dos
   endpoints de lookup. Datas com date picker. Currency com input + sufixo €.
   Sim/Não com Switch. Texto livre com Input/Textarea conforme tamanho.

Validações: Tipo, N.º Ação, Data são obrigatórios. Resto opcional.
Submete via POST/PATCH para /api/v1/formacao/acoes(/[id]).

Usa React Hook Form + zod (alinha com o resto do projeto se já houver convenção).
```

### F5 — Toggle Plano 2025/2026 (estado global)

```
Cria um contexto/store global "planoAnoStore" (Zustand ou React Context — usa o
que já existir no projeto) que mantém o ano-plano selecionado. Persiste em
localStorage.

Mostra o toggle como dois "pills" no topo de TODAS as páginas /formacao/* —
Plano 2026 e Plano 2025, com o ativo a vermelho/escuro.

Atualiza todos os fetches do módulo para incluírem `?planoAno=<ano>` na query.
No backend, garante que todos os endpoints aplicam o filtro planoAno quando
fornecido.
```

### F6 — Dashboard

```
Implementa app/formacao/dashboard/page.tsx replicando o dashboard de
form.seepmode.com com 3 widgets em grid responsiva:

1. "Produção por mês" — gráfico de barras empilhadas (Recharts, ou a lib
   já usada noutros dashboards do OpsDock):
   - x: meses (01/26, 02/26, ...)
   - y: nº de ações
   - empilhado por modalidade: Presencial (laranja), E-Learning (verde),
     Outros (amarelo).
   - mostra valor total no topo de cada barra.

2. "Tipologia de ações" — bar chart horizontal:
   - top 10 cursos por nº de ações.
   - barra com % do total + label do código curso à esquerda + valor à direita.

3. "Resumo analítico" — grid de 5 cards pequenos:
   Total de ações, Presencial, E-Learning, Outros tipos, Tipologias ativas.
   + barra horizontal "Peso do presencial" com %.

Endpoint: GET /api/v1/formacao/dashboard?planoAno=<ano>
Resposta:
{
  producaoPorMes: [{ mes: '01/26', presencial: N, elearning: N, outros: N }, ...],
  tipologiaAcoes: [{ codigo, nome, count }, ...] (top 10),
  resumoAnalitico: {
    totalAcoes, presencial, elearning, outros, tipologiasAtivas, pesoPresencialPct
  }
}

Implementa o handler do backend com queries SQL agregadas eficientes
(GROUP BY mês, GROUP BY cursoId).
```

### F7 — Relatório: Taxa de crescimento

```
Implementa app/formacao/relatorios/page.tsx com tabs (shadcn Tabs):
"Taxa de crescimento", "Relatório de atividades", "Prémios", "Operador", "ADM".
Header comum: badge "Fonte atual: 02 - 2026" + botão "Exportar" (placeholder por agora).

Implementa a tab "Taxa de crescimento":
- 4 cards: Total Ações, Total Formandos, Meses com dados, Último período.
- Tabela "Evolução mensal" (Mês / Ações / Formandos), uma linha por mês ordenada
  cronologicamente.

Endpoint: GET /api/v1/formacao/relatorios/taxa-crescimento?planoAno=<ano>
Resposta:
{
  totais: { totalAcoes, totalFormandos, mesesComDados, ultimoPeriodo },
  evolucaoMensal: [{ mes: 'Jan 2026', acoes, formandos }, ...]
}

Os outros tabs ficam em placeholder por enquanto.
```

### F8 — Relatório: Atividades

```
Na página de relatórios, implementa a tab "Relatório de atividades":
- 7 cards: Total Ações, Participantes, Fechadas, Por Fechar, Dados em falta,
  Envios, Certificados.
- Tabela "Tipologia de ações" (Tipologia / Ações / Fechadas / Dados em falta),
  ordenada por Ações desc.
- Toggle no topo direito: "Distribuição atual" (já implementado, sem alternativa
  por agora).

Endpoint: GET /api/v1/formacao/relatorios/atividades?planoAno=<ano>
Resposta:
{
  cards: { totalAcoes, participantes, fechadas, porFechar, dadosEmFalta, envios, certificados },
  tipologia: [{ codigo, nome, acoes, fechadas, dadosEmFalta }, ...]
}
```

### F9 — Relatório: Operador

```
Na página de relatórios, implementa a tab "Operador":
- Linha de badges: período, "até <data>", "<N> operadores".
- 4 cards: Operadores, Ações mensais listadas, Ações semanais listadas, Top ranking.
- Duas tabelas lado-a-lado:
  · "Ações por mês" (Período / Operador / Ações)
  · "Ações por semana" (Período / Operador / Ações)
- Cada tabela tem um toggle Mensal/Semanal no canto superior direito.

Endpoint: GET /api/v1/formacao/relatorios/operador?planoAno=<ano>
Resposta:
{
  cards: { operadores, acoesMensais, acoesSemanais, topRanking },
  porMes: [{ periodo: 'Mai 2026', operador: 'JM', acoes: 2 }, ...],
  porSemana: [{ periodo: 'Semana 19 / 2026', operador: 'JM', acoes: 2 }, ...]
}
```

### F10 — Relatório: ADM

```
Na página de relatórios, implementa a tab "ADM":
- Badges: período, "até <data>", "<N> ADM".
- 4 cards: ADM ativos, Certificados listados, Envios listados, Top ranking.
- Tabela "Indicadores por mês" (Período / ADM / Ações / Fechos / Envios / Certificados).

Endpoint: GET /api/v1/formacao/relatorios/adm?planoAno=<ano>
Resposta:
{
  cards: { admAtivos, certificadosListados, enviosListados, topRanking },
  indicadores: [
    { periodo: 'Mai 2026', adm: 'MS', acoes: 2, fechos: 0, envios: 0, certificados: 0 },
    ...
  ]
}
```

### F11 — Relatório: Prémios (cálculo real)

```
Implementa a tab "Prémios" da página de relatórios com cálculo real, segundo
a regra documentada na secção 1.6 → Prémios do "Plano_Implementacao_CStaff_Formacao.md".

Backend:
1. Service apps/api/src/formacao/premios/premios.service.ts com método
   calcular(planoAno, mes: 'YYYY-MM'):
   - Obtém parelhas ativas (folha ROTAS via tabela Parelha).
   - Por OP: count de ações no mês; count de ações com participantes >= 15.
   - Por equipa (Parelha.equipaNum): soma das ações dos OPs da equipa.
   - Aplica faixas:
       individual: 1-4 → 0€; 5-10 → 3€; 11-15 → 6€; 16+ → 9€ por ação.
       grupo:      4-16 → 0€; 17-40 → 3€; 41-60 → 6€; 61+ → 9€.
   - diasUteis e diasTrabalhados por pessoa (campo manual editável; default = dias úteis do mês).
   - Total = (individual + grupo) * (diasTrabalhados / diasUteis).
   - Aplica condições: todas as ações do mês fechadas? média >=15 alunos?
     pessoa presente nos 2 meses? Se não cumpre, total=0 e atribuído=false.
   - Regra: prémio de parelha SÓ é atribuído se o de grupo for atribuído.
   - Mínimo 50€ — abaixo disso, atribuído=false.

2. Endpoint GET /api/v1/formacao/relatorios/premios?planoAno=&mes=:
   Retorna { mes, parelhas: [{ codigo, op, adm, acoesOp, acoes15Op,
   acoesEquipa, individual€, grupo€, diasUteis, diasTrabalhados, total€,
   atribuido, motivos: [] }] }

3. Endpoint POST /api/v1/formacao/relatorios/premios/recalcular?mes=
   força recálculo (invalida cache).

Frontend:
- Seletor de mês (default = mês corrente -1).
- Tabela com uma linha por OP/ADM, colunas como o output acima.
- Coluna "Atribuído" com badge verde/vermelho + tooltip com motivos quando vermelho.
- Card de totais: total a pagar, nº pessoas com prémio, nº abaixo de 50€.
- Botão "Recalcular" + "Exportar CSV".

Testes unitários para cada faixa e cada condição. Fixture de teste deve
reproduzir 1 parelha que recebe e 1 que não recebe (motivos diferentes).
```

### F12 — Exportação CSV/XLSX

```
Implementa o botão "Exportar" em todas as tabs de relatórios.
Backend: endpoint genérico
  GET /api/v1/formacao/relatorios/:tipo/exportar?planoAno=<ano>&formato=csv|xlsx
  → retorna o ficheiro com o mesmo conteúdo do relatório atual.

Usa a lib `exceljs` (já presente no projeto OpsDock se houver, senão adiciona).
Frontend: ao clicar em "Exportar", faz fetch e dispara download via blob.
```

### F13 — Utilizadores

```
Verifica se o módulo de utilizadores existente em apps/api e apps/web suporta
os perfis: Admin, Coordenação, ADM, Gestor. Se algum faltar, adiciona à enum
de perfis e cria migration.

Cria página app/formacao/utilizadores/page.tsx que reusa os componentes
existentes de utilizadores mas:
- Adiciona filtro "Perfil" no topo.
- Botões "Limpar filtro", "Atualizar", "Novo utilizador".
- Tabela: Utilizador (link) / Perfil / Contacto / Estado (toggle Ativo) /
  Criado em / Ações [Editar].

Se o módulo de utilizadores existente JÁ é genérico, este page só configura
o filtro inicial e o set de perfis visível.
```

### F14 — Importação do Excel atual

```
Cria um importer para o ficheiro "04_2_Produtividade Formação_20260421_IM (1).xlsx"
(snapshot 2026-04-21, 12 folhas):

1. Backend endpoint: POST /api/v1/formacao/import/xlsx
   - Recebe upload multipart/form-data.
   - Guarda em MinIO bucket "formacao-imports".
   - Cria job BullMQ "formacao.import.parse".

2. Worker apps/worker/src/jobs/formacao-import.processor.ts:
   - Lê o XLSX (lib `exceljs`).
   - Importa SÓ as folhas "02 - 2025" e "02 - 2026" (ignora ROTAS — essa é
     responsabilidade do seed F1 — e ignora Passwords, pass recrutamento,
     INES, Analise, GLOBAIS, Divisão Rotas, 202602, 202603, 01 - Tx Crescimento).

   IMPORTANTE — mapeamento de colunas POR ANO (são diferentes!):

   Schema "02 - 2025" (linha 3 = headers, linhas 4+ = dados, 48 colunas):
     A=Tipo, B=Nº, C=Nº Ação, D=Curso, E=Data, F=Localidade, G=Participantes,
     H=Op, I=Admin, J=VER, K=Formador, L=Confirmação, M=Adjudicação,
     N=Data Fecho (1ª passagem), O=(vazio), P=Fechada, Q=Data Fecho,
     R=OP, S=Faltam dados, T=Nº certificados, U=OP Envio, V=Data envio,
     W=DTP, X=PP, Y=LS, Z=MJF, AB=PP, AC=LS, AD=MJF.

   Schema "02 - 2026" (linha 3 = headers, linhas 4+ = dados, 48+ colunas):
     A=Tipo, B=Nº, C=Nº Ação, D=Curso, E=Data, F=Localidade, G=Participantes,
     H=Op, I=Admin, J=VER/OBS, K=Tipo (INT/EXT), L=Formador,
     M=Confirmação cliente, N=Adjudicação formador, O=Sala,
     P=> acima de 15, Q=Fechada, R=Data Fecho, S=OP, T=Faltam dados,
     U=Nº certificados, V=OP Envio, W=Data envio, X=DTP - Entrada,
     Y=Folha presenças, Z=Digitalizado, AA=CV, AB=Ficha curricular, AC=CCP,
     AE=Teste, AF=Quest. formandos, AI=Rel. Estatística,
     AJ=Registos e resultados, AK=Aval. Formador, AL=Pauta,
     AO=SF, AP=MD, AQ=TS, AR=CB, AS=JM, AU=SF2, AV=MD2.

   - Persiste cada linha em AcaoFormacao com planoAno=<ano>.
   - Para 2025, os campos exclusivos de 2026 ficam null.
   - Resolve FKs: Empresa por nome, Curso por código, Cliente por nome
     (cria se não existir, regista warning), Formador por nome,
     OP/Admin por iniciais (FK Vendedor/Utilizador).
   - Datas em formato Excel (serial) convertidas para Date.
   - Persiste em transação por folha. Em caso de erro, regista linha+motivo
     numa tabela `import_errors` e continua.

3. Endpoints adicionais:
   - GET /api/v1/formacao/import/preview/:jobId — devolve resumo: total linhas
     por folha, OK, erros, warnings, primeiros 10 registos.
   - POST /api/v1/formacao/import/confirm/:jobId — descarta o staging anterior
     se já existir e marca este import como ativo.

4. UI em /formacao/utilizadores/import (acessível só a Admin):
   - Upload de XLSX.
   - Mostra preview com tabela de erros e botão Confirmar.

Testa com o ficheiro real. Contagens esperadas:
  - 02 - 2025 → 2078 ações (até 31/12/2025).
  - 02 - 2026 → 799 ações (até ~21/04/2026, snapshot do ficheiro).
```

### F15 — Polimento UI

```
Polimento da Home (/formacao/page.tsx):
- "Filtro rápido" filtra results client-side (em cima dos já carregados).
- Dropdown "Ordenar por coluna" funciona em todas as colunas.
- "Ação em lote" suporta: Eliminar selecionados, Marcar como fechada,
  Marcar como enviada.
- Checkbox "selecionar todos" controla todos os da página.
- Atalhos "7 dias / 1 mês / 1 ano" definem Data início/fim.

Polimento global:
- Loading skeletons nas tabelas e cards.
- Empty states quando não há dados.
- Toast notifications em sucesso/erro de mutations.
```

### F16 — Testes E2E

```
Escreve testes Playwright (ou a lib E2E já usada pelo OpsDock-web) cobrindo:

1. Fluxo CRUD ação:
   - Login como Admin.
   - Criar nova ação com todos os campos obrigatórios.
   - Editar.
   - Marcar como fechada.
   - Eliminar.

2. Listagem com filtros:
   - Filtrar por Tipo=Presencial + Data início/fim.
   - Verificar contagem.

3. Toggle Plano 2025/2026:
   - Mudar para 2025 e verificar que a listagem mostra 2025.

4. Dashboard renderiza os 3 widgets com dados da API.

5. Cada relatório (5 tabs) renderiza e exporta CSV.

6. Permissões: utilizador Gestor vê listagem mas não consegue eliminar
   registos de outros.

7. Importação XLSX: faz upload de fixture pequena (10 linhas) e confirma
   que registos aparecem na listagem.
```

---

## 6. Migração de dados — checklist

- [ ] Backup do ficheiro `04_2_Produtividade Formação_20260421_IM (1).xlsx`.
- [ ] Extração das listas canónicas do Excel (todas no mesmo ficheiro, folhas distintas):
  - Empresas (folha `ROTAS`, coluna A): Seepmed, Seepmode, Tacovia.
  - Zonas (folha `ROTAS`, coluna E): 5 zonas.
  - Vendedores + Parelhas + Rotas (folha `ROTAS`, 50 linhas).
  - Cursos (folha `02 - 2026`, coluna D — valores únicos; cruzar com `02 - 2025`).
  - Clientes (folha `02 - 2026`, coluna R — quando existir).
  - Formadores (folha `02 - 2026`, coluna L; folha `02 - 2025`, coluna K).
  - Utilizadores OP/ADM (iniciais nas colunas H/I de ambas as folhas).
- [ ] Popular tabelas auxiliares ANTES de importar `AcaoFormacao` (seed F1 a partir de ROTAS).
- [ ] Importar `02 - 2026` primeiro (schema mais completo), validar.
- [ ] Importar `02 - 2025` depois (com mapeamento de colunas distinto), validar.
- [ ] Verificar contagens batem certo:
  - 2026: 799 ações no snapshot (Tx Crescimento mostra 532 fechadas até fim de Q1).
  - 2025: 2078 ações (Tx Crescimento `TOTAL ACUMULADO` = 2079 — 1 de diferença a investigar).
- [ ] Comparar 5 ações aleatórias por amostragem (campo a campo).
- [ ] Validar regra dos Prémios: recalcular `202602` no CStaff e comparar com a folha do Excel — totais por parelha têm de bater.
- [ ] **Não migrar:** folhas `Passwords`, `pass recrutamento` (credenciais externas, geri num password manager), `INES` (working draft pessoal), `Analise` (vazia), `GLOBAIS`/`Divisão Rotas`/`01 - Tx Crescimento`/`202602`/`202603` (são vistas/analytics, geradas a partir de `02 - YYYY`).
- [ ] Manter o Excel como fonte de verdade até confirmar 1 mês de uso paralelo.

---

## 7. Critérios de aceitação globais

A migração está completa quando:

1. Qualquer utilizador do form.seepmode.com consegue fazer no CStaff o mesmo trabalho diário sem precisar de explicação adicional.
2. Os contagens dos relatórios batem exatamente com o que o form mostra hoje (mesmo cálculo, mesmos dados).
3. A exportação CSV/XLSX dos relatórios contém as mesmas colunas/linhas.
4. Toggle Plano 2025/2026 funciona em todas as páginas e persiste entre sessões.
5. Permissões funcionam por perfil (Admin / Coordenação / ADM / Gestor).
6. Importação do Excel histórico corre sem erros e os registos batem a olho com a aplicação atual.

---

## 8. Pontos por decidir mais tarde (não bloqueantes)

- Mobile (Flutter): replicar a Home + criar/editar ação com câmara para anexar Folha de Presenças? Decidir após F16.
- Anexos por campo (CV, CCP, Ficha curricular…): boolean → upload de PDF para MinIO. Pode ser F17 separada.
- Notificações: alertar OP/ADM quando uma ação fica > N dias sem fechar. Pode ser F18.
- Integração com sistema contabilístico (preencher automaticamente N.º Recibo, IRS, IVA): F19.
- UI editável de configuração das faixas/condições dos Prémios (F11 implementa cálculo com valores hardcoded; um ecrã de admin para editar a tabela vem depois): F20.
- Mapa de zonas/rotas com edição visual (substituir folha `Divisão Rotas`): F21.

---

> **Origem deste plano:** screenshots de `form.seepmode.com` + análise das 12 folhas de `04_2_Produtividade Formação_20260421_IM (1).xlsx` (snapshot 2026-04-21). Documento companion: `Estudo da produtividade da Formação.md`. Última revisão: 2026-05-08.
