 pipeline {
     agent any
 
     parameters {
         choice(
             name: 'ACTION',
             choices: ['apply', 'destroy'],
             description: 'Deploy or destroy the Zantac POC infrastructure'
         )
     }
 
     environment {
         AWS_DEFAULT_REGION = 'ap-south-1'
         TF_DIR             = 'terraform/environments/dev'
         ANSIBLE_DIR        = 'ansible'

         // Terraform variables - TF_VAR_* are auto-read by terraform
         // No tfvars file needed in pipeline - values injected via env vars
         TF_VAR_key_pair_name      = 'ci-cd-dev-key'
         TF_VAR_allowed_ssh_cidrs  = '["13.233.114.200/32","106.51.0.0/16"]'
     }
 
     stages {
 
         stage('Checkout') {
             steps {
                 checkout scm
                 echo "Branch: ${env.GIT_BRANCH}"
             }
         }
 
         stage('Terraform Init') {
             steps {
                 dir("${TF_DIR}") {
                     sh 'terraform init -upgrade'
                 }
             }
         }
 
         stage('Terraform Plan') {
             when {
                 expression { params.ACTION == 'apply' }
             }
             steps {
                 dir("${TF_DIR}") {
                     sh 'terraform plan -out=tfplan'
                 }
             }
         }
 
         stage('Approval Gate') {
             when {
                 expression { params.ACTION == 'apply' }
             }
             steps {
                 input message: 'Review the plan above. Deploy to AWS?', ok: 'Deploy'
             }
         }
 
         stage('Terraform Apply') {
             when {
                 expression { params.ACTION == 'apply' }
             }
             steps {
                 dir("${TF_DIR}") {
                     sh 'terraform apply tfplan'
                 }
             }
         }
 
         stage('Wait for Instances') {
             when {
                 expression { params.ACTION == 'apply' }
             }
             steps {
                 echo 'Waiting 90s for EC2 instances to initialise...'
                 sleep 90
             }
         }
 
         stage('Ansible Configure') {
             when {
                 expression { params.ACTION == 'apply' }
             }
             steps {
                 dir("${ANSIBLE_DIR}") {
                     sh 'ansible-playbook site.yml -v'
                 }
             }
         }
 
         stage('Smoke Test') {
             when {
                 expression { params.ACTION == 'apply' }
             }
             steps {
                 dir("${TF_DIR}") {
                     script {
                         def albDns = sh(
                             script: 'terraform output -raw alb_dns_name',
                             returnStdout: true
                         ).trim()
                         echo "Testing: http://${albDns}"
                         sh "curl -sf --max-time 15 http://${albDns} | head -5"
                     }
                 }
             }
         }
 
         stage('Terraform Destroy') {
             when {
                 expression { params.ACTION == 'destroy' }
             }
             steps {
                 dir("${TF_DIR}") {
                     sh 'terraform destroy -auto-approve'
                 }
             }
         }
     }
 
     post {
         success {
             echo '✅ Pipeline completed successfully'
         }
         failure {
             echo '❌ Pipeline failed - check logs above'
         }
         always {
             dir("${TF_DIR}") {
                 sh 'rm -f tfplan'
             }
         }
     }
 }