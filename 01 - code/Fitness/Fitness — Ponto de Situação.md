---
projeto: Arise (Fitness)
tipo: ponto de situação
atualizado: 2026-06-24
estado: funcional · testado em emulador · APK release gerado
---

# 📍 Arise (Fitness) — Ponto de Situação (2026-06-24)

App de fitness gamificada (Expo/React Native, estilo Solo Leveling). **Estado: funcional e testada de ponta a ponta num emulador Android; APK release standalone gerado e instalável.**

> Documentos relacionados: [[Fitness — Implementação, Testes e Deploy]] · [[Fitness — Páginas e Funcionalidades]]

---

## ✅ Funcionalidades implementadas

**Gamificação:** XP → níveis → ranks (E→S), 5 atributos derivados da atividade, quests diárias, streak, overlay de "+XP".

**Onboarding (8 passos) + perfil:** sexo, idade, **altura em metros (→cm)**, peso, %gordura; **objetivos múltiplos**; equipamento (Casa/Ginásio/Ambos); disponibilidade (**dias da semana**, minutos **desde 10 min**, estilo **Padrão/Intensivo-circuito**, **horários de lembrete**); limitações. Calcula IMC, peso/gordura alvo, calorias e proteína.

**Plano de treino:** gerado por modelos (FB / Upper-Lower / PPL), filtrado por equipamento, séries/reps por objetivo, objetivos distribuídos pelos dias; **adaptação por Gemini** em linguagem natural.

**Nutrição:** refeições + macros vs metas do perfil.

**Evolução:** gráficos (peso, volume, XP) + **fotos de progresso** (local; análise opcional por Gemini).

**Treinador IA (Gemini):** chat "O Sistema" com **Google Search grounding**; adapta a condições; não diagnostica.

**Bosses / Combate:** bosses **por escalão** com **avatar (emoji)**, recompensa e prazo 24h; aceitar/recusar; **combate na sessão de Treinos com barra de HP que desce ao vivo** conforme registas séries (treino reforçado); falhar = boss escapa (continua vivo, sem XP).

**Notificações:** lembretes locais (dias/horas) + notificação de boss. Em **development/APK build** usa **Notifee** com **imagem do Sistema (BigPicture)** + ação "Aceitar"; no Expo Go faz fallback de texto.

**Demonstração de exercícios:** miniatura + modal com **2 frames a alternar (efeito GIF)** da *Free Exercise DB* (open). 43/44 exercícios com imagem.

**Definições:** resumo do perfil, "Repetir avaliação", ligar/desligar lembretes.

---

## 🔧 Correções recentes
- **FK constraint failed** na re-sementeira de exercícios → resolvido com **upsert** (atualiza por nome, nunca apaga referenciados).
- **`getDb()` resiliente** — deixou de ficar com promessa rejeitada em cache (a app já não fica partida após um erro de init).

---

## 📦 Build / APK (estado atual)
- **APK release standalone gerado:** `~/Documentos/Projects/fitness/Arise.apk` (~51 MB, arm64-v8a + armeabi-v7a, assinado com chave **debug** → para sideload/teste).
- **Como regerar localmente (sem conta Expo):**
  ```bash
  npx expo prebuild --platform android --no-install
  cd android && ./gradlew assembleRelease -PreactNativeArchitectures=arm64-v8a,armeabi-v7a
  # APK em android/app/build/outputs/apk/release/app-release.apk
  ```
- **Instalar no telemóvel:** `adb install Arise.apk` (USB) ou transferir o ficheiro e tocar (permitir fontes desconhecidas).
- **Config de build pronta:** `eas.json` (perfis development/preview/production), `app.json` com package id `com.seepmode.arise`, plugin `expo-notifications` (ícone branco) e `expo-image-picker`.

---

## ⚠️ Limitações conhecidas
- **Notifee / imagem na notificação** só funciona em **build** (não no Expo Go).
- **Chave Gemini** embebida no bundle (`EXPO_PUBLIC_GEMINI_API_KEY`) — ok para pessoal; mover para **proxy** antes de publicar.
- **Imagens dos exercícios** carregam da internet (CDN); offline → placeholder. "Burpees" sem imagem.
- **APK assinado a debug** — Play Store exige keystore própria.
- **Notificações no Expo Go** mostram aviso vermelho (esperado); ignorar ou usar build.

---

## 🚀 Próximas melhorias (backlog)
- [ ] Editar metas (kcal/proteína) manualmente nas Definições.
- [ ] Histórico/troféus de bosses derrotados; artes próprias dos bosses.
- [ ] Barra de vida do boss com animação + cronómetro a contar ao vivo.
- [ ] Editar/remover exercícios do plano à mão; cronómetro de descanso.
- [ ] Nutrição: base de alimentos / código de barras; sugestão de refeição pelo Treinador.
- [ ] Evolução: comparador antes/depois (slider) nas fotos; medidas (cintura, braço…).
- [ ] Treinador: respostas em streaming; aplicar plano sugerido direto em Treinos.
- [ ] Notificações full-screen estilo SL (Android, dev build).
- [ ] Caminho para público: auth + base de dados cloud (trocar repositórios) + proxy Gemini + keystore própria + submissão às stores.
- [ ] Integração Apple Health / Google Fit.

---

## 🧪 Como retomar / testar
- Dev rápido (JS): `npx expo start` + Expo Go (SDK 54).
- Build nativo (notificações reais): `npx expo run:android` ou o APK acima.
- Validação: `npx tsc --noEmit` + `npx expo export --platform android`.
