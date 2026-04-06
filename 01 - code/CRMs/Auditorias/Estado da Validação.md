# Estado da Validação 

## Objetivo desta fase

Esta fase tem como objetivo validar a coerência da informação retirada do `Studio` para confirmar se os levantamentos feitos em:

- `01 - code/CRMs/Comparações de CRM/`
- `01 - code/CRMs/LuxuryCRM(pasta do projeto)/`

estão alinhados entre si ao nível de:

- módulos
- campos
- relações
- dropdowns

Nesta fase, a `página real` não está a ser usada como referência principal. O foco está no que foi retirado do `Studio`, usando a documentação técnica e os dumps SQL como apoio.

## O que está a ser feito

O trabalho está organizado em quatro linhas:

1. `Auditoria de Campos`
   - mapear campos entre `Seepmode`, `Tacovia` e `LuxuryCRM`
   - identificar gaps, fusões e normalizações

2. `Plano de Validação`
   - definir o processo de validação por módulo
   - separar módulos comuns às duas bases de módulos exclusivos

3. `Tabela de Comparação entre fontes`
   - cruzar o que foi documentado em `Comparações de CRM` com o que foi documentado em `LuxuryCRM`
   - confirmar coerência entre recolhas feitas por pessoas diferentes

4. `Validação no Studio`
   - confirmar visualmente os campos e dropdowns mais críticos
   - registar evidência sempre que existam dúvidas ou inconsistências

## Progresso já feito

### Documentação criada e organizada

- [Auditoria de Campos](/home/seepmode94/Documentos/Obsidian-volte/01%20-%20code/CRMs/Auditorias/Auditoria%20de%20Campos.md)
- [Plano de Validação](/home/seepmode94/Documentos/Obsidian-volte/01%20-%20code/CRMs/Auditorias/Plano%20de%20Valida%C3%A7%C3%A3o.md)
- [Comparações entre os campos e módulos de toda a informação da pasta LuxuryCRM(pasta do projeto) e a pasta Comparações de CRM](/home/seepmode94/Documentos/Obsidian-volte/01%20-%20code/CRMs/Auditorias/Compara%C3%A7%C3%B5es%20entre%20os%20campos%20e%20m%C3%B3dulos%20de%20toda%20a%20informa%C3%A7%C3%A3o%20da%20pasta%20LuxuryCRM%28pasta%20do%20projeto%29%20e%20a%20pasta%20Compara%C3%A7%C3%B5es%20de%20CRM.md)

### Conclusões já estabilizadas

- `Contratos`
  - existe um caso claro de fusão entre `anuidade_c` e `anuidade_list_c`
  - a UI visível trabalha com um único campo funcional de `Anuidade`
- `Acessos IEFP`
  - existe um ponto de normalização entre `icfp_email_c` e `iefp_email_c`
- `Fichas de Aptidão`
  - está a ser tratada como módulo exclusivo da `Seepmode`
- `Medicina Ocupacional`
  - está a ser tratada como módulo exclusivo da `Seepmode`, sujeito a confirmação final

### Progresso concreto em Assistências

No módulo `Assistências` já foi validado no `Studio`:

- os campos visíveis do filtro
- a diferença entre:
  - `dropdowns` de negócio
  - operadores de filtro de data
- os seguintes `dropdowns` de negócio:
  - `code_c`
  - `status`
  - `priority`
  - `mode_c`
  - `area_c`

Estado atual do módulo:

- `code_c`
  - confirmado no filtro
  - apresenta valores mistos: alguns com `label`, outros apenas numéricos
- `status`
  - confirmado no filtro
  - lista uniforme e legível
- `priority`
  - confirmado no filtro
  - lista numérica sem label textual
- `mode_c`
  - confirmado no filtro
  - lista uniforme e legível
- `area_c`
  - confirmado no filtro
  - lista uniforme e legível
- `send_receive_c`
  - confirmado documentalmente nas duas extrações do `Studio`
  - metadata técnica confirma `send_receive_list`
  - existe no `Studio`, mas não está visível no filtro real atual

## Riscos e pontos de atenção já encontrados

- `Assistências.code_c`
  - a lista não está uniformizada ao nível de labels
- `priority`
  - a lista aparece apenas com valores numéricos
- `send_receive_c`
  - já não é dúvida estrutural
  - há divergência entre o `Studio` e o filtro real atual
- existe risco de perda de informação se o cruzamento entre as duas recolhas não for feito módulo a módulo

## Processo que ainda falta percorrer

### 1. Fechar Assistências

Falta:

- cruzar os dropdowns já vistos com a documentação da outra recolha
- fechar documentalmente `code_list` como divergência real entre bases
- decidir se resta alguma divergência real fora de `code_list` ou apenas diferença de levantamento

### 2. Validar os módulos prioritários seguintes

Ordem atual:

- `Acessos IEFP`
- `Fichas de Aptidão`
- `Medicina Ocupacional`
- `Documentos`

### 3. Continuar a auditoria por módulo

Para cada módulo, falta:

- confirmar se existe nas duas bases ou só numa
- cruzar campos entre `Comparações de CRM` e `LuxuryCRM`
- identificar campos comuns, exclusivos e campos a fundir
- validar dropdowns relevantes
- confirmar relações
- assinalar gaps no `LuxuryCRM`

### 4. Consolidar a comparação entre as duas recolhas

Falta tornar explícito, por módulo:

- o que aparece nas notas de `Comparações de CRM`
- o que aparece na documentação de `LuxuryCRM`
- o que coincide
- o que diverge
- o que é confirmado por SQL

## Resultado esperado

No fim desta fase, o projeto deve ficar com:

- uma auditoria de campos organizada
- uma lista clara de gaps
- uma lista clara de campos a fundir ou normalizar
- uma validação dos dropdowns críticos
- uma comparação defensável entre as duas recolhas feitas a partir do `Studio`
