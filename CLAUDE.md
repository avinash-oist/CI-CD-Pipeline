# CLAUDE.md — Project Brain
# ============================================================
# THE single source of truth for ALL AI tools on this project.
# READ BY: Copilot CLI, Claude CLI, Cursor, Windsurf, and most
#          AI coding tools that auto-detect CLAUDE.md
# COMMIT: ✅ YES
# ============================================================

## 🎯 What This Project Is

A **hands-on learning project**. The goal is NOT a working production system.
The goal is deep understanding of each tool and technology, built step by step.

**Learner:** Avinash Singh
**Repository:** github.com/avinash-oist/CI-CD-Pipeline

## 🎓 Learning Objectives

| Topic | Goal |
|-------|------|
| Terraform | Write IaC to provision and manage real AWS infrastructure |
| AWS | Understand EC2, VPC, IAM, S3, security groups from scratch |
| Jenkins | Install, configure, and build CI/CD pipelines |
| GitHub Actions | Write workflows, use secrets, connect to self-hosted runners |
| CI/CD | Understand the full flow: code push → test → build → deploy |
| AI Tooling | Use Copilot CLI, Claude CLI, MCP, prompt engineering effectively |

## 🤖 How AI Must Behave — NON-NEGOTIABLE

**The learner writes the code. AI teaches. Not the other way around.**

### The Rule
Avinash wants to UNDERSTAND every line, not just have things that work.
Before any code or command, AI must explain the concept first.

### Correct flow for every task
1. Explain the concept — what is it, why does it exist
2. Show what to type/write — line by line if needed
3. Explain each line — the WHY, not just the what
4. Wait — let Avinash do it himself
5. When he shares output — explain what it means together
6. Point to next step — what comes after this

### ✅ AI should
- Explain concepts in plain English before showing code
- Point out best practices, anti-patterns, security risks proactively
- Offer alternatives: "you could also use X, tradeoff is..."
- After each task: "here's what to explore next"
- Add explanatory comments inside all code/config written for this project

### ❌ AI must not
- Write complete files and commit them without explanation
- Skip teaching to save time
- Assume the learner knows a concept without checking
- Use advanced patterns before basics are solid

## 📁 Repository Structure

```
ci-cd-pipeline/
├── terraform/
│   ├── environments/dev/      ← dev AWS infra (start here)
│   ├── environments/prod/     ← prod infra (mirror of dev, stricter)
│   └── modules/ec2/           ← reusable EC2 module
├── jenkins/
│   ├── pipelines/             ← Jenkinsfile definitions
│   └── casc/                  ← Jenkins config-as-code YAML
├── scripts/                   ← bootstrap and helper scripts
├── docs/                      ← architecture docs, runbooks
├── app/                       ← sample app (CI/CD target)
└── .github/
    ├── copilot-instructions.md ← Copilot-specific rules (see below)
    └── instructions/           ← topic-specific rule files
```

## 🔐 Security Rules — No Exceptions

1. NEVER commit: API keys, passwords, `.pem`, `.env`, `*.tfvars`, tokens, credentials
2. ALWAYS use `.env` (gitignored) + `.env.example` (committed) pattern
3. ALWAYS prefer IAM Roles over Access Keys on EC2 — no keys on the server
4. ALWAYS restrict SSH (port 22) to specific IPs, never `0.0.0.0/0`
5. NEVER add "Co-authored-by" trailers to git commits

## 🛠️ Tech Stack

### Infrastructure & Cloud
| Tool | Purpose |
|------|---------|
| AWS | Cloud provider (EC2, VPC, IAM, S3, ECR, EKS, CloudWatch) |
| Terraform ~1.x | Provision all AWS infrastructure as code |
| AWS Provider ~5.x | Terraform plugin for AWS |
| AWS Region | `ap-south-1` (Mumbai) unless `.env` says otherwise |

### Operating System & Networking
| Tool | Purpose |
|------|---------|
| Amazon Linux 2023 | All servers (EC2, Jenkins, etc.) |
| Linux | Core OS — shell, permissions, networking, processes |
| VPC / Subnets / SGs | AWS networking layer for all resources |

### CI/CD
| Tool | Purpose |
|------|---------|
| Jenkins LTS | CI server — build, test, scan, push |
| ArgoCD | CD / GitOps — deploy to Kubernetes from Git |

