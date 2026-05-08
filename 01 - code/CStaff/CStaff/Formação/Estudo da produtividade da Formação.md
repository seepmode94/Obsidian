# Estudo do Formulário de Formação (substituição pelo CStaff)

**Objetivo:** preparar a migração do site/Excel atuais para o módulo de Formação no CStaff.
**Fontes:**
- Formulário web atual (screenshots: listagem + detalhe registo).
- `04_Produtividade Formação_IT.xlsx`, folha `02 - 2026` (estrutura operacional viva, 240 ações registadas).

---

## 1. Inventário de campos — formulário web vs. Excel

Mapeamento direto entre os campos do detalhe do formulário e as colunas do Excel. A coluna **% preench.** mostra a taxa de preenchimento real nas 240 ações de 2026 (Excel) — sinaliza quais campos são essenciais vs. opcionais vs. abandonados.

### 1.1 Identificação da ação (sempre preenchidos)

| Formulário | Coluna Excel | Tipo | % preench. | Notas |
|---|---|---|---:|---|
| EMPRESA | B `Empresa` | texto | **0%** | 🟥 Vazio em 2026. No detalhe está "Seepmed, lda" — provavelmente fixo/default. |
| TIPO | C `Tipo` | enum | **100%** | "Presencial" / "E-learning" |
| NÚMERO | D `Nº` | int | 100% | Sequencial dentro do mês |
| N.º AÇÃO | E `Nº Ação` | texto | 100% | Formato `M012/26` (código + ano). **Chave natural.** |
| CURSO | F `Curso` | enum | 100% | Códigos: TC, HST, CDE, AFC, PS, MET5S, SHT, ORTT, EMER, ISMET, CE, TA-16H… |
| DATA | G `Data` | data | 100% | Excel guarda como serial (46024 = 2026-01-13) |
| LOCALIDADE | H `Localidade` | texto | 100% | Cidade/freguesia |
| PARTICIPANTES | I `Participantes` | int | 98% | Nº de formandos da ação |

### 1.2 Operacional — pessoas e logística (alta utilização)

| Formulário | Coluna Excel | % preench. | Notas |
|---|---|---:|---|
| OP | AC `Op` | **99%** | Iniciais do operacional (SF, MD, TS, CB, JM, IM…) |
| ADMIN | AD `Admin` | 99% | Iniciais do admin (AC, IF, FG, SD, MS…) |
| EXTERNO/INTERNO | K `Ext - Interno` | 99% | "INT" / "EXT" — formador interno ou externo |
| FORMADOR/ESTADO | AG `Formador` | 60% | **Texto livre**: "José Fernandes - confirmado", "Pedro Pereira - confirmado", "SQ enviada"… |
| NOME DO FORMADOR | J `Nome Formador` | **1%** | 🟥 Quase abandonada — substituída por AG. |
| CONFIRMACAO | AH `Confirmação` | 45% | Texto livre tipo "SQ #26.12.2025 Enviada" |
| ADJUDICACAO | AI `Adjudicação` | 45% | Idem (formato igual a Confirmação) |
| SALA | AJ `Sala` | 78% | Texto: "Sala cliente, projetor nosso", "Alugada (Lisotel)"… |
| TIPO 2 | AF `Tipo` | 50% | "INT"/"EXT" — duplicado de Ext-Interno |

### 1.3 Estado e fecho (preenche-se quando a ação fecha — ~30% do mês)

| Formulário | Coluna Excel | % preench. | Notas |
|---|---|---:|---|
| ACIMA DE 15 | AN `> acima de 15` | 37% | Flag/sim — aciona contabilização especial |
| FECHADA | AO `Fechada` | 30% | "Sim" / vazio |
| DATA FECHO | AP `Data Fecho` | 30% | Data |
| OP FECHO | AQ `OP` | 32% | Iniciais |
| FALTAM DADOS | AR `Faltam dados` | 31% | Sim/Não |
| N. CERTIFICADOS | AS `Nº certificados` | 31% | Inteiro |
| OP ENVIO | AT `OP` | 31% | Iniciais |
| DATA ENVIO | AU `Data envio` | 31% | Data |

