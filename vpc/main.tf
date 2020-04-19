
provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../modules/vpc"

  availability_zone_a = var.availability_zone_a
  availability_zone_b = var.availability_zone_b
  availability_zone_c = var.availability_zone_c

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr

  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_b_cidr = var.public_subnet_b_cidr
  public_subnet_c_cidr = var.public_subnet_c_cidr

  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
  private_subnet_c_cidr = var.private_subnet_c_cidr

  tags = var.tags
}

module "security-groups" {
  source = "../modules/security-groups"

  vpc_id = module.vpc.id
  tags   = var.tags
}
