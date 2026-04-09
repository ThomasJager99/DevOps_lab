# VPN & Proxy Infrastructure (AWS + Hetzner)

<p align="center">
  <img src="../../assets/wireguard.svg" width="180">
</p>

This section documents deployment of secure tunneling solutions using:

- WireGuard VPN
- Xray (VLESS)

Two providers were used:

- AWS (multi-stage setup: WireGuard → Xray)
- Hetzner (clean Xray deployment)

---

## Update: Logging, Routing and User Management

The configuration has been updated with additional control and observability features.

### Changes

- Added access and error logging:
  - `/var/log/xray/access.log`
  - `/var/log/xray/error.log`
- Configured log rotation using system logrotate
- Added `email` field for users to identify connections in logs
- Implemented BitTorrent traffic blocking via routing rules
- Forced IPv4 routing (`UseIPv4`)
- Added automation script for user creation using `jq`

### Logrotate

Logs are rotated daily with compression to prevent disk overflow.

### Automation

User creation is automated via a script that:
- Generates UUID
- Updates JSON config using `jq`
- Restarts Xray
- Generates connection link

### Note about jq

`jq` is used to safely modify JSON configuration without breaking structure.

## ⚠️ Privacy Notice

This setup includes logging and user identification (via `email` field).

This is NOT recommended for production VPN services focused on privacy.

Logging and user tracking were implemented strictly for learning and debugging purposes.

--
## Update: Routing & Traffic Control

Updated Xray configuration with basic traffic control and routing improvements.

Changes:
- Added IPv4-only routing (`domainStrategy: UseIPv4`)
- Implemented `blackhole` outbound for blocked traffic
- Added routing rule to block BitTorrent protocol

This helps prevent unwanted traffic (e.g. torrents) and improves control over outbound connections.

---

## Overview

The infrastructure includes:

- WireGuard VPN server (initial setup)
- Xray protocol server (VLESS over TCP)
- NAT (iptables masquerading)
- IPv4 routing enabled
- IPv6 disabled
- Persistent firewall rules

---

## Components

| Component | Purpose |
|----------|--------|
| WireGuard | VPN tunnel |
| Xray | Proxy protocol |
| iptables | NAT / routing |
| iptables-persistent | rule persistence |
| sysctl | kernel networking |

---

## Providers

### AWS
- Initial WireGuard deployment
- Migration to Xray

### Hetzner
- Clean Xray deployment

---

## Notes

- IPv6 disabled for simplicity
- NAT enabled for outbound traffic
- Configs are provided as examples (no secrets)

---

## Security

- All secrets removed
- UUID and keys must be generated manually
- Do not reuse example configs in production
