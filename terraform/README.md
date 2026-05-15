# terraform/ — Infrastructure as Code

## What is Terraform?

Terraform is a tool that lets you **describe your cloud infrastructure in code** (`.tf` files). Instead of clicking around the AWS console, you write code and Terraform creates/updates/destroys resources for you.

```
You write .tf files  →  terraform plan  →  terraform apply  →  AWS resources created
```

## Why IaC (Infrastructure as Code)?

| Without IaC | With IaC (Terraform) |
|------------|----------------------|
| Click through AWS console | Write code, run command |
| Hard to reproduce | Repeatable, idempotent |
| No history of changes | Tracked in Git |
| Easy to make mistakes | Peer-reviewed via PRs |
| Hard to share with team | Everyone uses same code |

## Directory Structure

```
terraform/
├── environments/          # Environment-specific settings
│   ├── dev/               # Dev: smaller/cheaper instances, relaxed rules
│   └── prod/              # Prod: larger instances, strict rules, backups
└── modules/               # Reusable building blocks
    └── ec2/               # Module: "give me an EC2 instance"
```

## Key Files in Each Environment

| File | Purpose |
|------|---------|
| `main.tf` | What resources to create (calls modules) |
| `variables.tf` | What inputs this config accepts |
| `outputs.tf` | What info to display after apply (e.g., server IP) |
| `backend.tf` | Where to store the Terraform state file (S3) |
| `terraform.tfvars.example` | ✅ Example variable values — SAFE to commit |
| `terraform.tfvars` | ❌ Real variable values — GITIGNORED |

## Key Concepts

- **Provider**: Plugin that talks to a cloud (e.g., `hashicorp/aws`)
- **Resource**: A thing to create (e.g., `aws_instance`, `aws_vpc`)
- **Module**: A reusable group of resources
- **State**: Terraform's memory of what it has created (stored in S3)
- **Plan**: Preview of what will change (`terraform plan`)
- **Apply**: Actually make the changes (`terraform apply`)
- **Destroy**: Delete everything (`terraform destroy`)

## State File Warning ⚠️

The `.tfstate` file is **GITIGNORED** for a reason:
- It contains real resource IDs
- It can contain secrets (database passwords, etc.)
- We store it remotely in **S3** with locking via **DynamoDB**

## Getting Started

```bash
cd terraform/environments/dev
terraform init      # download providers, set up backend
terraform plan      # preview changes
terraform apply     # create resources
terraform destroy   # clean up (saves AWS costs!)
```
