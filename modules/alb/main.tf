resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = true

  access_logs {
    bucket  = var.log_bucket_id
    prefix  = "ghenyo-ta-lb"
    enabled = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "http_to_https" {
  load_balancer_arn = aws_lb.main.arn
  port              = local.http_port
  protocol          = "HTTP"

  # By default, redirect all http traffic to https
  default_action {
    type = "redirect"

    redirect {
      port        = local.https_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = local.https_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  dynamic "default_action" {
    for_each = var.target_group_arn != "" ? [1] : []

    content {
      type             = "forward"
      target_group_arn = var.target_group_arn
    }
  }

  dynamic "default_action" {
    for_each = var.target_group_arn == "" ? [1] : []

    content {
      type = "fixed-response"

      fixed_response {
        content_type = "text/plain"
        message_body = "No backend target registered"
        status_code  = "200"
      }
    }
  }
}

resource "aws_security_group" "lb_sg" {
  name = var.alb_name
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.lb_sg.id

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.lb_sg.id

  from_port   = local.https_port
  to_port     = local.https_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_outbound_to_vpc" {
  type              = "egress"
  security_group_id = aws_security_group.lb_sg.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = "-1"
  cidr_blocks = local.all_ips
}