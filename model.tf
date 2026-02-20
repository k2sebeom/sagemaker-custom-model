resource "aws_sagemaker_model" "custom_model" {
  name               = var.model_name
  execution_role_arn = aws_iam_role.sagemaker_execution_role.arn

  primary_container {
    image          = "${aws_ecr_repository.model_container_repo.repository_url}:${var.model_image_tag}"
    model_data_url = var.model_artifact != null ? "s3://${aws_s3_bucket.model_data_bucket.bucket}/${var.model_artifact}" : null
  }
}
