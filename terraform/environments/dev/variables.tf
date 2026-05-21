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
   default     = "zantac"
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

  variable "public_subnet_cidr_b" {
   type        = string
   description = "CIDR block for the second public subnet (AZ-b)"
   default     = "10.0.2.0/24"
 }
 
 variable "availability_zone_b" {
   type        = string
   description = "Second availability zone for subnet B"
   default     = "ap-south-1b"
 }
 
 variable "instance_type" {
   type        = string
   description = "EC2 instance type"
   default     = "t3.micro"
 }
 
 variable "key_pair_name" {
   type        = string
   description = "Name of the AWS key pair for SSH access"
 }
 
 variable "allowed_ssh_cidrs" {
   description = "CIDRs allowed to SSH - your IP + Jenkins EC2 IP"
   type        = list(string)
 }