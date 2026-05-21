# ── ALB Security Group ───────────────────────────────────────────
 # Accepts HTTP from the whole internet on port 80
 resource "aws_security_group" "alb" {
   name        = "${var.project_name}-${var.environment}-alb-sg"
   description = "Allow HTTP from internet to ALB"
   vpc_id      = aws_vpc.main.id
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-alb-sg"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_vpc_security_group_ingress_rule" "alb_http" {
   security_group_id = aws_security_group.alb.id
   cidr_ipv4         = "0.0.0.0/0"
   from_port         = 80
   to_port           = 80
   ip_protocol       = "tcp"
   description       = "HTTP from internet (POC requirement #6)"
 }
 
 resource "aws_vpc_security_group_egress_rule" "alb_outbound" {
   security_group_id = aws_security_group.alb.id
   cidr_ipv4         = "0.0.0.0/0"
   ip_protocol       = "-1"
   description       = "ALB to webservers"
 }
 
 # ── Webserver Security Group ──────────────────────────────────────
 # Port 8080 ONLY from ALB SG — not from internet directly
 # Port 22 ONLY from your IP — SSH for Ansible/debugging
 resource "aws_security_group" "webserver" {
   name        = "${var.project_name}-${var.environment}-webserver-sg"
   description = "Allow 8080 from ALB only, SSH from admin"
   vpc_id      = aws_vpc.main.id
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-webserver-sg"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_vpc_security_group_ingress_rule" "web_from_alb" {
   security_group_id            = aws_security_group.webserver.id
   referenced_security_group_id = aws_security_group.alb.id
   from_port                    = 8080
   to_port                      = 8080
   ip_protocol                  = "tcp"
   description                  = "Apache 8080 from ALB SG only"
 }
 
 resource "aws_vpc_security_group_ingress_rule" "web_ssh" {
   security_group_id = aws_security_group.webserver.id
   cidr_ipv4         = var.allowed_ssh_cidrs
   from_port         = 22
   to_port           = 22
   ip_protocol       = "tcp"
   description       = "SSH from admin IP for Ansible"
 }
 
 resource "aws_vpc_security_group_egress_rule" "web_outbound" {
   security_group_id = aws_security_group.webserver.id
   cidr_ipv4         = "0.0.0.0/0"
   ip_protocol       = "-1"
   description       = "Outbound for package installs"
 }
