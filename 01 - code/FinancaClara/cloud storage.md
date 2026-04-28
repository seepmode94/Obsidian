# Cloud Storage — FinançaClara

Opções para guardar dados na cloud. Ordenadas por esforço/fit ao projeto.

---

## 1. Supabase (recomendado MVP)

Postgres + auth + RLS + realtime. SDK Flutter oficial.

**Free tier**: 500 MB DB, 50k MAU, 2 GB bandwidth.

### Passos
1. Criar projeto em [supabase.com](https://supabase.com).
2. Adicionar dep:
   ```bash
   flutter pub add supabase_flutter
   ```
3. Init no `main.dart`:
   ```dart
   await Supabase.initialize(
     url: 'https://xxx.supabase.co',
     anonKey: 'public-anon-key',
   );
   ```
4. Definir schema SQL:
   ```sql
   create table transactions (
     id uuid primary key default gen_random_uuid(),
     user_id uuid references auth.users not null,
     valor numeric not null,
     categoria_id uuid references categories,
     data timestamptz not null,
     nota text,
     created_at timestamptz default now()
   );
   ```
5. **Ativar RLS** em todas tabelas. Policy base:
   ```sql
   alter table transactions enable row level security;
   create policy "user vê só dele"
     on transactions for all
     using (auth.uid() = user_id);
   ```
6. Auth email/password ou OAuth (Google/Apple).
7. CRUD:
   ```dart
   await supabase.from('transactions').insert({...});
   final rows = await supabase.from('transactions').select();
   ```
8. Realtime opcional para sync multi-device:
   ```dart
   supabase.from('transactions').stream(primaryKey: ['id']).listen(...);
   ```

### Prós
- SQL real → agregações financeiras eficientes.
- RLS resolve permissões família/grupos (V1) sem lógica server.
- Free tier suficiente para validar MVP.
- Open source, self-host possível depois.

### Contras
- Vendor lock parcial (mitigado: schema Postgres puro, migra para servidor próprio se preciso).

---

## 2. Firebase (Firestore)

NoSQL Google. Setup zero, offline cache automático.

### Passos
1. Criar projeto Firebase Console.
2. `flutterfire configure`.
3. Adicionar deps:
   ```bash
   flutter pub add cloud_firestore firebase_auth
   ```
4. CRUD via `FirebaseFirestore.instance.collection('transactions')`.

### Prós
- Setup mais rápido que Supabase.
- Offline cache built-in.
- Auth muito maduro.

### Contras
- **NoSQL péssimo para agregações financeiras**. Somar gastos por categoria/mês = ler tudo no client ou manter contadores manuais.
- Custo dispara com leituras (cobra por document read).
- Queries compostas precisam índices manuais.

**Veredicto**: evitar para este projeto.

---

## 3. Offline-first (Supabase + drift)

Local primeiro, sync cloud em background. Melhor UX, complexidade alta.

### Passos
1. Drift como source of truth local (SQLite typed).
2. Cada row com colunas `updated_at`, `synced_at`, `dirty` (bool).
3. Worker periódico:
   - Push: rows `dirty=true` → Supabase.
   - Pull: rows com `updated_at > last_sync` → drift.
4. Conflict resolution:
   - Simples: last-write-wins (timestamp ganha).
   - Robusto: versionamento + merge manual.

### Alternativas para evitar escrever sync à mão
- **PowerSync** — sync bidirecional Postgres ↔ SQLite. Free tier disponível.
- **Brick** — ORM Flutter offline-first.

### Prós
- App funciona sem rede.
- UX rápido (zero latência leitura).
- Bateria amiga (sync em batch).

### Contras
- Complexidade grande. Conflitos, ordering, deletes propagados.
- Mais código, mais bugs.

**Veredicto**: V1.5+, não MVP.

---

## 4. Backend próprio (Go/Node + Postgres)

Servidor próprio em Hetzner/Fly.io/Railway. ~5€/mês.

### Contras MVP
- Auth, hosting, backups, migrations, monitoring tudo manual.
- RLS manual (middleware).
- Tempo gasto >>> valor entregue ao utilizador.

**Veredicto**: só pós-MVP se Supabase ficar limitante.

---

## 5. Appwrite

Alternativa open-source ao Firebase. Self-host ou cloud.

### Contras
- Comunidade menor que Supabase/Firebase.
- Queries SQL limitadas (não é Postgres real).

**Veredicto**: skip, Supabase ganha em tudo.

---

## Encriptação client-side

Dados financeiros = sensíveis. Camada extra acima cloud.

### Setup
```bash
flutter pub add cryptography flutter_secure_storage
```

### Padrão
1. Gerar chave AES-256 no primeiro login.
2. Guardar chave em `flutter_secure_storage` (Keychain iOS / Keystore Android).
3. Antes insert: encriptar `nota`, `valor`, etc.
4. Cloud guarda blob encriptado.
5. Após select: decriptar local.

### Trade-off
- Cloud não consegue fazer queries em cima dos campos encriptados.
- Soluções:
  - Encriptar só campos muito sensíveis (`nota`).
  - Manter `valor` + `categoria_id` em claro para agregações.
  - Ou: agregações no client (drift local + sync encriptado).

### Recovery
- Se utilizador perde dispositivo + chave → dados perdidos.
- Mitigação: backup chave encriptada por password (PBKDF2).

---

## Recomendação concreta

| Fase | Stack |
|------|-------|
| **MVP** | Supabase online-only, sem encriptação client-side |
| **V1** | Adicionar RLS por grupo família |
| **V1.5** | Drift + sync offline-first (PowerSync ou manual) |
| **V2** | Encriptação client-side em campos sensíveis |
| **V3+** | Reavaliar: backend próprio se Supabase ficar caro/limitante |

---

## Decisões pendentes

- [ ] Confirmar Supabase como backend MVP.
- [ ] Online-only ou offline-first desde início?
- [ ] Encriptação client-side desde MVP ou só V2?
- [ ] Multi-moeda afeta schema (coluna `currency`)?
- [ ] Backup/export para utilizador (CSV/JSON)?

---

*Versão 0.1 — 2026-04-28. Atualizar conforme decisões.*
