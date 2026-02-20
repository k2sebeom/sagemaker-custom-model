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