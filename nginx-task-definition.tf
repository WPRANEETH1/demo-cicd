resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.ecr_name}-taskdef"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([{
    name      = "${var.ecr_name}"
    image     = "103750175519.dkr.ecr.${var.region}.amazonaws.com/${var.ecr_name}:latest"
    essential = true
    portMappings = [{
      protocol      = "tcp"
      containerPort = "${var.ecr_port}"
      hostPort      = "${var.ecr_port}"
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.cloudwatch_log_group.name
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "/ecs/${var.ecr_name}-loggp"
}
