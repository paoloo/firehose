resource "aws_s3_bucket" "stream-bucket" {
  bucket = "${var.firehose_name}-${var.environment}-fh-bucket"
  acl    = "private"
  tags = {
    Environment = var.environment
  }
}

