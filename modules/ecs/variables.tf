# modules/compute/variables.tf

variable "env_name" {
  description = "The name of the environment (e.g., dev, prod)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where Fargate tasks will run."
  type        = list(string)
}

# Dependencies from other modules
variable "alb_sg_id" {
  description = "The Security Group ID of the Load Balancer."
  type        = string
}

variable "rds_sg_id" {
  description = "The Security Group ID of the Database."
  type        = string
}

variable "alb_listener_arn" {
  description = "The ARN of the ALB Listener to attach the service to."
  type        = string
}

variable "db_endpoint" {
  description = "The database cluster endpoint (Host)."
  type        = string
}

variable "db_port" {
  description = "The database port."
  type        = number
}

# Environment-specific sizing and scaling
variable "container_name" {
  description = "The name of the container defined in the Task Definition."
  type        = string
  default     = "web-api-container"
}

variable "container_image" {
  description = "The Docker image URL for the application (e.g., ECR path)."
  type        = string
}

variable "fargate_cpu" {
  description = "The CPU allocation for the Fargate task (e.g., 512, 1024, 2048)."
  type        = string
  default     = "512" # Small for dev
}

variable "fargate_memory" {
  description = "The Memory allocation for the Fargate task (e.g., 1024, 2048, 4096)."
  type        = string
  default     = "1024" # Small for dev
}

variable "desired_count" {
  description = "The number of tasks to run (Min scale out)."
  type        = number
  default     = 1 # Low for dev, higher for prod
}