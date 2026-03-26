  🚀 OpsDock: Guia de Reset Total e Reinstalação Completa

  Este guia serve para limpar todos os erros de base de dados, configurações antigas e "Failed to fetch", começando o
  projeto do zero de forma segura.

  ---

  🛠 Passo 1: Limpeza Profunda (The "Kill" Phase)


  Antes de reinstalar, temos de garantir que não há restos de processos antigos.


   1. Parar todos os terminais: Fecha as abas do VS Code ou terminais onde correste pnpm dev ou flutter run (Ctrl + C).
   2. Reset ao Docker: Apaga os containers e os volumes (onde a base de dados vive).
   1     cd OpsDock-development/infra
   2     docker compose down -v
   3     cd ..
   3. Limpar Node Modules (Opcional): Se suspeitares de erros de pacotes, apaga as pastas:


   1     # Na raiz do OpsDock-development
   2     rm -rf node_modules apps/api/node_modules apps/web/node_modules

  ---

  📦 Passo 2: Instalação e Configuração

   4. Reinstalar Dependências:


   1     pnpm install
   5. Configurar Variáveis de Ambiente:
      Garante que tens os ficheiros .env configurados. Se não tiveres, cria-os:


   1     # Na raiz
   2     cp .env.example .env
   3
   4     # No Frontend (Web)
   5     cp apps/web/.env.example apps/web/.env.local

  ---

  🗄 Passo 3: Infraestrutura e Base de Dados

   6. Ligar o Docker:


   1     cd infra
   2     docker compose up -d
   3     sleep 10 # Espera 10 segundos para o Postgres estabilizar
   4     cd ..
   7. Criar Tabelas e Dados Iniciais:
      Este é o passo mais importante para evitar o erro "Failed to fetch".
   1     # Cria as tabelas na base de dados
   2     pnpm db:migrate
   3
   4     # Cria os utilizadores padrão (Admin, Developer, Support)
   5     pnpm db:seed

  ---

  💻 Passo 4: Iniciar o Ecossistema Web


  Podes iniciar tudo junto ou em terminais separados para melhor diagnóstico.

  Opção Recomendada (Tudo junto):
   1 pnpm dev


  Opção para Debug (Terminais Separados):
   * Terminal 1 (Backend): cd apps/api && pnpm dev
   * Terminal 2 (Frontend): cd apps/web && pnpm dev
   * Terminal 3 (Worker): cd apps/worker && pnpm dev

  ---


  📱 Passo 5: Aplicação Mobile (OpsDock-mobile)

  Agora que o servidor está pronto, vamos tratar da aplicação mobile.

   1. Navegar para a pasta: cd ../OpsDock-mobile
   2. Corrigir Versão do SDK (FVM):


   1     fvm install stable
   2     fvm use stable --force
   3. Limpar e Correr:
   1     fvm flutter clean
   2     fvm flutter pub get
   3     fvm flutter run -d emulator-5554

  ---

  ✅ Verificação de Sucesso



  ┌───────────────┬───────────────────────────────────────────────┬───────────────────────┐
  │ Componente    │ Endereço                                      │ Credenciais (Padrão)  │
  ├───────────────┼───────────────────────────────────────────────┼───────────────────────┤
  │ Web Dashboard │ http://localhost:3000 (http://localhost:3000) │ admin@opsdock.local / │
  │               │                                               │ admin123              │
  │ Documentação  │ http://localhost:3001/api/docs                │ N/A                   │
  │ API           │ (http://localhost:3001/api/docs)              │                       │
  │ Grafana Logs  │ http://localhost:3200 (http://localhost:3200) │ admin / admin         │
  │ MinIO (S3)    │ http://localhost:9001 (http://localhost:9001) │ minio / minio123      │
  └───────────────┴───────────────────────────────────────────────┴───────────────────────┘

  ---


  🆘 Resolução de Problemas Comuns


  ❌ "Failed to fetch" no Login
   * Causa: A API não está a correr ou o URL no frontend está errado.
   * Solução: Verifica se apps/web/.env.local tem a linha: NEXT_PUBLIC_API_URL=http://localhost:3001/api.


  ❌ "Version solving failed" no Flutter
   * Causa: O SDK do Dart no FVM é mais antigo do que o pedido no pubspec.yaml.
   * Solução: Corre fvm install stable && fvm use stable --force.


  ❌ Erro ao ligar ao Postgres no Docker
   * Solução: Corre docker compose logs postgres para ver o erro. Geralmente, fazer docker compose down -v resolve 99%
     dos casos.

resumo para gemini:
  📝 Resumo de Contexto para o Gemini: OpsDock


  Projeto: OpsDock (Plataforma de Gestão de Infraestrutura)
  Arquitetura: Monorepo (pnpm workspaces + Turborepo)


  Componentes Ativos:
   1. Infra (Docker): Postgres (5432), Redis (6379), MinIO (9000), Loki (3100), Grafana (3200).
   2. Backend (NestJS): apps/api (Porta 3001). URL Base: http://localhost:3001/api.
   3. Frontend (Next.js 14): apps/web (Porta 3000).
   4. Mobile (Flutter): Projeto OpsDock-mobile (usando FVM e SDK Dart 3.11.0+).


  Estado do Setup:
   * Base de Dados: Migrations (pnpm db:migrate) e Seeds (pnpm db:seed) aplicadas.
   * Utilizador Admin: admin@opsdock.local / admin123.
   * Configuração Mobile: FVM configurado para stable para evitar erros de versão do SDK.


  Comandos Frequentes:
   * pnpm dev (na raiz do OpsDock-development) para iniciar Web e API.
   * fvm flutter run -d emulator-5554 (no OpsDock-mobile).
   * docker compose down -v para reset total da infraestrutura.