### 1.4 Documentação processual (checklist de dossier — ~30%)

Todas estas colunas guardam apenas **"Sim" / "Não"**.

| Formulário | Excel | % preench. |
|---|---|---:|
| ENTRADA DTP | AV `DTP - Entrada` | 34% |
| FOLHA DE PRESENÇAS | AW `Folha presenças` | 34% |
| DIGITALIZADO | AX `Digitalizado` | 30% |
| CV | AY `CV` | 29% |
| FICHA CURRICULAR | AZ `Ficha curricular` | 28% |
| CCP | BA `CCP` | 28% |
| TESTE | BC `Teste` | 32% |
| QUESTIONÁRIOS FORMANDOS | BD `Quest. formandos` | 33% |
| RELATÓRIOS AVALIATIVOS | BG `Rel. Avaliativos` | 23% |
| REGISTOS E RESULTADOS | BH `Registos e resultados` | 29% |
| AVALIAÇÃO FORMADOR | BI `Aval. Formador` | 28% |
| PAUTA | BJ `Pauta` | 28% |

### 1.5 Financeiro (subutilizado — 1-2%)

🟥 **Praticamente todos abaixo de 5% de preenchimento.** Indica que este lado é tratado fora do Excel/formulário (provavelmente em sistema contabilístico).

| Formulário | Excel | % preench. |
|---|---|---:|
| HORAS | O `Horas` | 1% |
| VALOR HORA | P `Valor Hora` | 8% |
| TOTAL HONORÁRIOS | Q `Total` | 2% |
| CLIENTE | R `Cliente` | 1% |
| KMS/DIESEL | S `Kms/diesel` | 1% |
| VALOR DESPESA | T `Valor` | 1% |
| IVA DESPESA | U `IVA` | 1% |
| IRS | V `IRS` | 1% |
| VALOR FINAL | W `Valor Final` | 2% |
| DTP ENTREGUE | X `DTP Entregue` | 1% |
| N.º RECIBO | Y `N. Recibo` | 1% |
| DATA DE PAGAMENTO | Z `Data Pagamento` | 1% |
| TESOURARIA | AA `Tesouraria` | 1% |
| IVA TESOURARIA | AB `IVA` | 1% |
| NOME DA SALA | AK `Nome Sala` | 1% |
| VALOR DA SALA | AL `Valor da Sala` | 2% |
| DATA PAG. SALA | AM `Data Pag Sala` | 2% |

### 1.6 Outros / observações

| Formulário | Excel | % preench. | Notas |
|---|---|---:|---|
| VER/OBS. | AE `VER/OBS` | 20% | Texto livre |
| SF / MD / TS / CB / JM | BM-BQ | 3-4% | Flags de equipa para **e-learning** |
| SF 2 / MD 2 / TS 2 / CB 2 / JM 2 | BS-BW | 3-4% | Idem (segunda volta?) |

> Há **dois blocos** de colunas SF/MD/TS/CB/JM (BM-BQ e BS-BW). Possivelmente "ronda 1" e "ronda 2" de e-learning ou início/fim. **A esclarecer.**

---

## 2. Listagem (Home) — filtros e colunas

### Filtros do formulário web

| Filtro | Mapeia para |
|---|---|
| N.º ação | `Nº Ação` |
| Curso | `Curso` |
| Número | `Nº` |
| Nome formador | `Formador` (AG, texto livre) |
| Formador/Estado | `Formador` (estado embebido no texto) |
| Data início / Data fim | `Data` (range) |
| Localidade | `Localidade` |
| Tipo | `Tipo` (Presencial/E-learning) |
| Estado | `Fechada` + `Confirmação` (combinado) |
| OP | `Op` |
| ADM | `Admin` |
| Plano 2025 / Plano 2026 | folha `02-2025` ou `02-2026` |

### Colunas da tabela

P01 Empresa | A Tipo | B Número | P07 Cliente | C N.º ação | D Curso | E Data | F Localidade | G Participantes | H OP | I Admin

> O formulário tem 815 registos no plano (`1-100 de 815`) — bate certo com a soma anual.

---

