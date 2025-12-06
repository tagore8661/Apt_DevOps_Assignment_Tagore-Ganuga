# Consolidated Terraform outputs for the module
output "alb_dns" {
  value       = aws_lb.alb.dns_name
  description = "ALB DNS name"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "asg_name" {
  value       = aws_autoscaling_group.asg.name
  description = "Auto Scaling Group name"
}
