# scripts/ — Utility & Automation Scripts

## What goes here?

Shell scripts and Python scripts that help with setup, maintenance, and automation tasks that don't belong in Terraform or Jenkins pipelines.

## Scripts We'll Create

| Script | Language | Purpose |
|--------|----------|---------|
| `bootstrap.sh` | Bash | One-time local setup: check prerequisites, create S3 backend bucket |
| `install-jenkins.sh` | Bash | Install Jenkins on EC2 (used as EC2 user-data script) |
| `rotate-keys.sh` | Bash | Remind/help rotate AWS access keys |

## Script Best Practices

1. **Shebang line** always at top: `#!/bin/bash`
2. **`set -euo pipefail`** — fail fast on errors
3. **Never hardcode secrets** — read from env vars or AWS Secrets Manager
4. **Add `--dry-run` flags** where destructive operations are possible
5. **Log what you're doing**: `echo "[INFO] Installing Jenkins..."`

## Example Pattern

```bash
#!/bin/bash
set -euo pipefail

# Read secrets from environment, never hardcode
AWS_REGION="${AWS_REGION:?ERROR: AWS_REGION is not set}"

echo "[INFO] Using region: $AWS_REGION"
```

The `:?` syntax means: "if this variable is empty, print the error message and exit" — a safe guard against running with missing config.
