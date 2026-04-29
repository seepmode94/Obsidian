# opsdock_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

To start project
```
~/Android/Sdk/emulator/emulator -avd pixel_api33 -gpu host -no-snapshot -no-boot-anim
````

  Guia de Configuração e Execução (Mobile + Backend)

  Este guia descreve como iniciar a infraestrutura de backend e o emulador Android para o projeto OpsDock.


  1. Iniciar a Infraestrutura (Base de Dados e Serviços)
  A base de dados e os serviços de suporte correm via Docker na pasta infra.

   1 # Navegar para a pasta de infraestrutura
   2 cd OpsDock-development/infra
   3
   4 # Iniciar os containers (Postgres, Redis, MinIO, Loki, Grafana)
   5 docker compose up -d


  2. Iniciar o Backend API
  Com os serviços Docker a correr, inicie o servidor NestJS.

   1 # Na raiz do projeto OpsDock-development
   2 pnpm dev
  O API ficará disponível em http://localhost:3001.


  3. Iniciar o Emulador Android
  Utilize o binário do SDK do Android para lançar o dispositivo virtual (AVD).


   1 # Comando para lançar o emulador (exemplo com o pixel_api33)
   2 ~/Android/Sdk/emulator/emulator -avd pixel_api33
  Dica: Mantenha este terminal aberto enquanto testa a aplicação.

  4. Iniciar a Aplicação Mobile
  Navegue para a pasta do projeto mobile e instale as dependências (se necessário) antes de correr.


   1 # Navegar para o projeto mobile
   2 cd ../OpsDock-mobile
   3
   4 # Iniciar o Metro Bundler / App
   5 pnpm dev
   6 # OU
   7 npx react-native run-android

  ---

  Notas Importantes


  Comunicação Emulador -> Backend
  O Android trata o localhost como o próprio dispositivo. Para que o emulador consiga "falar" com o API a correr no seu computador,
  deve configurar o URL do API na App Mobile como:
   - Host: 10.0.2.2 (IP especial do Android para o host local)
   - Porta: 3001
   - Exemplo: http://10.0.2.2:3001/api


  Comandos Úteis
   - Verificar containers: docker compose ps
   - Ver logs da DB: docker compose logs -f postgres
   - Listar emuladores disponíveis: ~/Android/Sdk/emulator/emulator -list-avds
