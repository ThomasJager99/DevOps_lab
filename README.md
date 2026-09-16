# DevOps Lab

<p align="center">
  <img src="assets/mascot/octopus.png" width="400">
</p>

Personal DevOps homelab used to practice Docker, Linux, networking, storage and backup strategies.

This repository does NOT contain real production data.
It represents a cleaned and documented reference architecture based on a real home server.

![Shell Lint](https://github.com/ThomasJager99/DevOps_lab/actions/workflows/lint.yml/badge.svg)
![Python Lint](https://github.com/ThomasJager99/DevOps_lab/actions/workflows/python-lint.yml/badge.svg)


---

### At a glance

- 🐳 20+ self-hosted services, one Docker Compose stack each, grouped by category
- 📊 Full observability stack — Prometheus, Grafana, Loki, Promtail, cAdvisor
- 💾 Automated incremental backups (rsync) with retention + runbooks
- ⚙️ CI on every push — ShellCheck + ruff via GitHub Actions
- 🐧 Single-node Debian homelab, reverse-proxied with nginx

---
## Goals

- Practice Docker and docker-compose
- Prepare foundation for Kubernetes (containerization, networking, storage concepts)
- Design persistent storage for containers
- Separate infrastructure from application data
- Implement and automate backups
- Document operational decisions (runbooks)
- Prepare for Junior DevOps / SRE interviews

---

## Environment

Host system:
- Debian Linux
- Single-node homelab (laptop used as server)

Main components:
- Docker
- docker-compose
- Bash scripts
- rsync backups
- Reverse proxy (nginx)

---

## Requirements

To run any stack in this repo you need:

- **Docker Engine** + the **Docker Compose v2** plugin (`docker compose`, not the legacy `docker-compose`)
- A Linux host — this lab runs on Debian, but any distro works

The install step differs per distro; the run commands are identical everywhere.
Quickest cross-distro install:

```bash
curl -fsSL https://get.docker.com | sh
```

…or use your distro's packages (Debian `apt`, Fedora `dnf`, Arch `pacman`, …)
per the official docs: https://docs.docker.com/engine/install/

Once Docker is installed, every service runs the same way:

```bash
cd docker_compose_services/<category>/<service>
cp docker-compose.example.yml docker-compose.yml
cp .env.example .env        # then edit .env
docker compose up -d
```

> Full per-distribution host setup (packages, networking, storage, firewall,
> SELinux / Podman notes) is covered separately in the homelab build guide.


---

## Monitoring
```
                          ┌─────────────────────────┐
                          │          Nginx          │
                          │      Reverse Proxy      │
                          └─────────────┬───────────┘
                                        │
                                        ▼
                                ┌───────────────┐
                                │    Grafana    │
                                │   Dashboards  │
                                └───────┬───────┘
                                        │
                     ┌──────────────────┴──────────────────┐
                     │                                     │
                     ▼                                     ▼
              ┌───────────────┐                     ┌──────────────┐
              │  Prometheus   │                     │     Loki     │
              │ Metrics Store │                     │  Log Storage │
              └───────┬───────┘                     └──────┬───────┘
                      │                                     │
          ┌───────────┴───────────┐                         │
          │                       │                         │
          ▼                       ▼                         ▼
   ┌──────────────┐       ┌───────────────┐         ┌───────────────┐
   │   cAdvisor   │       │ Node Exporter │         │    Promtail   │
   │Container Stats│      │ Host Metrics  │         │  Log Collector│
   └──────────────┘       └───────────────┘         └───────────────┘
                                                        │
                                                        ▼
                                               Docker container logs
```
The monitoring stack combines metrics and log collection.

Metrics pipeline:

- **Node Exporter** exposes host system metrics
- **cAdvisor** exposes container resource metrics
- **Prometheus** scrapes metrics from both services
- **Grafana** queries Prometheus to visualize metrics

Logging pipeline:

- **Promtail** collects logs from Docker containers
- **Loki** stores and indexes log data
- **Grafana** queries Loki to visualize logs

Only **Grafana** is exposed externally through the reverse proxy.
All other services communicate internally through the Docker network.

The monitoring example:

[Monitoring Setup Guide](docker_compose_services/monitoring)

---

### Backup Implementation

Backup scripts, snapshot logic, and retention strategy are implemented in:

→ [backup_tools](./architecture/backup_system/)

---

## Infrastructure Dashboard

<p align="center">
  <img src="assets/homepage.png" width="180">
</p>

<br>

A lightweight dashboard is deployed using **Homepage** to provide a central
entry point for internal services.

The dashboard aggregates links to commonly used infrastructure components such as:

- monitoring (Grafana)
- service interfaces
- development tools
- internal applications

This allows quick navigation across the self-hosted environment without
exposing multiple ports or remembering individual service URLs.

Example deployment configuration is available in:

docker_compose_services/homepage/

Example configuration:
[docker_compose_services/homepage](docker_compose_services/homepage)

---

## Repository Structure

```
DevOps_lab/
├── docker_compose_services/   # service stacks, grouped by category
│   ├── media/                 #   video, audiobooks, comics, photos
│   ├── apps/                  #   personal & productivity apps
│   ├── infra/                 #   reverse proxy, dashboard, stack manager, git
│   ├── observability/         #   metrics, logs, uptime
│   └── databases/             #   data backends
├── custom_dockerfile/         # custom container image definitions
├── architecture/              # system design docs + backup strategy
├── networking/                # network configuration docs
├── server_building/           # host / OS setup docs
├── servers/                # server configuration examples
├── python_uthtion/         # p# Python automation scripts
├── ops/                       # runbooks and operational scripts
├── assets/                    # images used in the docs (logos, dashboards)
└── .github/workflows/         # CI: shell + python linting
```

Each service under `docker_compose_services/` is a self-contained stack
(`docker-compose` file + example env + README). The categories are indexed
in `docker_compose_services/README.md`.

---

## Services Overview

Services included in this lab:
- nginx (reverse proxy)
- monitoring (glances)
- media services (example)
- application containers (example)

Each service:
- runs in Docker
- uses bind-mounted persistent data
- is isolated in a custom Docker network

---

## Storage Model

Principles:
- Containers are stateless
- All persistent data lives outside containers
- Application data and infrastructure are separated

High-level layout:
- docker_services → how services are started
- app_data → what services store
- backup → offline backup / Cloud

---

## Backups

Backup strategy:
- Tool: rsync
- Target: offline USB drive
- Mode: incremental with deletion

Backups include:
- application data
- service configuration
- infrastructure definitions

Backups exclude:
- operating system
- temporary files
- caches

See:
`ops/runbooks/backup.md`

---

## Operations

This repository contains runbooks for:
- backups
- restore procedures
- permission issues
- common container failures

The goal is to document operational thinking, not just configuration.

---

## Security Notes

- No real credentials are stored
- All secrets are replaced with placeholders
- .env files are provided as examples only

---

## Status

This lab is actively evolving.
Structure and documentation improve over time as new topics are learned.
Kubernetes is planned as a next step after stabilizing the Docker-based setup.

---

## Disclaimer

This is a learning and practice project.
It is not intended to be used as a production-ready setup without adaptation.
