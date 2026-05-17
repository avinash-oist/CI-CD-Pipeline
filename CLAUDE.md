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

## 💰 AWS Cost Rules — Free Tier Only

### Hard Rules — No Exceptions
1. **This project runs 100% on AWS Free Tier. No exceptions.**
2. **Before using ANY service not listed below as Free Tier safe, STOP and ask Avinash first.**
   - This applies even when yolo/auto-approve mode is active.
   - If unsure whether something costs money — ASK. Do not assume.
3. Always proactively flag cost risks BEFORE suggesting a resource or command.
4. When explaining any AWS resource, always state: what the Free Tier limit is, what charges kick in if exceeded, and any hidden costs (e.g., EBS, NAT Gateway, data transfer).

### AWS Free Tier Limits (Key Services)

| Service | Free Tier Limit | Resets |
|---------|----------------|--------|
| EC2 t2.micro (or t3.micro) | 750 hours/month | Monthly |
| EBS gp2/gp3 storage | 30 GB/month | Monthly |
| S3 | 5 GB storage, 20K GET, 2K PUT | Monthly |
| Data Transfer OUT | 1 GB/month (after that ~$0.09/GB) | Monthly |
| CloudWatch | 10 metrics, 3 dashboards, 1M API requests | Monthly |
| ECR | 500 MB/month for private repos | Monthly |
| Lambda | 1M requests/month, 400K GB-sec | Monthly |
| SNS | 1M publishes/month | Monthly |
| SQS | 1M requests/month | Monthly |
| VPC | Free (VPC itself, subnets, route tables, IGW) | Always |
| IAM | Free | Always |
| EKS Control Plane | ❌ NOT Free — $0.10/hour (~$72/month) | Hourly |
| NAT Gateway | ❌ NOT Free — $0.045/hour + $0.045/GB | Hourly |
| RDS | 750 hours db.t2.micro/month (12 months only) | Monthly |
| Elastic IP (unattached) | ❌ $0.005/hour if not attached to running instance | Hourly |

### ⚠️ Hidden Cost Nuances — AI Must Always Explain These

**EC2 is not the only cost when you launch an instance:**
- `EC2 t2.micro` → Free (750 hours/month)
- `EBS root volume` (default 8GB gp2) → Free up to 30GB — but CHARGED even if EC2 is STOPPED
- `Elastic IP` → Free when attached to running instance; ~$3.60/month if instance is stopped or IP is unattached
- `Data Transfer` → Free tier 1GB out/month; Jenkins downloading packages = costs data out
- `CloudWatch detailed monitoring` → NOT Free (basic monitoring is free)

**EKS Warning:** EKS control plane alone = $0.10/hour = ~$72/month. This is NOT Free Tier.
- For learning k8s: use `minikube` or `kind` locally first, then EKS only for final integration
- Always `eksctl delete cluster` or `terraform destroy` immediately after EKS learning session

**NAT Gateway Warning:** Required for private subnet → internet. Costs $0.045/hour = ~$32/month.
- For learning: use public subnets only, or use a Bastion host with no NAT Gateway

**S3 buckets:** Storage is cheap but data transfer out to internet is NOT. Never set buckets public.

### ✅ Cost-Saving Best Practices — Always Suggest These

**After every learning session:**
```
terraform destroy   ← MANDATORY — destroys all resources, stops all billing
```

**Before starting:**
- Confirm `terraform state list` shows no leftover resources from previous session
- Check AWS Console → Billing → Cost Explorer for any unexpected charges

**Always recommended (suggest these proactively):**
1. **AWS Budget Alert** — Set $0 threshold alert (any charge triggers email)
   - AWS Console → Billing → Budgets → Create budget → Cost budget → $1/month → alert at 80%
2. **Billing Alarm** — CloudWatch alarm on `EstimatedCharges > $1`
3. **EC2 Auto-Stop script** — Shell script or EventBridge rule to stop EC2 after X hours of inactivity
4. **Terraform destroy workflow** — Always end Terraform sessions with `terraform destroy` and verify with `terraform state list` (should be empty)
5. **Tag all resources** with `Environment = dev` → enables filtering in Cost Explorer
6. **S3 Lifecycle rules** — Auto-delete Terraform state backup versions after 30 days

### 🏭 Learning vs Production Comparison — Always Show This

**Every time a new AWS resource or architecture decision is introduced, AI must show a side-by-side table:**
- Column 1: What we build now (Free Tier / learning constraints)
- Column 2: What production should look like (HA, reliability, stability — cost is secondary)

This is non-negotiable. Avinash needs to be production-ready, not just "it works on free tier" ready.

**Example format to use (adapt per topic):**

| Component | Learning (Free Tier) | Production (Real Company) |
|-----------|---------------------|--------------------------|
| EC2 instance | t2.micro, single AZ | m5.large or c5.xlarge, Multi-AZ |
| EC2 count | 1 instance | Min 2 behind ALB (Auto Scaling Group) |
| EBS volume | gp2, 8GB | gp3, 100GB+, daily snapshots |
| Database | None / SQLite | RDS Multi-AZ, automated backups, read replica |
| Load Balancer | None | ALB (Application Load Balancer) |
| Networking | Public subnet only | Private subnets + NAT Gateway + Bastion/VPN |
| VPC | Single AZ | At least 2 AZs, separate subnets per tier |
| Jenkins | 1 EC2, no backup | Jenkins on EC2 in ASG or EKS, with EFS for persistence |
| k8s | minikube locally | EKS, managed node groups, min 3 nodes across 3 AZs |
| Container Registry | ECR (free 500MB) | ECR with lifecycle policies and replication |
| Monitoring | CloudWatch basic | Prometheus + Grafana + CloudWatch + PagerDuty alerts |
| Logs | None / CloudWatch | EFK stack, log retention policies, alerting |

**Key concepts to explain with each comparison:**
- **HA (High Availability):** Why Multi-AZ? What happens if one AZ goes down?
- **Fault Tolerance:** What fails gracefully vs cascades?
- **Auto Scaling:** Why ASG instead of a fixed instance count?
- **RTO / RPO:** Recovery Time Objective, Recovery Point Objective — what do companies set?
- **Cost implication:** Rough monthly cost of the production setup vs free tier

### 📋 Cost Checklist — Before Every `terraform apply`

- [ ] All instances are `t2.micro` or `t3.micro`
- [ ] No NAT Gateway (use public subnet or Bastion for learning)
- [ ] No EKS control plane (use minikube/kind until the EKS learning step)
- [ ] EBS volumes ≤ 30GB total across all instances
- [ ] No Elastic IPs left unattached
- [ ] AWS Budget Alert already configured
- [ ] You have a plan to `terraform destroy` after this session

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
