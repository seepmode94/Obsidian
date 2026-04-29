# Descrição

  ## Intro

  Este PR consolida a lógica funcional da página de Registo de Ponto / Assiduidade na app OpsDock-mobile.

  O foco deste trabalho foi alinhar o comportamento do mobile com os dados e validações disponibilizados pela API do módulo HRM em OpsDock-development, garantindo consistência entre o estado do colaborador, os registos de entrada/saída, a
  validação de localização e o tratamento de exceções.

  Neste PR ficaram cobertas as regras e fluxos da página de Registo de Ponto / Assiduidade. Ficam fora deste âmbito, para tratamento posterior:

  - página inicial
  - página de ausências
  - página de calendário

  ## Páginas Incluídas Neste PR

  - Registo de Ponto / Assiduidade

  ## Páginas Fora Deste PR

  - Página Inicial
  - Página de Ausências
  - Página de Calendário

  ## Página: Registo de Ponto / Assiduidade

  ### Objetivo

  Permitir ao colaborador:

  - registar entrada
  - registar saída
  - consultar o estado atual do dia
  - visualizar o histórico de registos
  - visualizar horas acumuladas com base em pares completos de entrada/saída

  Permitir ao administrador:

  - consultar eventos de ponto
  - visualizar exceções de assiduidade
  - validar registos marcados como exceção

  ### Lógica

  O estado atual do colaborador passa a ser inferido a partir do último evento registado no dia.

  Se o último evento do dia for check-in:

  - o colaborador é considerado com sessão aberta
  - a próxima ação esperada é check-out

  Se o último evento do dia for check-out:

  - o colaborador é considerado sem sessão aberta
  - a próxima ação esperada é check-in

  O mobile usa um único botão de ação para alternar entre:

  - Registar Entrada
  - Registar Saída

  A localização GPS é recolhida no mobile sempre que disponível e enviada para a API com:

  - latitude
  - longitude
  - gpsAccuracy

  A validação de geofence é feita no backend.

  Quando existe localização:

  - a API calcula a distância ao local configurado mais próximo
  - verifica se o registo está dentro do raio permitido

  Quando o registo fica fora da geofence:

  - o registo não é bloqueado
  - o registo é aceite
  - o registo fica marcado como exceção para revisão administrativa

  Quando não existe GPS:

  - o registo continua a poder ser submetido
  - a localização não fica validada
  - o caso pode ser tratado como exceção operacional

  O total de horas visível no histórico:

  - conta apenas pares completos de check-in e check-out
  - não contabiliza sessões ainda abertas

  ### Regras de Negócio Implementadas

  - O colaborador não pode fazer check-in se já existir uma sessão aberta.
  - O fluxo esperado de ponto é sequencial:
      - check-in -> check-out -> check-in -> check-out
  - O estado atual do colaborador deve ser determinado pelo último evento do dia.
  - A geofence deve ser validada no backend.
  - Registos fora da geofence não são rejeitados automaticamente.
  - Registos fora da geofence ficam marcados como exceção.
  - Exceções podem ser revistas e validadas por um administrador.
  - O histórico de horas deve considerar apenas pares completos de entrada/saída.

  ### Regras Atualmente Aplicadas Apenas no Mobile

  - O mobile bloqueia check-in a partir das 18:00.
  - Esta regra ainda não está centralizada no backend.

  ### Lacunas Identificadas Para Alinhamento Posterior

  - O backend ainda não bloqueia check-out sem check-in ativo.
  - A regra horária das 18:00 ainda não existe na API.
  - A tabela de location schedules existe, mas ainda não participa na lógica de attendance.
  - O campo exception_reason existe na base de dados, mas ainda não está a ser preenchido pelo serviço atual.
  - A política para registos sem GPS ainda precisa de ser formalizada como regra explícita.

  ### State Flow Representativo do Registo de Ponto

  O colaborador interage com a página de Registo de Ponto no mobile, que determina a ação disponível com base no último evento do dia. Ao submeter entrada ou saída, o mobile tenta recolher GPS e envia os dados para a API HRM. A API valida
  o estado atual do colaborador, calcula a geofence com base no local mais próximo e regista o evento. Se existir anomalia de localização, o registo é aceite mas marcado como exceção. O administrador consulta essas exceções e pode validá-
  las posteriormente. O histórico e o total de horas são calculados a partir dos eventos persistidos pela API.

  ## Dados Usados Pela API

  ### hrm_attendance_events

  Usado para guardar os registos de ponto.

  Campos relevantes:

  - employee_id
  - event_type
  - timestamp
  - latitude
  - longitude
  - gps_accuracy
  - location_id
  - within_geofence
  - distance_from_location
  - is_exception
  - exception_reason
  - reviewed_by
  - reviewed_at
  - notes

  ### hrm_locations

  Usado para guardar os locais válidos para validação de geofence.

  Campos relevantes:

  - id
  - name
  - latitude
  - longitude
  - geofence_radius

  ### hrm_location_schedules

  Estrutura existente para horários por localização.

  Campos relevantes:

  - location_id
  - day_of_week
  - start_time
  - end_time

  Nota:

  - esta tabela existe, mas ainda não está a ser usada pela lógica de attendance atual

  ## Endpoints Usados

  ### Consulta de dados

  - GET /hrm/attendance/user/events
  - GET /hrm/attendance/user/summary
  - GET /hrm/attendance/events
  - GET /hrm/attendance/summary

  ### Ações do colaborador

  - POST /hrm/attendance/user/check-in
  - POST /hrm/attendance/user/check-out

  ### Ações administrativas

  - PATCH /hrm/attendance/events/:id/review

  ## O Que é Calculado no Cliente

  Mantido no mobile:

  - estado visual atual com base no último evento do dia
  - alternância do botão entre entrada e saída
  - histórico visual por dia
  - total de horas no histórico com base em pares completos
  - bloqueio local de check-in a partir das 18:00

  Não deve ser tratado como source of truth:

  - validação final de geofence
  - estado de exceção
  - regras oficiais de janela horária
  - validade do fluxo de ponto

  ## O Que Vem da API

  - eventos de ponto do colaborador
  - resumo diário de assiduidade
  - localização associada ao registo
  - resultado da validação de geofence
  - distância ao local
  - marcação de exceção
  - eventos pendentes de revisão administrativa

  ## Validação / Testes

  ### Validação Realizada

  A validação deste PR foi feita principalmente através de análise funcional e verificação da lógica implementada entre mobile e backend, com foco em:

  - alternância entre check-in e check-out
  - inferência do estado atual do colaborador a partir do último evento do dia
  - envio de localização GPS a partir do mobile
  - validação de geofence no backend
  - marcação de exceções
  - visualização e revisão administrativa de exceções
  - cálculo de histórico e total de horas com base em pares completos de entrada/saída

  ### Cobertura Automática Existente

  Atualmente, a cobertura automática existente no repositório é limitada a:

  - testes unitários na API
  - smoke / widget test básico na app mobile

  ### O Que Não Foi Validado Com Testes Automatizados Específicos

  Neste momento, não existe ainda uma suíte dedicada para validar end-to-end o fluxo de Registo de Ponto / Assiduidade, nomeadamente:

  - testes de integração da API para check-in e check-out
  - testes de integração para geofence e marcação de exceções
  - testes automáticos para revisão administrativa de exceções
  - testes end-to-end do fluxo mobile do colaborador
  - testes automatizados para cenários sem GPS
  - testes automatizados para regras de sequência inválida, como check-out sem sessão aberta

  ### Follow-up Recomendado

  Como evolução posterior, recomenda-se adicionar:

  - testes de integração da API para fluxo sequencial de attendance
  - testes para validação dentro / fora de geofence
  - testes para submissão sem GPS
  - testes para revisão administrativa de exceções
  - testes end-to-end do fluxo mobile de registo de ponto
