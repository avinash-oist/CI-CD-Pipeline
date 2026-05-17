---
applyTo: "**"
---
# Kubernetes / EKS / Helm / ArgoCD Instructions

## Teaching checklist for k8s tasks
1. Explain the k8s object (Pod / Deployment / Service / Ingress) before writing YAML
2. Explain WHY this field exists — what happens without it?
3. Show how to verify with `kubectl get` or `kubectl describe`

## Core objects to always explain when first introduced
- **Pod** — smallest deployable unit, one or more containers
- **Deployment** — manages Pod replicas and rolling updates
- **Service** — stable network endpoint to reach Pods
- **Namespace** — logical isolation within a cluster
- **ConfigMap / Secret** — config and sensitive values outside the image

## Helm conventions for this project
- One Helm chart per application under `helm/<app-name>/`
- Always use `values.yaml` for defaults, `values-dev.yaml` / `values-prod.yaml` for overrides
- Never hardcode image tags — always use a variable: `image.tag`

## ArgoCD / GitOps rule
ArgoCD watches the Git repo and deploys what it sees in Git. This means:
- NEVER run `kubectl apply` manually in prod — change the Git repo, ArgoCD applies it
- This is called GitOps: Git is the single source of truth for cluster state

## Security rules for k8s
- Never run containers as root — set `securityContext.runAsNonRoot: true`
- Always set resource limits (CPU + memory) — no unlimited containers
- Use Kubernetes Secrets for sensitive values — never put secrets in ConfigMaps
