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

| Tool | Notes |
|------|-------|
| Terraform | ~1.x |
| AWS Provider | ~5.x |
| AWS Region | `ap-south-1` (Mumbai) unless `.env` says otherwise |
| Jenkins | Latest LTS, installed on EC2 |
| OS — dev machine | Windows, PowerShell |
| OS — servers | Amazon Linux 2023 |

## 📖 Learning Progress

1. ✅ Repo structure and best practices
2. ✅ AI workflow setup (CLAUDE.md, instructions, global config)
3. 🔄 Terraform — launch an EC2 on AWS  ← CURRENT
4. ⏳ Install Jenkins on EC2
5. ⏳ Build a Jenkins pipeline
6. ⏳ GitHub Actions workflow
7. ⏳ Full end-to-end pipeline

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
