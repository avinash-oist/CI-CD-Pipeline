# terraform/environments/dev/ — Development Environment

## Purpose

This directory holds the Terraform configuration for the **dev (development)** environment. It is where you experiment, break things, and learn — without affecting production.

## Dev vs Prod

| Setting | Dev | Prod |
|---------|-----|------|
| EC2 instance type | `t2.micro` (Free Tier) | `t3.medium` or larger |
| Auto-backups | Off | On |
| Multi-AZ | No | Yes |
| Deletion protection | Off | On |
| Cost | Minimal | Higher |

## Files (we'll create these next)

| File | What it does |
|------|-------------|
| `main.tf` | Calls the `ec2` module to create the VM |
| `variables.tf` | Defines what inputs are needed (region, instance type, etc.) |
| `outputs.tf` | Prints the EC2 public IP after `terraform apply` |
| `backend.tf` | Tells Terraform to store state in S3 |
| `terraform.tfvars.example` | Example values — commit this |
| `terraform.tfvars` | Your real values — DO NOT commit |

## Commands

```bash
# From this directory:
terraform init     # First time only — downloads AWS provider
terraform plan     # See what will be created/changed/destroyed
terraform apply    # Create the infra
terraform destroy  # Delete everything (do this after learning to save $)
```

## Cost Tip 💡

Always run `terraform destroy` when done practicing. A `t2.micro` EC2 costs ~$0.012/hour. Left running for a month = ~$9. Small, but adds up.
