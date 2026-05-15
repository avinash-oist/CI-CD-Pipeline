# .github/workflows/ — GitHub Actions Workflows

## What is this?

GitHub Actions is GitHub's **built-in CI/CD system**. Workflows are YAML files placed here that run automatically on events like a `git push` or pull request.

## When does a workflow run?

```yaml
on:
  push:
    branches: [main]        # runs on every push to main
  pull_request:             # runs on every PR
  workflow_dispatch:        # allows manual trigger from GitHub UI
```

## What will we put here?

| File | Purpose |
|------|---------|
| `terraform-plan.yml` | Run `terraform plan` on every PR to preview infra changes |
| `terraform-apply.yml` | Run `terraform apply` when PR merges to main |
| `lint.yml` | Lint and validate code |

## Key Concepts

- **Workflow** = the YAML file (the whole automation)
- **Job** = a group of steps that runs on a virtual machine (runner)
- **Step** = a single command or action within a job
- **Action** = a reusable unit (e.g., `actions/checkout@v4`)
- **Runner** = the machine that runs the job (GitHub-hosted or self-hosted)
- **Self-hosted runner** = your EC2 instance running jobs! (we'll set this up)

## Secrets in GitHub Actions

Never hardcode secrets! Store them in:
> GitHub repo → Settings → Secrets and variables → Actions

Then use them like:
```yaml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
```
