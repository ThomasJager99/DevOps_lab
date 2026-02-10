_____________________________

📅 Date: 2026-02-XX
🔧 Topic: Create rsync-based backup script for infra and application data

## Context
The system consists of containerized services with separated infrastructure
definitions and persistent application data. A reliable and repeatable backup
mechanism was required after moving to a clear infra/data separation model.

## What I did
Created a shell script using rsync to back up infrastructure files and
application data into separate directories on a backup storage location,
with unified logging.

## Tools involved
- bash
- rsync
- cron

## Commands used
- rsync -avh --delete --itemize-changes
- mountpoint
- mkdir

## Config / Files changed
- ops/scripts/backup.sh
- cron configuration (weekly schedule)

## Why
Manual backups were error-prone and did not scale with system complexity.
Using rsync allows incremental backups, clear visibility of changes, and
independent restore of infra and application data. Separating infra and data
reduces blast radius during restore operations.

## Result
A repeatable and automated backup process was established.
Infrastructure and application data are backed up independently with
consistent logging and verification points.

## Lessons learned
Backups must reflect system structure.
Separating infra and data at backup level simplifies restore and troubleshooting.

_____________________________

📅 Date: 2026-02-XX
🔧 Topic: Deploy nginx as a reverse proxy for internal services

## Context
A single entry point was required to expose selected internal services while
keeping application containers isolated from direct host access.

## What I did
Deployed nginx as a reverse proxy container connected to the internal Docker
network. Configured path-based routing to expose the Glances web interface
through a single HTTP endpoint.

## Tools involved
- Docker
- Docker Compose
- nginx

## Commands used
- docker compose up -d
- docker compose logs nginx
- docker exec -it nginx nginx -t

## Config / Files changed
- docker-compose.example.yml
- nginx.conf

## Why
Using a reverse proxy centralizes ingress traffic and reduces the attack surface
by exposing only one service to the host. Path-based routing allows multiple
internal services to be accessed without publishing additional ports.

## Result
nginx successfully routed HTTP requests from the host to the internal Glances
service while keeping Glances inaccessible directly from the host network.

## Lessons learned
- Reverse proxies simplify service exposure and access control
- Internal-only services can still be safely accessed through controlled ingress
_____________________________

📅 Date: 2026-02-XX
🔧 Topic: Deploy Glances for container and host monitoring

## Context
A lightweight monitoring solution was required to observe system resource usage
and container-level metrics within a Docker-based infrastructure.

## What I did
Deployed Glances as a Docker container with access to Docker metrics and host
system information. The service was connected to the internal Docker network and
configured for read-only access to system resources where possible.

## Tools involved
- Docker
- Docker Compose
- Linux system interfaces

## Commands used
- docker compose up -d
- docker compose logs glances

## Config / Files changed
- docker-compose.example.yml
- .env.example

## Why
Running Glances in a container provides a simple and reproducible way to monitor
system and container metrics without installing additional tooling on the host.
Read-only mounts reduce risk while still allowing visibility into system state.

## Result
The Glances service started successfully and exposed real-time monitoring data
for the host and running containers within the internal network.

## Lessons learned
- Monitoring containers often require controlled access to host resources
- Read-only mounts are sufficient for most observability use cases

_____________________________

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

