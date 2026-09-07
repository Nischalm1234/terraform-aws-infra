# S3 Bucket — Application Storage
resource "aws_s3_bucket" "app_storage" {
  # Bucket names must be globally unique
  bucket = "${var.project_name}-app-storage-${var.environment}"

  tags = {
    Name        = "${var.project_name}-app-storage"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Block all public access (Crucial for security)
resource "aws_s3_bucket_public_access_block" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning (Keeps a history of object changes)
resource "aws_s3_bucket_versioning" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}