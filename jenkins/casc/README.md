# jenkins/casc/ — Jenkins Configuration as Code (JCasC)

## What is JCasC?

Normally you configure Jenkins by clicking through the UI. **JCasC** lets you define that same configuration in a **YAML file** — so it's versioned, reproducible, and automated.

## Why JCasC?

| Without JCasC | With JCasC |
|--------------|-----------|
| Click through Jenkins UI | YAML file in Git |
| Hard to reproduce | `docker run` + YAML = identical Jenkins |
| Config lost if server dies | Stored in Git, always recoverable |
| Slow to set up new environments | Automated, seconds |

## What We'll Configure Here

- Admin user setup (credentials from env vars, not hardcoded!)
- GitHub integration
- Plugin list
- Agent/node configuration
- Security settings

## Example (coming soon)

```yaml
# jenkins/casc/jenkins.yaml
jenkins:
  systemMessage: "CI/CD Learning Pipeline - Managed by JCasC"
  securityRealm:
    local:
      allowsSignup: false
      users:
        - id: "${JENKINS_ADMIN_USER}"     # from environment variable
          password: "${JENKINS_ADMIN_PASSWORD}"  # from environment variable
```

> Note: `${VAR}` syntax reads from environment variables — secrets stay out of Git!
