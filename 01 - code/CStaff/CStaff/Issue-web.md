# Recrutamento: organização de vagas por departamento e suporte a múltiplas vagas

## Intro

A página de recrutamento apresenta as vagas sem agrupamento claro por departamento e sem identificação da empresa associada, dificultando a navegação e a leitura quando existem várias oportunidades em aberto. Adicionalmente, o fluxo actual não permite registar mais do que uma vaga em simultâneo para o mesmo departamento/empresa, limitando o uso real do módulo. O pedido é reorganizar a apresentação das vagas, expor a informação da empresa e permitir múltiplas vagas em aberto.

## Alterações

Reorganização do módulo de recrutamento para agrupar as vagas por departamento, expor a informação da empresa e suportar múltiplas vagas em simultâneo. Principais alterações:

- **Agrupamento por departamento:** as vagas passam a ser apresentadas agrupadas pelo departamento a que pertencem, com cabeçalho/secção dedicada por cada departamento.

- **Informação da empresa:** cada vaga (ou bloco de departamento) passa a mostrar a empresa associada, para distinguir vagas de empresas diferentes dentro do mesmo grupo.

- **Suporte a múltiplas vagas:** remoção da restrição que impedia mais do que uma vaga em aberto para o mesmo departamento/empresa; o formulário e a listagem passam a aceitar e a apresentar N vagas em simultâneo.

- **Listagem e ordenação:** ajuste da listagem para ordenar vagas dentro de cada departamento de forma consistente (ex.: por data de criação ou estado), evitando duplicação visual e melhorando a leitura.

- **Inserção de todos os departamentos:** garantir que todos os departamentos existentes ficam disponíveis no módulo de recrutamento, incluindo aqueles que actualmente não estão a ser carregados/listados, para que qualquer vaga possa ser associada ao departamento correcto.

**Resultado esperado:** página de recrutamento mais legível e organizada, com vagas agrupadas por departamento e empresa visíveis, e possibilidade de manter várias vagas abertas em paralelo sem conflitos de listagem ou criação.

---

# Centro de Operações: corrigir listagem de colaboradores por departamento e expor vagas/delegações

## Intro

No Centro de Operações a listagem de colaboradores por departamento está incorrecta: aparecem colaboradores inactivos misturados com os activos, o que polui a vista e induz em erro sobre a equipa real do departamento. Além disso, não existe qualquer indicação visual quando o departamento tem vagas abertas, apesar de essa informação ser relevante no mesmo contexto. O caso de SST tem ainda a particularidade de ter delegações, que actualmente não estão reflectidas na estrutura. Existe um Excel com as necessidades de vagas por departamento que deve servir de referência para alinhar a informação apresentada.

## Alterações

Correcção da listagem de colaboradores por departamento no Centro de Operações, integração da informação de vagas em aberto e suporte a delegações para SST. Principais alterações:

- **Filtrar colaboradores inactivos:** os colaboradores inactivos deixam de aparecer dentro do departamento na vista do Centro de Operações; passam a listar-se apenas os colaboradores activos.

- **Indicador de vagas abertas:** quando o departamento tem vagas em aberto, apresentar no mesmo local o número de vagas disponíveis, de forma a tornar visível a necessidade de recrutamento sem trocar de página.

- **Delegações de SST:** o departamento de SST passa a suportar e a apresentar as suas delegações, reflectindo a estrutura real (departamento + delegações) na listagem.

- **Alinhamento com Excel de necessidades:** uso do Excel existente com as necessidades de vagas por departamento como fonte de referência para validar/popular o número de vagas apresentado por departamento.

**Resultado esperado:** vista do Centro de Operações com colaboradores correctos por departamento (apenas activos), número de vagas em aberto visível junto ao departamento, SST com as suas delegações representadas e informação coerente com o Excel de necessidades de vagas.

---

# Departamento Técnico: nova aba no detalhe do colaborador para ID do terminal Dahua

## Intro

No departamento técnico, o detalhe do colaborador não dispõe de um local para registar o ID do terminal de picagem Dahua associado a cada colaborador, informação necessária para correlacionar registos do terminal físico com o utilizador correspondente no sistema. Actualmente esta associação é feita fora do detalhe (ou de forma não estruturada), dificultando consulta e manutenção. O pedido é adicionar uma nova aba no detalhe do colaborador (dentro do departamento técnico) que permita inserir e gerir o ID do terminal Dahua.

## Alterações

Adição de nova aba no detalhe do colaborador (departamento técnico) para registo do ID do terminal de picagem Dahua. Principais alterações:

- **Nova aba "Terminal Dahua":** adição de aba dedicada no detalhe do colaborador, dentro do departamento técnico, para configuração do terminal de picagem.

- **Campo ID do terminal:** input para inserir/editar o ID do terminal Dahua associado ao colaborador, com validação básica de formato e persistência no backend.

- **Modelo/persistência:** extensão do modelo do colaborador (ou tabela associada) para suportar o campo `dahua_terminal_id`, com migração e endpoint correspondente.

- **Permissões:** acesso à aba e à edição limitado aos perfis adequados (ex.: admin/RH/técnico), seguindo o modelo de permissões já existente no detalhe do colaborador.

- **Apresentação/leitura:** o ID guardado fica visível na aba e pode ser consultado/alterado posteriormente, suportando a correlação com registos vindos do terminal Dahua.

**Resultado esperado:** colaboradores do departamento técnico passam a ter no seu detalhe uma aba dedicada onde se insere e mantém o ID do terminal de picagem Dahua, permitindo associação clara entre utilizador e dispositivo físico.

---

# Excepções: disponibilizar acções "validar" e "assumir falta" em paralelo

## Intro

Na web, no módulo de Excepções, as opções disponíveis estão limitadas e não permitem ao gestor escolher livremente entre **validar** uma excepção (caso em que a falta não é cobrada ao colaborador) e **assumir falta** (caso em que se mantém o registo de falta). Actualmente uma das acções não está acessível ou está condicionada de forma que obriga a tratar fora do fluxo. O pedido é manter **ambas** as opções disponíveis em paralelo, preservando as regras já implementadas para cada uma delas.

## Alterações

Disponibilização das duas acções de tratamento de excepções (validar / assumir falta) em paralelo, mantendo as regras existentes. Principais alterações:

- **Acção "Validar":** opção de validar a excepção, registando-a como justificada e **não** cobrando falta ao colaborador.

- **Acção "Assumir falta":** opção de assumir a excepção como falta, mantendo o comportamento actual de registo/cobrança da falta.

- **Ambas disponíveis em simultâneo:** a UI passa a apresentar as duas acções lado a lado para cada excepção, sem exclusões artificiais — o gestor escolhe a que aplicar caso a caso.

- **Manutenção das regras já implementadas:** preservar as regras de negócio actuais associadas a cada acção (impacto em saldo, registo no histórico, notificações, permissões, etc.) sem alterar comportamento existente — apenas garantir disponibilidade simultânea.

**Resultado esperado:** no módulo de Excepções, o gestor passa a ter sempre disponíveis as duas acções (validar e assumir falta) em paralelo, podendo optar pela mais adequada a cada caso, com as mesmas regras de negócio já aplicadas hoje a cada uma delas.
