resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.firehose_name}-${var.environment}"
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "${var.firehose_name}-${var.environment}"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}

