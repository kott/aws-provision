
aws_region = "us-east-2"

availability_zone_a = "us-east-2a"
availability_zone_b = "us-east-2b"
availability_zone_c = "us-east-2c"

vpc_name = "dev-vpc"
vpc_cidr = "172.31.0.0/16"

public_subnet_a_cidr = "172.31.0.0/20"
public_subnet_b_cidr = "172.31.16.0/20"
public_subnet_c_cidr = "172.31.32.0/20"

private_subnet_a_cidr = "172.31.240.0/20"
private_subnet_b_cidr = "172.31.224.0/20"
private_subnet_c_cidr = "172.31.208.0/20"

## Tags
tags = {
  environment = "dev"
}
