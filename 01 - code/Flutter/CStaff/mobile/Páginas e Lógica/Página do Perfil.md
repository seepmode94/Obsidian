  # Página: Perfil

  ## Objetivo

  Permitir ao colaborador:
  - consultar os próprios dados pessoais e profissionais
  - consultar documentos associados ao seu perfil
  - navegar para a página completa de documentos
  - consultar detalhes completos do perfil em modo apenas leitura
  - terminar sessão

  ## Lógica

  - A página de perfil foi redesenhada para um formato mais próximo de mobile app final.
  - O cabeçalho apresenta:
    - avatar com iniciais
    - nome do colaborador
    - cargo
    - departamento
  - A secção `Meus Documentos` deixou de usar conteúdo mockado.
  - A secção `Meus Documentos` passa a carregar documentos reais através do repositório de documentos em modo self-service.
  - São apresentados até 3 documentos na área do perfil.
  - O botão `Ver todos` encaminha o colaborador para a página completa de documentos.
  - O link `Ver mais detalhes` abre um bottom sheet com todos os dados disponíveis do colaborador em modo read-only.
  - O atalho `Segurança e Palavra-passe` foi removido por não existir ainda fluxo funcional associado.
  - Os dados pessoais deixaram de apresentar placeholders mockados e mostram apenas valores reais ou `--`.

  ## Regras de Negócio Implementadas

  - O colaborador só pode consultar documentos visíveis para si.
  - O perfil mostra apenas documentos reais associados ao colaborador ou documentos globais permitidos.
  - A consulta de detalhes do colaborador é apenas de leitura.
  - O perfil não expõe ações de edição avançada nesta fase.
  - O perfil não expõe fluxo de alteração de palavra-passe.

  ## Dados Usados Pela API

  ### `hrm_employees`
  Usado para carregar os dados do colaborador autenticado.

  Campos relevantes:
  - `first_name`
  - `last_name`
  - `email`
  - `personal_email`
  - `phone`
  - `date_of_birth`
  - `gender`
  - `nationality`
  - `address`
  - `city`
  - `postal_code`
  - `country`
  - `tax_id`
  - `social_security_number`
  - `bank_iban`
  - `employee_number`
  - `department_name`
  - `delegacao_name`
  - `manager_name`
  - `role`
  - `hire_date`
  - `start_date`
  - `end_date`
  - `probation_end_date`
  - `work_schedule`
  - `notes`

  ### `hrm_documents`
  Usado para carregar documentos associados ao colaborador.

  Campos relevantes:
  - `employee_id`
  - `category`
  - `title`
  - `file_url`
  - `file_name`
  - `visibility`
  - `created_at`

  ## Endpoints Usados

  ### Perfil
  - `GET /users/me`
  - `GET /hrm/employees/me`

  ### Documentos do colaborador
  - `GET /hrm/documents/user/list`
  - `GET /hrm/documents/user/:id`

  ## Alterações Implementadas

  - Redesenho da página de perfil do colaborador.
  - Substituição de dados mockados por dados reais no perfil.
  - Integração de documentos reais na secção `Meus Documentos`.
  - Navegação de `Ver todos` para a página de documentos do colaborador.
  - Criação de apresentação read-only dos detalhes completos do colaborador.
  - Remoção do atalho `Segurança e Palavra-passe`.

  ## Validações

  - Validar carregamento dos dados reais do colaborador no perfil.
  - Validar apresentação de até 3 documentos reais na secção `Meus Documentos`.
  - Validar navegação de `Ver todos` para a página de documentos.
  - Validar abertura do detalhe completo do colaborador em read-only.
  - Validar ausência de ações de edição nessa vista.
  - Validar remoção do atalho de segurança.

