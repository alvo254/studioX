resource "aws_s3_bucket" "studiox-shared" {
  bucket = var.bucket_name
  
  tags = {
    Name = "studiox"
  }
}

resource "aws_s3_bucket_public_access_block" "toast-public_access" {
  bucket = aws_s3_bucket.studiox-shared.id
  
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.studiox-shared.id
  policy = jsonencode({
       "Version": "2012-10-17",
       "Statement": [
          {
              "Sid": "Statement1",
              "Effect": "Allow",
              "Principal": "*",
              "Action": "s3:GetObject",
              "Resource": "arn:aws:s3:::${var.bucket_name}/*"
          }
      ]
  })
}
