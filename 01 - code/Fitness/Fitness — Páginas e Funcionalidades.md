---
projeto: Arise (Fitness)
tipo: páginas e UX
atualizado: 2026-06-24
prints: testados em emulador Android (Expo Go SDK 54)
---

# 📱 Arise (Fitness) — Páginas e Funcionalidades

Cada página: **print real**, como funciona, e **propostas** a adicionar.
Estética "Sistema": dark + neon cyan, ranks E→S, painéis com cantos.

---

## 🧭 Onboarding (8 passos)

Aparece na 1ª utilização (e via Definições → *Repetir avaliação*). Gera o perfil, as recomendações e o plano.

### 1 — Bem-vindo
![[01-onboarding-bemvindo.png]]
Ecrã de entrada do "Sistema" com barra de progresso 1/8.

### 2 — Quem és (sexo + idade)
![[02-onboarding-quem-es.png]]
Seleção de sexo e idade. O botão **Continuar só ativa** quando os campos são válidos.

### 3 — O teu corpo (altura em metros)
![[03-onboarding-corpo-metros.png]]
Altura em **metros** (`1,82`) com conversão automática mostrada (**= 182 cm**), peso e % gordura opcional.

### 4 — Objetivos (multi-seleção)
![[04-onboarding-objetivos-multi.png]]
Vários objetivos em simultâneo. Mensagem: *"O Sistema vai distribuir os objetivos pelos teus dias de treino."* + experiência.

### 5 — Onde treinas (equipamento)
![[05-onboarding-equipamento.png]]
Casa / Ginásio / Ambos (com ícones). Em Casa/Ambos aparece a lista do que tens.

### 6 — Disponibilidade
![[06-onboarding-disponibilidade.png]]
Dias da semana + minutos/sessão (**desde 10 min**) + estilo (Padrão / Intensivo circuito) + **horários de lembrete**.

### 7 — Limitações
![[07-onboarding-limitacoes.png]]
Texto livre (lesões/dores). Usado pelo Treinador IA. Disclaimer: não substitui aconselhamento médico.

### 8 — Avaliação
![[08-onboarding-avaliacao.png]]
IMC, peso saudável, **gordura-alvo**, **calorias e proteína/dia** calculadas. Botão **"Despertar ⚔️"** gera o plano.

**Propostas:**
- Permitir saltar passos opcionais mais rápido / barra "passo X de Y" clicável.
- Sugerir % de gordura visualmente (escala com silhuetas).
- Mostrar uma estimativa do plano já no passo 8 (preview dos dias).

---

## 🏠 Início (Dashboard + Boss)
![[10-inicio-dashboard.png]]

**Como funciona:** painel do jogador (Rank, **Poder**, barra de XP, 5 atributos, streak), secção **Desafio** (Boss), cartão **Próximo Treino** (do plano), quests diárias e gráfico de XP (mais abaixo). Ícone ⚙️ → Definições.

**Propostas:**
- Animação de "level up" e de subida de rank.
- Resumo do dia (kcal/treino) no topo.
- Atalho rápido "Registar treino/refeição".

---

## ⚔️ Boss / Desafio
![[11-boss-desafio.png]]

**Como funciona:** "Novo Desafio" invoca um Boss **escalado ao nível** (aqui Rank E — *Lobo Esfomeado* 🐺), com objetivo (700 kg de volume), recompensa (**+120 XP**) e prazo de 24h. **Aceitar/Recusar**. Dispara também uma **notificação** com ação *Aceitar* (vai direto ao treino). Falhar o prazo → o boss **escapa** (sem XP) e pode ser caçado de novo.

**Propostas:**
- Artes/ilustrações próprias dos bosses (em vez de emoji).
- Barra de "vida" do boss a descer conforme o progresso do treino.
- Bosses semanais especiais / raids com recompensas maiores.

---

## 🏋️ Treinos
![[12-treinos-plano.png]]

**Como funciona:** "Sessão de Hoje" (escolher exercício → reps/peso → adicionar série → concluir treino dá XP). "O Teu Plano" mostra os dias gerados (ex.: **Dia 1 — Push**, tag **Ganhar músculo**, exercícios 4×8-12 adaptados ao equipamento). Botão **"Adaptar com o Treinador (IA)"**. Histórico em baixo.

**Propostas:**
- Cronómetro de descanso entre séries.
- Repetir último treino / sugerir peso com base no histórico.
- Marcar séries do plano como feitas (checklist) e calcular progresso do dia.

---

## 🥗 Nutrição
![[13-nutricao.png]]

**Como funciona:** totais do dia vs **metas do perfil** (aqui 2890 kcal / 148 g proteína), macros, e formulário para adicionar refeição (tipo + kcal + macros). Lista "Hoje".

**Propostas:**
- Base de dados de alimentos / pesquisa rápida.
- Leitura de código de barras.
- Sugestão de refeição pelo Treinador para fechar os macros do dia.

---

## 📈 Evolução
![[14-evolucao.png]]

**Como funciona:** cartões de resumo (Nível, Poder, Sequência, Treinos, Volume total, **Peso atual**), registar medição (+25 XP), **Fotografias** de progresso (local; comparação antes/depois) e gráficos (peso, volume, XP) mais abaixo.

**Propostas:**
- Comparador antes/depois com slider sobre as fotos.
- Metas visuais (linha do peso-alvo no gráfico).
- Medidas (cintura, braço, etc.) além do peso.

---

## 🤖 Treinador (Gemini)
![[15-treinador.png]]

**Como funciona:** chat "O Sistema" (treinador + nutricionista) com sugestões rápidas e input. Usa o teu contexto real (nível, treinos, metas) e **pesquisa Google** (fontes). Não diagnostica.

### Resposta real do Gemini (testado)
![[16-treinador-resposta-gemini.png]]
Pedido "Sugere um treino rápido de 30 minutos" → resposta estruturada em PT-PT (aquecimento + plano), com o contexto "Nível 1, Rank E".

**Propostas:**
- Botão para **aplicar** um plano sugerido pelo chat diretamente em Treinos.
- Respostas em streaming (texto a aparecer).
- Histórico de conversas / "memória" do treinador.

---

## ⚙️ Definições

**Como funciona:** resumo do perfil (objetivos, estilo, equipamento, disponibilidade, altura, limitações), **"Repetir avaliação"** (reabre o onboarding pré-preenchido e gera novo plano mantendo o progresso) e ligar/desligar **lembretes**.

**Propostas:**
- Editar metas de nutrição manualmente.
- Tema/aparência, unidades (kg/lb).
- Exportar/importar dados (backup).

---

## Notas de verificação (2026-06-24)
- Fluxo completo conduzido num **emulador Android** (Expo Go SDK 54): todos os ecrãs acima são prints reais dessa sessão.
- **Notificações locais funcionam** no Expo Go (a notificação do Boss apareceu com a ação *Aceitar*); as **push remotas** exigem development build.
- A **resposta real do Gemini** foi confirmada (último print).
