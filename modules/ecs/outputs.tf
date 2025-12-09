output "backend_sg_id" {
  description = "The Security Group ID of the ECS Backend."
  value       = aws_security_group.backend_sg.id
}