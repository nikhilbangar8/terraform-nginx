module "network" {
  source = "./modules/network"

  aws_region         = var.aws_region
  vpc_cidr           = var.vpc_cidr
  primary_sub_cidr   = var.primary_sub_cidr
  secondary_sub_cidr = var.secondary_sub_cidr

}

module "compute" {
  source = "./modules/compute"

  instance_type       = var.instance_type
  vpc_id              = module.network.vpc_id
  primary_subnet_id   = module.network.primary_subnet_id
  secondary_subnet_id = module.network.secondary_subnet_id
  ssh_access_cidr = var.ssh_access_cidr
}
