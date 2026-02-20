# SageMaker Execution Role
resource "aws_iam_role" "sagemaker_execution_role" {
  name = "AmazonSageMaker-ExecutionRole-${var.model_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AWS managed policies to the SageMaker execution role
resource "aws_iam_role_policy_attachment" "sagemaker_canvas_ai_services_access" {
  role       = aws_iam_role.sagemaker_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerCanvasAIServicesAccess"
}

resource "aws_iam_role_policy_attachment" "sagemaker_canvas_data_prep_full_access" {
  role       = aws_iam_role.sagemaker_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerCanvasDataPrepFullAccess"
}

resource "aws_iam_role_policy_attachment" "sagemaker_canvas_full_access" {
  role       = aws_iam_role.sagemaker_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerCanvasFullAccess"
}

resource "aws_iam_role_policy_attachment" "sagemaker_canvas_sm_data_science_assistant_access" {
  role       = aws_iam_role.sagemaker_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerCanvasSMDataScienceAssistantAccess"
}

resource "aws_iam_role_policy_attachment" "sagemaker_full_access" {
  role       = aws_iam_role.sagemaker_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

# Custom policy for S3 and ECR access
resource "aws_iam_policy" "sagemaker_s3_ecr_access" {
  name        = "SageMaker-S3-ECR-Access-${var.model_name}"
  description = "Policy for SageMaker to access project S3 bucket and ECR repository"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.model_data_bucket.arn,
          "${aws_s3_bucket.model_data_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken"
        ]
        Resource = [
          aws_ecr_repository.model_container_repo.arn,
          "*"
        ]
      }
    ]
  })
}

# Attach the custom policy to the SageMaker execution role
resource "aws_iam_role_policy_attachment" "sagemaker_s3_ecr_access" {
  role       = aws_iam_role.sagemaker_execution_role.name
  policy_arn = aws_iam_policy.sagemaker_s3_ecr_access.arn
}

