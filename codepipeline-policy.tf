resource "aws_s3_bucket" "nginx_codepipeline_bucket" {
  bucket = "nginx-codebuild-bucket"
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.nginx_codepipeline_bucket.id
  acl    = "private"
}

resource "aws_iam_role" "ecs_codepipeline_role" {
  name = "nginx-codepipeline-role"

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

resource "aws_iam_role_policy_attachment" "amazon-s3-full-codepipeline-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.ecs_codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-cloudwatch-full-codepipeline-access" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  role       = aws_iam_role.ecs_codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-codecommit-full-codepipeline-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
  role       = aws_iam_role.ecs_codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-codepipeline-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
  role       = aws_iam_role.ecs_codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-codebuild-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
  role       = aws_iam_role.ecs_codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "amazon-ecs-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  role       = aws_iam_role.ecs_codepipeline_role.name
}