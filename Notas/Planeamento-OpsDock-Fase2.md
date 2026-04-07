# Planeamento OpsDock - Fase 2


### 👥 Gestão de Perfil & Dados de Colaborador (Página RH)

- [ ] **Definir e Implementar Bloqueio de Documentos:**
    *   **Exemplo:** Documentos de incapacidade/deficiência (multiusos) devem ser visíveis **apenas** para o perfil `ADMIN`.
    *   Garantir que estes dados não aparecem em listagens gerais ou exports gerados por RH.
    *   *Nota: [A REVER] Identificar outras "Situações Extraordinárias" que exijam este nível de restrição.*
- [ ] **Expansão dos Dados Pessoais:**
    *   Adicionar campos: Telefone Pessoal, E-mail Pessoal, Contacto de Emergência, Morada (aba financeira) e Data de Aniversário.
    *   Garantir que o aniversário aparece no calendário partilhado da equipa.
- [ ] **Ajuste de Dados Profissionais:**
    *   Inserir Número de Colaborador na aba profissional.
    *   Refatorar Tipos de Contrato: A Termo, Sem Termo, Tempo Indeterminado, Estágio, Part-time, Prestação de Serviços.
    *   **Login e Autenticação:** Definir o e-mail do contrato como o login oficial de acesso do colaborador à plataforma.
- [ ] **Flexibilidade no Upload:**
    *   Permitir a alteração do nome do ficheiro/documento no momento do upload.
- [ ] **Recibos de Vencimento (Ligação Primavera):**
    *   Efetuar levantamento de necessidades técnicas para integração com o ERP Primavera.
    *   *Nota: Avaliar se esta é a fase ideal para implementar.*
    *   *Nota: Estes Recibos vão diretamente para os documentos do colaborador.*

### 🏖️ Férias e Ausências (Página RH)

- [ ] **Atualização de Interface (Cards):**
    *   Alterar os cards informativos para: "Disponíveis para o ano", "Marcados", "Por marcar", "Já gozadas" e "Pendentes".
- [ ] **Melhorias no Calendário/Mapa:**
    *   Deixar marcado no mapa calendário os outros tipos de ausência (além de férias).
    *   Permitir que o ADMIN, ao clicar num dia específico, veja o detalhe do tipo de ausência do colaborador.
- [ ] **Novos Tipos de Ausência:**
    *   Adicionar **"Nojo"** (falecimento) com seleção de Grau de Parentesco (validar legislação).
    *   Adicionar **"Assistência à Família"** (validar regras de assistência a filhos em idade escolar).
- [ ] **Gestão de Saldos de Férias:**
    *   Permitir a marcação de férias com **saldo negativo**.
    *   Implementar transição automática de saldos (positivos e negativos) para o período seguinte.
- [ ] **Ausência para Consultas Médicas:
    * Permitir o registo de ausência parcial com especificação de horário (hora de início e fim).
    * Implementar funcionalidade para o colaborador anexar o comprovativo médico (upload) após a realização da consulta.

#### 📱 Versão Mobile
- [ ] **Ausências da Equipa:**
    *   Melhorar a visualização do mapa (ex: suporte a modo landscape/rodar telemóvel para apresentar mais detalhes do mapa).

### 🕒 Assiduidade (Página RH)

- [ ] **Controlo de Picagens:**
    *   Permitir picagem antecipada (antes do horário definido).
    *   Implementar controlo e registo do período de almoço.
    *   Adicionar opção de picagem para **"Consulta"**.
- [ ] **Sincronização & Cruzamento de Dados:**
    *   Garantir paridade total entre os dados mobile e web.
    *   Implementar cruzamento automático entre as picagens e as ausências parciais registadas.

### 🛠️ Página Departamento Técnico

- [ ] **Ordenação de Listagens:**
    *   Ordenar a tabela de colaboradores por ordem alfabética.

### 💼 Recrutamento (Página RH)

- [ ] **Gestão de Vagas:**
    *   Adicionar novas áreas/campos ao criar uma vaga.
    *   Incluir informações de: Empresa e Delegação.
- [ ] **Workflow de Entrevistas:**
    *   Retirar a parte da Candidatura.
    *   Adicionar possibilidade de configurar uma **2ª Entrevista** (aba específica caso exista).
    *   Definir Pessoa Responsável pela entrevista em ambas as fases (1ª e 2ª fase).
    *   Configurar agendamento automático de e-mail para o candidato com os detalhes da entrevista (usando como referência o e-mail de info@seepmode.com).
- [ ] **Dados do Candidato:**
    *   Adicionar campo de Notas/Observações.
    *   Upload de Documentos: Currículo, Certificados de Habilitações e Certificados Médicos.
- [ ] **Conversão para Colaborador (Fluxo de Admissão):**
    *   **Fase Intermédia:** Ao ser admitido, o candidato passa primeiro para o estado de **"Período Experimental"** (em vez de passar diretamente a Colaborador).
    *   **Automação de Transição:** O sistema deve transitar o colaborador automaticamente para o estado final de **"Colaborador"** após o término do período experimental (validar prazos legais por tipo de contrato).
    *   **Notificações de Status:** Enviar aviso automático aos Recursos Humanos e Gestores de Equipa tanto no início do período experimental como na transição final para colaborador.
    *   Implementar função de aviso automático à equipa (notificação/e-mail) quando um candidato é admitido.
    *   Manter a fase **"Contratado"** na pipeline de recrutamento para preservar o histórico.

### 🚪 Gestão de Offboarding (Saídas) - Página RH

- [ ] **Lógica de Demissão e Aviso Prévio:**
    *   Implementar sistema de cálculo automático de aviso prévio com base no tipo de contrato (Ex: Efetivo = 60 dias).
    *   **Novo Estado de Colaborador:** Criar o estado **"Em Demissão"** para identificar colaboradores que pediram a demissão e estão a cumprir o aviso prévio.
    *   **Automação de Transição:** O colaborador passa de "Colaborador" para "Em Demissão" ao registar a saída, e para "Inativo" após o último dia de trabalho.
    *   **Automação de Notificações:** Enviar alerta ao Responsável de Departamento, RH e Admin quando um pedido de demissão for registado.
    *   **Template de Alerta:** "Colaborador [X], da empresa [X] e cargo [X], pediu demissão; cumpre o prazo de [X] dias."

- [ ] **Dashboard & Suporte à Decisão:**

    *   Criar dashboard de recrutamento para o candidato recrutado, exibindo as notas e observações acumuladas para facilitar a decisão final.
- [ ] **Estatísticas & Analytics:**
    *   Implementar aba de estatísticas anuais de recrutamento.
    *   Incluir gráficos com métricas por: Departamento, Empresa e Cargo.


### 🔄 **Paridade & Consistência Web/Mobile (Global)

- [ ] **Validação Cruzada (Cross-Platform Sync):
* Garantir que todas as novas funcionalidades e dados inseridos na Web tenham paridade total com a versão Mobile.
* Testes Comparativos: Realizar testes em cada página para assegurar que a experiência de utilizador (UX) e a integridade dos dados são consistentes em ambas as plataformas.
