# Monitoring Stack: Prometheus + Grafana + Node Exporter + cAdvisor

<p align="center">
  <img src="../../assets/grafana.svg" width="180">
</p>

<br>

<p align="center">
  <img src="../../assets/prometheus.svg" width="180">
</p>

<br>

<p align="center">
  <img src="../../assets/cadvisor.png" width="180">
</p>

<br>




This directory contains an example monitoring stack deployed with
Docker Compose.

The stack includes:

- Prometheus for metrics collection
- Grafana for visualization
- Node Exporter for host system metrics
- cAdvisor for container metrics

All services are connected through a shared Docker network.

---

## Components

### Prometheus

Official image:
https://hub.docker.com/r/prom/prometheus

Prometheus collects metrics from configured targets using a pull model.

Metrics sources in this setup:

- Node Exporter (host metrics)
- cAdvisor (container metrics)

---

### Grafana

Official image:
https://hub.docker.com/r/grafana/grafana

Grafana provides dashboards and visualization for metrics stored in
Prometheus.

After deployment Grafana is accessible on:

http://localhost:3000

Default credentials:

admin / admin

---

### Node Exporter

Official image:
https://hub.docker.com/r/prom/node-exporter

Node Exporter exposes hardware and operating system metrics such as:

- CPU usage
- memory
- disk usage
- network activity

---

### cAdvisor

Official image:
https://github.com/google/cadvisor

cAdvisor provides container-level metrics including:

- container CPU usage
- memory consumption
- filesystem usage
- network activity

---

## Network

All services are attached to an external Docker network.

Create the network before deployment:

docker network create monitoring_network

---

## Deployment

Start the monitoring stack:

docker compose up -d

Check running services:

docker compose ps

View logs:

docker compose logs

---

## What This Demonstrates

This setup demonstrates a common DevOps monitoring architecture including:

- host metrics collection
- container metrics monitoring
- centralized metrics storage
- dashboard visualization
- containerized monitoring infrastructure

---

## Thanks

Thanks to the maintainers of Prometheus, Grafana,
Node Exporter and cAdvisor for providing powerful open-source
monitoring tools widely used in modern infrastructure.
