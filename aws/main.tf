module "network" {
  source = "./modules/network"

  stage             = var.stage
  project           = var.project
  aws_account_id    = sensitive(local.aws_account_id)
  aws_region        = var.aws_region
  cidr_block_prefix = var.cidr_block_prefix
}

module "servers" {
  source     = "./modules/servers"
  depends_on = [module.network]

  stage           = var.stage
  project         = var.project
  aws_account_id  = sensitive(local.aws_account_id)
  aws_region      = var.aws_region
  vpc_id          = module.network.vpc_id
  subnet_id       = module.network.public_subnets_ids
  access_key      = var.access_key
  secret_key      = var.secret_key
  hosted_zone_id  = var.hosted_zone_id
  netmaker_domain = var.netmaker_domain
  secret_name     = var.secret_name
}
