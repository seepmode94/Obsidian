# Otimização do módulo Formações — Levantamento de Necessidades

> **Estado:** levantamento (não implementado). Pedido por antoniosantos@seepmode.com em 2026-05-27.
> **Contexto:** otimizar a página de detalhe da Formação (`sdmod_training` / `trainings`) para concentrar lá toda a informação operacional via atalhos/subpaineis. A riqueza fica **na Formação**, não no `cstaff` (decisão do dono: cstaff fora de scope para já). Trabalho a implementar mais tarde, noutra branch.

## Decisões já tomadas

| Tema | Decisão |
|---|---|
| Onde vive a riqueza | Nas Formações (LCRM), não no cstaff por agora. |
| Sala | Informação rica acessível a partir da Formação (não read-only de cstaff já). |
| Projetor | Novo módulo **Equipamento + alocações** (não apenas relate). |
| Sessões | Precisam de campos início/fim e formandos por dentro. |
| Formandos | Anexos (certificados/justificativos/reclamações) + checkbox SIGO. |
| Scope desta fase | Desenhar tudo; implementar depois. |

## Cardinalidade e modelo final (confirmado 2026-05-27)

- **1 Formação → N Sessões.**
- **Cada Sessão ↔ 1 Sala** (1-1). Logo uma Formação pode envolver **várias salas** (uma por sessão).
- **Cada Sessão ↔ 1 Formador**, mas o formador está **originalmente associado à Formação** (mantém-se painel Formador no topo + o formador por-sessão via `trainers_sessions`).
- **Dados comerciais da Sala vivem no catálogo da Sala** (nome, morada, condições comerciais/pagamento, responsável, **+ nº fatura, valor, IVA, data pagamento, fatura-ficheiro**). Não são por-sessão.
- **Formandos inscrevem-se na Formação** (nível ação, `training_controls`). A **Presença** (`attendances`) marca presente/ausente **por sessão**.
- Equipamento (projetor) é **alocado por sessão**, por intervalo início/fim, 1 sessão de cada vez.

Estrutura do detalhe da Formação:

```
FORMAÇÃO
├─ Visão Geral (campos da ação)                         [ex]
├─ FORMADOR (original da formação, 1) — info+pagamento  [ex]
├─ SESSÕES (subpainel-LISTA, N) — cada sessão expande p/:
│    ├─ início / fim                                    [novo]
│    ├─ Sala (relate 1-1 ao catálogo)                   [novo]
│    ├─ Formador da sessão (1, trainers_sessions)       [ex, expor]
│    ├─ Formandos/Presenças (attendances)               [ex, expor]
│    └─ Equipamento alocado                             [novo]
├─ FORMANDOS (training_controls, nível formação)        [ex+novo: SIGO/anexos]
├─ FATURA (cliente)                                     [ex]
└─ ATRIBUIÇÃO + Relações                                [ex]
```

---

## 1. Formadores — atalho dentro da Formação

**Quer:** a partir do detalhe da Formação, abrir info do formador **+ as formações que ele ministra**.

**Estado atual:**
- `trainings.trainer_c` → relate a **Contacts** (não ao módulo Formadores).
- Módulo Formadores (`sdmod_formation_trainers` / `trainers`, ~2.6k linhas) = diretório de pessoas + dados de pagamento (valor/hora, recibo, datas). Ligado a **Sessões** via join `trainers_sessions`, **não** diretamente à Formação.
- Nome (`trainer_name`) corrompido com strings de UI ("abrir", "ver") em parte das linhas; nome fiável vem de `contact_id → Contacts`.

**Lacunas / necessidades:**
- N1. Definir relação canónica Formação ↔ Formador (hoje é via Contacts em `trainer_c`, e via Sessão em `trainers_sessions` — duas vias, inconsistentes).
- N2. No detalhe do Formador: subpainel "Formações que ministra" (reverse das formações/sessões onde aparece).
- N3. Atalho no detalhe da Formação para abrir ficha do Formador (info + pagamento) sem sair do fluxo.
- N4. Decidir se a info do formador é lida do diretório `trainers` ou de Contacts (qual é a fonte de verdade do nome/contacto).

---

## 2. Sessões — início, fim e formandos por dentro

