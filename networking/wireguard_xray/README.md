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
