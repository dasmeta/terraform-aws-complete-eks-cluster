locals {
  oidc_provider_arn = "arn:aws:iam::000000000000:oidc-provider/oidc.eks.eu-central-1.amazonaws.com/id/6F40EA94327Dh8956DDB9S0AE7907CFD"
}

module "fluent-bit" {
  source = "../../"

  cluster_name                = "Test"
  oidc_provider_arn           = local.oidc_provider_arn
  eks_oidc_root_ca_thumbprint = replace(local.oidc_provider_arn, "/.*id//", "")
  region                      = "eu-central-1"
  log_group_name              = "Test-fluent-bit"
  create_log_group            = true
  account_id                  = 000000000000
  log_retention_days          = 7
}
