📅 Date: 2026-02-XX
🔧 Topic: Deploy Komga as a Docker service with persistent storage

## Context
A self-hosted media service was required to manage and serve a comics library.
The service had to persist data across container restarts and integrate into an
existing Docker-based infrastructure.

## What I did
Deployed Komga using Docker Compose with explicit bind mounts for persistent data.
Configured the container to run as a non-root user aligned with host UID/GID.

## Tools involved
- Docker
- Docker Compose
- Linux filesystem

## Commands used
- docker compose up -d
- docker compose logs komga

## Config / Files changed
- docker-compose.example.yml
- application data directory (bind mount target)

## Why
Running Komga as a container allows predictable deployment and easy recovery.
Bind mounts were used to ensure that application state is stored outside the
container filesystem and can be backed up independently.

UID/GID alignment was required to avoid permission issues on the host filesystem
and during backup operations.

## Result
The Komga service started successfully, persisted its data across restarts, and
became accessible through the internal Docker network.

## Lessons learned
- Persistent data must be planned before first container start
- Non-root containers require explicit ownership preparation on the host

_____________________________


📅 Date: 2026-02-XX
🔧 Topic: Deploy Kavita as a containerized service

## Context
A self-hosted e-book management service was required as part of the internal
media stack with persistent storage and controlled access.

## What I did
Deployed Kavita using Docker Compose with bind-mounted directories for
configuration and application data. Connected the service to an internal
Docker bridge network and mounted the media library in read-only mode.

## Tools involved
- Docker
- Docker Compose
- Linux filesystem

## Commands used
- docker compose up -d
- docker compose logs kavita

## Config / Files changed
- docker-compose.example.yml
- .env.example

## Why
Containerization provides reproducible deployment and simplifies recovery.
Bind mounts ensure that application state persists independently of the
container lifecycle. Read-only media mounts prevent accidental modification
of source data.

## Result
The Kavita service started successfully, retained its data across restarts,
and became accessible within the internal Docker network.

## Lessons learned
- Persistent storage must be planned before first container start
- Read-only mounts reduce risk for source media directories

_____________________________


📅 Date:
🔧 Topic:

## Context
(What system or component this relates to)

## What I did
(Concrete action, no emotions, no story)

## Tools involved
- 

## Commands used
- 

## Config / Files changed
- 

## Why
(Technical reasoning, not “because it worked”)

## Result
(What changed after the action)

## Lessons learned
(Optional but recommended)

_____________________________