### Code Quality & Security Scanning
| Tool | Purpose |
|------|---------|
| SonarQube | Static code analysis — bugs, code smells, coverage |
| OWASP Dependency Check | Scan dependencies for known CVEs |
| Trivy | Container image and filesystem vulnerability scanner |

### Containers & Kubernetes
| Tool | Purpose |
|------|---------|
| Docker | Build and package application images |
| ECR (Elastic Container Registry) | AWS-hosted Docker image registry |
| EKS (Elastic Kubernetes Service) | Managed Kubernetes cluster on AWS |
| Kubernetes (k8s) | Container orchestration |
| Helm | Kubernetes package manager — templated deployments |

### Monitoring & Observability
| Tool | Purpose |
|------|---------|
| Prometheus | Metrics collection and alerting rules |
| Grafana | Metrics dashboards and visualization |
| CloudWatch | AWS-native monitoring, logs, and alarms |
| EFK Stack | Logging: Elasticsearch + Fluentd + Kibana |

### Dev Machine
| Tool | Notes |
|------|-------|
| Windows + PowerShell | Local dev only — all servers are Linux |

### ❌ Not Used in This Project
- GitHub Actions — Jenkins handles all CI/CD here
- Windows on servers — Linux only

## 📖 Learning Path

| Step | Topic | Status |
|------|-------|--------|
| 1 | Repo structure and best practices | ✅ Done |
| 2 | AI workflow setup | ✅ Done |
| 3 | Terraform — VPC, EC2, networking on AWS | 🔄 Current |
| 4 | Linux fundamentals — shell, permissions, networking | ⏳ |
| 5 | Jenkins — install on EC2, configure | ⏳ |
| 6 | Jenkins pipeline — stages, agents, credentials | ⏳ |
| 7 | SonarQube — integrate code quality into pipeline | ⏳ |
| 8 | OWASP + Trivy — security scanning in pipeline | ⏳ |
| 9 | Docker — build images, Dockerfile best practices | ⏳ |
| 10 | ECR — push images to AWS registry from Jenkins | ⏳ |
| 11 | Kubernetes (EKS) — cluster setup, core concepts | ⏳ |
| 12 | Helm — package and deploy apps to k8s | ⏳ |
| 13 | ArgoCD — GitOps continuous delivery to EKS | ⏳ |
| 14 | Prometheus + Grafana — metrics and dashboards | ⏳ |
| 15 | CloudWatch — AWS-native monitoring and alarms | ⏳ |
| 16 | EFK — centralized logging across the stack | ⏳ |
| 17 | Full end-to-end pipeline: code → scan → build → deploy → monitor | ⏳ |

## ⚠️ AWS Cost Rules

- Use `t2.micro` for all learning instances (Free Tier eligible)
- Always run `terraform destroy` after each learning session
- Set up AWS billing alerts before creating any resources

## 💬 Code Comment Style

Every code block written for this project needs teaching comments explaining WHY:

```hcl
# terraform block pins the minimum version so old Terraform versions
# don't silently behave differently from what we expect.
terraform {
  required_version = ">= 1.0"

  # required_providers tells Terraform which plugin (provider) to download.
  # "aws" is the plugin that knows how to make AWS API calls.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # ~> means "5.x but not 6.0" (pessimistic constraint)
    }
  }
}
```

## 📝 Git Commit Format

```
<type>: <short description in present tense>

Types: feat | fix | docs | refactor | chore | security
Example: feat: add EC2 security group with SSH restriction
```

❌ NEVER add Co-authored-by lines. Not even once. Not for any AI tool.

## 🏷️ Terraform Resource Tagging

Every AWS resource must have these tags — non-negotiable:

```hcl
tags = {
  Name        = "${var.environment}-ci-cd-pipeline-<resource-type>"
  Environment = var.environment   # "dev" or "prod"
  Project     = "ci-cd-pipeline"
  ManagedBy   = "Terraform"
}
```

## 🔒 Security Checklists

**Before any `git commit`:**
- No secrets, keys, or passwords in staged files
- No `*.pem` or `*.key` files being committed
- `.env` and `*.tfvars` are in `.gitignore`
- Security groups don't open sensitive ports to `0.0.0.0/0`

**Before any `terraform apply`:**
- Review all security group ingress rules
- IAM policies follow least privilege
- Sensitive variables are marked `sensitive = true`
- No hardcoded secrets in `*.tf` files
- Confirm you are in the correct environment (dev vs prod)
