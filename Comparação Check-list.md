
## Resumo
- A maior parte dos módulos já tem conteúdo equivalente entre `check-list Tacovia.md` e `check-list Seepmode.md`.
- As diferenças de conteúdo realmente relevantes concentram-se em poucos módulos.

## Módulos sem diferenças de conteúdo relevantes
- Clientes
- Propostas
- Faturas
- Contratos
- Contactos
- Telefonemas
- Reuniões
- Notas
- Emails
- Formandos
- Formadores
- Assistências

## Módulos com diferenças de conteúdo relevantes

### Documentos
- Em `Tacovia`, no bloco de revisões de `Vista de Detalhe`, existem os campos:
- `Revisão criada por`
- `Data de criação da última revisão`
- Na `Seepmode`, estes campos não aparecem com essa designação.
- A `Seepmode` tem na `Vista de Lista` os campos:
- `Data de criação`
- `Criado por`
- Mas isso não equivale explicitamente a informação da última revisão.
### Sessões
- O conteúdo entre os dois ficheiros é substancialmente diferente.
- Principais itens que existem em `Tacovia` e não estão refletidos na `Seepmode`:
- `Formação`
- `Abreviatura`
- `Sessões`
- `Atribuído a`


### Medicina Ocupacional
- Principais pontos a rever:
- `Passatempos`, `Recomendações`, `Observações Finais` e `Outros` aparecem agregados como `FMO` na `Seepmode`

### Fichas de Aptidão
- A `Seepmode` tem muito mais conteúdo detalhado do que a `Tacovia`.
- Não parece haver falta de conteúdo na `Seepmode`.
- A diferença principal é que `Tacovia` tem um bloco muito simplificado com:
- `Nome`
- `Atribuído a`
- `Descrição`
- e a `Seepmode` expandiu isso em vários blocos específicos.
- Neste módulo, a diferença é de modelação e detalhe, não de falta evidente na `Seepmode`.

## Módulos que exigem validação manual
1. ==Medicina Ocupacional==
  No módulo `Medicina Ocupacional`, falta na `Seepmode` a opção `Rastreio oftalmológico`; em contrapartida, a `Seepmode` inclui `Rastreio otorrinolingolo`.

  Após `Patologia Apresentada`, ambos os módulos incluem `Recomendações`; no entanto, na `Seepmode` esse bloco surge identificado como `FMO`, tal como acontece com outros blocos ao longo da comparação.

  Na `Vista de Lista`, a `Seepmode` apresenta, a mais face à `Tacovia`, os campos `Data de Nascimento` e `Sexo`. Essas diferenças refletem-se também nos `Filtros`, com o acréscimo adicional do campo `Criado por` no lado da `Seepmode`.

  2. ==Sessões==
  No módulo `Sessões`, verifica-se uma diferença significativa entre a `Tacovia` e a `Seepmode`, tanto ao nível da estrutura como do conteúdo apresentado.

  Na `Tacovia`, o módulo está orientado para sessões de formação, incluindo campos como `Formação`, `Nome`, `Abreviatura`, `Sessões`, `Descrição` e `Atribuído a`, distribuídos por `Vista de Detalhe`, `Vista de Lista`, `Criação rápida` e
  `Filtro`.

  Na `Seepmode`, o módulo apresenta uma configuração distinta, centrada em `Relatórios agendados`, com campos como `Nome`, `Situação`, `Relatórios`, `Agendar`, `Última execução`, `Destinatários do email` e `Descrição`. Na `Vista de Lista`,
  surgem ainda os campos `Nome`, `Relatórios` e `Situação`, e no `Filtro` aparecem `Nome`, `Meus itens` e `Todos os endereços de email`.

  Trata-se, por isso, de uma diferença real de conteúdo e de finalidade do módulo entre os dois ficheiros.

  3. ==Formações==
  No módulo `Formações`, na `Criação rápida`, a `Seepmode` não apresenta o bloco `Recursos Administrativos`, ao contrário da `Tacovia`. No entanto, esse bloco existe na `Seepmode` na `Vista de detalhe`, pelo que a diferença se verifica
  apenas nessa vista específica.

  4. ==Documentos==
  No módulo `Documentos`, na `Vista de detalhe`, existem diferenças de conteúdo entre a `Seepmode` e a `Tacovia`.

  Na `Seepmode`, surge o campo `Fichas de Aptidão`, que não está presente na `Tacovia`.

  Por outro lado, na `Tacovia`, surgem elementos que não estão refletidos da mesma forma na `Seepmode`, nomeadamente:
  - `Faturas(Histórico)`
  - um campo adicional de `(preencher)`
  - o bloco `LBL_REVISIONS_PANEL`, que inclui:
  - `Revisão criada por`
  - `Data de criação da última revisão`
  - `Situação`
  - `Data de criação`
  - `Data de alteração`

  Na `Vista de Lista > Predefinido` da `Seepmode`, falta ainda o campo `Nome do documento: [document_name]`.

  Assim, a diferença neste módulo não está apenas na organização, mas também em campos distintos presentes em cada ficheiro.



## Conclusão
  - `Fichas de Aptidão` encontra-se mais detalhado na `Seepmode`.
  - `Sessões` constitui um caso de conteúdo efetivamente diferente entre ficheiros.
  - `Documentos` apresenta diferenças concretas em campos disponíveis nas vistas de detalhe e de lista.
  - `Medicina Ocupacional` continua a ser o módulo com maior número de diferenças a confirmar manualmente.

