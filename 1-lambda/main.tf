terraform {
  backend "s3" {}
}

data "aws_availability_zones" "available" {}

data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# Zip Lambda function
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/${var.source_path}"
  output_path = "${path.module}/files/lambda.zip"
}
