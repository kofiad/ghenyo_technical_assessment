resource "aws_ecs_cluster" "main" {
  name = "${var.env_name}-backend-cluster"
  tags = {
    Name        = "${var.env_name}-ecs-cluster"
    Environment = var.env_name
  }
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "${var.env_name}-backend-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      cpu       = tonumber(var.fargate_cpu)
      memory    = tonumber(var.fargate_memory)
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
      environment = [
        {
          name  = "DATABASE_HOST"
          value = var.db_endpoint
        },
        {
          name  = "DATABASE_PORT"
          value = var.db_port
        }
      ]
    }
  ])
}

resource "aws_lb_target_group" "main" {
  name        = "${var.env_name}-backend-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30
    timeout             = 5
  }
}

resource "aws_lb_listener_rule" "backend_traffic" {
  listener_arn = var.alb_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"] 
    }
  }
}

resource "aws_ecs_service" "main" {
  name            = "${var.env_name}-backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.backend_sg.id]
    subnets          = var.private_subnet_ids            
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = var.container_name
    container_port   = 8080
  }
}


resource "aws_security_group" "backend_sg" {
  name        = "${var.env_name}-backend-sg"
  description = "Allows traffic from ALB and allows outbound to DB"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
    description     = "Allow traffic from ALB"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_backend_to_db" {
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend_sg.id
  security_group_id        = var.rds_sg_id                  

}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.env_name}-ecs-exec-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.env_name}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}