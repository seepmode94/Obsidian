# OpsDock

A unified ops platform to manage and monitor remote servers, applications, and databases with Docker-based deployments, centralized logs, tickets, and backups.

## Project Structure

```
opsdock/
├── apps/
│   ├── api/              # NestJS backend API
│   ├── web/              # Next.js 14 frontend
│   └── worker/           # BullMQ job processor
├── agent/                # Node.js agent (runs on managed servers)
├── packages/
│   └── shared/           # Shared TypeScript types and utilities
├── infra/                # Docker Compose infrastructure
├── package.json          # pnpm workspaces root
├── turbo.json            # Turborepo configuration
└── pnpm-workspace.yaml   # Workspace definition
```

## Technology Stack

| Component | Technology |
|-----------|------------|
| **Frontend** | Next.js 14 (App Router), React 18, TypeScript, Tailwind CSS, shadcn/ui |
| **Backend** | NestJS, TypeScript, PostgreSQL, Redis/BullMQ |
| **Agent** | Node.js, TypeScript, Docker SDK |
| **Authentication** | JWT + Refresh Tokens (OIDC-ready) |
| **Log Aggregation** | Grafana Loki |
| **Object Storage** | MinIO (S3-compatible) |
| **Build System** | Turborepo, pnpm workspaces |

## Deploy to Production

From the `main` branch, run:

```bash
# Standard deploy — builds, deploys, runs pending migrations
./deploy.sh

# Full reset — drops the database, re-runs all migrations, and seeds
./deploy.sh --reset-db
```

**Default mode** merges `main` into `production`, pushes, SSHs into the server, builds and starts Docker containers, and runs any pending migrations.

**`--reset-db`** does all of the above plus drops the entire `public` schema (all tables and data), recreates it, runs all migrations from scratch, applies seed data, and restarts the API. A confirmation prompt is shown before proceeding.

> **Warning**: `--reset-db` destroys all production data. Use only when you need a clean slate.

For full setup instructions, see [documentation/deployment.md](documentation/deployment.md).

## Prerequisites

- **Node.js** >= 20.0.0
- **pnpm** >= 9.0.0
- **Docker** and **Docker Compose**

## Quick Start

### 1. Clone and Install Dependencies

```bash
cd opsdock
pnpm install
```

### 2. Start Infrastructure Services

The infrastructure includes PostgreSQL, Redis, MinIO, Loki, and Grafana.

```bash
cd infra
docker compose up -d
```

Wait for all services to be healthy:

```bash
docker compose ps
```

Expected services:
| Service | Port | Description |
|---------|------|-------------|
| PostgreSQL | 5432 | Main database |
| Redis | 6379 | Queue and cache |
| MinIO | 9000 (API), 9001 (Console) | S3-compatible object storage |
| Loki | 3100 | Log aggregation |
| Grafana | 3200 | Dashboards and visualization |

### 3. Configure Environment

Copy the example environment file:

```bash
cp .env.example .env
```

The default values work for local development. For production, update:
- `JWT_SECRET` - Use a secure 32+ character secret
- `ENCRYPTION_KEY` - 32-byte hex-encoded key for secrets encryption
- `AGENT_HMAC_SECRET` - Secret for agent command signing

### 4. Run Database Migrations

```bash
pnpm db:migrate
```

### 5. Seed Initial Data

```bash
pnpm db:seed
```

This creates default users and sample data:

| Email                      | Password    | Role      |
| -------------------------- | ----------- | --------- |
| admin@opsdock.local        | admin123    | Admin     |
| dev@opsdock.local          | dev123      | Developer |
| support@opsdock.local      | support123  | Support   |
| daniel.jackson@example.com | employee123 | Employee  |

### 6. Start Development Servers

Run each in a separate terminal:

```bash
# Terminal 1: API Server (http://localhost:3001)
cd apps/api && pnpm dev

# Terminal 2: Web Frontend (http://localhost:3000)
cd apps/web && pnpm dev

# Terminal 3: Background Worker
cd apps/worker && pnpm dev
```

Or use Turborepo to run all:

```bash
pnpm dev
```

### 7. Access the Application

- **Web UI**: http://localhost:3000
- **API Docs (Swagger)**: http://localhost:3001/api/docs
- **Grafana**: http://localhost:3200 (admin/admin)
- **MinIO Console**: http://localhost:9001 (minio/minio123)

## Project Components

### API (`apps/api/`)

NestJS backend providing REST endpoints for:
- Authentication (JWT with refresh tokens)
- User management with RBAC (Admin, Developer, Support)
- Server inventory management
- Application and environment configuration
- Deployment orchestration
- Backup management
- Ticket system
- Log querying (via Loki)
- Audit logging

Key directories:
```
src/
├── auth/           # JWT authentication and RBAC
├── users/          # User management
├── servers/        # Server inventory
├── apps/           # Application management
├── environments/   # Environment configuration
├── deployments/    # Deployment history and triggers
├── backups/        # Backup management
├── tickets/        # Support ticket system
├── integrations/   # External integrations (GitHub)
├── logs/           # Log querying via Loki
├── audit/          # Audit event logging
├── database/       # Migrations and seeds
└── common/         # Shared interceptors, filters, decorators
```

