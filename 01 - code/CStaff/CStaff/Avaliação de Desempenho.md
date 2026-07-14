
---
# CStaff -> Estudo: Avaliação de Desempenho

> [!info] Objetivo
> Estudar modelos existentes de avaliação de desempenho (ex: Factorial) para desenhar a funcionalidade equivalente no CStaff.

> [!note] Fontes em estudo
> - Vídeo: [Modelo Avaliação de Desempenho para avaliar a performance da sua equipa (Guia passo a passo)](https://www.youtube.com/watch?v=txnTaEVP1ig)
> - Referência visual: modelo Factorial (screenshot, ver abaixo)

---

## Modelo de referência (Factorial)

### Questionários quantitativos
- Formulário quantitativo para medir resultados de forma objetiva e padronizada.
- Ideal para estabelecer métricas-chave (KPIs), comparar pontuações entre períodos e obter dados precisos para tomada de decisão baseada em evidências.
- Consolidação dos resultados num separador "relatório global".
- Editável por colaborador, em separadores próprios (Colaborador 1, Colaborador 2, etc.).

### Questionários abertos (Qualitativos)
- Separador "QUESTIONÁRIO ABERTO" permite personalizar perguntas que aprofundam o "porquê" dos resultados.
- Valor: capturar nuances, sugestões e contextos que os números não revelam -> feedback mais humano e detalhado.

---

## Fluxo do modelo (passo a passo)

### Fase 1 — Preparação e configuração

![[factorial-avaliacao-desempenho-instrucoes-fases.png]]

1. **Definir parâmetros** no separador `CONFIGURAÇÃO`:
   - Até **8 critérios de avaliação** (competências), cada um com nome + significado descrito em forma de comportamentos observáveis.

     ![[factorial-avaliacao-desempenho-config-competencias-1.png]]

     Exemplo de critérios usados no modelo: Compromisso, Orientação ao Cliente (E/I), Habilidades de Comunicação, Adaptação à Mudança, Inovação, Rigor Profissional, Resolução de Problemas, Liderança.

     ![[factorial-avaliacao-desempenho-config-competencias-2-departamentos.png]]

   - Até **4 departamentos** (ex: Administração e Finanças, Vendas, Sistemas, Recursos Humanos).
   - *Recomendação do modelo:* depois de configurado, ocultar os separadores de configuração ("Hide Sheet") para evitar confusões.

2. **Definir escalas e planos de ação** no separador `CONFIG 2`:

   ![[factorial-avaliacao-desempenho-escala-niveis-plano-acao.png]]

   - **Escala Global**: intervalo de pontos (0–100) mapeado para um nível/medalha (ex: Sem Avaliar, Bronze, Prata...).
   - **Tabela de Níveis**: converte a resposta qualitativa do avaliador em pontos — Não Aplica = 0, Baixo = 25, Médio = 50, Alto = 80, Excelente = 100.
   - **Plano de Ação**: lista fixa de ações possíveis — Formação, Supervisão, Mentoria, Promoção, Plano de Desenvolvimento.

3. **Registar participantes** no separador `COLABORADORES`:

   ![[factorial-avaliacao-desempenho-colaboradores-lista.png]]

   - Lista de colaboradores com Nome, Cargo, Avaliador, Departamento, Data de Alta.
   - As colunas de pontuação por competência (Compromisso, Orientação ao Cliente, etc.) são preenchidas **automaticamente** a partir dos questionários individuais — é aqui que se consolidam os resultados de todos.
   - Cada colaborador fica associado a um número de questionário específico (E1, E2, E3...) que o avaliador deve preencher.

### Fase 2 — Execução da avaliação

Cada colaborador tem o seu próprio separador de questionário (`E1`, `E2`, ...).

![[factorial-avaliacao-desempenho-questionario-cabecalho.png]]

- Cabeçalho automático: Nome, Cargo, Responsável/Avaliador, Departamento, Data de Alta. O avaliador só introduz a **Data de Avaliação**.
- Para cada competência, o avaliador escolhe um **nível** num dropdown (Não Aplica / Baixo / Médio / Alto / Excelente) → converte-se automaticamente em **pontos** (tabela da Config 2).
- O sistema calcula a **Pontuação Total** (média das competências) e o **Nível do Resultado** (ex: "PRATA"), com base na Escala Global.

![[factorial-avaliacao-desempenho-questionario-radar.png]]

- **Plano de Ação**: o avaliador pode propor até 3 ações (dropdown com Formação, Supervisão, Mentoria, Promoção, Plano de Desenvolvimento), cada uma com Data de Início e Período de Execução.

  ![[factorial-avaliacao-desempenho-plano-acao-dropdown.png]]
  ![[factorial-avaliacao-desempenho-plano-acao-dropdown-selecionado.png]]

- Campo de **comentários/observações** em texto livre.
- **Gráfico radar** gerado automaticamente, visualizando o perfil de competências do avaliado (ponto forte vs. ponto fraco de forma visual).

### Fase 3 — Análise de resultados

- **Consulta individual**: aceder ao separador do colaborador (E1, E2...) para ver o detalhe da avaliação.
- **Consulta global**: separador `Relatório Global` consolida os resultados de todos os colaboradores, permitindo comparar pontuações entre pessoas e entre períodos.

### Questionário aberto (Qualitativo) — separador paralelo

![[factorial-avaliacao-desempenho-qualitativo-autoavaliacao.png]]

- Estrutura em blocos. O primeiro bloco visível é **"Auto-avaliação do colaborador"**, com perguntas abertas de texto livre, ex:
  - "Para começar: Como qualificaria o seu desempenho neste período?"
  - "Novos desafios: Quais considera que deverão ser os próximos passos?"
- Corre em paralelo ao questionário quantitativo, mas foca-se no "porquê" e no contexto — não substitui a pontuação, complementa-a.

---

## Ideias para o CStaff

Ideia: Avaliação de Desempenho configurável (CStaff)

Adaptar o modelo Factorial mas sem nada fixo no código — tudo definido pelo Administrador/RH através da app, para se ajustar à realidade de cada empresa/ciclo de avaliação.

O que fica configurável (Admin/RH):
- Critérios de avaliação: nome + descrição do comportamento esperado. Sem limite fixo de 8 — criar, editar, arquivar critérios livremente.
- Escala de pontuação: níveis (ex: Baixo/Médio/Alto/Excelente) e o valor numérico de cada um — ajustável por empresa/ciclo.
- Níveis de resultado global: faixas de pontuação → rótulo (ex: Bronze/Prata/Ouro, ou outra nomenclatura à escolha).
- Plano de ação: lista de ações possíveis (Formação, Mentoria, Promoção...) — editável, não fechada.
- Questionário aberto (qualitativo): perguntas de texto livre configuráveis por bloco (ex: auto-avaliação, avaliação do chefe), podendo variar por departamento/cargo.
- Periodicidade e departamentos/cargos abrangidos por cada ciclo de avaliação.

Fluxo (mantém a lógica do modelo Factorial):
1. RH/Admin cria um ciclo de avaliação e escolhe os critérios, escala e questionários aplicáveis.
2. Sistema atribui o ciclo aos colaboradores elegíveis (por departamento/cargo/individual).
3. Chefe/avaliador preenche o questionário quantitativo (nível por critério → pontos automáticos) + qualitativo (texto livre).
4. App calcula pontuação total, nível de resultado e gráfico radar automaticamente por colaborador.
5. RH consolida tudo numa vista agregada (equivalente ao "Relatório Global") — comparar pessoas, departamentos e evolução entre ciclos.
6. Plano de ação fica associado ao colaborador com datas, e pode alimentar follow-ups (ex: recordatório da formação proposta).

Diferença chave vs. modelo Factorial (spreadsheet): lá os critérios/escala/plano de ação estão fixos numa folha de configuração manual; no CStaff isto deve ser dados geridos pela app (CRUD para Admin/RH), permitindo reutilizar/adaptar critérios entre ciclos sem recriar tudo, e manter histórico de ciclos anteriores mesmo que os critérios mudem.

---

## Perguntas em aberto

- Como mapear KPIs quantitativos vs. campos abertos no modelo de dados do CStaff?
- Fluxo: quem preenche (colaborador/chefe/RH) e em que momento do ciclo?
- Periodicidade das avaliações (trimestral/semestral/anual)?
- Como se relaciona com o fluxo chefe→RH já existente (picagem/ausências)?
