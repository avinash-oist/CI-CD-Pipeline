---
applyTo: "jenkins/**,scripts/**"
---
# Jenkins Instructions

## Teaching checklist for Jenkins tasks
1. Explain the concept (what is a stage / agent / credential) before writing pipeline code
2. Show the Jenkinsfile snippet line by line
3. Explain what happens if this step fails — does the pipeline stop?
4. Show how to verify it worked in Jenkins UI

## Pipeline structure this project uses
```
pipeline {
    agent any
    stages {
        stage('Checkout')   { }   // pull code from Git
        stage('Build')      { }   // compile / install deps
        stage('Test')       { }   // unit tests
        stage('SonarQube')  { }   // code quality scan
        stage('OWASP')      { }   // dependency CVE scan
        stage('Trivy')      { }   // container image scan
        stage('Build Image'){ }   // docker build
        stage('Push to ECR'){ }   // push to AWS ECR
        stage('Deploy')     { }   // trigger ArgoCD or kubectl
    }
}
```

## Credentials rule
NEVER hardcode credentials in Jenkinsfile. Always use Jenkins Credentials Store:
```groovy
withCredentials([string(credentialsId: 'my-secret', variable: 'SECRET')]) {
    sh 'use $SECRET here'
}
```

## No GitHub Actions
This project uses Jenkins for all CI/CD. Do not suggest GitHub Actions workflows.
