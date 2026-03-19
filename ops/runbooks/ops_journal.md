_____________________________


📅 Date: 2026-03-19  
🔧 Topic: Trilium Notes container deployment  

## Context
Deployment of Trilium Notes as a lightweight personal knowledge base using Docker Compose.

## What I did
Created a Docker Compose service for Trilium Notes using a named volume for persistent storage.

## Tools involved
- Docker
- Docker Compose

## Commands used
- docker compose up -d
- docker logs trilium

## Config / Files changed
- docker-compose.yml
- .env.example

## Why
Trilium requires persistent storage for notes. Named volumes provide portability and isolation from host filesystem paths.

## Result
Trilium is accessible via browser on configured port. Notes are stored persistently inside Docker volume.

## Lessons learned
Using named volumes simplifies deployment across different environments without relying on host-specific paths.

_____________________________


📅 Date: 2026-02-XX
🔧 Topic: Deploy Homepage dashboard service

## Context
A simple web dashboard was required to organize and access internal services
running inside the infrastructure environment.

## What I did
Deployed Homepage as a containerized dashboard application using Docker
Compose. Configured the service with persistent storage and exposed it
through a dedicated HTTP port.

## Tools involved
- Docker
- Docker Compose
- Homepage

## Commands used
- docker compose up -d
- docker compose logs homepage
- docker ps

## Config / Files changed
- docker-compose.yml.exmpl
- .env.exmpl

## Why
Homepage provides a lightweight interface to organize internal tools and
services. It simplifies navigation between infrastructure components and
improves operational visibility.

## Result
Homepage successfully deployed and exposed through the configured port.
The dashboard can now be used to centralize access to internal services.

## Lessons learned
Even simple infrastructure tools benefit from standardized deployment
patterns including logging policies, health checks and resource limits.


_____________________________


📅 Date: 2026-03-XX
🔧 Topic: Deploy monitoring stack with Prometheus, Grafana, Node Exporter and cAdvisor

## Context
Monitoring capabilities were required to observe host system metrics
and container resource usage within the Docker-based infrastructure.

## What I did
Deployed a monitoring stack consisting of Prometheus, Grafana,
Node Exporter and cAdvisor using Docker Compose.

Configured Prometheus to scrape metrics from Node Exporter and
cAdvisor services.

Connected all services through a dedicated Docker network.

## Tools involved
- Docker
- Docker Compose
- Prometheus
- Grafana
- Node Exporter
- cAdvisor

## Commands used
- docker network create monitoring_network
- docker compose up -d
- docker compose ps
- docker compose logs

## Config / Files changed
- docker-compose.yml.exmpl
- prometheus.yml
- README.md

## Why
The monitoring stack provides visibility into system performance and
container resource consumption. This allows observing infrastructure
behavior and detecting potential performance issues.

## Result
Prometheus successfully collects metrics from Node Exporter and
cAdvisor. Grafana visualizes collected metrics via dashboards.

## Lessons learned
Containerized monitoring stacks provide a flexible and portable way
to observe infrastructure behavior in development and production
environments.

_____________________________

📅 Date: 2026-02-13
🔧 Topic: Deploy multi-service stack (Nginx, MySQL, Redis) with healthchecks

Context

DevOps lab environment. A multi-service setup was required to demonstrate
container networking, service dependencies, persistent storage, and health
monitoring within a single Docker Compose stack.

What I did

Deployed a Docker Compose stack including Nginx, MySQL 8.0, and Redis 7.
Configured a named volume for MySQL persistent storage.
Configured a named volume for Redis data persistence.
Connected all services to a dedicated external Docker network.
Exposed selected service ports for local access.
Added healthchecks for MySQL and Redis.
Configured service dependencies using depends_on with health conditions.
Moved sensitive configuration values into an external .env file.

Tools involved
	•	Docker
	•	Docker Compose
	•	Nginx (official image)
	•	MySQL 8.0 (official image)
	•	Redis 7 (official image)

Commands used
	•	docker network create test_media
	•	docker compose up -d
	•	docker compose ps
	•	docker compose logs
	•	docker inspect
	•	docker stats

Config / Files changed
	•	docker-compose.yml.exmpl
	•	.env.exmpl
	•	nginx configuration file

Why

