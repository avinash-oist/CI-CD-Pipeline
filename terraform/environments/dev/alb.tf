resource "aws_lb" "main" {
   name               = "${var.project_name}-${var.environment}-alb"
   internal           = false
   load_balancer_type = "application"
   security_groups    = [aws_security_group.alb.id]
   subnets            = [aws_subnet.public.id, aws_subnet.public_b.id]
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-alb"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_lb_target_group" "webservers" {
   name     = "${var.project_name}-${var.environment}-tg"
   port     = 8080
   protocol = "HTTP"
   vpc_id   = aws_vpc.main.id
 
   health_check {
     enabled             = true
     path                = "/"
     port                = "traffic-port"
     protocol            = "HTTP"
     healthy_threshold   = 2
     unhealthy_threshold = 2
     timeout             = 5
     interval            = 30
   }
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-tg"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_lb_listener" "http" {
   load_balancer_arn = aws_lb.main.arn
   port              = 80
   protocol          = "HTTP"
 
   default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.webservers.arn
   }
 }
 
 resource "aws_autoscaling_attachment" "asg_to_alb" {
   autoscaling_group_name = aws_autoscaling_group.webservers.name
   lb_target_group_arn    = aws_lb_target_group.webservers.arn
 }