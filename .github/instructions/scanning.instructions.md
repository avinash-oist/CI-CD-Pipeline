---
applyTo: "**"
---
# Security Scanning Instructions (SonarQube, OWASP, Trivy)

## The three layers of scanning in this pipeline

```
SonarQube          → scans SOURCE CODE (bugs, code smells, test coverage, duplications)
OWASP Dep-Check    → scans DEPENDENCIES (known CVEs in your libraries/packages)
Trivy              → scans CONTAINER IMAGES (OS packages, app deps inside the image)
```

These are complementary — each catches what the others miss.

## Teaching rule
Before adding any scanner to the pipeline, explain:
1. What it scans (source? deps? image?)
2. What a "finding" looks like and what severity means
3. What the pipeline should do on HIGH/CRITICAL finding — fail or warn?

## Quality Gate rule (SonarQube)
A Quality Gate is a pass/fail threshold. This project's gate:
- Coverage < 70% → FAIL
- Any BLOCKER issue → FAIL
- Any CRITICAL security hotspot unreviewed → FAIL
Never skip the Quality Gate check in the pipeline.

## Trivy scan — always scan before pushing to ECR
```bash
# Scan image before pushing
trivy image --exit-code 1 --severity HIGH,CRITICAL myapp:latest
# --exit-code 1 means: fail the pipeline if HIGH or CRITICAL found
```

## OWASP — fail on CVSS score >= 7
```xml
<failBuildOnCVSS>7</failBuildOnCVSS>
```
CVSS 7+ = HIGH severity. Pipeline should fail, not just warn.
