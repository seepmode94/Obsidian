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
- `Medicina Ocupacional`
  - modelo rico e relações funcionais visíveis confirmados na `Tacovia`

### O que ainda está realmente pendente

- fechar melhor `Assistências.code_list`
- confirmar se ainda há impacto em workflows a partir de `Assistências`
- confirmar relações técnicas finas de `Fichas de Aptidão`
  - `accounts_sdmod_capability_1_c`
  - `contacts_sdmod_capability_1_c`
  - `project_sdmod_capability_1_c`
  - `sdmod_capability_documents_1_c`
- fechar o gap estrutural exato de `project_sdmod_capability_1_c`
- fechar melhor dropdowns internos e destino técnico final de `Medicina Ocupacional`
- reconciliar notas antigas com o que já foi confirmado agora em `Studio` e UI

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

1. Fechar `Assistências.code_list`
   - confirmar se a divergência é definitivamente real entre bases
   - consolidar a decisão de usar superset da `Tacovia`
   - rever se ainda falta alguma evidência útil por imagem

2. Rever impacto em workflows em `Assistências`
   - apenas se este ponto continuar relevante para decisão técnica
   - registar se o problema é estrutural, funcional ou apenas documental

3. Fechar relações finas de `Fichas de Aptidão`
   - confirmar:
     - `accounts_sdmod_capability_1_c`
     - `contacts_sdmod_capability_1_c`
     - `project_sdmod_capability_1_c`
     - `sdmod_capability_documents_1_c`
   - sempre que possível, confirmar em SQL ou documentação técnica

4. Fechar o gap de `project_sdmod_capability_1_c`
   - decidir se o destino correto é:
     - coluna direta `project_id`
     - ou join dedicada

5. Fechar `Medicina Ocupacional`
   - rever dropdowns internos relevantes
   - confirmar se o destino técnico previsto no `LuxuryCRM` está alinhado com a evidência já recolhida
   - registar gaps de schema/mapeamento, se ainda existirem

### Fase 2. Consolidar a auditoria documental

6. Rever as notas antigas de comparação
   - comparar o que foi escrito antes com o que já foi confirmado agora
   - separar:
     - divergência real
     - diferença documental antiga
     - inconsistência entre `Studio` e UI

7. Atualizar as conclusões por módulo
   - tornar explícito, para cada módulo relevante:
     - o que está fechado
     - o que está parcial
     - o que ainda depende de outra base ou de SQL

8. Limpar conclusões que já não são defensáveis sem nuance
   - sobretudo onde a presença operacional na `Tacovia` enfraqueceu leituras antigas demasiado rígidas

### Fase 3. Fecho técnico com foco no `LuxuryCRM`

9. Rever os módulos que ainda exigem decisão técnica final no `LuxuryCRM`
   - confirmar se o destino técnico previsto absorve:
     - fusões
     - normalizações
     - relações
     - dropdowns
     - gaps de schema

10. Produzir uma lista curta e defensável de gaps reais
   - campos a fundir
   - campos a normalizar
   - relações que exigem decisão
   - gaps de schema
   - incoerências `Studio != UI real`

### Fase 4. Preparar o fecho para projeto / issue / responsável

11. Criar uma síntese executiva final
   - o que já pode avançar
   - o que ainda bloqueia
   - o que precisa de validação noutra base
   - o que é só correção documental

12. Preparar texto final para issue ou responsável de projeto
   - resumo curto do estado
   - lista de pendentes reais
   - lista de decisões já tomadas

## Ordem Recomendada de Execução

Se o trabalho continuar a partir daqui, a ordem recomendada é:

1. `Assistências`
2. `Fichas de Aptidão`
3. `Medicina Ocupacional`
4. consolidação documental transversal
5. revisão final de alinhamento com `LuxuryCRM`
6. síntese executiva / issue final

## Critério Prático para os próximos dias

Antes de abrir um novo módulo, confirmar sempre:

- este ponto ainda está realmente pendente?
- a resposta depende da `Tacovia`, da `Seepmode`, do SQL ou apenas de documentação?
- o objetivo é fechar estrutura, dropdown, relação ou gap?

Se a resposta não for clara, registar primeiro o tipo de pendência antes de continuar a recolha.
