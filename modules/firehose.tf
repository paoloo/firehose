resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  name        = "${var.firehose_name}-${var.environment}"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn           = aws_iam_role.firehose_role.arn
    bucket_arn         = aws_s3_bucket.stream-bucket.arn
    buffer_size        = 5
    buffer_interval    = 60
    compression_format = "GZIP"

    prefix              = "data/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"
    error_output_prefix = "errors/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/!{firehose:error-output-type}"

    cloudwatch_logging_options {
      enabled         = "true"
      log_group_name  = aws_cloudwatch_log_group.log_group.name
      log_stream_name = aws_cloudwatch_log_stream.log_stream.name
    }
  }
}