**Quer:** cada Sessão com **início e fim**, e **dentro os formandos**.

**Estado atual:**
- `sdmod_Sessions` / `sessions` tem apenas: `name`, `abbreviation`, `session` (nº), `description`, e relate à Formação. **Não tem datetime de início/fim.**
- Formandos por sessão existem via **Presenças** (`sdmod_attendances` / `attendances`): liga `session_id` ↔ `contact_id` ↔ `training_control_id`. Campos `attendance`, `inscription`, `certification` (varchar, deviam ser enum), datas.

**Lacunas / necessidades:**
- N5. Adicionar à Sessão: **data/hora início** e **data/hora fim** (campos novos).
- N6. Expor no detalhe da Sessão o subpainel **Formandos/Presenças** (já existe relação via `attendances`, falta layout/metadata).
- N7. Expor no detalhe da Formação o subpainel **Sessões** com início/fim visíveis (subpainel Sessões já existe; falta os campos novos).
- N8. Normalizar `attendance`/`inscription`/`certification` para enum/dropdown (hoje varchar livre).
- N9. Esclarecer duplicação **Formandos (`training_controls`, ~110k)** vs **Presenças (`attendances`, ~148)** — qual é o registo por-formando-por-sessão e qual o registo administrativo por-formando. Afeta onde colocar anexos/SIGO (ver §3).

---

## 3. Formandos — anexos + SIGO

**Quer:** possibilidade de **anexar** certificados, justificativos, reclamações; **checkbox** para certificar se estão no SIGO.

**Estado atual:**
- Formando = `sdmod_Training_control` / `training_controls`. SIGO existe mas como **texto**: `sigo_formation_code`, `sigo_n_c` (+ datas `certificate_issue_date`, `sigo_training_date`...). **Não há checkbox** "está no SIGO".
- Certificado: só **datas** (`internal_certificate_date`, `certificate_sent_date`, `intern_certificate_number_c`). **Não há upload de ficheiros.**
- Não existe tabela de documentos/anexos ligada a Formandos.
- ⚠️ Metadata: QA 2026-04-30 nota que `field_metadata` existe para `Attendances` mas **falta para `TrainingControls`** (43 campos por semear). Bloqueia exposição correta no Studio/views.

**Lacunas / necessidades:**
- N10. Mecanismo de **anexos por formando** com categoria/tipo: certificado, justificativo, reclamação. Reutilizar upload de ficheiros existente (`modules/records` file upload) ligado ao registo do Formando, com campo de tipo.
- N11. **Checkbox "No SIGO?"** (bool) no Formando, separado dos códigos SIGO de texto existentes.
- N12. Semear `field_metadata` de `TrainingControls` (pré-requisito para qualquer mudança de view do Formando).
- N13. Definir tipos/dropdown das categorias de anexo (certificado / justificativo / reclamação / outro).

---

## 4. Sala — informação rica acessível da Formação

**Quer:** nome das salas em **tabela/dropdown**; se não existir, **criar**. Campos: nome, morada, condições comerciais, condições de pagamento, nº fatura, valor, IVA, data de pagamento, nome e contacto do responsável, email. (Nota dono: "falta fatura".)

**Estado atual:**
- **Não existe módulo Sala.** Na Formação há campos soltos em `lbl_editview_panel1` (LOCALIZAÇÃO/Sala): `place`, `address`, `room` (varchar), `local_invoice_number_c`, `local_value_c`, `local_payment_date_c`, `projector`.
- Sala é hoje texto livre → sem catálogo, sem reuso, sem dados do responsável, sem IVA.

**Decisão (2026-05-27):** Sala é **por-sessão** (cada sessão 1-1 com 1 sala) e **todos os dados — incluindo comerciais — vivem no catálogo da Sala**. Não há dados de sala por-formação nem por-sessão; a sessão apenas referencia (relate) a sala.

