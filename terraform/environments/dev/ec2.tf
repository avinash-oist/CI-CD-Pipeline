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
 
 resource "aws_instance" "jenkins" {
   ami                    = data.aws_ami.amazon_linux_2023.id
   instance_type          = var.instance_type
   subnet_id              = aws_subnet.public.id
   vpc_security_group_ids = [aws_security_group.jenkins.id]
   key_name               = var.key_pair_name
 
   root_block_device {
     volume_size           = 10
     volume_type           = "gp2"
     delete_on_termination = true
   }
 
   tags = {
     Name        = "${var.project_name}-${var.environment}-jenkins"
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }