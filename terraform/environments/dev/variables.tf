variable "aws_region" {
   type        = string
   description = "AWS region to deploy resources"
   default     = "ap-south-1"
 }
 
 variable "environment" {
   type        = string
   description = "Deployment environment name (dev, staging, prod)"
   default     = "dev"
 }
 
 variable "project_name" {
   type        = string
   description = "Project name used for resource naming and tagging"
   default     = "ci-cd-pipeline"
 }
 
 variable "vpc_cidr" {
   type        = string
   description = "CIDR block for the VPC"
   default     = "10.0.0.0/16"
 }
 
 variable "public_subnet_cidr" {
   type        = string
   description = "CIDR block for the public subnet"
   default     = "10.0.1.0/24"
 }
 
 variable "availability_zone" {
   type        = string
   description = "Availability zone for the subnet and EC2"
   default     = "ap-south-1a"
 }
 
 variable "instance_type" {
   type        = string
   description = "EC2 instance type"
   default     = "t2.micro"
 }
 
 variable "key_pair_name" {
   type        = string
   description = "Name of the AWS key pair for SSH access"
 }
 
 variable "my_ip" {
   type        = string
   description = "Your public IP in CIDR format (e.g. 1.2.3.4/32) for SSH access"
 }

