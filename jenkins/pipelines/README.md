# jenkins/pipelines/ — Jenkinsfile Definitions

## What goes here?

Every Jenkins pipeline is defined in a **Jenkinsfile**. This directory holds all pipeline definitions for this project.

## Best Practice: Jenkinsfile in the repo

The Jenkinsfile lives in the **same Git repo as the code it builds**. This means:
- Pipeline changes are code-reviewed just like application changes
- You can see the history of pipeline changes
- Anyone cloning the repo has the full pipeline definition

## Pipelines We'll Build

| File | Purpose |
|------|---------|
| `Jenkinsfile.infra` | Pipeline to run `terraform plan` / `terraform apply` |
| `Jenkinsfile.app` | Pipeline to build, test, and deploy the application |

## Coming Soon

We'll write these Jenkinsfiles after Jenkins is running on EC2.
