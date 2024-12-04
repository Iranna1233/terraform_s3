provider "aws" {
  region = "us-east-1"  # Replace this with your desired region
}

resource "aws_s3_bucket_acl" "middleware-s3-dev-bucket" {
  bucket = "middleware-s3-dev-bucket"
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning-middleware-s3-dev-bucket" {
  bucket = aws_s3_bucket.middleware-s3-dev-bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "middleware-s3-dev-bucket" {
  bucket = aws_s3_bucket.middleware-s3-dev-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "middleware-s3-dev-bucket" {
  bucket = aws_s3_bucket.middleware-s3-dev-bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm   = "AES256"
    }
  }
}
