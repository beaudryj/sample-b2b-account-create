module "api_gateway_resource_wildcard" {
  source = "git@github.com:beaudryj/tf_apigw_resource.git"

  # Resource info
  rest_api_id         = data.terraform_remote_state.api_gateway.outputs.rest_api_id
  new_resource_toggle = "true"
  root_resource_id    = data.terraform_remote_state.api_gateway.outputs.root_resource_id
  new_resourcepath    = "create"
}

module "api_gateway_resource_proxy_wildcard" {
  source = "git@github.com:beaudryj/tf_apigw_resource.git"
  # Resource info
  rest_api_id         = data.terraform_remote_state.api_gateway.outputs.rest_api_id
  new_resource_toggle = "true"
  root_resource_id    = module.api_gateway_resource_wildcard.resource_id
  new_resourcepath    = "{proxy+}"
}

module "api_gateway_root_mapping_wildcard" {
  source = "git@github.com:beaudryj/tf_apigw_mapping.git"

  # API Gateway
  api_name              = "${var.api_name}"
  api_method            = var.api_method
  function_name         = "${var.api_name}"
  authorizer_id         = data.terraform_remote_state.api_gateway.outputs.authorizer_id
  rest_api_id           = data.terraform_remote_state.api_gateway.outputs.rest_api_id
  gateway_execution_arn = data.terraform_remote_state.api_gateway.outputs.gateway_execution_arn
  resource_id           = module.api_gateway_resource_wildcard.resource_id
  gatewayed_lambda_arn  = data.terraform_remote_state.sample-b2b-create_lambda.outputs.lambda-invoke-arn
  gatewayed_lambda_name = "sample-b2b-account-create"
  resource_name         = "create"
  request_parameters    = {}
  request_validator_id  = data.terraform_remote_state.api_gateway.outputs.api_validator
  resource_identifier   = "root-wildcard"
}

module "api_gateway_proxy_mapping_wildcard" {
  source = "git@github.com:beaudryj/tf_apigw_mapping.git"

  # API Gateway
  api_name              = "${var.api_name}"
  api_method            = var.api_method
  function_name         = "${var.api_name}"
  authorizer_id         = data.terraform_remote_state.api_gateway.outputs.authorizer_id
  rest_api_id           = data.terraform_remote_state.api_gateway.outputs.rest_api_id
  gateway_execution_arn = data.terraform_remote_state.api_gateway.outputs.gateway_execution_arn
  resource_id           = module.api_gateway_resource_proxy_wildcard.resource_id
  gatewayed_lambda_arn  = data.terraform_remote_state.sample-b2b-create_lambda.outputs.lambda-invoke-arn
  gatewayed_lambda_name = "sample-b2b-account-create"
  resource_name         = "{proxy+}"
  request_parameters    = {}
  request_validator_id  = data.terraform_remote_state.api_gateway.outputs.api_validator
  resource_identifier   = "proxy-wildcard"
}
