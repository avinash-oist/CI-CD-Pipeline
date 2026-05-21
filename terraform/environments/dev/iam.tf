 resource "aws_iam_user" "webserver_restarter" {
   name = "${var.project_name}-${var.environment}-restarter"
 
   tags = {
     Environment = var.environment
     Project     = var.project_name
     ManagedBy   = "terraform"
   }
 }
 
 resource "aws_iam_policy" "restart_webserver" {
   name        = "${var.project_name}-${var.environment}-restart-policy"
   description = "Allows restarting httpd on tagged Zantac instances via SSM only"
 
   policy = jsonencode({
     Version = "2012-10-17"
     Statement = [
       {
         Sid    = "AllowSSMSendCommand"
         Effect = "Allow"
         Action = ["ssm:SendCommand"]
         Resource = [
           "arn:aws:ssm:${var.aws_region}::document/AWS-RunShellScript",
           "arn:aws:ec2:${var.aws_region}:*:instance/*"
         ]
         Condition = {
           StringEquals = {
             "ec2:ResourceTag/Project"     = var.project_name
             "ec2:ResourceTag/Environment" = var.environment
           }
         }
       },
       {
         Sid      = "AllowSSMDescribe"
         Effect   = "Allow"
         Action   = ["ssm:GetCommandInvocation"]
         Resource = ["*"]
       }
     ]
   })
 }
 
 resource "aws_iam_user_policy_attachment" "restarter_policy" {
   user       = aws_iam_user.webserver_restarter.name
   policy_arn = aws_iam_policy.restart_webserver.arn
 }
 
 resource "aws_iam_access_key" "restarter" {
   user = aws_iam_user.webserver_restarter.name
 }