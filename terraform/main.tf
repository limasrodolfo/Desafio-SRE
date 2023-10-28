module "vpc" {
  source           = "./modules/vpc"
  application_name = "desafio"
}

module "ec2-public" {
  source           = "./modules/ec2-public"
  application_name = "desafio"
  vpc_id = module.vpc.vpc_id
  subnet_id        = module.vpc.public_subnet_ids
}