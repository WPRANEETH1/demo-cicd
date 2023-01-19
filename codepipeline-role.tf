resource "aws_s3_bucket" "nginx_codepipeline_bg_bucket" {
  bucket = "nginx-codepipeline-bg-bucket"
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_bg_acl" {
  bucket = aws_s3_bucket.nginx_codepipeline_bg_bucket.id
  acl    = "private"
}

resource "aws_iam_role" "ecs_codepipeline_bg_role" {
  name = "nginx-codepipeline-bg-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "amazon-s3-full-codepipeline-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.ecs_codepipeline_bg_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-cloudwatch-full-codepipeline-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  role       = aws_iam_role.ecs_codepipeline_bg_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-codecommit-full-codepipeline-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
  role       = aws_iam_role.ecs_codepipeline_bg_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-codepipeline-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
  role       = aws_iam_role.ecs_codepipeline_bg_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-codebuild-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
  role       = aws_iam_role.ecs_codepipeline_bg_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-ecs-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  role       = aws_iam_role.ecs_codepipeline_bg_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-ecsreg-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.ecs_codepipeline_bg_role.name
}