The stack demonstrates inter-container networking within a shared Docker
network.
Healthchecks ensure service availability visibility.
Using named volumes provides data persistence independent of container
lifecycle.
Externalizing secrets into .env prevents credential exposure in version control.

Result

Multi-service stack successfully deployed.
Services communicate over the internal Docker network.
Health status is reported correctly.
Persistent data stored in Docker-managed volumes.

Lessons learned

Service isolation, network segmentation, and health monitoring are essential
foundations for production-oriented containerized environments.
_____________________________

📅 Date: 2026-02-13
🔧 Topic: Harden MySQL deployment with healthcheck and resource limits

Context

Existing custom MySQL container required production-style improvements
including health monitoring and memory constraints.

What I did

Added healthcheck configuration using mysqladmin ping.
Configured memory limits to prevent uncontrolled resource consumption.
Maintained external network isolation and persistent named volume.

Tools involved
	•	Docker Compose
	•	MySQL 8
	•	mysqladmin

Commands used
	•	docker compose up -d
	•	docker inspect custom_mysql
	•	docker stats

Config / Files changed
	•	docker-compose.yml

Why

Healthchecks allow runtime status visibility and better container lifecycle
control.
Memory limits prevent database container from exhausting host resources.
Production-style configuration improves operational predictability.

Result

Container reports healthy/unhealthy state correctly.
Memory usage is constrained.
Deployment behaves closer to production standards.

Lessons learned

Healthchecks and resource limits are essential even in local DevOps labs to
simulate real production environments.
_____________________________

📅 Date: 2026-02-xx
🔧 Topic: Build custom MySQL image with configuration and init script

## Context

DevOps lab infrastructure. A custom MySQL image was required to demonstrate
image customization and controlled database initialization.

## What I did

Created a custom MySQL image based on the official mysql:8 image.
Added a custom configuration file (my.cnf).
Added an initialization SQL script executed during first startup.
Deployed the container via Docker Compose using a dedicated external network.

## Tools involved
	•	Docker
	•	Docker Compose
	•	MySQL 8

## Commands used
	•	docker build -t custom_mysql .
	•	docker compose up -d
	•	docker network create db_net

## Config / Files changed
	•	Dockerfile
	•	docker-compose.yml
	•	config/my.cnf
	•	init/init.sql
	•	.env

## Why

Custom image demonstrates container customization and initialization logic.
Using a dedicated network isolates the database layer.
Using named volume ensures persistent storage independent of container lifecycle.

## Result

Custom MySQL container successfully built and deployed.
Database initialized automatically on first run.
Configuration parameters applied correctly.

## Lessons learned

Image customization allows controlled infrastructure behavior and simplifies
repeatable database provisioning.
_____________________________

📅 Date: 2026-02-xx
🔧 Topic: Deploy MySQL container with isolated Docker network

## Context

Local DevOps lab infrastructure. Database layer required for development and
service separation testing.

## What I did

Deployed MySQL 8.0 container using Docker Compose.
Created a dedicated Docker network for database isolation.
Exposed port 3306 to localhost for development access.
Configured credentials via external .env file.
Enabled persistent storage using a named Docker volume.

## Tools involved
	•	Docker
	•	Docker Compose
	•	MySQL official image

## Commands used
	•	docker network create mysql_network
	•	docker compose up -d
	•	docker compose ps
	•	docker logs mysql

## Config / Files changed
	•	docker_compose_services/mysql/docker-compose.yml.exmpl
	•	docker_compose_services/mysql/.env.exmpl

## Why

Separating the database into its own Docker network improves isolation and
prevents unintended cross-service exposure.
Using a named volume ensures persistent storage independent of container
lifecycle.
Using an .env file keeps credentials outside the compose definition.

## Result

A running MySQL container with persistent storage and controlled network
isolation.
Database accessible locally via port 3306.

## Lessons learned

Infrastructure layers should be logically separated early to simplify scaling,
security management, and service architecture evolution.

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

## Cron Environment

The cron job defines an explicit PATH variable.
This is required because cron runs with a minimal environment and does not
inherit the user's interactive shell PATH.

Defining PATH explicitly ensures that all required binaries (rsync, bash,
coreutils) are resolved correctly during execution.

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
0 15 * * 0 /bin/bash /home/user/ops/scripts/backup.sh

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

