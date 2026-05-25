# Reunião Formação — Resumo

**Data:** 2026-05-25
**Tema:** CRM — reorganização de módulos para o fluxo da Formação

---

## Contexto / Pontos discutidos

### Acessos IEFP
- Quando as empresas não dão representatividade, os acessos ficam em **Acessos IEFP**.
- As colegas de Formação nunca acedem a essa página.

### Formandos e Formadores
- Com as alterações previstas, é possível que deixe de ser necessário ir às páginas de **Formandos** e **Formadores**.
- Essa informação passa a ser apresentada diretamente nas **Ações**.

###  Contactos
- Módulo **Contactos** serve para tudo: formadores, formandos, médicos, pacientes, etc.
- Função atual: armazenamento e tratamento de dados.
- **Separar conteúdo sensível** dentro de Contactos para que quem trata das formações não veja, por exemplo, os pacientes.

---

### Ações (página central das alterações)
- Adicionar **módulos** dentro de Ações para evitar saltar de página em página.
- Objetivo: manter todo o conteúdo nesta página.

### Módulo Formador
- Adicionar módulo **Formador** dentro de Ações.
- Informações apresentadas em **dropdown**.
- Inclui infos das **ações ministradas**, valores, etc.
- Dados já existem, mas passam a **refletir dentro da Ação** (deixa de ser preciso ir à página do formador).
- Ao **selecionar o formador no dropdown**, apresentar automaticamente **toda a informação que precisa de ser preenchida** (campos relacionados com aquele formador).

### Módulo Sala (Localização)
- Já existe, mas precisa de novos campos:
    - Atribuída a X formador
    - Nome da sala
    - Morada
    - Condições comerciais
    - Condições de pagamento
    - Nº de fatura
    - Data de pagamento
    - IVA
    - (… restantes campos pertinentes)
- Criar **base de dados geográfica** no módulo Sala, com pesquisa por **dropdowns encadeados**:
    - Dropdown **Região** (ex.: Faro)
    - Dropdown **Concelho**
    - Dropdown **Cidades do concelho**
- Ao filtrar por região/concelho/cidade, mostrar os **projetores disponíveis para a área** (cruza com a aba Projetores).
- Exemplo: formação em Faro → seleciona região → vê projetores disponíveis nessa zona.

### Módulo Formandos
- Adicionar módulo **Formandos** dentro de Ações.
- Deixa de ser necessário ir a **Contactos / Formandos** para consultar/preencher.
- Dados refletidos diretamente dentro da Ação.

### Módulo Sessões
- Adicionar módulo **Sessões** dentro de Ações.
- Campos:
    - **Datas** da sessão
    - **Hora de início** e **hora de fim**
    - **Formandos** em dropdown (selecionáveis a partir de Contactos)
- Substitui a necessidade de consultar Formandos/Formadores em páginas separadas.

### Nova aba Projetores (Inventário)
- Criar nova aba **Projetores** que funciona como inventário.
- Usa os **filtros das salas** para saber em que sala está cada projetor em **tempo real**.
- Manter **histórico** de utilização:
    - Por quem foi usado
    - Em que formações foi requisitado
- **E-mail automático** (se possível) para quem tem o projetor no momento, a informar:
    - _"Vamos precisar do projetor para o dia X, por favor entregar o projetor a …"_

### Integração Calendário CStaff ↔ CRM
- Ligar o **calendário do CStaff** ao CRM.
- Ligação feita na **parte final** do fluxo da ação.
- **Campos dinâmicos por modalidade**:
    - Se **e-learning** → abre tabelas/campos específicos para e-learning.
    - Se **presencial** → abre tabelas/campos próprios do presencial.
- Objetivo: simplificar o processo, mostrando apenas o que é necessário para cada modalidade.
- Adicionar uma **frame/embed no CRM** para **visualizar o calendário tal como está no CStaff**:
    - Vista mensal (Seg–Dom) com navegação `< Mês Ano >`.
    - Contadores por dia (`Xaç. · Xform.`) — nº de ações e nº de formandos.
    - Cores por **empresa/origem** (ex.: Seepmode, Tacovia) e por **modalidade** (presencial vs e-learning).
    - Cada entrada clicável → abre a ação correspondente no CRM.

![[anexos/cstaff-calendario.png]]

### Aba Anexos / Módulo DTP — Anexos (fim da ação)
- No **final da ação** entra mais um "módulo" → **DTP / Anexos**.
- Centraliza documentos/ficheiros relacionados com a ação (contratos, comprovativos, materiais, etc.).
- Conteúdo previsto:
    - **Apresentação utilizada** (PPT)
    - **Digitalização do DTP**
    - **Plano de sessão / programa** (automatizado)
    - **Avaliação da ação** (parte pedagógica)
    - **Avaliação da ação em e-learning** das ações
    - **Relatórios estatísticos**, etc.
