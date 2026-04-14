resource "aws_sagemaker_endpoint_configuration" "model_endpoint_config" {
  count = var.deploy_endpoint ? 1 : 0
  name  = "${var.model_name}-endpoint-config"

  production_variants {
    variant_name           = "primary"
    model_name             = aws_sagemaker_model.custom_model.name
    initial_instance_count = var.endpoint_initial_instance_count
    instance_type          = var.endpoint_instance_type
  }
}

resource "aws_sagemaker_endpoint" "model_endpoint" {
  count                = var.deploy_endpoint ? 1 : 0
  name                 = "${var.model_name}-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.model_endpoint_config[0].name
}
