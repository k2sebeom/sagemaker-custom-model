# SageMaker Custom Model Terraform Module

Terraform module for provisioning AWS infrastructure to deploy custom models on Amazon SageMaker.

## Features

- ECR repository for custom model container images
- S3 bucket for model artifacts
- IAM execution role with necessary SageMaker permissions
- SageMaker model resource configuration
- Optional SageMaker endpoint deployment

## Usage

### Local

```hcl
module "sagemaker_model" {
  source = "."

  model_name      = "my-custom-model"
  model_image_tag = "v1.0.0"
  model_artifact  = "model.tar.gz"  # optional
  aws_region      = "us-west-2"     # optional
}
```

### From GitHub

```hcl
module "sagemaker_model" {
  source = "github.com/k2sebeom/sagemaker-custom-model-infra"

  model_name      = "my-custom-model"
  model_image_tag = "v1.0.0"
  model_artifact  = "model.tar.gz"  # optional
  aws_region      = "us-west-2"     # optional
}
```

Pin to a specific tag or commit for stability:

```hcl
module "sagemaker_model" {
  source = "github.com/k2sebeom/sagemaker-custom-model-infra?ref=v1.0.0"

  model_name      = "my-custom-model"
  model_image_tag = "v1.0.0"
}
```

### With Endpoint Deployment

Set `deploy_endpoint = true` to also provision a SageMaker endpoint:

```hcl
module "sagemaker_model" {
  source = "github.com/k2sebeom/sagemaker-custom-model-infra?ref=v1.0.0"

  model_name      = "my-custom-model"
  model_image_tag = "v1.0.0"

  deploy_endpoint                 = true
  endpoint_instance_type          = "ml.g4dn.xlarge"
  endpoint_initial_instance_count = 1
}

output "endpoint_name" {
  value = module.sagemaker_model.sagemaker_endpoint_name
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| model_name | Name of the SageMaker model | `string` | n/a | yes |
| model_image_tag | Tag of the deployed model | `string` | `"latest"` | no |
| model_artifact | Model artifact path in S3 | `string` | `null` | no |
| aws_region | AWS region | `string` | `"us-west-2"` | no |
| deploy_endpoint | Whether to deploy a SageMaker endpoint | `bool` | `false` | no |
| endpoint_instance_type | Instance type for the SageMaker endpoint | `string` | `"ml.m5.large"` | no |
| endpoint_initial_instance_count | Initial number of instances for the endpoint | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| ecr_repository_url | URL of the model container ECR repository |
| s3_bucket_name | Name of the model data S3 bucket |
| model_execution_role | ARN of the SageMaker execution role |
| sagemaker_model | ARN of the SageMaker model |
| sagemaker_endpoint_name | Name of the SageMaker endpoint (`null` if `deploy_endpoint` is `false`) |
| sagemaker_endpoint_arn | ARN of the SageMaker endpoint (`null` if `deploy_endpoint` is `false`) |

## Requirements

- Terraform >= 1.0
- AWS Provider