- **Regra de bloqueio:** se **não existirem anexos**, **não é possível finalizar a ação**.
- **Verificação IEFP** (notificações) integrada nesta fase.
- A confirmar: **emissão de certificados** ocorre aqui?

### Estado da Ação — bloqueio em Pré-Ativo
- Enquanto **nem todos os campos estiverem preenchidos**, o estado da ação **não transita de "Pré-Ativo"**.
- Funciona como validação obrigatória antes de avançar no fluxo.

### Estados das formações
- Atualmente existem **6 estados**.
- **Adicionar "Pré-Ativo"** → passa a haver mais estados antes da ação ser efetivamente criada.
- A informação é solicitada quando a ação é criada, mas a ação **tem estados antes** desse momento.

### Comprovativo de Frequência Individual
- Atualmente vem em **Word**.
- Acrescentar **automatismo** que cruze **IEFP ↔ CRM** (o CRM já tem toda a informação necessária).
- Objetivo: gerar o comprovativo automaticamente, sem preenchimento manual.

### Pasta do Cliente / Centralização no CRM
- A **pasta do cliente** continua guardada no **servidor**.
- Toda a informação do cliente passa a estar **dentro do CRM**.
- Permite consultar o **estado das candidaturas em massa**.

### Localização da Ação
- **NUTS II** = local da ação (campo a normalizar).

### Integração SIGO
- Integração dos **recibos** com o **SIGO**.
- Adicionar no CRM a **importação do ficheiro CSV** do SIGO para **formandos**.
- Campos solicitados ao cliente para preencher (entrada padronizada).
- **Adaptar o ficheiro Excel do SIGO** (`Formandos_Template.xls`) para que os **formadores** o preencham diretamente.
    - Manter as colunas do template SIGO (ex.: Identificação, Sub Tipo Doc Identificação, Número Doc Identificação, Check Digit, …).
    - Servir de fonte única para depois importar no CRM sem retrabalho.

![[anexos/sigo-formandos-template.png]]

### Importação de dados no CRM
- Definir **campos obrigatórios** na importação.
- Garantir **não duplicação de clientes** (chave de deduplicação + normalização).
- Apoia a estratégia geral de normalização de dados.

### Questões — Modelo de dados de Contactos
- O módulo **Contactos** agrega hoje vários "tipos" no mesmo registo (Formador, Formando, Médico, Paciente, Salas, …) via campo **Tipo**.
- Dúvidas levantadas:
    - O **Excel** (template SIGO) **suporta várias tipologias** de contacto no mesmo ficheiro?
    - Será que **Contactos é o melhor sítio** para gerir estes atores tão diferentes?
    - Não seria solução criar **módulos próprios** para **Formandos** e **Pacientes** (e separar por natureza)?
- Implicações:
    - Vantagem de módulos próprios: schema dedicado, permissões granulares, separação de dados sensíveis (paciente ≠ formando).
    - Vantagem de Contactos unificado: 1 fonte de identidade, menos duplicação se a mesma pessoa for vários papéis.
- **Decisão pendente** antes de avançar com os submódulos dentro de Ações.

![[anexos/crm-contactos-tipo.png]]

### Revisão do módulo IEFP
- Avaliar se o **módulo IEFP** ainda tem utilidade ou se está **a mais**.
- Se redundante face às novas alterações → **remover/consolidar** noutro módulo.


### Mapeamento dos campos atuais da Ação (CRM) ↔ nova estrutura
Análise sobre o ecrã atual da Ação para verificar **se falta informação**.

![[anexos/crm-acao-mapeamento.png]]

**SEGUIMENTO** (já existente, manter)
- Data verificação · Data entrega informação ao formando · Data envio adjudicação ao formador · Nº certificados enviados · Seguimento do cliente · Data digitalização · Ação fechada (S/N) · Fechado por
- Data envio email info ao cliente · Data confirmação tele cliente · Data envio certificados · Observações · Data análise estatística · Data fecho ação

**LOCALIZAÇÃO / Sala** (expandir)
- Atuais: Local (ex.: Portugal_Faro) · Morada · Sala · Projector · Nº Fatura · Valor · Data pagamento sala
- A acrescentar (nome das salas em **tabela/dropdown**, se não existir → opção de criar):
    - Nome da sala
    - Morada
    - Condições comerciais
    - Condições de pagamento
    - Nº fatura · **Fatura** (em falta) · Valor · IVA · Data de pagamento
    - **Nome e contacto do responsável** · **email**

**Formadores** (novo módulo dentro da Ação)
- Dropdown com **caixa de seleção das formações que cada formador ministra**.
- Ao selecionar, autopreencher campos relacionados.

**Projetor**
- Dúvida em aberto: **possibilidade de alocar em vários dias?** (validar com aba Projetores).

**Sessões** (novo módulo)
- Início, fim
- **Dentro da sessão → formandos** (dropdown).

**Formandos** (novo módulo dentro da Ação)
- Possibilidade de **anexar**: certificados, justificativos, reclamações.
- **Checkbox** para certificar que estão no **SIGO**.