## 3. Diagnóstico — o que aprendemos

### 🔴 Redundâncias e campos a colapsar

1. **`Nome Formador` (J) vs `Formador` (AG):** o J está abandonado (1%). Manter só um campo, com **nome separado de estado**.
2. **`Tipo 2` (AF) vs `Ext-Interno` (K):** ambos guardam INT/EXT. Eliminar duplicação.
3. **`Confirmação` (AH) vs `Adjudicação` (AI):** mesmo formato, mesmas datas no exemplo. **A esclarecer se são realmente eventos distintos.**
4. **`Sala` (AJ texto) vs `Nome Sala` (AK) + `Valor Sala` (AL) + `Data Pag Sala`:** a primeira tem 78%, as outras 1-2%. Os campos detalhados nunca são usados — o pessoal mete tudo em texto livre na "Sala".

### 🟥 Bloco financeiro — fora do âmbito do formulário

17 campos com 1-2% de preenchimento. Decisão recomendada para o CStaff:
- **Não migrar** o bloco financeiro para o formulário operacional.
- Se for preciso, criar um **módulo financeiro separado** com integração com a contabilidade.
- Manter no operacional só: `Valor Hora` (referência), `Cliente` (já útil para relatórios) e `Horas` (planeamento).

### 🟢 Bloco de identificação — sólido

Tipo, Nº, Nº Ação, Curso, Data, Localidade, Participantes, OP, Admin, Ext/Int — preenchimento 98-100%. **Estes são os obrigatórios reais.**

### 🟡 Documentação processual — checklist de "Sim/Não"

12 campos com ~30% de preenchimento. Funcionam como **checklist de fecho de dossier**. No CStaff isto deve ser:
- Um **sub-formulário/painel** que só aparece quando `Fechada = Sim`.
- Ou melhor: um **componente de estado processual** com progress bar (ex.: "8/12 documentos entregues").
- Cada item pode evoluir para upload de ficheiro em vez de boolean.

### 🟡 Estado de fecho — workflow incompleto

Os campos `Fechada / Data Fecho / OP Fecho / Faltam dados / Nº certificados / OP envio / Data envio` representam um **fluxo de máquina de estado**:
1. Ação criada → estado "Aberta"
2. Confirmação/Adjudicação → "Confirmada"
3. Execução
4. `Fechada = Sim` → "Fechada"
5. Verificação documentos → `Faltam dados`
6. Geração e envio de certificados → `OP envio` + `Data envio`

No CStaff vale a pena **modelar como state machine** em vez de 7 campos soltos.

### 🟡 SF/MD/TS/CB/JM — atribuição de equipa para e-learning

Só 3-4% das linhas. Provavelmente devia ser **um único campo "Equipa atribuída"** (enum) em vez de 5 colunas booleanas. E os blocos `SF 2 / MD 2 / TS 2 / CB 2 / JM 2` precisam de explicação — podem ser uma segunda atribuição/repetição.

---

## 4. Proposta de modelo de dados para o CStaff

