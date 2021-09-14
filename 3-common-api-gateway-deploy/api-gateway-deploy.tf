module "api_gateway_deployment" {
  source = "git@github.com:beaudryj/tf_apigw_deployment.git"

  function_name = var.api_name
  stage_name    = var.stage_name
  rest_api_id   = data.terraform_remote_state.api_gateway.outputs.rest_api_id
  domain_name   = var.domain_name
  base_path     = ""
}