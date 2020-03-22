output "firehose_arn" {
  value = aws_kinesis_firehose_delivery_stream.firehose_stream.arn
}

output "firehose_name" {
  value = aws_kinesis_firehose_delivery_stream.firehose_stream.name
}

output "bucket_arn" {
  value = aws_s3_bucket.stream-bucket.arn
}

output "bucket_id" {
  value = aws_s3_bucket.stream-bucket.id
}

