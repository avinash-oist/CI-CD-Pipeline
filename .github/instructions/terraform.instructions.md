---
# .github/instructions/terraform.instructions.md
# ============================================================
# TOPIC: Terraform best practices for this project
# TOGGLE: Use `/instructions` in Copilot CLI to enable/disable
# APPLIES TO: All *.tf files and terraform/ directory work
# ============================================================
applyTo: "terraform/**"
---

# Terraform Instructions

## File Structure (Mandatory for Every Module/Environment)

Every Terraform directory MUST have these files:
```
main.tf        — resource definitions
variables.tf   — input variable declarations  
outputs.tf     — output value declarations
backend.tf     — remote state config (S3 + DynamoDB lock)
versions.tf    — required_providers and terraform version constraint
```

Optionally:
```
locals.tf      — computed/derived values (use instead of repeating expressions)
data.tf        — data source lookups only
```

## Naming Convention

```hcl
# Pattern: <environment>-<project>-<resource-type>-<purpose>
resource "aws_instance" "jenkins" {
  # ...
  tags = {
    Name        = "${var.environment}-ci-cd-pipeline-ec2-jenkins"
    Environment = var.environment
    Project     = "ci-cd-pipeline"
    ManagedBy   = "Terraform"
    CreatedBy   = "Terraform"
  }
}
```

## Variable Types — Always Declare Them

```hcl
variable "instance_type" {
  description = "EC2 instance type. Use t2.micro for Free Tier."
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t3.small"], var.instance_type)
    error_message = "Use a small instance for learning to control costs."
  }
}
```

## Sensitive Variables

```hcl
variable "db_password" {
  description = "Database password — read from environment, never hardcoded"
  type        = string
  sensitive   = true   # marks as sensitive — won't show in plan/apply output
}
```

## State Management

- NEVER store state locally in production — use S3 backend
- ALWAYS enable DynamoDB locking to prevent concurrent applies
- Use separate state files per environment (different S3 key paths)
- NEVER commit *.tfstate or *.tfvars files

## Teaching Checklist

When helping with Terraform tasks, always explain:
1. What the resource does in plain English
2. Which arguments are required vs optional
3. What the `terraform plan` output means before applying
4. How to verify the resource was created correctly in AWS Console
5. How much this will cost (if anything beyond Free Tier)

## Common Pitfalls to Warn About

- Using `latest` AMI without filtering → always pin to a specific AMI or use data source
- Missing `depends_on` when resources have implicit dependencies
- Forgetting to set `prevent_destroy = true` for critical prod resources
- Exposing sensitive outputs without `sensitive = true`
- Running `terraform destroy` in prod by accident → always confirm environment
