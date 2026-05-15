# CI/CD Pipeline — Learning Project

> **Goal:** Learn end-to-end CI/CD using Terraform, Jenkins, AWS, GitHub Actions, and AI-assisted tooling (GitHub Copilot CLI).

---

## 📚 What You're Building

```
GitHub Push → GitHub Actions / Jenkins → Terraform → AWS Infrastructure
```

A fully automated pipeline that:
1. Provisions AWS infrastructure with **Terraform**
2. Installs and configures **Jenkins** on an EC2 VM
3. Runs a **CI/CD pipeline** for a sample application
4. Uses **GitHub Actions** for lightweight automation tasks

---

## 🗂️ Repository Structure

```
ci-cd-pipeline/
│
├── .github/                   # GitHub-specific config
│   └── workflows/             # GitHub Actions workflow YAML files
│       └── README.md
│
├── terraform/                 # Infrastructure as Code (IaC)
│   ├── environments/          # Per-environment variable overrides
│   │   ├── dev/               # Development environment
│   │   └── prod/              # Production environment
│   └── modules/               # Reusable Terraform modules
│       └── ec2/               # Module: launch an EC2 instance
│
├── jenkins/                   # Jenkins configuration
│   ├── pipelines/             # Jenkinsfile pipeline definitions
│   └── casc/                  # Jenkins Configuration as Code (JCasC) YAML
│
├── scripts/                   # Shell/Python helper scripts
│   ├── bootstrap.sh           # First-time setup script
│   └── README.md
│
├── docs/                      # Project documentation
│   ├── architecture.md        # Architecture diagrams & decisions
│   └── setup-guide.md         # Step-by-step setup guide
│
├── app/                       # Sample application (pipeline target)
│
├── .env.example               # ✅ Template env file — SAFE to commit
├── .env                       # ❌ Real secrets — GITIGNORED, never commit
├── .gitignore                 # What Git should ignore
└── README.md                  # This file
```

---

## 🔐 Security Best Practices (IMPORTANT)

| Rule | Why |
|------|-----|
| Never commit `.env` | Contains real secrets |
| Never commit `*.tfvars` | May contain AWS keys, passwords |
| Never commit `*.pem` or `*.key` | SSH private keys = full server access |
| Never commit `.terraform/` | Contains downloaded binaries |
| Never commit `*.tfstate` | Contains real resource IDs and sometimes secrets |
| Use `.env.example` | Documents needed vars without exposing values |
| Use IAM roles on EC2 | Avoids storing AWS keys on the server at all |

---

## 🚀 Quick Start

### Prerequisites
- AWS CLI installed and configured (`aws configure`)
- Terraform installed (`terraform -version`)
- Git
- GitHub Copilot CLI (you're using it!)

### Setup

```bash
# 1. Clone the repo
git clone https://github.com/avinash-oist/ci-cd-pipeline.git
cd ci-cd-pipeline

# 2. Copy environment template and fill in real values
cp .env.example .env
# Edit .env with your real AWS credentials, region, etc.

# 3. Initialize Terraform (coming soon)
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

---

## 📖 Learning Path

| Step | Topic | Directory |
|------|-------|-----------|
| 1 | Repo setup & best practices | `/` (root) |
| 2 | Provision EC2 with Terraform | `terraform/` |
| 3 | Install Jenkins on EC2 | `scripts/` + `jenkins/` |
| 4 | Create a Jenkins pipeline | `jenkins/pipelines/` |
| 5 | Add GitHub Actions | `.github/workflows/` |
| 6 | Connect GitHub → Jenkins | `jenkins/` |
| 7 | Full end-to-end pipeline | All of the above |

---

## 🤖 AI & Copilot CLI

This project uses GitHub Copilot CLI for:
- Scaffolding infrastructure code
- Explaining concepts as we build
- Code review and suggestions

---

## 📝 Notes

- This is a **learning project** — comments are intentionally verbose
- Each directory has its own `README.md` explaining what belongs there
- Questions? Open an issue or ask Copilot CLI!
