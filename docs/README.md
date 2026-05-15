# docs/ — Project Documentation

## What goes here?

Documentation that explains the project — architecture decisions, setup guides, runbooks (how to do common operations), and troubleshooting guides.

## Files We'll Create

| File | Purpose |
|------|---------|
| `architecture.md` | System architecture diagram and component descriptions |
| `setup-guide.md` | Step-by-step guide to set up from scratch |
| `aws-prerequisites.md` | AWS account setup, IAM user/role creation |
| `runbook.md` | How to do common operations (restart Jenkins, apply Terraform, etc.) |

## Documentation Best Practices

- Keep docs **close to the code** (e.g., module READMEs explain the module)
- Update docs **in the same PR as the code change**
- Use **diagrams** — even ASCII art helps
- Document **why**, not just **what** — code explains what, docs explain why

## Architecture Overview (Preview)

```
┌─────────────────────────────────────────┐
│                  AWS                     │
│                                         │
│  ┌──────────┐      ┌─────────────────┐  │
│  │  GitHub  │─────▶│  EC2 (Jenkins)  │  │
│  └──────────┘      └────────┬────────┘  │
│       │                     │           │
│       │ GitHub Actions       │ deploys   │
│       ▼                     ▼           │
│  ┌──────────┐      ┌─────────────────┐  │
│  │ Terraform│─────▶│   App Server    │  │
│  └──────────┘      └─────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```
