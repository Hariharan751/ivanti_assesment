provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source          = "../../modules/vpc"
  name            = "eks-dev-vpc"
  cidr            = "10.0.0.0/16"
  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  tags            = local.tags
}

module "eks" {
  source           = "../../modules/eks"
  cluster_name     = "eks-dev"
  cluster_version  = "1.29"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnets
  instance_types   = ["t3.medium"]
  min_size         = 1
  max_size         = 3
  desired_size     = 2
  tags             = local.tags
}

locals {
  tags = {
    Environment = "dev"
    Project     = "eks-devops-assessment"
  }
}
