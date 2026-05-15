# AGENTS.md — AI Agent Instructions
# ============================================================
# FILE: AGENTS.md (repo root)
# SCOPE: REPO-LEVEL — this project only
# COMMIT: ✅ YES
# READ BY: Copilot CLI, OpenAI Codex agents, general AI agents
# ============================================================
# Note: CLAUDE.md has deeper project context. Read both.
# ============================================================

## Project Identity

**Name:** ci-cd-pipeline  
**Type:** Learning project — NOT production  
**Owner:** Avinash Singh  
**Purpose:** Learn Terraform, Jenkins, AWS, GitHub Actions, CI/CD, AI tooling end-to-end

## Agent Behaviour Rules

### 1. Teach, Don't Just Do
This is a learning project. Every time an agent completes a task, it should briefly
explain what was done and why. Mention best practices. The learner values understanding
over speed.

### 2. Security Hardcoded Rules
- NEVER write or suggest any command/code that would commit secrets to git
- NEVER create .env files with real values (only .env.example templates)
- NEVER open security groups to 0.0.0.0/0 except for ports explicitly requested
- ALWAYS prefer IAM Roles over long-lived Access Keys
- NEVER add "Co-authored-by" trailers to git commits

### 3. Infrastructure Changes
- Before ANY `terraform apply` or destructive operation: explain what will happen
- Always show `terraform plan` output interpretation before applying
- Remind to run `terraform destroy` after learning sessions (cost saving)
- Tag every AWS resource with: `Environment`, `Project`, `ManagedBy = "Terraform"`

### 4. Step-by-Step Preference
The learner prefers:
1. Concept explanation first
2. Show the code/command
3. Explain each part of the code
4. Run it
5. Verify it worked
6. Explain what to learn next

### 5. File Conventions
- Shell scripts: `#!/bin/bash` + `set -euo pipefail`
- Terraform files: always have `main.tf`, `variables.tf`, `outputs.tf`
- Git commits: imperative mood, present tense, no trailers

## What This Repo Does

Builds a full CI/CD pipeline step by step:
```
GitHub Push → GitHub Actions → Terraform → AWS EC2 → Jenkins → Deploy App
```

## Current Tech Stack
- Terraform ~1.x with AWS provider ~5.x
- AWS (EC2, VPC, IAM, S3, Security Groups)
- Jenkins LTS (installed on EC2 via scripts)
- GitHub Actions
- Amazon Linux 2023 (on EC2)
- Windows PowerShell (local dev machine)

## Working Directory Conventions

| Task | Directory |
|------|-----------|
| AWS infrastructure | `terraform/environments/dev/` or `prod/` |
| Reusable IaC blocks | `terraform/modules/` |
| CI pipeline logic | `jenkins/pipelines/` |
| Server config scripts | `scripts/` |
| GitHub automation | `.github/workflows/` |
