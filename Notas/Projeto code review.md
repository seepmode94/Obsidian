# Projeto Code Review

## Tarefas

- criar um hook script
- criar review.md com regras de revisao

## Fluxo do hook

- o hook chama o agente e chama o agente para o review.md
- utiliza o o finegrainedToken para ter acesso a ler issue

## APIs e tokens

- e usar a API da deepseek (sk-d64ed907a8d44f429b78a9eb30ae14b1)
- Fine grained token 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

## Plano de acao

1. Definir o objetivo do hook

- decidir quando o hook deve correr
- decidir se o resultado bloqueia ou apenas avisa

2. Criar o review.md

- definir regras de revisao claras
- incluir criterios como bugs, seguranca, testes, performance e legibilidade

3. Definir o fluxo do agente

- o hook recolhe o diff ou ficheiros alterados
- o hook le o review.md
- o agente usa essas regras para fazer a analise
- o agente devolve um relatorio de code review

4. Integrar leitura de issues do GitHub

- usar o finegrainedToken para ler a issue associada
- incluir contexto da issue na analise do agente

5. Integrar a API da DeepSeek

- definir como o hook chama a API
- definir o prompt com base no diff, review.md e issue
- tratar erros, timeout e resposta da API

6. Definir a saida do processo

- apresentar o relatorio no terminal ou guardar em ficheiro
- identificar problemas criticos, avisos e sugestoes

7. Testar o fluxo completo

- testar com alteracoes pequenas
- testar com alteracoes maiores
- testar com e sem issue associada

8. Melhorar a seguranca

- evitar deixar tokens hardcoded no script
- mover tokens para variaveis de ambiente ou local seguro

