---
projeto: Arise (Fitness)
tipo: documentação técnica
atualizado: 2026-06-24
---

# ⚔️ Arise (Fitness) — Implementação, Testes e Deploy

App de fitness **gamificada** ao estilo *Solo Leveling*: "O Sistema" é o teu treinador e nutricionista. Treinas, registas alimentação, sobes de nível (Rank E→S), enfrentas **Bosses** e acompanhas a evolução.

> Pasta do projeto: `~/Documentos/Projects/fitness`

---

## 1. Stack tecnológica

| Camada | Tecnologia | Versão |
|---|---|---|
| Framework | **Expo (React Native)** | SDK 54 |
| Runtime | React Native / React | 0.81 / 19.1 |
| Navegação | **expo-router** (file-based) | 6.x |
| Base de dados | **expo-sqlite** (local) | 16.x |
| Gráficos | **react-native-svg** (custom) | 15.x |
| Ícones | @expo/vector-icons (Ionicons) | 15.x |
| Fotos | expo-image-picker + expo-file-system | 17.x / 19.x |
| Notificações | expo-notifications | — |
| Háptica | expo-haptics | — |
| IA | **Vercel AI SDK** + `@ai-sdk/google` (Gemini 2.5 Flash) + `zod` | ai 6 / 3 / 4 |
| Linguagem | TypeScript (strict) | 5.9 |

**Dados:** tudo é guardado **localmente** (SQLite). A camada `src/db/repositories.ts` é uma abstração propositada — quando a app for pública troca-se por cloud + auth **sem reescrever os ecrãs**.

**IA:** chave em `EXPO_PUBLIC_GEMINI_API_KEY` (ficheiro `.env`). Em uso pessoal fica embebida no bundle; para público move-se para um proxy (ver secção 7).

---

## 2. Estrutura do projeto

```
src/
  app/                       # rotas (expo-router)
    _layout.tsx              # providers + Stack + handler de notificações de boss
    onboarding.tsx           # assistente de 8 passos
    definicoes.tsx           # perfil, repetir avaliação, lembretes
    (tabs)/
      _layout.tsx            # tab bar + gating do onboarding
      index.tsx              # Início (dashboard + Boss)
      treinos.tsx            # treinos + plano + adaptar com IA
      nutricao.tsx           # refeições + macros
      evolucao.tsx           # gráficos + fotos
      treinador.tsx          # chat Gemini
  components/
    system/                  # UI "Sistema" (painéis, XP bar, stats, inputs)
    charts.tsx               # gráficos svg
  constants/theme.ts         # paleta, ranks, atributos
  db/
    schema.ts                # esquema SQL
    database.ts              # abertura + migrations + seed
    repositories.ts          # acesso a dados (abstração p/ cloud)
    seed.ts                  # biblioteca de exercícios
  lib/
    gamification.ts          # XP, níveis, ranks, atributos
    quests.ts                # quests diárias
    plan-generator.ts        # gerador de planos por modelos
    recommendations.ts       # IMC, gordura/peso alvo, calorias/proteína
    boss.ts                  # geração de bosses (por escalão)
    notifications.ts         # lembretes locais + notificação de boss
    photos.ts                # captura/armazenamento de fotos
    date.ts                  # helpers de datas
    ai/coach.ts              # chat Gemini (com Google Search grounding)
    ai/plan-coach.ts         # adaptação do plano (generateObject + zod)
    ai/photo-coach.ts        # análise de fotos (visão)
  state/player-store.tsx     # contexto global + overlay de XP
```

---

## 3. Funcionalidades implementadas

**Núcleo / gamificação**
- Sistema de **XP → níveis → ranks (E→S)** e 5 **atributos** (Força, Resistência, Agilidade, Vitalidade, Disciplina) derivados da atividade.
- **Quests diárias** (treinar, séries, refeições, proteína, peso) com recompensa de XP.
- **Streak** de dias ativos.
- Overlay animado de "+XP" com háptica.

**Onboarding + perfil (8 passos)**
- Sexo, idade, **altura em metros** (com conversão automática para cm), peso, % gordura (opcional).
- **Objetivos múltiplos** (multi-seleção) + experiência.
- Equipamento (Casa / Ginásio / Ambos + o que tens em casa).
- **Disponibilidade**: dias da semana + minutos/sessão (**a partir de 10 min**) + estilo (Padrão / **Intensivo circuito**) + horários de lembrete.
- Limitações/lesões (texto livre).
- **Avaliação**: IMC, peso saudável, gordura-alvo, calorias e proteína diárias (Mifflin-St Jeor).

**Plano de treino**
- Gerado por **modelos** (regras): divisão por dias (FB / Upper-Lower / PPL), exercícios filtrados por equipamento, séries/reps por objetivo, ajustado ao tempo.
- Objetivos distribuídos pelos dias (cada dia mostra o seu objetivo).
- Modo **circuito** (full-body, vários exercícios curtos) para sessões curtas.
- **Adaptação por Gemini**: pedidos em linguagem natural ("só tenho halteres", "não posso agachar") → plano novo estruturado.

**Nutrição**
- Registo de refeições (kcal + macros) vs. **metas calculadas do perfil**.

**Evolução**
- Gráficos (peso, volume, XP) + cartões de resumo.
- **Fotografias de progresso** (local; envio opcional ao Gemini para feedback visual).

