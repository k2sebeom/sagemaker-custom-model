# SageMaker Custom Model Terraform Module

Terraform module for provisioning AWS infrastructure to deploy custom models on Amazon SageMaker.

## Features

- ECR repository for custom model container images
- S3 bucket for model artifacts
- IAM execution role with necessary SageMaker permissions
- SageMaker model resource configuration

## Usage

```hcl
module "sagemaker_model" {
  source = "."

  model_name        = "my-custom-model"
  model_image_tag   = "v1.0.0"
  model_artifact    = "model.tar.gz"  # optional
  aws_region        = "us-west-2"     # optional
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| model_name | Name of the SageMaker model | `string` | n/a | yes |
| model_image_tag | Tag of the deployed model | `string` | `"latest"` | no |
| model_artifact | Model artifact path in S3 | `string` | `null` | no |
| aws_region | AWS region | `string` | `"us-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ecr_repository_url | URL of the model container ECR repository |
| s3_bucket_name | Name of the model data S3 bucket |
| model_execution_role | ARN of the SageMaker execution role |
| sagemaker_model | ARN of the SageMaker model |

## Requirements

- Terraform >= 1.0
- AWS Provider
