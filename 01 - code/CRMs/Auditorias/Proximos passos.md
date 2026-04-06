# Próximos Passos

## Panorama Geral

A fase atual de auditoria avançou bastante ao nível da confirmação estrutural dos módulos no `Studio` e na UI real da `Tacovia`.

Neste momento, o projeto já tem uma base documental muito mais sólida para:

- distinguir o que é gap real do que era apenas diferença documental antiga
- confirmar quais módulos estão estruturalmente coerentes entre `Studio` e UI
- identificar casos de fusão e normalização já fechados
- isolar os módulos onde ainda existem pendências técnicas reais
- registar explicitamente os casos em que `Studio != UI real`

### O que já ficou

- `Contratos`
  - fusão entre `anuidade_c` e `anuidade_list_c` fechada
- `Acessos IEFP`
  - `iefp_email_c` confirmado como nome técnico correto
  - `icfp_email_c` tratado como erro documental antigo
- `Assistências`
  - estrutura principal e dropdowns principais já validados
  - `send_receive_c` confirmado no `Studio`, com divergência no filtro real
  - `code_list` fechado como divergência real
  - decisão técnica fechada: usar superset da `Tacovia`
  - impacto em workflows tratado como não bloqueante nesta fase
- `Documentos`
  - estrutura base, anexos, revisão e relações visíveis reforçadas
- `Clientes`
- `Propostas`
- `Faturas`
- `Contactos`
- `Formações`
- `Formandos`
- `Formadores`
- `Reuniões`
- `Telefonemas`
- `Notas`
- `Emails`
  - nestes módulos, a coerência geral entre `Studio` e UI ficou bastante reforçada
  - os gaps remanescentes parecem, na maioria, finos e mais documentais do que estruturais
- `Fichas de Aptidão`
  - modelo rico confirmado na evidência disponível
  - ligação funcional ao universo de `Medicina Ocupacional` confirmada
  - relações finas confirmadas em `Studio > Relationships`
  - `project_sdmod_capability_1_c` resolvido funcionalmente como `project_id`
- `Medicina Ocupacional`
  - modelo rico e relações funcionais visíveis confirmados na `Tacovia`
  - dropdowns internos já não aparecem como bloqueio crítico para apresentação

### O que ainda está realmente pendente

- reconciliar notas antigas com o que já foi confirmado agora em `Studio` e UI
- rever se ainda existe algum gap de schema ou mapeamento residual em `Medicina Ocupacional`
- consolidar o alinhamento final com o `LuxuryCRM` nos módulos mais sensíveis

### Risco transversal já confirmado

Foi identificado um problema transversal importante:

- o `Studio` nem sempre espelha fielmente a UI real
- em vários casos, sobretudo nos filtros, existe divergência entre o layout guardado no `Studio` e os campos expostos ao utilizador

Isto significa que:

- o `Studio` continua a ser útil como evidência
- mas não deve ser tratado como fonte final única sem validação na UI
- sempre que houver conflito, deve ser registado explicitamente:
  - `Studio != UI real`

## Passo a Passo a Seguir

### Fase 1. Fechar os pendentes críticos

1. Consolidar o fecho crítico já obtido
   - `Assistências`
   - `Fichas de Aptidão`
   - `Medicina Ocupacional`
   - garantir que estes três módulos aparecem como fechados ou não bloqueantes no estado final

2. Rever apenas gaps residuais de `Medicina Ocupacional`
   - confirmar se sobra algum gap real de schema ou mapeamento
   - se não houver, marcar como sem bloqueios técnicos relevantes nesta fase

### Fase 2. Consolidar a auditoria documental

3. Rever as notas antigas de comparação
   - comparar o que foi escrito antes com o que já foi confirmado agora
   - separar:
     - divergência real
     - diferença documental antiga
     - inconsistência entre `Studio` e UI

4. Atualizar as conclusões por módulo
   - tornar explícito, para cada módulo relevante:
     - o que está fechado
     - o que está parcial
     - o que ainda depende de outra base ou de SQL

5. Limpar conclusões que já não são defensáveis sem nuance
   - sobretudo onde a presença operacional na `Tacovia` enfraqueceu leituras antigas demasiado rígidas

### Fase 3. Fecho técnico com foco no `LuxuryCRM`

6. Rever os módulos que ainda exigem decisão técnica final no `LuxuryCRM`
   - confirmar se o destino técnico previsto absorve:
     - fusões
     - normalizações
     - relações
     - dropdowns
     - gaps de schema

7. Produzir uma lista curta e defensável de gaps reais
   - campos a fundir
   - campos a normalizar
   - relações que exigem decisão
   - gaps de schema
   - incoerências `Studio != UI real`

### Fase 4. Preparar o fecho para projeto / issue / responsável

8. Criar uma síntese executiva final
   - o que já pode avançar
   - o que ainda bloqueia
   - o que precisa de validação noutra base
   - o que é só correção documental

9. Preparar texto final para issue ou responsável de projeto
   - resumo curto do estado
   - lista de pendentes reais
   - lista de decisões já tomadas

## Ordem Recomendada de Execução

Se o trabalho continuar a partir daqui, a ordem recomendada é:

1. consolidação documental transversal
2. revisão final de alinhamento com `LuxuryCRM`
3. síntese executiva / issue final

## Critério Prático para os próximos dias

Antes de abrir um novo módulo, confirmar sempre:

- este ponto ainda está realmente pendente?
- a resposta depende da `Tacovia`, da `Seepmode`, do SQL ou apenas de documentação?
- o objetivo é fechar estrutura, dropdown, relação ou gap?

Se a resposta não for clara, registar primeiro o tipo de pendência antes de continuar a recolha.
