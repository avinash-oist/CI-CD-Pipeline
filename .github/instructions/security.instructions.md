---
# .github/instructions/security.instructions.md
# ============================================================
# TOPIC: Security rules — always active for this project
# TOGGLE: This should ALWAYS be enabled
# ============================================================
applyTo: "**"
---

# Security Instructions — Always Active

## The Golden Rules (No Exceptions)

### Rule 1: Nothing Sensitive Goes to Git. Ever.
These file types/patterns MUST be in .gitignore and NEVER committed:
- `.env` (but `.env.example` ✅ is fine)
- `*.tfvars` (but `*.tfvars.example` ✅ is fine)
- `*.pem`, `*.key`, `*.p12`, `*.pfx` — private keys of any kind
- `*credentials*`, `*secret*`, `*password*` — any file with these names
- `~/.aws/credentials` — should NEVER be copied into the repo
- `*.tfstate`, `*.tfstate.backup` — Terraform state (may contain secrets)

When generating these file types, IMMEDIATELY check they are gitignored.

### Rule 2: Secrets Come from Environment Variables
```bash
# ❌ NEVER hardcode
aws_region = "ap-south-1"           # OK — not a secret
aws_access_key = "AKIA..."          # ❌ NEVER hardcode!
db_password = "mypassword123"       # ❌ NEVER hardcode!

# ✅ ALWAYS read from environment
aws_access_key = os.environ["AWS_ACCESS_KEY_ID"]
```

### Rule 3: IAM Roles Over Access Keys on EC2
```
❌ Bad: Install AWS CLI on EC2 + paste access keys in ~/.aws/credentials
✅ Good: Attach IAM Role to EC2 → AWS SDK auto-discovers credentials
```

### Rule 4: Least Privilege
- Every IAM policy should grant ONLY what is needed, nothing more
- Security groups: only open ports that are actively needed
- SSH (port 22): ONLY from specific IPs, never 0.0.0.0/0

### Rule 5: No Co-authored-by in Commits
Never add "Co-authored-by: Copilot" or any AI Co-authored-by trailer.

## Security Review Checklist

Before any `git commit`, check:
- [ ] No secrets, keys, or passwords in staged files
- [ ] No *.pem or *.key files being committed
- [ ] .env exists in .gitignore
- [ ] *.tfvars exists in .gitignore
- [ ] Security groups don't have 0.0.0.0/0 on sensitive ports

Before any `terraform apply`, check:
- [ ] Review security group ingress rules
- [ ] IAM policies follow least privilege
- [ ] Sensitive variables are marked `sensitive = true`
- [ ] No hardcoded secrets in *.tf files

## What to Use Instead of Hardcoded Secrets

| Scenario | Solution |
|----------|---------|
| Local dev credentials | `.env` file (gitignored) + `.env.example` |
| Terraform variables | `terraform.tfvars` (gitignored) + `.tfvars.example` |
| EC2 accessing AWS | IAM Role attached to EC2 (no keys needed!) |
| Jenkins credentials | Jenkins Credentials Store (never in Jenkinsfile) |
| GitHub Actions secrets | GitHub Secrets → Settings → Secrets |
| Production secrets | AWS Secrets Manager or Parameter Store |
