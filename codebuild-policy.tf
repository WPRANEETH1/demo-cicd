resource "aws_iam_role" "code-build" {
  name = "ecs-code-build-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "amazon-ec2-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.code-build.name
}

resource "aws_iam_role_policy_attachment" "amazon-codecommit-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
  role       = aws_iam_role.code-build.name
}

resource "aws_iam_role_policy_attachment" "amazon-ec2-container-reg-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.code-build.name
}

resource "aws_iam_role_policy_attachment" "amazon-s3-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.code-build.name
}

resource "aws_iam_role_policy_attachment" "amazon-cloudwatch-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  role       = aws_iam_role.code-build.name
}

resource "aws_iam_role_policy_attachment" "amazon-codebuild-admin-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
  role       = aws_iam_role.code-build.name
}

resource "aws_security_group" "nginx_codebuild" {
  name   = "nginx-codebuild-${var.environment}-gs"
  vpc_id = aws_vpc.main.id

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}