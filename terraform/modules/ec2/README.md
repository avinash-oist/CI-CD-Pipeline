# terraform/modules/ec2/ — EC2 Instance Module

## Purpose

This module creates an **AWS EC2 instance** (a virtual machine in the cloud) with all the supporting resources it needs:

- The EC2 instance itself
- Security Group (acts as a firewall — controls inbound/outbound traffic)
- Key Pair (SSH key for logging into the server)
- IAM Role + Instance Profile (gives the EC2 permission to call other AWS services without storing credentials on the server)

## Why an IAM Role instead of Access Keys on the server?

This is a **critical security best practice**:

❌ Bad: Store `AWS_ACCESS_KEY_ID` in a file on the server  
✅ Good: Attach an IAM Role to the EC2 — AWS injects temporary credentials automatically

With an IAM Role:
- No long-lived credentials to rotate or leak
- Temporary credentials auto-refresh every hour
- Easy to scope permissions with IAM policies

## Files (coming soon)

| File | What it does |
|------|-------------|
| `main.tf` | `aws_instance`, `aws_security_group`, `aws_key_pair`, `aws_iam_role` |
| `variables.tf` | `instance_type`, `ami_id`, `environment`, `allowed_ssh_cidr`, etc. |
| `outputs.tf` | `public_ip`, `instance_id`, `public_dns` |

## Usage

```hcl
module "jenkins_server" {
  source            = "../../modules/ec2"
  instance_type     = var.instance_type
  environment       = var.environment
  allowed_ssh_cidr  = var.my_ip_cidr    # only YOUR IP can SSH in
  key_name          = var.key_name
}
```

## Security Group Rules We'll Create

| Direction | Protocol | Port | Source | Why |
|-----------|----------|------|--------|-----|
| Inbound | TCP | 22 | Your IP only | SSH access |
| Inbound | TCP | 8080 | Your IP only | Jenkins UI |
| Outbound | All | All | 0.0.0.0/0 | Allow internet access |

> ⚠️ Never open port 22 to `0.0.0.0/0` (the whole internet) in production!