**FATURA** (já existente, manter)
- Nº Factura · Valor Factura · Data Factura · Data pagamento · Valor pago.

**ATRIBUIÇÃO** (já existente, manter)
- Atribuído a · Vendedor.

**Relações** (já existente)
- Faturas · Sessões · Grupos de segurança.

> **A confirmar:** se há mais campos legais/IEFP que estejam fora deste ecrã e precisem de entrar no novo desenho.

### Normalização de dados
- Todos os campos passam a ser **selecionáveis** (com opção "criar novo").
- **Não dar liberdade de escrita livre** → garante dados normalizados.

---

## Decisões tomadas

- Centralizar fluxo da Formação no módulo **Ações** com submódulos embutidos.
- Substituir campos de texto livre por campos selecionáveis em todos os módulos relevantes.
- Reforçar segregação de dados sensíveis no módulo Contactos.

## Ações / Próximos passos

- [ ] Mapear que submódulos devem aparecer dentro de **Ações**.
- [ ] Expandir o módulo **Sala** com os novos campos (formador, nome, morada, condições comerciais/pagamento, nº fatura, data pagamento, IVA).
- [ ] Criar módulo **Formador** dentro de Ações em dropdown, com ações ministradas e valores; ao selecionar o formador, apresentar automaticamente os campos que precisam de ser preenchidos.
- [ ] Criar módulo **Formandos** dentro de Ações para evitar consulta em Contactos/Formandos.
- [ ] Criar nova aba **Projetores** (inventário): localização em tempo real por sala, histórico de utilização (utilizador + formação) e e-mail automático de pedido de devolução.
- [ ] Implementar base de dados geográfica no módulo **Sala** com dropdowns encadeados (Região → Concelho → Cidade) e cruzamento com disponibilidade de projetores na área.
- [ ] Criar módulo **Sessões** dentro de Ações com datas, hora início/fim e formandos em dropdown.
- [ ] Adicionar aba **Anexos** dentro de Ações para centralizar documentos da ação.
- [ ] Desenhar módulo **DTP/Anexos** no final da ação (PPT, digitalização DTP, plano de sessão automatizado, avaliação pedagógica, avaliação e-learning, relatórios estatísticos).
- [ ] Implementar regra: **ação não finaliza sem anexos obrigatórios**.
- [ ] Ligar **verificação IEFP** (notificações) ao módulo DTP/Anexos.
- [ ] Confirmar se a **emissão de certificados** acontece no módulo DTP/Anexos ou noutro ponto.
- [ ] Integrar **calendário do CStaff** com o CRM na parte final do fluxo, com campos dinâmicos consoante a modalidade (e-learning vs presencial).
- [ ] Embeber **frame do calendário do CStaff** dentro do CRM (vista mensal, contadores diários ações/formandos, cores por empresa e modalidade, entradas clicáveis para a ação).
- [ ] Implementar regra de estado: ação só sai de **Pré-Ativo** quando todos os campos estiverem preenchidos.
- [ ] Adicionar estado **Pré-Ativo** ao ciclo (passar de 6 para 7 estados) e mapear estados anteriores à criação da ação.
- [ ] Automatizar geração do **Comprovativo de Frequência Individual** cruzando IEFP ↔ CRM (substituir Word manual).
- [ ] Centralizar pasta do cliente no CRM (servidor mantém ficheiros, CRM mantém informação + estado das candidaturas em massa).
- [ ] Normalizar campo **NUTS II** como local da ação.
- [ ] Integrar **recibos** via SIGO e importação do **CSV do SIGO** para formandos.
- [ ] Adaptar o template Excel do SIGO (`Formandos_Template.xls`) para ser preenchido pelos formadores e usado como input do CRM.
- [ ] Definir **campos obrigatórios** na importação de dados do CRM e regra de **deduplicação** de clientes.
- [ ] Listar e automatizar todos os pontos de processo passíveis de automação.
- [ ] Avaliar utilidade do módulo **IEFP** — decidir entre manter, consolidar ou remover.
- [ ] Definir regra de visibilidade em **Contactos** para isolar pacientes/dados sensíveis das colegas da Formação.
- [ ] Converter campos de texto livre em listas selecionáveis com opção "criar novo".
- [ ] Validar se Formandos/Formadores ficam ocultos ou removidos do menu após migração para Sessões.

## Pendências / Bloqueios

- **Decisão pendente:** manter Contactos como módulo único multi-tipo **ou** criar módulos dedicados a **Formandos** e **Pacientes**. Bloqueia o desenho dos submódulos dentro de Ações.
- Confirmar se o template Excel do SIGO suporta múltiplas tipologias de contacto ou se exige um ficheiro por tipologia.
- Confirmar onde é feita a **emissão de certificados** (módulo DTP/Anexos ou outro).
- Validar se o **projetor** pode ser alocado em vários dias dentro da mesma ação.

## Notas adicionais

-
