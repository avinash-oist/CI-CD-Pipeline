---
applyTo: "**"
---
# Observability Instructions (Prometheus, Grafana, CloudWatch, EFK)

## The three pillars of observability

```
Metrics  → numbers over time (CPU %, request rate, error rate) → Prometheus + Grafana
Logs     → text events from applications and infrastructure    → EFK stack
Traces   → request flow through distributed services           → (future: Jaeger/OTEL)
```

## Teaching rule
When introducing any observability tool, explain:
1. Which pillar it addresses (metrics / logs / traces)
2. What component generates the data (app? OS? k8s?)
3. How to read a basic dashboard or query

## Prometheus + Grafana
- Prometheus **scrapes** metrics from targets (pull model, not push)
- Every service exposes a `/metrics` endpoint — Prometheus polls it
- Grafana queries Prometheus and visualizes the data
- Alert rules live in Prometheus — Grafana is visualization only

## CloudWatch
- AWS-native — automatically collects EC2, EKS, and service metrics
- Use for AWS-specific alerting (billing, service health, EC2 CPU)
- Not a replacement for Prometheus — use both: CloudWatch for AWS infra, Prometheus for app metrics

## EFK Stack (Elasticsearch + Fluentd + Kibana)
```
App/k8s pods → Fluentd (collect + ship logs) → Elasticsearch (store + index) → Kibana (search + visualize)
```
- Fluentd runs as a DaemonSet on every k8s node — collects all pod logs automatically
- Never log secrets, passwords, or PII — logs are searchable by everyone with Kibana access