### Web (`apps/web/`)

Next.js 14 frontend with:
- App Router architecture
- Server and client components
- shadcn/ui component library
- TanStack Query for data fetching
- Tailwind CSS styling

Key pages:
- `/login` - Authentication
- `/servers` - Server inventory table
- `/apps` - Application management
- `/deployments` - Deployment history
- `/logs` - Log search interface
- `/backups` - Backup management
- `/tickets` - Support tickets
- `/security` - Vulnerability dashboard
- `/admin/integrations` - Integration settings

### Worker (`apps/worker/`)

BullMQ job processor handling:
- Deployment execution
- Backup creation and uploads
- Vulnerability scanning
- Backup retention cleanup (scheduled)

### Agent (`agent/`)

Lightweight agent deployed on managed servers:
- Heartbeat reporting to control plane
- Docker Compose deployment execution
- Backup creation (code + database)
- Log file shipping to Loki
- Trivy vulnerability scanning
- HMAC signature verification for security

### Shared (`packages/shared/`)

TypeScript type definitions shared across all packages:
- Entity types (User, Server, App, etc.)
- API response types
- Agent command types

## Docker Infrastructure

### Starting Services

```bash
cd infra
docker compose up -d
```

### Stopping Services

```bash
cd infra
docker compose down
```

### Stopping and Removing Data

```bash
cd infra
docker compose down -v
```

### Viewing Logs

```bash
cd infra
docker compose logs -f [service-name]
```

### Service Configuration

Services are configured in `infra/docker-compose.yml`. Key configuration files:
- `infra/loki-config.yml` - Loki log aggregation settings
- `infra/grafana-datasources.yml` - Grafana data source provisioning

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `DATABASE_URL` | postgresql://opsdock:opsdock@localhost:5432/opsdock | PostgreSQL connection string |
| `REDIS_URL` | redis://localhost:6379 | Redis connection string |
| `JWT_SECRET` | (dev default) | JWT signing secret |
| `JWT_EXPIRES_IN` | 15m | Access token expiry |
| `JWT_REFRESH_EXPIRES_IN` | 7d | Refresh token expiry |
| `ENCRYPTION_KEY` | (dev default) | AES-256 key for secrets |
| `MINIO_ENDPOINT` | localhost | MinIO server host |
| `MINIO_PORT` | 9000 | MinIO API port |
| `MINIO_ACCESS_KEY` | minio | MinIO access key |
| `MINIO_SECRET_KEY` | minio123 | MinIO secret key |
| `MINIO_BUCKET` | opsdock-backups | Backup storage bucket |
| `LOKI_URL` | http://localhost:3100 | Loki server URL |
| `API_PORT` | 3001 | API server port |
| `NEXT_PUBLIC_API_URL` | http://localhost:3001/api | Frontend API URL |
| `AGENT_HMAC_SECRET` | (dev default) | Agent command signing key |

## Common Commands

```bash
# Install dependencies
pnpm install

# Run all apps in development
pnpm dev

# Build all packages
pnpm build

# Run linter
pnpm lint

# Lint backend (API only)
pnpm --filter @opsdock/api lint

# Run backend unit tests
pnpm --filter @opsdock/api test

# Type checking
pnpm typecheck

# Database migrations
pnpm db:migrate

# Seed database
pnpm db:seed
``

# Drop, create, migrate, and seed database using Docker Postgres

```sh
cd infra
```

```sh
docker compose up -d postgres && docker compose exec postgres dropdb opsdock --if-exists -U opsdock && docker compose exec postgres createdb opsdock -U opsdock && pnpm db:migrate && pnpm db:seed

# Clean build artifacts
pnpm clean
```

## Internationalization

UI translations live in `apps/web/src/i18n/translations/`. Update the English baseline
and provide matching keys in Portuguese (`pt.ts`) and Spanish (`es.ts`). The selected
language is stored in `localStorage` as `opsdock_locale` and can be changed from the
sidebar language picker. To auto-generate translations, set
`GOOGLE_TRANSLATE_API_KEY` and run `pnpm --filter @opsdock/web i18n:generate`.

## User Roles

| Role | Permissions |
|------|-------------|
| **Admin** | Full access to all features, user management, integrations |
| **Developer** | View servers, apps, deployments, logs, backups |
| **Support** | Create and manage own tickets, view servers and apps |

## API Documentation

Swagger documentation is available at `http://localhost:3001/api/docs` when the API is running.

## Troubleshooting

### Database Connection Failed

Ensure PostgreSQL is running:
```bash
docker compose ps postgres
docker compose logs postgres
```

### Redis Connection Failed

Check Redis status:
```bash
docker compose ps redis
docker compose logs redis
```

### MinIO Bucket Not Found

The backup bucket is created automatically when first used. To create manually:
```bash
docker compose exec minio mc mb /data/opsdock-backups
```

### Loki Not Receiving Logs

Check Loki health:
```bash
curl http://localhost:3100/ready
```

## License

Private - All rights reserved.