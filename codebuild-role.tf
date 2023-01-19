resource "aws_iam_role" "code-build-bg" {
  name = "ecs-code-build-bg-role"

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

resource "aws_iam_role_policy_attachment" "amazon-ec2-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.code-build-bg.name
}

resource "aws_iam_role_policy_attachment" "amazon-codecommit-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
  role       = aws_iam_role.code-build-bg.name
}

resource "aws_iam_role_policy_attachment" "amazon-ec2-container-reg-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.code-build-bg.name
}

resource "aws_iam_role_policy_attachment" "amazon-s3-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.code-build-bg.name
}

resource "aws_iam_role_policy_attachment" "amazon-cloudwatch-full-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  role       = aws_iam_role.code-build-bg.name
}

resource "aws_iam_role_policy_attachment" "amazon-codebuild-admin-bg-access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
  role       = aws_iam_role.code-build-bg.name
}

resource "aws_iam_role_policy_attachment" "amazon-ecs-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  role       = aws_iam_role.code-build-bg.name
}

resource "aws_s3_bucket" "nginx_codebuild_bg_bucket" {
  bucket = "nginx-codebuild-bg-bucket"
}

resource "aws_s3_bucket_acl" "codebuild_bucket_bg_acl" {
  bucket = aws_s3_bucket.nginx_codebuild_bg_bucket.id
  acl    = "private"
}