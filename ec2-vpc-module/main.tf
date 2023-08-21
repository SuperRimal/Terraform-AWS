module "server" {
  source = "./modules/server"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.publicSubnet
}

module "vpc" {
  source = "./modules/vpc"
  
}

