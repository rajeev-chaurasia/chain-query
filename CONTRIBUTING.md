# 👩‍💻 Developer Onboarding & Contribution Guide

Welcome — this document shows how to get ChainQuery running locally and how to contribute.

## Prerequisites

Install the following tools before you begin:

- Git: https://git-scm.com/downloads
- Go (v1.20+): https://go.dev/dl/
- Docker Desktop (must be running): https://www.docker.com/products/docker-desktop/
- golang-migrate (CLI): https://github.com/golang-migrate/migrate
- abigen (optional, for generating Go bindings): https://geth.ethereum.org/docs/developers/dapp-dev/native-bindings

Install the CLI tools (example):

```bash
# Install migrate (Postgres support)
go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest

# Install abigen (optional)
go install github.com/ethereum/go-ethereum/cmd/abigen@latest

# You may need to restart your terminal for the installed binaries to be on $PATH
```

## Local setup

#### 1. Clone the repository

```bash
git clone https://github.com/rajeev-chaurasia/chain-query.git
cd chain-query
```

#### 2. Start the database

This project uses a local PostgreSQL instance via Docker Compose. From the repo root run:

```bash
docker compose up -d
```

The Compose service exposes Postgres on localhost:5432 by default. Connection details:

- Host: localhost
- Port: 5432
- Database: chainquery_db
- Username: postgres
- Password: password

Note: If you already have a Postgres server running on your host and it is listening on port 5432, either stop the host Postgres (e.g., Homebrew: `brew services stop postgresql`) or use the Docker network approach below to run migrations against the container.

#### 3. Run database migrations

Set the DB URL and run the migrations:

```bash
export DB_URL="postgres://postgres:password@localhost:5432/chainquery_db?sslmode=disable"
migrate -database "$DB_URL" -path migrations up
```

If you run into a "role does not exist" error when connecting on localhost, it usually means your `migrate` client is connecting to a different Postgres server on the host. Two options to avoid this:

- Stop your host Postgres so the Docker container's port is used.
- Run migrate inside Docker on the compose network so the service name `db` resolves to the container (example below).

Run migrate from Docker (network method):

```bash
docker run --rm \
	--network chain-query_default \
	-v "$PWD/migrations":/migrations:ro \
	-e PGPASSWORD=password \
	migrate/migrate:latest \
	-path=/migrations -database "postgres://postgres:password@db:5432/chainquery_db?sslmode=disable" up
```

## Running the application

To run the small example that verifies connectivity to an Arbitrum RPC endpoint:

```bash
go run main.go
```

You should see output similar to:

```
Success! Connected to the Arbitrum node.
Latest Block Number: <number>
```

## Project structure

- `abis/` — JSON ABI files for smart contracts
- `contracts/` — generated Go bindings (produced by `abigen`)
- `migrations/` — SQL migration files
- `docker-compose.yml` — local DB service definition
- `go.mod` — Go module dependencies
- `main.go` — small example entrypoint

## How to contribute

1. Create a branch for your work:

```bash
git checkout -b feat/my-new-feature
```

2. Implement your changes and add tests where appropriate.

3. Commit and push:

```bash
git add .
git commit -m "feat: describe your change"
git push origin feat/my-new-feature
```

4. Open a Pull Request on GitHub and add a clear description of the change and any testing notes.

## Tips & conventions

- Keep commits small and focused. Use Conventional Commits (e.g., `feat:`, `fix:`, `chore:`).
- Add or update migrations when altering DB schemas.
- Run `go mod tidy` after changing dependencies.

---

Thanks for contributing — welcome aboard!