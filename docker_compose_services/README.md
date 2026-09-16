# Docker Compose Services


<p align="center">
  <img src="../assets/mascot/termkujira.png" width="180">
</p>

<br>


This directory collects the self-hosted services running in the homelab. Each
service is a self-contained Docker Compose stack — its own `docker-compose` file,
an example env and a README — and the stacks are grouped by purpose into the
categories below. The collection grows over time; the current list of services
in each category lives in that category's README.

Nothing here contains real credentials — every stack ships an example env you
copy and fill in.

<table>
  <tr>
    <td width="80" align="center"><a href="media/"><img src="../assets/logos/clapperboard.svg" width="64" alt="Media"></a></td>
    <td><a href="media/"><b>Media</b></a><br>Streaming and libraries for video, audiobooks, comics and photos.</td>
  </tr>
  <tr>
    <td width="80" align="center"><a href="apps/"><img src="../assets/icons/app-window.svg" width="64" alt="Apps"></a></td>
    <td><a href="apps/"><b>Apps</b></a><br>Personal and productivity applications — finance, documents, notes, tasks, passwords.</td>
  </tr>
  <tr>
    <td width="80" align="center"><a href="infra/"><img src="../assets/icons/server.svg" width="64" alt="Infrastructure"></a></td>
    <td><a href="infra/"><b>Infrastructure</b></a><br>The plumbing — reverse proxy, dashboard, stack manager and Git hosting.</td>
  </tr>
  <tr>
    <td width="80" align="center"><a href="observability/"><img src="../assets/icons/activity.svg" width="64" alt="Observability"></a></td>
    <td><a href="observability/"><b>Observability</b></a><br>Metrics, logs, uptime and live system health.</td>
  </tr>
  <tr>
    <td width="80" align="center"><a href="databases/"><img src="../assets/icons/database-zap.svg" width="64" alt="Databases"></a></td>
    <td><a href="databases/"><b>Databases</b></a><br>Shared and standalone data backends.</td>
  </tr>
</table>

## Layout

```
docker_compose_services/
├── media/           video, audiobooks, comics, photos
├── apps/            personal & productivity apps
├── infra/           proxy, dashboard, stack manager, git
├── observability/   metrics, logs, uptime
└── databases/       data backends
```

Each service folder keeps its own `docker-compose` file, example env and README,
so it can be understood — and run — on its own. New services are added into the
category they belong to, and listed in that category's README.

---

## Requirements

Every stack here needs **Docker Engine** and the **Docker Compose v2** plugin
(`docker compose`, with a space). The run commands are identical on any Linux
distro — only the install step differs.

Quickest cross-distro install (detects your distro):

```bash
curl -fsSL https://get.docker.com | sh
```

Or install from your distro's packages:

| Distro | Install |
|--------|---------|
| Debian / Ubuntu | Docker's apt repo → `apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin` |
| Fedora / RHEL | Docker's dnf repo → `dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin` |
| Arch | `pacman -S docker docker-compose` |

Prefer Docker's official repo so you get Compose **v2**. Some older setups — e.g.
Debian 12 with the distro's own `docker-compose` package — only ship the legacy
**v1** standalone, where the command is `docker-compose` (with a hyphen). It is
otherwise identical: just swap `docker compose` → `docker-compose` in the steps.

