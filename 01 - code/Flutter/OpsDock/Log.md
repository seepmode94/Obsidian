
---
 # OpsDock Mobile -> Mapa de Integração

  > [!info] Objectivo
  > Trabalhar na pasta `OpsDock-mobile` usando `OpsDock-development` como fonte de verdade para:
  > - endpoints
  > - payloads
  > - autenticação
  > - permissões
  > - modelos de dados

  > [!warning] Regra actual
  > - Posso consultar `OpsDock-development`
  > - Não devo alterar `OpsDock-development` para já
  > - Tudo o que for criado no `mobile` deve ligar aos endpoints reais definidos no backend

  ---

  ## Visão Geral

  ### Mobile
  - `OpsDock-mobile/lib/core/network`
  - `OpsDock-mobile/lib/repositories`
  - `OpsDock-mobile/lib/models`
  - `OpsDock-mobile/lib/blocs`
  - `OpsDock-mobile/lib/screens`

  ### Backend de referência
  - `OpsDock-development/apps/api/src`

  ### Base URL actual
  - `http://10.0.2.2:3001/api`

  ### Stack de comunicação
  - `Dio`
  - Bearer token
  - refresh automático de token

  ---

  ## Fonte de Verdade da API

  > [!tip] Backend
  > O backend é NestJS e usa prefixo global:
  > - `/api`

  ### Endpoints base confirmados
  - `POST /api/auth/login`
  - `POST /api/auth/refresh`
  - `GET /api/users/me`

  ### Swagger
  - `http://localhost:3001/api/docs`

  ---

  ## Áreas já ligadas no Mobile

  ### Auth
  - [x] `POST /api/auth/login`
  - [x] `POST /api/auth/refresh`

  ### User
  - [x] `GET /api/users/me`

  ### Employees
  - [x] `GET /api/hrm/employees`
  - [x] `GET /api/hrm/employees/:id`
  - [x] `GET /api/hrm/employees/stats`
  - [x] `PATCH /api/hrm/employees/:id`

  ### Leave
  - [x] `GET /api/hrm/leave/types`
  - [x] `GET /api/hrm/leave/balances/:employeeId`
  - [x] `GET /api/hrm/leave/requests`
  - [ ] `POST /api/hrm/leave/requests`
  - [x] `GET /api/hrm/leave/team-balances`
  - [x] `PATCH /api/hrm/leave/balances/:id`
  - [x] `PATCH /api/hrm/leave/requests/:id/approve`
  - [x] `PATCH /api/hrm/leave/requests/:id/reject`
  - [x] `GET /api/hrm/leave/public-holidays`

  ### Attendance
  - [ ] `POST /api/hrm/attendance/check-in`
  - [ ] `POST /api/hrm/attendance/check-out`
  - [x] `GET /api/hrm/attendance/events`
  - [x] `GET /api/hrm/attendance/summary`
  - [x] `PATCH /api/hrm/attendance/events/:id/review`

  ### Documents
  - [x] `GET /api/hrm/documents`
  - [x] `GET /api/hrm/documents/:id`

  ### Onboarding
  - [x] `GET /api/hrm/onboarding/assignments`
  - [ ] `PATCH /api/hrm/onboarding/completions/:id/complete`

  ### Recruitment
  - [x] `GET /api/hrm/recruitment/jobs`
  - [x] `GET /api/hrm/recruitment/jobs/:id`
  - [x] `POST /api/hrm/recruitment/jobs`
  - [x] `PATCH /api/hrm/recruitment/jobs/:id`
  - [x] `DELETE /api/hrm/recruitment/jobs/:id`
  - [x] `GET /api/hrm/recruitment/jobs/:jobId/candidates`
  - [x] `POST /api/hrm/recruitment/candidates`
  - [x] `PATCH /api/hrm/recruitment/candidates/:id/stage`
  - [x] `POST /api/hrm/recruitment/candidates/:id/convert`
  - [x] `GET /api/hrm/recruitment/interviews`
  - [x] `POST /api/hrm/recruitment/interviews`

  ### External Tickets
  - [x] `GET /api/external-tickets/apps`
  - [x] `POST /api/external-tickets`
  - [x] `POST /api/external-tickets/crm-auth`

  ---

  ## Incompatibilidades Detectadas

  > [!danger] Pontos que precisam de correcção no mobile
  > Estes casos podem falhar mesmo que a UI exista.

  ### 1. Leave Request
  - endpoint:
    - `POST /api/hrm/leave/requests`
  - problema:
    - o backend exige `totalDays`
  - estado do mobile:
    - não envia `totalDays`
  - impacto:
    - erro de validação ao criar pedido de férias

  ### 2. Attendance Check-in / Check-out
  - endpoints:
    - `POST /api/hrm/attendance/check-in`
    - `POST /api/hrm/attendance/check-out`
  - problema:
    - o backend exige `employeeId`
  - estado do mobile:
    - não envia `employeeId`
  - impacto:
    - check-in/check-out podem falhar

  ### 3. Onboarding Complete
  - endpoint correcto no backend:
    - `PATCH /api/hrm/onboarding/completions/:id/complete`
  - estado do mobile:
    - chama `/hrm/onboarding/tasks/:id/complete`
  - impacto:
    - rota inexistente / erro 404

  ---

  ## Permissões

  > [!warning] Restrição importante
  > Grande parte dos endpoints HRM no backend está protegida com:
  > - `@Roles('admin')`

  ### Roles existentes
  - `admin`
  - `developer`
  - `support`
  - `employee`

  ### Impacto prático
  - utilizadores não `admin` podem receber `403 Forbidden`
  - isto pode afectar:
    - employees
    - leave
    - attendance
    - documents
    - onboarding
    - recruitment

  > [!question] Implicação para o mobile
  > Antes de assumir que uma funcionalidade "não funciona", confirmar se o problema é:
  > - erro de endpoint
  > - erro de payload
  > - falta de permissões

  ---

  ## Prioridades de Trabalho

  ### Alta prioridade
  - [ ] corrigir criação de férias para enviar `totalDays`
  - [ ] corrigir attendance para enviar `employeeId`
  - [ ] corrigir endpoint de conclusão de onboarding

  ### Média prioridade
  - [ ] validar se os modelos JSON do mobile correspondem exactamente às respostas do backend
  - [ ] confirmar que funcionalidades devem estar disponíveis para utilizadores não `admin`

  ### Baixa prioridade
  - [ ] mapear endpoints ainda não consumidos no mobile
  - [ ] preparar lista de futuras integrações possíveis

  ---

  ## Regra de Decisão

  ### Sempre que for criar algo no mobile
  1. confirmar se o endpoint já existe em `OpsDock-development`
  2. confirmar payload exacto esperado pelo backend
  3. confirmar resposta devolvida
  4. confirmar se exige autenticação
  5. confirmar se exige role específica
  6. só depois implementar no `mobile`

  ---

  ## Resumo Final

  > [!summary] Estado actual
  > A integração entre `OpsDock-mobile` e `OpsDock-development` já está montada e bem encaminhada.
  >
  > O mobile já consome várias áreas reais da API, mas ainda existem incompatibilidades concretas em:
  > - `leave`
  > - `attendance`
  > - `onboarding`
  >
  > O maior risco técnico neste momento é assumir que um erro vem da app, quando na prática pode ser:
  > - payload incompleto
  > - endpoint errado
  > - restrição de permissões