**Lacunas / necessidades:**
- N14. **Catálogo de Salas** (módulo/tabela próprio) com TODOS os campos: nome, morada, condições comerciais, condições de pagamento, responsável (nome, contacto, email), **nº fatura, valor, IVA, data de pagamento, fatura (ficheiro)**.
- N15. Na **Sessão**: novo campo relate → **catálogo de Salas** (dropdown com criar-se-não-existe). Substitui o uso do `room` varchar da Formação.
- N16. Migrar os campos soltos da Formação (`place`, `address`, `room`, `local_invoice_number_c`, `local_value_c`, `local_payment_date_c`) → catálogo de Salas. Acrescentar **IVA** e **fatura-ficheiro** (resolve o "falta fatura").
- N17. Catálogo = fonte única dos dados da sala; sessão só aponta. (Nota: assume-se que os valores comerciais são por-sala, não negociados por-evento.)
- N18. ⚠️ Confirma sobreposição com TAC-17 (que previa Sala read-only de cstaff). Esta decisão **revoga/adia** essa parte do TAC-17 — registar no plano TAC-17.

---

## 5. Projetor — módulo Equipamento + alocações

**Quer:** poder **alocar projetor em vários dias**; projetor associado a **uma sessão de cada vez**.

**Estado atual:**
- **Não existe módulo.** Só `trainings.projector` varchar (texto livre). Sem agenda, sem deteção de conflito.

**Lacunas / necessidades:**
- N19. Novo módulo **Equipamentos/Recursos** (catálogo: nome, tipo, identificador). Suporta vários projetores.
- N20. Tabela de **Alocações** ligando Equipamento ↔ Sessão (ou ↔ dia/intervalo), porque um projetor serve várias sessões em dias diferentes mas só **uma sessão de cada vez**.
- N21. **Deteção de conflito**: impedir alocar o mesmo equipamento a duas sessões sobrepostas no tempo (depende de N5 — Sessão ter início/fim).
- N22. Vista de agenda/calendário do equipamento (que dias está alocado). Opcional fase 2.
- N23. Migrar `trainings.projector` (texto) → relate à alocação/equipamento.

---

## Dependências entre necessidades

- N21 (conflito projetor) **depende de** N5 (Sessão início/fim).
- N6/N7 (subpaineis Sessão/Formando) **dependem de** N12 (semear field_metadata TrainingControls).
- N15/N16 (Sala por-sessão) **revisita** decisão TAC-17 (N18).
- N10/N11 (anexos + SIGO) ficam no **Formando** (`training_controls`).

## Decisões resolvidas (2026-05-27)

| # | Questão | Decisão |
|---|---|---|
| N9 | Âncora dos anexos/SIGO | **Formando** (`training_controls`) — inscrição por formação. Presença (`attendances`) só marca presente/ausente por sessão. |
| N4 | Fonte do nome do Formador | **Contacts** (`contact_id`); `trainer_name` corrompido, ignorar. |
| Sala | Por-formação vs por-sessão | **Por-sessão** (1-1). |
| Sala | Onde vivem dados comerciais | **No catálogo da Sala** (nº fatura, valor, IVA, data pgto, fatura-ficheiro inclusive). |
| N16 | "falta fatura" | **Ficheiro** anexo no catálogo da Sala. |
| Projetor | Granularidade alocação | **Intervalo início/fim da sessão**, 1 sessão de cada vez. |
| Formador | Cardinalidade | **1 por sessão** (`trainers_sessions`) + associação original à Formação (painel topo). |

## Questões ainda em aberto

1. **N18** — confirmar formalmente revogação/adiamento da parte "Sala de cstaff" do TAC-17 (atualizar `tac-17-lcrm-plan.md`).
2. **HORA ENTRADA/SAÍDA** por presença (campos novos em `attendances`) — queres esse detalhe ou basta presente Sim/Não?
3. Valores comerciais da sala são mesmo **fixos por sala** (catálogo) e nunca negociados por-evento? Se variarem por evento, têm de descer para a sessão.

---

## Nota de implementação (para quando avançar)

Pela regra do projeto, **todas as mudanças de layout (campos novos, mover, esconder em detail/edit/list/filter/popup) vão por migration SQL sobre `view_metadata` ou via Studio** — nunca editar render-code. Módulos/campos/relações novos = migrations numeradas idempotentes em `apps/api/src/database/migrations`. Atualizar a documentação source-of-truth (`module_field_nature.md`, `module_relations.md`, `module_views.md`) em conjunto.
