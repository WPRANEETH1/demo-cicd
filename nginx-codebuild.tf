resource "aws_security_group" "nginx_codebuild_bg" {
  name   = "nginx-codebuild-${var.environment}-bg-gs"
  vpc_id = aws_vpc.main.id

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_codebuild_project" "ecs_to_ecr_bg" {
  name          = "nginx-ecr-codebuild-bg"
  description   = "nginx_codebuild_project"
  build_timeout = "60"
  service_role  = aws_iam_role.code-build-bg.arn

  artifacts {
    location = aws_s3_bucket.nginx_codebuild_bg_bucket.bucket
    type     = "S3"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_MEDIUM"
    image           = "aws/codebuild/standard:6.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "task_definition"
      value = aws_ecs_task_definition.nginx_bg.family
    }  

    environment_variable {
      name  = "container_name"
      value = "${var.ecs_name}"
    }  
    
    environment_variable {
      name  = "container_port"
      value = 80
    }       

  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }

  source {
    type            = "NO_SOURCE"
    buildspec       = "${file("demo-app/buildspec.yml")}"
  }

  source_version = "master"

  vpc_config {
    vpc_id = aws_vpc.main.id

    subnets = [
      aws_subnet.private.0.id,
      aws_subnet.private.1.id
    ]

    security_group_ids = ["${aws_security_group.nginx_codebuild_bg.id}"]
  }

  tags = {
    Environment = "Test"
  }
}