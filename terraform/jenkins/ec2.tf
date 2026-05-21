 data "aws_ami" "amazon_linux_2023" {
   most_recent = true
   owners      = ["amazon"]
 
   filter {
     name   = "name"
     values = ["al2023-ami-2023*-x86_64"]
   }
 
   filter {
     name   = "state"
     values = ["available"]
   }
 }
 
 resource "aws_security_group" "jenkins" {
   name        = "${var.project_name}-${var.environment}-jenkins-sg"
   description = "Jenkins CI server access"
   vpc_id      = aws_vpc.jenkins.id
 
   ingress {
     description = "Jenkins UI"
     from_port   = 8080
     to_port     = 8080
     protocol    = "tcp"
     cidr_blocks = [var.my_ip]
   }
 
   ingress {
     description = "SSH"
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = [var.my_ip]
   }
 
   egress {
     description = "All outbound - needed to download Jenkins plugins and call AWS APIs"
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins-sg"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_instance" "jenkins" {
   ami                    = data.aws_ami.amazon_linux_2023.id
   instance_type          = var.instance_type
   key_name               = var.key_pair_name
   subnet_id              = aws_subnet.jenkins.id
   vpc_security_group_ids = [aws_security_group.jenkins.id]
   iam_instance_profile   = aws_iam_instance_profile.jenkins.name
 
   user_data = base64encode(<<-EOF
     #!/bin/bash
     set -euo pipefail
 
     # Java 21 - required by Jenkins LTS 2.463+
     dnf install -y java-21-amazon-corretto
 
     # Jenkins LTS
     wget -O /etc/yum.repos.d/jenkins.repo \
       https://pkg.jenkins.io/redhat-stable/jenkins.repo
     rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
     dnf install -y jenkins
     systemctl enable jenkins
     systemctl start jenkins
 
     # Terraform CLI
     dnf install -y yum-utils
     yum-config-manager --add-repo \
       https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
     dnf install -y terraform
 
     # Ansible + boto3 for dynamic inventory
     dnf install -y python3-pip git
     pip3 install ansible boto3 botocore
     ansible-galaxy collection install amazon.aws
 
     # Print initial admin password location to logs
     echo "Jenkins initial password: $(cat /var/lib/jenkins/secrets/initialAdminPassword)" \
       >> /var/log/jenkins-setup.log
   EOF
   )
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
     Role        = "jenkins"
   }
 }