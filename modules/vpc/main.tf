
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "dedicated"
  tags = merge(map("Name", var.vpc_name), var.tags)
}

# Subnets
resource "aws_subnet" "vpc-subnet-a-public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_a_cidr
  availability_zone = var.availability_zone_a
  tags = merge(map("Name", "vpc-subnet-a-public"), var.tags)
}
resource "aws_subnet" "vpc-subnet-a-private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_a_cidr
  availability_zone = var.availability_zone_a
  tags = merge(map("Name", "vpc-subnet-a-private"), var.tags)
}
resource "aws_subnet" "vpc-subnet-b-public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_b_cidr
  availability_zone = var.availability_zone_b
  tags = merge(map("Name", "vpc-subnet-b-public"), var.tags)
}
resource "aws_subnet" "vpc-subnet-b-private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_b_cidr
  availability_zone = var.availability_zone_b
  tags = merge(map("Name", "vpc-subnet-b-private"), var.tags)
}
resource "aws_subnet" "vpc-subnet-c-public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_c_cidr
  availability_zone = var.availability_zone_c
  tags = merge(map("Name", "vpc-subnet-c-public"), var.tags)
}
resource "aws_subnet" "vpc-subnet-c-private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_c_cidr
  availability_zone = var.availability_zone_c
  tags = merge(map("Name", "vpc-subnet-c-private"), var.tags)
}
