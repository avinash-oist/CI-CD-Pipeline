# app/ — Sample Application

## What goes here?

A simple application that will be the **target** of your CI/CD pipeline. The whole point of the pipeline is to build, test, and deploy this app automatically.

## What kind of app?

We'll keep it simple — a small web app (Python Flask or Node.js) that:
- Has a few unit tests
- Can be containerized with Docker (optional)
- Gets deployed to the EC2 server by Jenkins

## CI/CD Flow for the App

```
1. Developer pushes code to GitHub
2. Jenkins detects the push (webhook)
3. Jenkins runs: install dependencies
4. Jenkins runs: unit tests  ← if this fails, pipeline stops
5. Jenkins runs: build
6. Jenkins runs: deploy to EC2
7. Jenkins sends notification (success/failure)
```

## Coming Soon

We'll build this out once the Jenkins server is running.
