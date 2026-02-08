# DevOps Lab

<p align="center">
  <img src="assets/octopus.png" width="400">
</p>

Personal DevOps homelab used to practice Docker, Linux, networking, storage and backup strategies.

This repository does NOT contain real production data.
It represents a cleaned and documented reference architecture based on a real home server.

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

## Repository Structure

docker_services/  
Contains docker-compose files for each service.
Only infrastructure definitions, no data.

app_data/  
Example structure for persistent application data.
Used only as reference, not real data.

ops/  
Operational documentation and scripts.

architecture/  
High-level explanations of system design decisions.

examples/  
Sanitized examples of logs, configs and outputs.

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
