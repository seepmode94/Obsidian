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
- Essa informação passa a ser apresentada diretamente nas **Sessões**.

### Contactos
- Módulo **Contactos** serve para tudo: formadores, formandos, médicos, pacientes, etc.
- Função atual: armazenamento e tratamento de dados.
- **Separar conteúdo sensível** dentro de Contactos para que quem trata das formações não veja, por exemplo, os pacientes.

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

### Aba Anexos
- Adicionar **aba para anexos** dentro de Ações.
- Centraliza documentos/ficheiros relacionados com a ação (contratos, comprovativos, materiais, etc.).

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

### Importação de dados no CRM
- Definir **campos obrigatórios** na importação.
- Garantir **não duplicação de clientes** (chave de deduplicação + normalização).
- Apoia a estratégia geral de normalização de dados.

### Automação
- **Automatizar o processo o máximo possível** (transversal a todos os pontos acima).

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
- [ ] Integrar **calendário do CStaff** com o CRM na parte final do fluxo, com campos dinâmicos consoante a modalidade (e-learning vs presencial).
- [ ] Implementar regra de estado: ação só sai de **Pré-Ativo** quando todos os campos estiverem preenchidos.
- [ ] Adicionar estado **Pré-Ativo** ao ciclo (passar de 6 para 7 estados) e mapear estados anteriores à criação da ação.
- [ ] Automatizar geração do **Comprovativo de Frequência Individual** cruzando IEFP ↔ CRM (substituir Word manual).
- [ ] Centralizar pasta do cliente no CRM (servidor mantém ficheiros, CRM mantém informação + estado das candidaturas em massa).
- [ ] Normalizar campo **NUTS II** como local da ação.
- [ ] Integrar **recibos** via SIGO e importação do **CSV do SIGO** para formandos.
- [ ] Definir **campos obrigatórios** na importação de dados do CRM e regra de **deduplicação** de clientes.
- [ ] Listar e automatizar todos os pontos de processo passíveis de automação.
- [ ] Definir regra de visibilidade em **Contactos** para isolar pacientes/dados sensíveis das colegas da Formação.
- [ ] Converter campos de texto livre em listas selecionáveis com opção "criar novo".
- [ ] Validar se Formandos/Formadores ficam ocultos ou removidos do menu após migração para Sessões.

## Pendências / Bloqueios

-

## Notas adicionais

-
