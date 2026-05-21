 variable "aws_region" {
   type    = string
   default = "ap-south-1"
 }
 
 variable "environment" {
   type    = string
   default = "dev"
 }
 
 variable "project_name" {
   type    = string
   default = "zantac"
 }
 
 variable "vpc_cidr" {
   type    = string
   default = "10.1.0.0/16"
 }
 
 variable "subnet_cidr" {
   type    = string
   default = "10.1.1.0/24"
 }
 
 variable "availability_zone" {
   type    = string
   default = "ap-south-1a"
 }
 
 variable "instance_type" {
   type    = string
   default = "t3.micro"
 }
 
 variable "key_pair_name" {
   description = "EC2 key pair for SSH"
   type        = string
 }
 
 variable "my_ip" {
   description = "Your IP for SSH and Jenkins UI access"
   type        = string
 }
