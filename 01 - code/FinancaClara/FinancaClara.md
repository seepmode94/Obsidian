# FinançaClara

App mobile pessoal para controlo de despesas, partilha familiar e monitorização de investimentos.

---

## 1. Visão

Centralizar gastos pessoais e familiares num só sítio. Mostrar **onde** vai o dinheiro, **quanto** sobra, e **como** crescem investimentos. Estatísticas claras > planilhas Excel.

## 2. Problema

- Pessoas perdem noção de gastos pequenos recorrentes (subscrições, cafés, takeaway).
- Casais/famílias não têm visão partilhada — cada um controla o seu, ninguém vê o total.
- Apps existentes (Revolut, banco) só mostram **uma** conta. Sem agregação multi-banco + investimentos + partilha familiar.

## 3. Utilizadores

- **MVP**: eu (utilizador único).
- **V1**: grupos familiares, casais (convite por link/email, permissões partilha).
- Futuro:  colegas de casa, pequenos grupos(PMEs).

## 4. Funcionalidades core

### MVP (single-user)
- Registo manual de despesa (valor, categoria, data, nota).
- Categorias personalizáveis (alimentação, transporte, lazer, casa…).
- Dashboard mensal: total gasto, gráfico por categoria, comparação mês anterior.
- Receitas (salário, extras).
- Saldo do mês.

### V1 (familiar)
- Criar grupo família.
- Convidar membros.
- Ver despesas individuais + agregadas do grupo.
- Permissões: quem vê o quê (ex: filhos não veem salário pais).
- Despesas partilhadas (renda, supermercado) com split automático.

### V2 (investimentos)
- Carteira: ações, ETF, cripto, depósitos.
- Valor investido vs valor atual.
- Rentabilidade % (mensal, anual, total).
- Possível integração APIs cotações (yahoo finance, coingecko).

### V3 (avançado)
- Importação automática extrato bancário (Open Banking — ver `enable banking.md`).
- Orçamentos por categoria com alertas.
- Objetivos poupança (mealheiros virtuais).
- Previsão fim de mês baseado histórico.

## 5. Stack

### Atual (scaffold default)
- **Flutter SDK** `^3.11.0` (Dart).
- **Plataformas presentes**: Android, iOS, Web, macOS, Windows.
- **Deps**: `cupertino_icons` + `flutter_lints`.
- Sem state management, routing, HTTP, persistência ainda.

### A adicionar (ordem sugerida)

| Camada | Recomendação | Alternativas |
|--------|--------------|--------------|
| State mgmt | **Riverpod** (`flutter_riverpod`) — testável, sem BuildContext | Bloc, Provider |
| Routing | **go_router** (oficial Google, declarativo, deep links) | auto_route |
| HTTP | **dio** (interceptors, retry) | http (mais simples) |
| Local DB | **drift** (SQLite typed) ou **isar** (NoSQL rápido) | hive |
| Secure storage | **flutter_secure_storage** (Keychain/Keystore) — tokens, chaves | — |
| Encriptação | **cryptography** package | — |
| Charts | **fl_chart** (dashboard categorias) | syncfusion |
| Forms | **reactive_forms** ou validação manual | — |
| Auth | Supabase SDK ou Firebase Auth | — |
| Datas | `intl` (locale pt_PT) | — |
| Lint extra | `very_good_analysis` (regras stricter) | — |

### Backend (decidir)

- **Supabase** — Postgres + auth + RLS + realtime. SDK Flutter oficial. **Recomendado MVP**.
- Firebase — fácil mas NoSQL chato para queries financeiras agregadas.
- Próprio (Go/Node + Postgres) — só faz sentido pós-MVP.

### Plataformas — **focar Android+iOS no MVP**
Web/macOS/Windows ficam mas não são prioridade. Remove esses folders se quiser repo enxuto, ou ignora.

### Open Banking
Enable Banking (PSD2, EU) — só V3.

## 6. Modelo de dados (rascunho)

```
User { id, email, nome, biometria_enabled }
Group { id, nome, owner_id, membros[] }
Account { id, user_id, nome, tipo (corrente/poupança/cripto), saldo }
Transaction { id, account_id, valor, categoria_id, data, nota, tipo (entrada/saída) }
Category { id, user_id|group_id, nome, icone, cor, parent_id }
Investment { id, user_id, ativo, qty, preco_compra, data_compra }
Budget { id, user_id|group_id, categoria_id, limite, periodo }
```

## 7. Decisões pendentes

- [x] ~~Stack mobile~~ → **Flutter** (decidido).
- [ ] State management (Riverpod recomendado).
- [ ] Routing (go_router recomendado).
- [ ] Backend (Supabase vs próprio) — **Supabase para MVP**.
- [ ] Local DB (drift vs isar).
- [ ] Plataformas alvo MVP — recomendado **Android+iOS only**, congelar web/desktop.
- [ ] Modelo monetização: free, premium, freemium? (afeta arquitetura).
- [ ] Multi-moeda? (EUR só, ou USD/BRL/etc).
- [ ] Offline-first ou online-only? (com Supabase + drift = offline-first viável).
- [ ] Encriptação local dados financeiros — obrigatório para confiança utilizador.
- [ ] Nome final + branding.

## 8. Riscos

- **Privacidade**: dados financeiros = sensíveis. Encriptação + GDPR não-negociável.
- **Concorrência**: YNAB, Mobills, Wallet — já maduros. Diferencial = partilha familiar + investimentos integrados.
- **Scope creep**: V2/V3 grandes. MVP tem que sair pequeno e funcional.
- **Manutenção sozinho**: stack tem que ser produtiva (1 pessoa).

## 9. Próximos passos

### Fase 0 — fundações projeto Flutter
1. Adicionar deps base ao `pubspec.yaml`:
   ```yaml
   flutter_riverpod: ^2.5.0
   go_router: ^14.0.0
   drift: ^2.18.0
   drift_flutter: ^0.2.0
   flutter_secure_storage: ^9.2.0
   intl: ^0.19.0
   fl_chart: ^0.68.0
   ```
2. Estrutura de pastas:
   ```
   lib/
     core/         # config, theme, utils
     data/         # models, repositories, drift db
     features/
       expenses/   # screens + providers + widgets
       dashboard/
       categories/
       settings/
     routing/      # go_router config
     main.dart
   ```
3. Setup `very_good_analysis` ou apertar `analysis_options.yaml`.

### Fase 1 — MVP single-user (sem backend)
4. Wireframes 4 telas: lista despesas, adicionar despesa, dashboard, categorias.
5. Schema drift: `transactions`, `categories`, `accounts`.
6. CRUD despesas local (sem cloud).
7. Dashboard mensal — fl_chart pizza por categoria.
8. Seed categorias default (alimentação, transporte, etc).

### Fase 2 — cloud + auth
9. Setup Supabase project.
10. Auth email/password.
11. Sync drift ↔ Supabase (offline-first).
12. Biometria local para abrir app.

### Fase 3 — família
13. Tabela `groups` + `group_members`.
14. RLS policies Supabase (membro só vê grupo dele).
15. UI convite (deep link).
16. Dashboard agregado grupo.

## 10. Notas / ideias soltas

- Widget home screen com saldo do mês.
- Notificações: "gastaste 80% do orçamento alimentação".
- Foto do recibo → OCR → preenche transação.
- Modo "viagem" — separar gastos férias do dia-a-dia.
- Export CSV/PDF para contabilista.

---

*Atualizar conforme decisões. Versão 0.1 — 2026-04-28.*
