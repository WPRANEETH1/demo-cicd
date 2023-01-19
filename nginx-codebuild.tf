resource "aws_codebuild_project" "nginx-to-ecr" {
  name          = "nginx-ecr-ecr-deployment"
  description   = "nginx_codebuild_project"
  build_timeout = "60"
  service_role  = aws_iam_role.code-build.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_MEDIUM"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "${var.region}"
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "103750175519"
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = aws_ecr_repository.ecr_repository.name
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }

  source {
    type            = "CODECOMMIT"
    location        = var.codecommit_url
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"

  vpc_config {
    vpc_id = aws_vpc.main.id

    subnets = [
      aws_subnet.private.0.id,
      aws_subnet.private.1.id
    ]

    security_group_ids = ["${aws_security_group.nginx_codebuild.id}"]
  }

  tags = {
    Environment = "Test"
  }
}