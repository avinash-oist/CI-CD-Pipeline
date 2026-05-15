# terraform/modules/ — Reusable Terraform Modules

## What is a Terraform Module?

A module is like a **function** in programming — you write it once and reuse it.

Instead of copy-pasting EC2 config into both dev and prod, you write one `ec2` module and call it from both environments with different inputs.

```hcl
# In dev/main.tf
module "web_server" {
  source        = "../../modules/ec2"
  instance_type = "t2.micro"      # cheap for dev
  environment   = "dev"
}

# In prod/main.tf  
module "web_server" {
  source        = "../../modules/ec2"
  instance_type = "t3.medium"     # bigger for prod
  environment   = "prod"
}
```

## Modules in This Project

| Module | Purpose |
|--------|---------|
| `ec2/` | Launch an EC2 instance with security group, key pair, IAM role |

## Module Structure

Each module has:

| File | Purpose |
|------|---------|
| `main.tf` | The actual resources (what gets created) |
| `variables.tf` | Inputs the module accepts |
| `outputs.tf` | Values the module exposes back to caller |

## Public Registry

Terraform also has pre-built community modules at https://registry.terraform.io — we'll use some later!
