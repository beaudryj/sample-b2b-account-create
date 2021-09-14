#############################
# Backend Variables
#############################
variable "region" {
  description = "Name of the AWS region to run in."
  type        = string
}

variable "bucket" {
  description = "The name of the S3 bucket where state will be stored"
  type        = string
}

variable "dynamodb_table" {
  description = "The name of the dynamoDB table used to lock the state"
  type        = string
}

variable "key" {
  description = "The key used for the state file"
  type        = string
}

variable "encrypt" {
  description = "Used to toggle encryption of state bucket"
  type        = bool
}

variable "role_arn" {
  description = "Role ARN used for assumption"
  type        = string
  default     = null
}

#############################
# API Gateway
#############################
variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_method" {
  description = "The name of the API Method"
  type        = string
}