```
AcaoFormacao
├── id (uuid)
├── numeroAcao        // "M012/26" — chave natural, único
├── numeroSequencial  // 1, 2, 3… dentro do mês
├── tipo              // enum: PRESENCIAL | ELEARNING
├── curso             // FK -> Curso (TC, HST, CDE…)
├── data              // date
├── localidade        // text
├── participantes     // int
├── empresa           // FK (default Seepmed)
├── cliente           // FK -> Cliente (opcional, hoje 1%)
│
├── Pessoas
│   ├── opOperacional   // FK -> Utilizador (SF/MD/TS/CB/JM)
│   ├── opAdmin         // FK -> Utilizador (AC/IF/FG/SD/MS)
│   ├── formadorTipo    // enum: INTERNO | EXTERNO
│   ├── formador        // FK -> Formador
│   └── formadorEstado  // enum: PENDENTE | CONFIRMADO | RECUSADO
│
├── Logística
│   ├── salaTipo         // enum: CLIENTE | ALUGADA | NOSSA
│   ├── salaDescricao    // texto livre (substitui o atual "Sala")
│   ├── horas            // int (opcional)
│   └── confirmacaoData  // data (substitui texto "SQ #26.12.2025 Enviada")
│
├── Estado (state machine)
│   ├── estadoAtual    // enum: ABERTA | CONFIRMADA | EXECUTADA | FECHADA | ENVIADA
│   ├── dataFecho      // date
│   ├── faltamDados    // bool
│   ├── numCertificados // int
│   └── dataEnvio      // date
│
├── Dossier (checklist documental, só relevante após FECHADA)
│   ├── dtpEntrada       // bool/file
│   ├── folhaPresencas   // bool/file
│   ├── digitalizado     // bool
│   ├── cv               // bool/file
│   ├── fichaCurricular  // bool/file
│   ├── ccp              // bool/file
│   ├── teste            // bool/file
│   ├── questionarios    // bool/file
│   ├── relatoriosAval   // bool/file
│   ├── registosResults  // bool/file
│   ├── avalFormador     // bool/file
│   └── pauta            // bool/file
│
├── Flags
│   ├── acimaDe15        // bool (auto-calculável: participantes >= 15)
│   └── observacoes      // texto livre
│
└── (opcional, módulo separado) Financeiro
    ├── valorHora, totalHonorarios, kmsDiesel, valorDespesa,
    ├── ivaDespesa, irs, valorFinal, numRecibo, dataPagamento,
    ├── tesouraria, ivaTesouraria, valorSala, dataPagSala
```

**Tabelas auxiliares a criar:**
- `Curso` (TC = Trabalhos em Conta, HST = Higiene e Segurança…) — popular a partir dos códigos existentes.
- `Formador` (interno/externo, com CV, valor/hora associado).
- `Cliente` (já há lista no Excel).
- `Sala` (se vier a ser modelado a sério; hoje não vale a pena).

---

## 5. Pontos por esclarecer contigo

1. **Empresa = "Seepmed, lda"**: é sempre fixo? Se sim, posso retirar o campo do formulário e deixar implícito.
2. **Confirmação vs Adjudicação**: são dois eventos diferentes ou redundantes? No exemplo M012/26 ambos têm "SQ #26.12.2025 Enviada".
3. **`Acima de 15`**: é simplesmente `participantes >= 15`? Ou tem regra extra? Pode ser auto-calculado.
4. **SF / MD / TS / CB / JM (e os "2")**: o que distingue cada coluna? São equipas ou pessoas? Porquê dois blocos?
5. **Bloco financeiro**: confirma-me que NÃO precisamos no CStaff (é tratado em sistema contabilístico)?
6. **Documentação (CV, CCP, Ficha…)**: queres só checkbox ou upload do PDF?
7. **Status workflow**: faz sentido a sequência ABERTA → CONFIRMADA → EXECUTADA → FECHADA → ENVIADA, ou tem mais estados (ex.: CANCELADA, ADIADA)?
8. **Plano 2025/2026**: queres separar fisicamente (toggle no UI) ou é só um filtro por ano?
9. **Códigos de curso (TC, HST, CDE…)**: tens uma lista canónica em algum lado, ou recolho-os do Excel?
10. **Listagem com 815 registos**: paginação, scroll infinito, ou export para Excel/CSV?

---

## 6. Próximos passos sugeridos

- [ ] Validar comigo as 10 perguntas acima → fechar o modelo de dados.
- [ ] Extrair lista canónica de **cursos**, **clientes**, **formadores** e **localidades** a partir do Excel para popular as tabelas auxiliares.
- [ ] Desenhar **wireframe** do CStaff: listagem (filtros + tabela paginada) + detalhe (com seções colapsáveis: Identificação, Pessoas, Logística, Estado, Dossier, Financeiro opcional).
- [ ] Definir **migração**: script que lê o XLSX e popula a base do CStaff (já tenho o extractor a funcionar em `/tmp/xlsx_extract.py`).
- [ ] Decidir **utilizadores e papéis**: quem cria, quem fecha, quem envia certificados.

---

> Origem: `04_Produtividade Formação_IT.xlsx` (folha `02 - 2026`, 240 ações) + screenshots do formulário web atual. Análise: 2026-05-08.
