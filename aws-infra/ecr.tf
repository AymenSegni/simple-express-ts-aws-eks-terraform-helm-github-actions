#######################################
#           ECR Repository            #
#######################################

data "aws_caller_identity" "current" {}
module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "${local.name}-${local.environment}"

  repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = local.tags

}
