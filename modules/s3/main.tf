resource "aws_s3_bucket" "s3_user_data" {
  bucket = "jenkins-user-data01"
}

resource "aws_s3_bucket_object" "user_data" {
  bucket = aws_s3_bucket.s3_user_data.id
  for_each = fileset("./modules/s3/scripts/", "*")
  key = each.value
  source = "./modules/s3/scripts/${each.value}"
  etag = filemd5("./modules/s3/scripts/${each.value}")
}