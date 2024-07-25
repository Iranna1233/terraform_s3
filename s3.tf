provider "aws" {
  region = "us-east-1"  # Replace this with your desired region
}

resource "aws_s3_bucket" "my-tf-test-bucket1" {
  bucket = "my-tf-test-bucket1"
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "my-tf-test-bucket1" {
  bucket = aws_s3_bucket.my-tf-test-bucket1.id
  rule {
    id = "archive"
    status = "Enabled"
    transition {
      days          = 1
      storage_class = "GLACIER"
    }
  }
}
