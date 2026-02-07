# System Overview

This repository documents a self-hosted, single-node DevOps lab built on a
Linux-based system to practice infrastructure design, containerization, and
operational workflows.

## Operating System
- Debian GNU/Linux 13 (Trixie)
- x86_64 architecture
- Modern kernel with cgroup v2 support

## Hardware Profile
- CPU: Dual-core Intel CPU with SMT (4 logical CPUs)
- Memory: ~20 GB RAM
- Architecture: Single-socket, non-NUMA system

## Storage Layout
- System disk: SSD (ext4)
- Data disk: External storage (exFAT)
- Swap enabled

The system separates OS files from application and media data to simplify
maintenance and backup workflows.

## Container Runtime
- Docker Engine (Community Edition)
- Docker Compose v2 (plugin-based)
- containerd runtime with runc

## Container Platform Details
- Storage driver: overlay2
- Logging driver: json-file
- cgroup driver: systemd
- cgroup version: v2
- Default runtime: runc

## Networking Model
- Docker bridge networking
- Internal-only services by default
- Single ingress point via reverse proxy
- No direct localhost coupling between containers

## Observability
- Container and host metrics collected via a dedicated monitoring container
- Monitoring access is internal and read-only where possible

## Operations
- Services managed via Docker Compose
- Persistent data stored outside container filesystems
- Cron-based backups with documented restore procedures
- Operational changes documented in an ops journal

## Scope
This system is not production infrastructure.
It exists as a practical DevOps lab and as a reference for architectural and
operational decision-making.
