 output "vpc_id" {
   description = "VPC ID"
   value       = aws_vpc.main.id
 }
 
 output "public_subnet_a_id" {
   description = "Public subnet A (ap-south-1a)"
   value       = aws_subnet.public.id
 }
 
 output "public_subnet_b_id" {
   description = "Public subnet B (ap-south-1b)"
   value       = aws_subnet.public_b.id
 }
 
 output "alb_dns_name" {
   description = "ALB DNS name - use this to access the web app"
   value       = aws_lb.main.dns_name
 }
 
 output "alb_url" {
   description = "Full URL to access the web application"
   value       = "http://${aws_lb.main.dns_name}"
 }
 
 output "asg_name" {
   description = "Auto Scaling Group name"
   value       = aws_autoscaling_group.webservers.name
 }
 
 output "iam_restarter_username" {
   description = "IAM username for webserver restart only"
   value       = aws_iam_user.webserver_restarter.name
 }
 
 output "iam_restarter_access_key_id" {
   description = "Access key ID for the restarter IAM user"
   value       = aws_iam_access_key.restarter.id
 }
 
 output "iam_restarter_secret_key" {
   description = "Secret access key for the restarter IAM user"
   value       = aws_iam_access_key.restarter.secret
   sensitive   = true
 }