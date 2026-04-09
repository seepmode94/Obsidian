# Projeto Code Review

---

## Tarefas

- criar um hook script
- criar review.md com regras de revisao

---

## Fluxo do hook

- o hook chama o agente e chama o agente para o review.md
- utiliza o o finegrainedToken para ter acesso a ler issue

---

## APIs e tokens

- e usar a API da deepseek (sk-d64ed907a8d44f429b78a9eb30ae14b1)
- Fine grained token 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

---

## Plano de acao

### 1. Definir o objetivo do hook

- decidir quando o hook deve correr
- decidir se o resultado bloqueia ou apenas avisa

### 2. Criar o review.md

- definir regras de revisao claras
- incluir criterios como bugs, seguranca, testes, performance e legibilidade

### 3. Definir o fluxo do agente

- o hook recolhe o diff ou ficheiros alterados
- o hook le o review.md
- o agente usa essas regras para fazer a analise
- o agente devolve um relatorio de code review

### 4. Integrar leitura de issues do GitHub

- usar o finegrainedToken para ler a issue associada
- incluir contexto da issue na analise do agente

### 5. Integrar a API da DeepSeek

- definir como o hook chama a API
- definir o prompt com base no diff, review.md e issue
- tratar erros, timeout e resposta da API

### 6. Definir a saida do processo

- apresentar o relatorio no terminal ou guardar em ficheiro
- identificar problemas criticos, avisos e sugestoes

### 7. Testar o fluxo completo

- testar com alteracoes pequenas
- testar com alteracoes maiores
- testar com e sem issue associada

### 8. Melhorar a seguranca

- evitar deixar tokens hardcoded no script
- mover tokens para variaveis de ambiente ou local seguro

---

## MVP

- criar um hook simples que corre antes do push
- ler o review.md com as regras de revisao
- recolher o diff atual
- opcionalmente ler a issue associada
- enviar diff, regras e contexto para o agente
- receber um relatorio simples com problemas e sugestoes
- mostrar o resultado no terminal

---

## Arquitetura minima

- um ficheiro review.md com as regras de revisao
- um hook script para recolher contexto e chamar o agente
- uma camada de integracao com a API da DeepSeek
- uma camada de integracao com GitHub para leitura de issues
- uma saida final em markdown ou texto no terminal

---

## Ficheiros a criar

- review.md
- scripts/code-review-hook.sh
- scripts/code-review-agent.js ou scripts/code-review-agent.py
- docs/exemplo-relatorio-review.md
- .env.example

---

## Ordem de implementacao

1. criar o review.md com regras base
2. criar o hook script
3. recolher diff e metadados da branch
4. ligar o hook ao agente
5. integrar chamada a API da DeepSeek
6. integrar leitura de issues do GitHub
7. definir formato do relatorio
8. testar com casos reais
9. mover tokens para variaveis de ambiente

---

## Decisoes em aberto

- qual hook usar: pre-commit, pre-push ou manual
- se o processo bloqueia ou apenas avisa
- como identificar automaticamente a issue associada
- se o agente deve analisar apenas diff ou tambem ficheiros completos
- se o relatorio deve ficar no terminal, em ficheiro ou nos dois

---

## Proxima fase

- escrever a primeira versao do review.md
- criar o esqueleto do hook script
- definir o formato do prompt enviado para a DeepSeek
- testar o fluxo ponta a ponta com um exemplo simples


## Checklist de Revisão

 
Ao rever alterações, verificar obrigatoriamente:
- [ ] PR resolve apenas e unicamente os objetivos da issue associada
- [ ] Sem funcionalidades externas, complexidade desnecessária ou abstrações não solicitadas
- [ ] Controladores contêm apenas routers — lógica auxiliar extraída para `/helpers/`
- [ ] Sem helpers duplicados — reutilizar existentes
- [ ] Novas tabelas na BD apenas se explicitamente pedidas na issue
- [ ] Testes unitários criados para novos controladores e helpers (dentro de `/tests/` por temática)
- [ ] `permission.json` alinhado com a documentação de validações
- [ ] `package-lock.json` atualizado quando há alterações ao `package.json`
- [ ] Migrações de BD reversíveis e testadas
- [ ] Permissões não alargadas acidentalmente
- [ ] Routing/geocoding usa endpoints OSM (não Google APIs)
- [ ] Linter passa sem erros
- [ ] Sem fallback chains especulativos — nomes de propriedades verificados
- [ ] Deploy configs sincronizados entre todos os ambientes (staging, production, .env)
- [ ] Documentação em `/documentation/` atualizada se lógica alterada em módulos afetados