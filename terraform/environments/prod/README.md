# terraform/environments/prod/ — Production Environment

## Purpose

This is the **production** environment. Real users hit this. Extra caution required.

## Rules for prod

1. **Always run `terraform plan` and review before `terraform apply`**
2. **Never apply directly from your laptop** — only via CI/CD pipeline
3. **Enable deletion protection** on all critical resources
4. **Use separate AWS account** for prod (best practice — we'll keep it one account for learning)
5. **Enable CloudTrail** to audit all API calls

## Files (same structure as dev, different variable values)

| File | What it does |
|------|-------------|
| `main.tf` | Same module calls as dev, but with prod-grade settings |
| `variables.tf` | Variable definitions |
| `outputs.tf` | Output values after apply |
| `backend.tf` | S3 state backend (different bucket/key from dev) |
| `terraform.tfvars.example` | Example values — commit this |
| `terraform.tfvars` | Real prod values — DO NOT commit |

## Note for Learning

We'll build dev first. Prod will mirror dev with stricter settings. In a real team, prod changes only go through:

```
PR → Code Review → CI tests → Manual approval → terraform apply
```
