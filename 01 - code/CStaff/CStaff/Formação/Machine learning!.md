  ## Otimização e agrupamento de Formações (mapa + modelo de sugestão)

  Camada de tratamento de dados que se monta **por cima** da integração cstaff/sanitização
  desta issue. Liga-se ao objetivo de **exportar a lógica do `form.seepmode.com` para o
  cstaff**: o modelo de otimização vive em Python (exportável), e o LoungeCRM fornece-lhe
  os dados das Formações.

  ### Decisões assumidas
  - **Estado `Pré-Ativo`:** ainda **não existe** no código — vai ser adicionado em breve.
    Desenhar já a estrutura a contar com ele (entre `Planeamento` e `Ativa`).
  - **Modelo em Python**, exportável para outra aplicação (cstaff / `form.seepmode.com`).
    O LCRM expõe os dados; o motor de sugestão corre do lado Python.
  - **União de formações é manual** — sem lógica de "desfundir" / undo por agora.
  - **Abordagem do motor:** **heurística primeiro** (regras geo + tempo) para ter o mapa e
    as sugestões a funcionar já; **ML** como evolução. *(confirmar)*

  ### As 3 variáveis de agrupamento
  1. **Tempo** — janela de datas aceitável para o cliente.
  2. **Distância** — raio que o cliente/formador está disposto a percorrer.
  3. **Formação** — só se agrupam formações do mesmo produto/curso.

  ### Modelo de dados
  - [ ] Campos novos na Formação: **janela de tempo** (data início/fim aceitável) — não existem hoje.
  - [ ] Campo **raio de distância** (km) na Formação.
  - [ ] **Geocoding do local pedido** (`formation_place_c`) para calcular distâncias no mapa.
  - [ ] Marcar **ação canónica** vs **ações absorvidas** numa união (campo/relação).
  - [ ] Reaproveitar o `cstaff_trainer_id` (desta issue) como o formador da ação resultante.

  ### Captura no Planeamento
  - [ ] Expor **janela de tempo** + **raio de distância** no formulário ao passar para `Planeamento`
        (via Studio/`view_metadata`, nunca render-code).
  - [ ] As Formações entram no fluxo a partir da ação **"Convert Invoice to Trainee"**
        (`invoice-training-conversion.service.ts`), em `Pré-Planeamento`.

  ### Motor de sugestão de agrupamento (Python, exportável)
  - [ ] **v1 heurística:** agrupar Formações que sejam (a) mesmo produto/curso,
        (b) janelas de tempo com interseção, (c) dentro do raio de distância.
  - [ ] **v2 ML:** modelo que aprende com o histórico (rentabilidade, disponibilidade do formador,
        padrões dos clientes) — *só depois do v1*.
  - [ ] Definir **inputs** (produto, coordenadas, janela de tempo, raio, nº de formandos) e
        **output** (clusters agrupáveis + score de confiança).
  - [ ] Endpoint no LCRM que serve as Formações em `Planeamento` ao motor Python.
  - [ ] Empacotar o modelo de forma **exportável** para o cstaff / `form.seepmode.com`.

  ### Mapa de Portugal
  - [ ] Mapa com a **procura por localização** (onde estão a ser pedidas formações).
  - [ ] Marcador do pedido + **raio de distância** alcançável.
  - [ ] Filtros por produto/curso, janela de tempo e estado.
  - [ ] Destacar os **clusters sugeridos** pelo motor.

  ### Página de união / funilamento (N → 1, manual)
  - [ ] Listar os **agrupamentos sugeridos** (ex.: 3 faturas → 3 ações → 1 ação).
  - [ ] Utilizador **revê, ajusta e confirma** a união (escolhe a ação canónica).
  - [ ] A canónica **absorve** info das outras (formandos, faturas, anexos, valores); faturas
        continuam ligadas à ação resultante.
  - [ ] **Arquivar as ações duplicadas** sem perder histórico/relações + registo de auditoria.

  ### Transição para Ativo
  - [ ] No `Pré-Ativo`: **data**, **local** e **formador** definidos.
  - [ ] **Obrigar formador ao passar para `Ativo`** *(alinhar com o bullet já existente desta issue)*.

  ### Produtividade
  - [ ] Alimentar a análise análoga ao livro **"01 - Tx Crescimento"**
        (`04_2_Produtividade Formação_...xlsx`) com os dados de agrupamento/ações resultantes.

  ### Dependências (desta issue / TAC-20)
  - [ ] Formadores sanitizados e ligados via `cstaff_trainer_id` (pré-requisito do formador na ação).
  - [ ] Nomes de Formações **normalizados pelo produto** que as criou (pré-requisito para agrupar por curso).
  - [ ] Salas a vir do cstaff (capacidade entra como restrição do agrupamento).
