provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "vpc" {
  cidr_block = "172.31.0.0/16"
  instance_tenancy = "dedicated"
  tags = merge(map("Name", var.vpc_name), var.tags)
}

# Subnets
resource "aws_subnet" "vpc-subnet-a-public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.0.0/20"
  availability_zone = var.aws_zones[0]
  tags = merge(map("Name", "vpc-subnet-a-public"), var.tags)
}
resource "aws_subnet" "vpc-subnet-a-private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.240.0/20"
  availability_zone = var.aws_zones[0]
  tags = merge(map("Name", "vpc-subnet-a-private"), var.tags)
}
resource "aws_subnet" "vpc-subnet-b-public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.16.0/20"
  availability_zone = var.aws_zones[1]
  tags = merge(map("Name", "vpc-subnet-b-public"), var.tags)
}
resource "aws_subnet" "vpc-subnet-b-private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.224.0/20"
  availability_zone = var.aws_zones[1]
  tags = merge(map("Name", "vpc-subnet-b-private"), var.tags)
}
resource "aws_subnet" "vpc-subnet-c-public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.32.0/20"
  availability_zone = var.aws_zones[2]
  tags = merge(map("Name", "vpc-subnet-c-public"), var.tags)
}
resource "aws_subnet" "vpc-subnet-c-private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.208.0/20"
  availability_zone = var.aws_zones[2]
  tags = merge(map("Name", "vpc-subnet-c-private"), var.tags)
}