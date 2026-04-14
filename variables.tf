variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "model_name" {
  description = "Name of the SageMaker model"
  type        = string
}

variable "model_image_tag" {
  description = "Tag of the deployed model"
  type        = string
  default     = "latest"
}

variable "model_artifact" {
  description = "Model artifact path"
  type        = string
  default     = null
}

variable "deploy_endpoint" {
  description = "Whether to deploy a SageMaker endpoint for the model"
  type        = bool
  default     = false
}

variable "endpoint_instance_type" {
  description = "Instance type for the SageMaker endpoint"
  type        = string
  default     = "ml.m5.large"
}

variable "endpoint_initial_instance_count" {
  description = "Initial number of instances for the SageMaker endpoint"
  type        = number
  default     = 1
}