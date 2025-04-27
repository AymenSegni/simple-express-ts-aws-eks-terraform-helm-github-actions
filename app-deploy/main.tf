module "app_deploy" {
  source  = "cloudposse/helm-release/aws"
  version = "v0.10.1"

  # helm release settings 
  atomic               = true
  cleanup_on_fail      = true
  timeout              = 300
  wait                 = true
  name                 = "${local.name}-${local.environment}"
  create_namespace     = true
  kubernetes_namespace = "${local.name}-${local.environment}"

  # required: OIDC issuer URL for the EKS cluste
  eks_cluster_oidc_issuer_url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer


  # Specify the Helm chart details to deploy
  chart         = "${path.module}/helm"
  chart_version = "0.0.1"

  tags = local.tags

  values = [
    templatefile("${path.module}/helm/values.yaml",

      {
        image = var.image

    })
  ]
}

variable "image" {
  type        = string
  description = "Full docker image path on ECR"
  default     = ""
}

