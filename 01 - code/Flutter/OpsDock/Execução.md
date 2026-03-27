 🚀 Guia de Execução: OpsDock

  Este guia cobre desde a infraestrutura até à aplicação mobile, com secções dedicadas a resolução de problemas comuns.

  1. Infraestrutura (Docker)
  Certifica-te de que os serviços de base estão ativos.


   1 cd OpsDock-development/infra
   2 docker compose up -d
   * Serviços: Postgres (5432), Redis (6379), MinIO (9000), Loki, Grafana.


  2. Backend API (NestJS)
  A aplicação mobile precisa da API para funcionar. Não te esqueças deste passo!
   1 cd OpsDock-development
   2 pnpm dev
   * Endpoint: http://localhost:3001


  3. Emulador Android
  Com o emulador aberto (como já tens), verifica se ele é reconhecido:
   1 fvm flutter devices

  4. Aplicação Mobile (Flutter + FVM)
  Aqui é onde encontraste o erro. O projeto exige um SDK Dart mais recente do que o que tens configurado no FVM.


  Passo a Passo para Correr:
   1. Entrar na pasta: cd OpsDock-mobile
   2. Atualizar o Flutter no FVM:
   1     fvm install stable
   2     fvm use stable --force
   3. Limpar e Instalar Dependências:


   1     fvm flutter clean
   2     fvm flutter pub get
   4. Executar:
   1     fvm flutter run -d emulator-5554

  ---

  🛠 Casos de Erro e Resoluções


  Erro A: "Version solving failed (SDK version mismatch)"
  Sintoma: O erro que recebeste: Because opsdock_mobile requires SDK version ^3.11.0, version solving failed.
   * Causa: A versão do Flutter/Dart definida no teu FVM é antiga (3.6.2) e o projeto pede a 3.11.0+.
   * Solução:
       * Corre fvm install stable e fvm use stable.
       * Se o erro persistir, abre o ficheiro pubspec.yaml e verifica a linha sdk: '>=3.11.0 <4.0.0'. Podes baixar para
         ^3.6.0 se tiveres a certeza que o código é compatível, mas o ideal é atualizar o SDK.


  Erro B: "Connection Refused" ou Erro de Login na App
  Sintoma: A app abre no emulador, mas não carrega dados ou dá erro ao fazer login.
   * Causa: O Android Emulator vê o localhost como o próprio telemóvel, não o teu PC.
   * Solução:
       * No ficheiro de configuração da App (geralmente .env ou constants.dart), o URL da API deve ser
         http://10.0.2.2:3001 em vez de localhost:3001.
       * Verifica se o Backend (Passo 2) está realmente a correr.


  Erro C: "FVM not found" ou "Flutter not recognized"
  Sintoma: Comandos fvm ou flutter dão erro de comando não encontrado.
   * Solução:
       * Certifica-te que o FVM está no teu PATH: export PATH="$PATH":"$HOME/.pub-cache/bin".
       * Usa sempre o prefixo fvm antes de flutter (ex: fvm flutter run).


  Erro D: "CocoaPods not installed" (Apenas se testares em iOS/Mac)
  Sintoma: Erro ao compilar para iOS.
   * Solução:
   1     cd ios
   2     pod install
   3     cd ..

  ---


  Dica Pro: Monitorização
  Para ver se as logs de erro estão a chegar ao servidor enquanto usas a app:
   * Logs do Backend: Vê o terminal onde correste o pnpm dev.
   * Logs da Base de Dados: docker compose logs -f postgres.

