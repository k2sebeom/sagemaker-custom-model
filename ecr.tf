resource "aws_ecr_repository" "model_container_repo" {
  name                 = "sagemaker-${var.model_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}
