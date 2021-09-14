# Create Lambda
resource "aws_lambda_function" "sample-b2b-create_lambda" {
  filename         = "${path.module}/files/lambda.zip"
  function_name    = "sample-b2b-account-create"
  role             = aws_iam_role.sample-b2b-create_iam_for_lambda.arn
  timeout          = var.lambda_timeout
  handler          = "lambda_handler.lambda_handler"
  source_code_hash = filebase64sha256("${data.archive_file.lambda.output_path}")
  runtime = "python3.7"
}
