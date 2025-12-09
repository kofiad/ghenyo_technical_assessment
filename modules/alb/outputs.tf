output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "The domain name of the load balancer"
}

output "alb_http_listener_arn" {
  value       = aws_lb_listener.http_to_https.arn
  description = "The ARN of the HTTP redirect listener"
}

output "alb_https_listener_arn" {
  value       = aws_lb_listener.https.arn
  description = "The ARN of the HTTPS listener"
}

output "alb_security_group_id" {
  value       = aws_security_group.lb_sg.id
  description = "The ALB Security Group ID"
}