 resource "aws_security_group" "jenkins" {
   name        = "${var.project_name}-${var.environment}-jenkins-sg"
   description = "Security group for Jenkins server"
   vpc_id      = aws_vpc.main.id
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins-sg"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_vpc_security_group_ingress_rule" "ssh" {
   security_group_id = aws_security_group.jenkins.id
   cidr_ipv4         = var.my_ip
   from_port         = 22
   to_port           = 22
   ip_protocol       = "tcp"
   description       = "SSH access from admin IP only"
 }
 
 resource "aws_vpc_security_group_ingress_rule" "jenkins_ui" {
   security_group_id = aws_security_group.jenkins.id
   cidr_ipv4         = var.my_ip
   from_port         = 8080
   to_port           = 8080
   ip_protocol       = "tcp"
   description       = "Jenkins web UI access from admin IP only"
 }
 
 resource "aws_vpc_security_group_egress_rule" "all_outbound" {
   security_group_id = aws_security_group.jenkins.id
   cidr_ipv4         = "0.0.0.0/0"
   ip_protocol       = "-1"
   description       = "Allow all outbound traffic"
 }
