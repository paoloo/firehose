# Kinesis firehose interface
This repository creates a Kineses firehose stream, a S3 bucket and define the machanics to store data from stream into S3

## procedures

import this as a terraform module:
```
module "kinesis-stream" {
    source          = "git::git@github.com:paoloo/firehose.git//modules/"
    region          = var.region
    environment     = var.environment
	firehose_name   = "covid19"
}

output "firehose_name"   { value = "${module.kinesis-stream.firehose_name}" }
output "bucket"          { value = "${module.kinesis-stream.bucket_id}"     }
```

then,
```
terraform init
terraform plan -var="environment=dev"
terraform apply -var="environment=dev"
```

Usage metrics are generated on Cloudwatch.

## test

```
$ aws firehose put-record --delivery-stream-name analytics-bi-qa1 --record '{"Data":"{\"app\":\"paolo-api\",\"event\":\"firehose_created\",\"version\":1,\"data\":{\"hello world\"}}"}
```

should return something like:

```
{
   "RecordId": "DgpTIlSm6KLhndy4Hbx4UTAJYfHVNuz9ehX5fu3H70RJqitwqRFPbdwkOvQOw6C64VXgoPV8aMazW9EQ6heWjG2PTSBw3HyBDyjAXD/FVEMQHNperqFTc3oONc2bhvxOE8p15ph0SjulWjvkZbq2IFWTvsHgv+Iv9X3ampdON8EOn57QEmzHxZ+ww0nmQk77UKzXvXw34oWrxpUUjGQVArO5p/ez3IZt"
}
```

## Expected data model
```
{
   "app": "paolo_api",
   "event": "card_created",
   "version": 1,
   "data": {custom event data...}
}
```


