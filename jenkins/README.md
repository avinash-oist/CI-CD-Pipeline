# jenkins/ — Jenkins CI/CD Configuration

## What is Jenkins?

Jenkins is an open-source **automation server**. It watches your Git repo and automatically runs a pipeline whenever you push code.

```
You push code → Jenkins detects it → Runs tests → Builds app → Deploys to server
```

## How We'll Run Jenkins

We'll install Jenkins on the EC2 instance that Terraform creates. Later, the Jenkins server itself becomes a **self-hosted GitHub Actions runner** too.

## Directory Structure

```
jenkins/
├── pipelines/     # Jenkinsfile definitions — the pipeline logic
└── casc/          # Jenkins Configuration as Code — server config as YAML
```

## Key Concepts

| Concept | Explanation |
|---------|-------------|
| **Jenkinsfile** | Defines the pipeline steps (like a recipe) — lives in the repo |
| **Pipeline** | The sequence of stages: Build → Test → Deploy |
| **Stage** | A named phase of the pipeline (e.g., "Run Tests") |
| **Agent** | The machine that runs the pipeline |
| **Blue Ocean** | Jenkins modern UI plugin |
| **JCasC** | Jenkins Configuration as Code — config Jenkins with YAML, not UI |

## Pipeline Types

```
Declarative Pipeline (recommended — easier to read):

pipeline {
    agent any
    stages {
        stage('Build') { steps { sh 'echo building...' } }
        stage('Test')  { steps { sh 'echo testing...'  } }
        stage('Deploy'){ steps { sh 'echo deploying...' } }
    }
}
```

## Credentials in Jenkins

Like GitHub Actions secrets, Jenkins has a **credentials store**:
> Jenkins UI → Manage Jenkins → Credentials

Types: Username/Password, Secret Text, SSH Key, AWS Credentials  
**Never hardcode credentials in Jenkinsfiles!**

Use them like:
```groovy
withCredentials([string(credentialsId: 'aws-access-key', variable: 'AWS_KEY')]) {
    sh 'aws s3 ls'
}
```
