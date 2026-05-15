# CLAUDE.md — Project AI Context
# ============================================================
# FILE: CLAUDE.md  (repo root)
# SCOPE: REPO-LEVEL — applies to this project only
# COMMIT: ✅ YES — shared context for all AI tools & teammates
# READ BY: Copilot CLI, Claude CLI, many AI coding tools
# ============================================================

## 🎯 Project Purpose

This is a **hands-on learning project**. The goal is NOT to have a production system
running — the goal is to deeply understand how each tool and technology works.

**Learner:** Avinash Singh
**Learning Objectives:**
- Terraform: provision and manage AWS infrastructure with IaC
- AWS: EC2, VPC, IAM, S3, security groups, and core services
- Jenkins: set up CI/CD pipelines, understand agents, pipelines, credentials
- GitHub Actions: workflows, runners, secrets, reusable actions
- CI/CD: end-to-end pipeline from git push to deployment
- AI Tooling: GitHub Copilot CLI, Claude CLI, MCP, prompt engineering

## 🤖 How AI Should Assist This Project

**This is critical. Read carefully.**

The learner wants to UNDERSTAND, not just get code that works.

### ✅ AI SHOULD:
- Explain concepts BEFORE writing code ("here's what a security group is and why...")
- Teach best practices at every step
- Point out what NOT to do and why (anti-patterns, security risks)
- Explain AWS/Terraform/Jenkins concepts in plain language first
- Show the "why" behind every decision
- Suggest "what to try next" or "what to learn after this"
- When writing Terraform/scripts, add comments that explain each resource/block
- Point out alternatives when they exist ("you could also use X, here's the tradeoff")

### ❌ AI SHOULD NOT:
- Just dump complete solutions without explanation
- Skip teaching the concept to save time
- Write code so complex the learner can't understand it
- Use advanced features before the basics are solid

### Example of what the learner wants:
**Bad:** "Here's the complete Terraform EC2 configuration."  (just code, no teaching)
**Good:** "An EC2 instance is AWS's virtual machine service. Here's the minimum config
to launch one. Let me explain each block: `ami` is the OS image (like an ISO),
`instance_type` is the hardware size, `tags` are labels to find it later..."

## 📁 Repository Structure

```
ci-cd-pipeline/
├── terraform/environments/dev/    # Start here for AWS infra
├── terraform/environments/prod/   # Mirror of dev with stricter settings
├── terraform/modules/ec2/         # Reusable EC2 module
├── jenkins/pipelines/             # Jenkinsfile CI/CD definitions
├── jenkins/casc/                  # Jenkins config-as-code YAML
├── scripts/                       # Bootstrap and utility scripts
├── docs/                          # Architecture docs
└── app/                           # Sample app to build/test/deploy
```

## 🔐 Security Rules (Non-Negotiable)

1. **NEVER** suggest committing: API keys, passwords, .pem files, .env files,
   *.tfvars files, AWS credentials, or any secret of any kind
2. **ALWAYS** use .env (gitignored) + .env.example (committed) pattern
3. **ALWAYS** prefer IAM Roles over Access Keys for EC2/services
4. **ALWAYS** lock SSH access to specific IPs, never 0.0.0.0/0 on port 22
5. **NEVER** add "Co-authored-by" trailers to git commits

## 🛠️ Tech Stack

| Tool | Version/Notes |
|------|--------------|
| Terraform | ~1.x |
| AWS Provider | ~5.x |
| Jenkins | Latest LTS |
| AWS Region | Configured in .env |
| OS (dev) | Windows (PowerShell) |
| OS (servers) | Amazon Linux 2023 |

## 📖 Learning Path (Current Stage)

1. ✅ Repo setup and structure  ← DONE
2. ✅ AI workflow setup         ← DONE (this file)
3. 🔄 Terraform: launch EC2     ← NEXT
4. ⏳ Jenkins on EC2
5. ⏳ Jenkins pipeline
6. ⏳ GitHub Actions
7. ⏳ Full end-to-end pipeline

## 🧪 Running / Testing

```bash
# Terraform
cd terraform/environments/dev
terraform init && terraform plan   # preview changes
terraform apply                    # apply (creates AWS resources)
terraform destroy                  # clean up (save costs!)

# Always destroy dev resources when done practicing
```

## ⚠️ Cost Awareness

This project uses real AWS resources that cost money.
- Always run `terraform destroy` after each learning session
- Use `t2.micro` (Free Tier eligible) for all learning instances
- Set up AWS billing alerts (docs/aws-prerequisites.md)
