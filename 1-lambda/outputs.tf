output "lambda-invoke-arn" {
  description = "Invocation ARN used by api gateway for triggering lambda a"
  value       = aws_lambda_function.sample-b2b-create_lambda.invoke_arn
}

output "lambda-arn" {
  description = "ARN of Lambda a for reference"
  value       = aws_lambda_function.sample-b2b-create_lambda.arn
}

output "lambda-iam-role" {
  description = "ARN of IAM role created for lambda"
  value       = aws_iam_role.sample-b2b-create_iam_for_lambda.arn
}