**Treinador IA (Gemini)**
- Chat "O Sistema" com **Google Search grounding** (respostas atualizadas + fontes), consciente de condições, **sem diagnóstico** (encaminha para profissionais).

**Bosses (desafios)**
- Bosses **por escalão** (nível baixo = bosses fracos), com **avatar** (emoji), objetivo, recompensa XP e **prazo de 24h**.
- Aceitar/Recusar; derrota-se completando um treino que cumpra o objetivo.
- **Notificação com ação "Aceitar"** → vai direto ao treino.
- Falhar o prazo = sem XP, o **boss escapa e continua vivo** (podes caçá-lo de novo).

**Definições**
- Resumo do perfil, **"Repetir avaliação"** (edita perfil + gera novo plano), ligar/desligar lembretes.

---

## 4. Como testar ANTES do deploy

```bash
cd ~/Documentos/Projects/fitness

# 1) Verificação de tipos (deve dar 0 erros)
npx tsc --noEmit

# 2) Bundle de produção (apanha erros de import em toda a árvore)
npx expo export --platform android   # ou ios

# 3) Correr a app
npx expo start         # lê o QR com o Expo Go, ou:
npx expo start --android   # abre num emulador/dispositivo Android ligado
```

**IA (Gemini)** — para testar Treinador, adaptação de plano e análise de fotos:
1. Cria chave em https://aistudio.google.com/apikey
2. `.env` na raiz: `EXPO_PUBLIC_GEMINI_API_KEY=a_tua_chave`
3. `npx expo start -c` (o `-c` limpa a cache para reler o `.env`)
4. Requer internet.

**Conduzir um emulador por linha de comandos** (útil para verificação):
```bash
adb exec-out screencap -p > shot.png      # captura de ecrã
adb shell input tap X Y                     # toque
adb shell input text "texto"                # escrever
adb shell input swipe X1 Y1 X2 Y2 300       # scroll
```

✅ **Estado verificado (2026-06-24):** fluxo completo testado num emulador Android (Expo Go SDK 54) — onboarding → plano → dashboard → boss → treinos → nutrição → evolução → Treinador (resposta real do Gemini). Ver `Fitness — Páginas e Funcionalidades`.

---

## 5. Como fazer DEPLOY (development build + stores)

O Expo Go é só para desenvolvimento. Para uma app instalável e completa (notificações 100%, ícone próprio, stores) usa-se **EAS Build**.

```bash
# uma vez
npm i -g eas-cli
eas login
eas build:configure

# Development build (testar tudo, incl. notificações) — Android
eas build --profile development --platform android
#   instala o .apk/.aab no telemóvel e corre `npx expo start --dev-client`

# Build de produção
eas build --profile production --platform android   # .aab para a Play Store
eas build --profile production --platform ios       # precisa de conta Apple

# Submeter às lojas
eas submit --platform android
eas submit --platform ios
```

**Custos das contas:** Google Play Console **25€ (uma vez)**; Apple Developer **99€/ano**.

> Antes de build de produção: definir `ios.bundleIdentifier` e `android.package` no `app.json`, ícone e splash próprios, e a chave Gemini fora do cliente (secção 7).

---

## 6. Caminho para publicar (produção)

Por ordem recomendada:

1. **Proxy para o Gemini** — criar uma função serverless (ex.: Vercel) que recebe os pedidos e fala com o Gemini; a app deixa de ter a chave. Remover `EXPO_PUBLIC_GEMINI_API_KEY` do cliente.
2. **Autenticação + base de dados cloud** — adicionar login e sincronização. Como o acesso a dados está isolado em `src/db/repositories.ts`, troca-se a implementação **sem mexer nos ecrãs**.
3. **Development/Production build (EAS)** — notificações push e locais a 100% (o Expo Go limita push).
4. **Submissão às stores** (secção 5).
5. **Privacidade** — política de privacidade (fotos de corpo e dados de saúde são sensíveis); declarar que a análise de fotos envia a imagem ao Google só quando o utilizador escolhe.

---

## 7. Como adicionar novas funcionalidades (padrão do projeto)

1. **Modelo de dados** — tabela/coluna em `src/db/schema.ts` (+ `ensureColumn` em `database.ts` se for coluna nova).
2. **Repositório** — funções de acesso em `src/db/repositories.ts`.
3. **Lógica pura** — em `src/lib/` (testável, sem UI).
4. **Estado** — expor no `src/state/player-store.tsx` se for global.
5. **Ecrã/Componente** — em `src/app/` / `src/components/system/`.
6. **Validar** — `npx tsc --noEmit` + `npx expo export` + correr no emulador.

---

## 8. Limitações conhecidas

- **expo-notifications no Expo Go**: as **push remotas** foram removidas do Expo Go (SDK 53+), o que gera um aviso vermelho (LogBox) ao abrir — **não é fatal** e as **notificações locais funcionam** (boss/lembretes aparecem). Para suporte total → development build.
- **Chave Gemini no bundle** (uso pessoal). Mover para proxy antes de publicar.
- **Fotos** ficam só no dispositivo; sem backup/sync até existir cloud.

---

## 9. Próximas ideias (backlog)
- Definir metas (kcal/proteína) manualmente nas Definições.
- Histórico de bosses derrotados / "troféus".
- Editar/remover exercícios do plano à mão.
- Exportar/importar dados (backup local).
- Apple Health / Google Fit (passos, peso).
