resource "aws_iam_role" "firehose_role" {
  name               = "${var.firehose_name}-${var.environment}_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "firehose_role_policy" {
  depends_on = [
    aws_iam_role.firehose_role,
    aws_s3_bucket.stream-bucket,
  ]
  name   = "${var.firehose_name}-${var.environment}_policy"
  role   = aws_iam_role.firehose_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:PutObject",
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.stream-bucket.arn}",
        "${aws_s3_bucket.stream-bucket.arn}/*"
      ]
    },

    {
        "Effect": "Allow",
        "Action": [
            "firehose:PutRecord",
            "firehose:PutRecordBatch"
        ],
        "Resource": [
            "${aws_kinesis_firehose_delivery_stream.firehose_stream.arn}"
        ]
    }

  ]
}
EOF

}

