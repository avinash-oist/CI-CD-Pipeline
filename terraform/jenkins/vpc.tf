 resource "aws_vpc" "jenkins" {
   cidr_block           = var.vpc_cidr
   enable_dns_hostnames = true
   enable_dns_support   = true
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins-vpc"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_internet_gateway" "jenkins" {
   vpc_id = aws_vpc.jenkins.id
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins-igw"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_subnet" "jenkins" {
   vpc_id                  = aws_vpc.jenkins.id
   cidr_block              = var.subnet_cidr
   availability_zone       = var.availability_zone
   map_public_ip_on_launch = true
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins-subnet"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_route_table" "jenkins" {
   vpc_id = aws_vpc.jenkins.id
 
   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.jenkins.id
   }
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins-rt"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_route_table_association" "jenkins" {
   subnet_id      = aws_subnet.jenkins.id
   route_table_id = aws_route_table.jenkins.id
 }