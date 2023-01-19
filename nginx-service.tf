resource "aws_ecs_service" "ecs_service" {
  name                               = "${var.ecr_name}-${var.environment}"
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = compact(concat(tolist([aws_security_group.nginx_tasks.id])))
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main_tg.arn
    container_name   = "${var.ecr_name}"
    container_port   = "${var.ecr_port}"
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}