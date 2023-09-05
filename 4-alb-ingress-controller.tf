module "alb-ingress-controller" {
  source = "./modules/aws-load-balancer-controller"

  count = var.create ? 1 : 0

  account_id = local.account_id
  region     = local.region

  cluster_name                = module.eks-cluster[0].cluster_id
  eks_oidc_root_ca_thumbprint = local.eks_oidc_root_ca_thumbprint
  oidc_provider_arn           = module.eks-cluster[0].oidc_provider_arn

  ## the load balancer access logs sync to s3=>lambda=>cloudwatch was disabled/commented-out so this params also need/can be commented,
  ## after then the fix be applied for enabling this functionality we can uncomment them
  # create_alb_log_bucket       = true
  # alb_log_bucket_name = var.alb_log_bucket_name != "" ? var.alb_log_bucket_name : "${module.eks-cluster[0].cluster_id}-ingress-controller-log-bucket"
  # alb_log_bucket_path = var.alb_log_bucket_path != "" ? var.alb_log_bucket_path : module.eks-cluster[0].cluster_id
}
