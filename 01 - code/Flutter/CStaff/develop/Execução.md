  🌐 Guia de Execução: OpsDock Web (Dashboard)


  Este guia explica como iniciar o painel de controlo web no teu browser.


  1. Pré-requisitos (Docker + API)
  A aplicação Web não funciona sozinha; ela precisa da Base de Dados e da API Backend.
   2. Docker: docker compose up -d (na pasta infra/)
   3. API: pnpm dev ou pnpm --filter api dev (na raiz do projeto)


  4. Iniciar a Aplicação Web
  Abre um terminal novo na raiz do projeto OpsDock-development e corre:


   1 # Opção A: Iniciar tudo (API + Web)
   2 pnpm dev
   3
   4 # Opção B: Iniciar apenas a Web (Mais rápido se a API já estiver aberta)
   5 pnpm --filter web dev

  5. Aceder no Chrome
  Assim que o terminal mostrar que o servidor está pronto, verás uma mensagem como:
  > ➜ Local: http://localhost:3000


   6. Abre o Google Chrome.
   7. Navega para: http://localhost:3000 (ou a porta que o terminal indicar).

  ---

  🛠 Casos de Erro e Resoluções (Web)


  Erro A: "Erro de Rede" ou Dashboard vazio
  Sintoma: A página carrega, mas não aparecem dados ou dá erro ao entrar.
   * Causa: A API (Backend) não está a correr ou houve um erro na ligação à base de dados.
   * Solução:
       * Verifica se correste pnpm dev na raiz.
       * Verifica se o Postgres está ativo: docker ps.


  Erro B: Portas em Conflito
  Sintoma: Error: listen EADDRINUSE: address already in use :::3000.
   * Causa: Já tens outro processo (ou outra aba do VS Code) a usar a porta 3000.
   * Solução:
       * Fecha outros terminais abertos.
       * Ou corre: fuser -k 3000/tcp (no Linux) para "matar" o processo antigo.

  Erro C: Dependências em falta
  Sintoma: Erro de "Module not found" ao iniciar o pnpm dev.
   * Solução: Na raiz do projeto, corre:


   1     pnpm install


  Erro D: CORS no Chrome
  Sintoma: Erros no console do Chrome (F12) sobre "CORS Policy".
   * Causa: A API não está a permitir pedidos do localhost:3000.
   * Solução: Verifica o ficheiro .env no backend para garantir que o FRONTEND_URL está configurado para
     http://localhost:3000.

  ---

