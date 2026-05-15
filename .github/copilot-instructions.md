# GitHub Copilot Instructions — CI/CD Learning Project
# ============================================================
# FILE: .github/copilot-instructions.md
# SCOPE: REPO-LEVEL — this project only
# COMMIT: ✅ YES — shared with all contributors
# READ BY: GitHub Copilot CLI, GitHub Copilot in VS Code
# ============================================================

## About This Project

This is a **learning project** for Avinash to master CI/CD, Terraform, Jenkins, and AWS.

**Primary goal:** Deep understanding through hands-on practice, not just a working system.

For full project context, also read: `CLAUDE.md` and `AGENTS.md` in the repo root.

## How Copilot Should Help

### Teaching Mode (Always On)
Before writing any code or config, briefly explain:
- What the tool/concept is
- Why this specific approach (not just "this is one way to do it")
- What could go wrong and how to avoid it
- What the learner should explore on their own next

### Inline Comments in Code
For this project specifically, add teaching comments in all new code:
```hcl
# resource "aws_instance" creates a virtual machine (EC2) in AWS
# The AMI (ami-xxx) is the OS image — like an ISO file for a VM
resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type  # t2.micro = 1 vCPU, 1GB RAM, Free Tier eligible
}
```

## Hard Rules

### ❌ NEVER DO THESE:
1. Add "Co-authored-by" or any trailer to git commits
2. Suggest committing: .env, *.tfvars, *.pem, *.key, passwords, tokens, API keys
3. Hardcode AWS region, account ID, or credentials in any file
4. Open security groups to `0.0.0.0/0` on port 22 (SSH)
5. Use `terraform apply` without first explaining what will be created/changed/destroyed
6. Create AWS resources without cost-awareness warning for anything beyond Free Tier

### ✅ ALWAYS DO THESE:
1. Use variables for anything environment-specific (region, instance type, etc.)
2. Tag every AWS resource: `Environment`, `Project = "ci-cd-pipeline"`, `ManagedBy = "Terraform"`
3. Remind to run `terraform destroy` after each learning session
4. Prefer IAM Roles over Access Keys for any service-to-service auth
5. Validate `.gitignore` covers new sensitive file types before suggesting their creation
6. Use `.env.example` pattern — template committed, real values gitignored

## Terraform Conventions for This Project

```hcl
# Every resource block should have these tags
tags = {
  Name        = "${var.environment}-resource-name"
  Environment = var.environment        # dev | prod
  Project     = "ci-cd-pipeline"
  ManagedBy   = "Terraform"
}
```

## AWS Region

Use the region from the `AWS_REGION` environment variable or `var.aws_region`.
Default to `ap-south-1` (Mumbai) unless explicitly configured otherwise.

## Git Commit Style

Format: `<type>: <short description>`  
Types: `feat`, `fix`, `docs`, `refactor`, `chore`, `security`  
Example: `feat: add EC2 module with security group`  
NO trailing Co-authored-by lines. Ever.
