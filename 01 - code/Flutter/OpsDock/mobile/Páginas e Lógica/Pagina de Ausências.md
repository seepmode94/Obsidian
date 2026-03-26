• # Templates Mobile Colaborador
  `TAC-2: Página de Ausências, Calendário e Registo de Ponto`

  ## Descrição

  ### Intro

  Este PR consolida a experiência mobile do colaborador em `OpsDock-mobile`, com foco em três áreas funcionais do módulo HRM:

  - **Página de Ausências**
  - **Página de Calendário**
  - **Página de Registo de Ponto**

  O objetivo foi alinhar o comportamento da app com os dados disponibilizados pela API, garantindo consistência entre pedidos de ausência, saldo de férias e registos de assiduidade em modo self-service.

  Neste ciclo, o foco principal foi:
  - eliminar divergências entre cálculo local e dados vindos da API
  - suportar cancelamento e interrupção de férias em curso
  - introduzir o fluxo self-service de registo de ponto para o colaborador
  - melhorar a experiência visual e funcional do registo de ponto

  Ficam fora deste PR:
  - página inicial
  - restantes ajustes administrativos fora do fluxo do colaborador

  ---

  ## Páginas Incluídas Neste PR

  - Página de Ausências
  - Página de Calendário
  - Página de Registo de Ponto

  ## Páginas Fora Deste PR

  - Página Inicial
  - Ajustes adicionais de backoffice administrativo

  ---

  # Página: Ausências

  ## Objetivo

  Permitir ao colaborador:
  - consultar saldo de férias
  - consultar pedidos recentes
  - criar pedidos de ausência
  - editar pedidos futuros
  - cancelar pedidos futuros
  - interromper férias em curso

  ## Lógica

  - O saldo disponível de férias passou a ser lido diretamente da API.
  - O mobile deixou de usar cálculo local como referência principal para os dias disponíveis.
  - O valor principal passou a ser o saldo do tipo `vacation`.
  - Os contadores visuais de aprovados, pendentes e baixas mantêm-se apenas como apoio visual.
  - Se o pedido for futuro:
    - pode ser editado
    - pode ser cancelado
  - Se o pedido estiver em curso:
    - não pode ser editado
    - pode ser cancelado para interromper as férias
  - Ao interromper férias em curso:
    - o pedido é encurtado até à data atual
    - apenas os dias já gozados ficam registados
    - os dias futuros são devolvidos ao saldo

  ## Regras de Negócio Implementadas

  - O saldo disponível de férias do colaborador deve vir da API.
  - Cancelamento de férias futuras:
    - remove o pedido
    - devolve todo o saldo correspondente
  - Cancelamento de férias em curso:
    - mantém apenas os dias já gozados
    - devolve ao saldo apenas os dias futuros não gozados
  - O dia da interrupção conta como dia usado.
  - Pedidos já terminados não podem ser cancelados.
  - Editar pedido continua disponível apenas para pedidos futuros.
  - Cancelar pedido passou a estar disponível para pedidos futuros e em curso.

  ## Dados Usados Pela API

  ### `hrm_leave_requests`
  Usado para guardar os pedidos de ausência.

  Campos relevantes:
  - `employee_id`
  - `leave_type_id`
  - `start_date`
  - `end_date`
  - `total_days`
  - `status`

  ### `hrm_leave_balances`
  Usado para guardar o saldo anual por colaborador e por tipo de ausência.

  Campos relevantes:
  - `entitled_days`
  - `used_days`
  - `pending_days`
  - `carried_over`

  ### `remainingDays`
  Valor devolvido pela API como saldo disponível calculado para o tipo `vacation`.

  Este valor passou a ser a referência principal usada pelo mobile.

  ## Endpoints Usados

  ### Consulta de dados
  - `GET /hrm/leave/user/balances`
  - `GET /hrm/leave/user/requests`
  - `GET /hrm/leave/types`

  ### Ações do colaborador
  - `POST /hrm/leave/user/requests`
  - `PATCH /hrm/leave/user/requests/:id`
  - `PATCH /hrm/leave/user/requests/:id/cancel`
  - `DELETE /hrm/leave/user/requests/:id`

  ---

  # Página: Calendário

  ## Objetivo

  Permitir ao colaborador consultar as suas ausências em contexto temporal e perceber visualmente:
  - dias em que está ausente
  - distribuição das ausências no calendário
  - contexto temporal dos pedidos aprovados e pendentes

  ## Lógica

  - O calendário usa os pedidos de ausência carregados da API.
  - Os pedidos do colaborador são convertidos em marcações por dia.
  - Pedidos rejeitados e cancelados não são considerados como ausência ativa.
  - A visualização do calendário respeita `start_date` e `end_date`.
  - Em contexto de criação ou edição, a visualização ajuda a perceber a distribuição temporal das ausências.

  ## Regras de Negócio Aplicadas

  - Ausências rejeitadas e canceladas não contam como ausências ativas no calendário.
  - A visualização depende dos pedidos existentes carregados da API.
  - A marcação temporal dos pedidos respeita o intervalo real do pedido.

  ## Dados Usados Pela API

  ### `hrm_leave_requests`
  Campos relevantes:
  - `employee_id`
  - `employee_name`
  - `start_date`
  - `end_date`
  - `status`
  - `leave_type_id`

  ### `hrm_leave_types`
  Campos relevantes:
  - `id`
  - `code`
  - `name`
  - `color`

  ## Endpoints Usados

  - `GET /hrm/leave/user/requests`
  - `GET /hrm/leave/types`
  - `POST /hrm/leave/user/requests`
  - `PATCH /hrm/leave/user/requests/:id`

  ---

  # Página: Registo de Ponto

  ## Objetivo

  Permitir ao colaborador:
  - registar a própria entrada
  - registar a própria saída
  - consultar o próprio histórico
  - consultar o próprio resumo de assiduidade

  ## Lógica

  - O módulo de registo de ponto foi estruturado em modo self-service para o colaborador.
  - O colaborador usa endpoints próprios, distintos dos endpoints administrativos.
  - O frontend não envia `employeeId`.
  - A API resolve o colaborador autenticado com base no utilizador em sessão.
  - O colaborador atua apenas sobre as próprias marcações.
  - O histórico foi ajustado para filtrar corretamente:
    - semana civil atual
    - mês civil atual
  - O registo do próprio dia passou a ser lido corretamente com filtro por data.
  - A UI do registo de ponto passou a incluir:
    - ecrã principal de registo
    - ecrã de confirmação
    - histórico de marcações

  ## Regras de Negócio Implementadas

  - O colaborador pode registar apenas o próprio ponto.
  - O colaborador não pode indicar manualmente `employeeId`.
  - O colaborador não pode consultar marcações de outros colaboradores.
  - `Esta Semana` filtra apenas a semana atual.
  - `Este Mês` filtra apenas o mês atual.
  - O histórico do próprio dia deve refletir corretamente `check-in` e `check-out`.
  - O administrador mantém os endpoints de supervisão e revisão de exceções.

  ## Dados Usados Pela API

  ### `hrm_attendance_events`
  Usado para guardar as marcações de entrada e saída.

  Campos relevantes:
  - `employee_id`
  - `event_type`
  - `timestamp`
  - `latitude`
  - `longitude`
  - `gps_accuracy`
  - `location_id`
  - `within_geofence`
  - `distance_from_location`
  - `is_exception`

  ### `hrm_employees`
  Usado para resolver o colaborador autenticado a partir do utilizador em sessão.

  Campos relevantes:
  - `id`
  - `user_id`

  ## Endpoints Usados

  ### Self-service do colaborador
  - `POST /hrm/attendance/user/check-in`
  - `POST /hrm/attendance/user/check-out`
  - `GET /hrm/attendance/user/events`
  - `GET /hrm/attendance/user/summary`

  ### Gestão administrativa
  - `POST /hrm/attendance/check-in`
  - `POST /hrm/attendance/check-out`
  - `GET /hrm/attendance/events`
  - `GET /hrm/attendance/summary`
  - `PATCH /hrm/attendance/events/:id/review`

  ---

  ## Alterações Implementadas Neste PR

  - O mobile deixou de recalcular localmente os dias disponíveis de férias como valor principal.
  - O saldo disponível passou a usar diretamente o valor carregado da API.
  - A validação de submissão de férias passou a usar saldo vindo da API.
  - O cancelamento de férias em curso foi refletido no fluxo do colaborador.
  - O botão `Cancelar` passou a estar disponível também para pedidos em curso.
  - O botão `Editar` manteve-se apenas para pedidos futuros.
  - A página de registo de ponto do colaborador foi redesenhada.
  - Foi integrado o fluxo self-service de assiduidade.
  - O histórico de assiduidade passou a filtrar por semana e mês civis.
  - Foi removido o botão decorativo sem ação no topo do histórico.
  - Foi corrigida a leitura dos registos do próprio dia.

  ---

  ## Testes

  ### Testes automatizados executados por mim

  #### Flutter
  - `flutter test`
  - Resultado:
    - `00:00 +1: All tests passed!`

  #### Análise estática
  - `flutter analyze` nos ficheiros alterados durante este trabalho
  - Resultado:
    - sem erros nos ficheiros alterados

  #### Análise global do projeto
  - `flutter analyze`
  - Resultado:
    - o projeto já tem issues pré-existentes fora do âmbito deste PR
    - `67 issues found`
    - principais tipos encontrados:
      - `deprecated_member_use`
      - `unused_import`
      - `unused_field`
      - `depend_on_referenced_packages`

  ### Testes funcionais / manuais executados

  #### Página de Ausências
  - validação do saldo disponível com base no valor vindo da API
  - validação da criação de pedido de férias
  - validação do cancelamento de pedido futuro
  - validação da interrupção de férias em curso
  - validação da atualização visual do saldo após alteração do pedido

  #### Página de Calendário
  - validação da visualização dos pedidos no calendário
  - validação da distribuição temporal das ausências
  - validação da exclusão visual de pedidos não ativos

  #### Página de Registo de Ponto
  - validação do registo de entrada
  - validação do registo de saída
  - validação do ecrã de confirmação de registo
  - validação da leitura do histórico
  - validação do filtro `Esta Semana`
  - validação do filtro `Este Mês`
  - validação da remoção do botão decorativo sem ação no histórico

  ### Notas
  - `flutter test` passou com sucesso.
  - O `flutter analyze` global continua a reportar issues já existentes no projeto e não introduzidas por este PR.
  - As validações específicas das alterações feitas neste PR ficaram sem erros nos ficheiros alterados.

  ---

  ## Notas

  Foi identificada uma regra de negócio adicional sobre transição anual de férias, mas **não foi alterada neste PR**:

  `saldo do ano = 22 + dias não gozados do ano anterior - dias gozados a mais do ano anterior`

  Esta regra deverá ser tratada numa issue/PR separado.

  ---

  ## Anexos

  ### Página Ausências
  - screenshot da página de ausências
  - screenshot do fluxo de cancelamento de pedido futuro
  - screenshot do fluxo de interrupção de férias em curso

  ### Página Calendário
  - screenshot do calendário com pedidos ativos

  ### Página Registo de Ponto
  - screenshot da página principal
  - screenshot da confirmação de registo
  - screenshot do histórico

  ---

  ## Commit

  - `2a6bf91` `TAC-2: Add templates mobile user`
  - incluir o hash do commit atual desta parte da assiduidade
