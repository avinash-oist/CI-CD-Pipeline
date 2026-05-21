 data "aws_ami" "amazon_linux_2023" {
   most_recent = true
   owners      = ["amazon"]
 
   filter {
     name   = "name"
     values = ["al2023-ami-2023*-x86_64"]
   }
 
   filter {
     name   = "state"
     values = ["available"]
   }
 }
 
 resource "aws_launch_template" "webserver" {
   name_prefix   = "${var.project_name}-${var.environment}-"
   image_id      = data.aws_ami.amazon_linux_2023.id
   instance_type = var.instance_type
   key_name      = var.key_pair_name
 
   network_interfaces {
     associate_public_ip_address = true
     security_groups             = [aws_security_group.webserver.id]
   }
 
   user_data = base64encode(<<-EOF
     #!/bin/bash
     set -euo pipefail
     dnf update -y
     dnf install -y httpd
     sed -i 's/^Listen 80$/Listen 8080/' /etc/httpd/conf/httpd.conf
     echo "<h1>Zantac POC - $(hostname)</h1>" > /var/www/html/index.html
     systemctl enable httpd
     systemctl start httpd
   EOF
   )
 
   tag_specifications {
     resource_type = "instance"
     tags = {
       Name        = "${var.project_name}-${var.environment}-webserver"
       Environment = var.environment
       Project     = var.project_name
       ManagedBy   = "terraform"
       Role        = "webserver"

     }
   }
 }
 
 resource "aws_autoscaling_group" "webservers" {
   name                = "${var.project_name}-${var.environment}-asg"
   min_size            = 1
   desired_capacity    = 2
   max_size            = 3
   vpc_zone_identifier = [aws_subnet.public.id, aws_subnet.public_b.id]
 
   launch_template {
     id      = aws_launch_template.webserver.id
     version = "$Latest"
   }
 
   health_check_type         = "ELB"
   health_check_grace_period = 120
 
   tag {
     key                 = "Environment"
     propagate_at_launch = true
     value               = var.environment
   }

   tag {
     key                 = "Role"
     propagate_at_launch = true
     value               = "webserver"
   }
 
   tag {
     key                 = "Project"
     propagate_at_launch = true
     value               = var.project_name
   }
 }
 
 resource "aws_autoscaling_policy" "cpu_tracking" {
   name                   = "${var.project_name}-${var.environment}-cpu-tracking"
   autoscaling_group_name = aws_autoscaling_group.webservers.name
   policy_type            = "TargetTrackingScaling"
 
   target_tracking_configuration {
     predefined_metric_specification {
       predefined_metric_type = "ASGAverageCPUUtilization"
     }
     target_value = 70.0
   }
 }
