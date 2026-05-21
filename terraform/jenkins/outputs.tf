 output "jenkins_public_ip" {
   description = "Jenkins EC2 public IP"
   value       = aws_instance.jenkins.public_ip
 }
 
 output "jenkins_url" {
   description = "Open this in your browser to access Jenkins"
   value       = "http://${aws_instance.jenkins.public_ip}:8080"
 }
 
 output "jenkins_ssh" {
   description = "SSH command to access Jenkins EC2"
   value       = "ssh -i ~/.ssh/ci-cd-dev-key-fixed.pem ec2-user@${aws_instance.jenkins.public_ip}"
 }