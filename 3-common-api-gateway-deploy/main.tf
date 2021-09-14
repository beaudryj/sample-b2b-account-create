terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "api_gateway" {
  backend = "s3"
  config = {
    bucket   = var.bucket
    key      = "dev/sample-b2b-base-infra/apigw"
    region   = var.region
    role_arn = var.role_arn
  }
}

