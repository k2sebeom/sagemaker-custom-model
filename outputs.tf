output "ecr_repository_url" {
  description = "URL of the model container ECR repository"
  value       = aws_ecr_repository.model_container_repo.repository_url
}

output "s3_bucket_name" {
  description = "Name of the model data S3 bucket"
  value       = aws_s3_bucket.model_data_bucket.bucket
}

output "model_execution_role" {
  value = aws_iam_role.sagemaker_execution_role.arn
}

output "sagemaker_model" {
  value = aws_sagemaker_model.custom_model.arn
}
