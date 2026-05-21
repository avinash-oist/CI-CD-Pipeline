 # Trust policy - allows EC2 to assume this role
 resource "aws_iam_role" "jenkins" {
   name = "${var.project_name}-${var.environment}-jenkins-role"
 
   assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statement = [{
       Effect    = "Allow"
       Principal = { Service = "ec2.amazonaws.com" }
       Action    = "sts:AssumeRole"
     }]
   })
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins-role"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 # Jenkins needs these permissions to create the full app infra
 resource "aws_iam_role_policy_attachment" "jenkins_ec2" {
   role       = aws_iam_role.jenkins.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
 }
 
 resource "aws_iam_role_policy_attachment" "jenkins_vpc" {
   role       = aws_iam_role.jenkins.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
 }
 
 resource "aws_iam_role_policy_attachment" "jenkins_elb" {
   role       = aws_iam_role.jenkins.name
   policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
 }
 
 resource "aws_iam_role_policy_attachment" "jenkins_autoscaling" {
   role       = aws_iam_role.jenkins.name
   policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
 }
 
 resource "aws_iam_role_policy_attachment" "jenkins_iam" {
   role       = aws_iam_role.jenkins.name
   policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
 }
 
 resource "aws_iam_role_policy_attachment" "jenkins_ssm" {
   role       = aws_iam_role.jenkins.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
 }
 
 # Instance profile - the bridge between IAM role and EC2 instance
 resource "aws_iam_instance_profile" "jenkins" {
   name = "${var.project_name}-${var.environment}-jenkins-profile"
   role = aws_iam_role.jenkins.name
 }
