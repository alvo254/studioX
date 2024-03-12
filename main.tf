module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "efs" {
  source = "./modules/efs"
}

module "s3" {
  source = "./modules/s3"
}

module "ec2" {
  source             = "./modules/ec2"
  subnet             = module.vpc.subnet_id
  security_group     = module.sg.security_group
  efs_file_system_id = module.efs.efs_id
  pub_sub2_id = module.vpc.pub_sub2_id

}