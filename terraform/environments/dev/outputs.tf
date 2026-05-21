
 output "instance_public_ip" {
   description = "Public IP of the Jenkins EC2 instance"
   value       = aws_instance.jenkins.public_ip
 }
 
 output "instance_id" {
   description = "EC2 instance ID"
   value       = aws_instance.jenkins.id
 }
 
 output "vpc_id" {
   description = "VPC ID"
   value       = aws_vpc.main.id
 }
 
 output "public_subnet_id" {
   description = "Public subnet ID"
   value       = aws_subnet.public.id
 }
 
 output "ssh_command" {
   description = "SSH command to connect to the instance"
   value       = "ssh -i ~/.ssh/ci-cd-dev-key.pem ec2-user@${aws_instance.jenkins.public_ip}"
 }