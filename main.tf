module "vpc" {
  source       = "./vpc"
  resoursename = var.resoursename
}

module "rdb" {
  source          = "./rdb"
  instance_type   = var.instance_type
  resoursename    = var.resoursename
  username        = var.username
  password        = var.password
  rds_sg          = module.security-group.rds_sg
  subnet-group-id = module.vpc.subnet-group-id

}

module "security-group" {
  source       = "./security-group"
  resoursename = var.resoursename
  vpc-id       = module.vpc.vpc-id
}

module "ec2" {
  source        = "./ec2"
  vpc-id        = module.vpc.vpc-id
  resoursename  = var.resoursename
  sg-id         = module.security-group.sg_id
  subnet-id     = module.vpc.subnet-id
  instance_type = var.instance_type
  depends_on    = [module.rdb]
}
