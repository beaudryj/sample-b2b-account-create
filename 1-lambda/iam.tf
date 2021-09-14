# Create Service Role
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "sample-b2b-create_iam_for_lambda" {
  name               = "sample-b2b-create_iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

# Lambda role policy document
data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:UpdateTable",
      "dynamodb:Scan",
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "xray:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name   = "sample-b2b-account-create"
  role   = aws_iam_role.sample-b2b-create_iam_for_lambda.id
  policy = data.aws_iam_policy_document.lambda_policy_document.json
}