resource "aws_lb" "main" {
  name               = "ecs-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = compact(concat(tolist([aws_security_group.alb.id])))
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "main_tg" {
  name        = "ecs-nginx-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/actuator/health"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "main_listener" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main_tg.id
    type             = "forward"
  }  
}

# resource "aws_alb_listener" "https" {
#   load_balancer_arn = aws_lb.main.id
#   port              = 443
#   protocol          = "HTTPS"

#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = ""

#   default_action {
#     target_group_arn = aws_alb_target_group.main_tg.id
#     type             = "forward"
#   }
# }