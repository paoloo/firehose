variable "region" {
  default = "us-west-2"
}

variable "firehose_name" {
  default = "covid-data"
}

variable "environment" {
  default = "dev"
}

provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "covid"
  region                  = var.region
}

module "kinesis-stream" {
  source        = "./modules"
  region        = var.region
  environment   = var.environment
  firehose_name = var.firehose_name
}

output "firehose_name" {
  value = module.kinesis-stream.firehose_name
}

output "bucket" {
  value = module.kinesis-stream.bucket_id
}

