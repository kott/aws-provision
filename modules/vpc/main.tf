
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "dedicated"
  tags             = merge(map("Name", var.vpc_name), var.tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(map("Name", format("igw-%v", var.vpc_name)), var.tags)
}

# elastic IPs (one per AZ)
resource "aws_eip" "eip_a" {
  vpc  = true
  tags = merge(map("Name", "eip-a"), var.tags)
}

resource "aws_eip" "eip_b" {
  vpc  = true
  tags = merge(map("Name", "eip-b"), var.tags)
}

resource "aws_eip" "eip_c" {
  vpc  = true
  tags = merge(map("Name", "eip-c"), var.tags)
}


# subnets & nat gateways (3 public 3 private across 3 AZ)

# public subnet a
resource "aws_subnet" "vpc_subnet_a_public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = var.availability_zone_a
  tags              = merge(map("Name", "vpc-subnet-a-public"), var.tags)
}

resource "aws_nat_gateway" "nat_subnet_a" {
  allocation_id = aws_eip.eip_a.id
  subnet_id     = aws_subnet.vpc_subnet_a_public.id
  tags          = merge(map("Name", "nat-subnet-a"), var.tags)
  depends_on    = [aws_eip.eip_a, aws_internet_gateway.igw, aws_subnet.vpc_subnet_a_public]
}

# public subnet b
resource "aws_subnet" "vpc_subnet_b_public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_b_cidr
  availability_zone = var.availability_zone_b
  tags              = merge(map("Name", "vpc-subnet-b-public"), var.tags)
}

resource "aws_nat_gateway" "nat_subnet_b" {
  allocation_id = aws_eip.eip_b.id
  subnet_id     = aws_subnet.vpc_subnet_b_public.id
  tags          = merge(map("Name", "nat-subnet-b"), var.tags)
  depends_on    = [aws_eip.eip_b, aws_internet_gateway.igw, aws_subnet.vpc_subnet_b_public]
}

# public subnet c
resource "aws_subnet" "vpc_subnet_c_public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_c_cidr
  availability_zone = var.availability_zone_c
  tags              = merge(map("Name", "vpc-subnet-c-public"), var.tags)
}

resource "aws_nat_gateway" "nat_subnet_c" {
  allocation_id = aws_eip.eip_c.id
  subnet_id     = aws_subnet.vpc_subnet_c_public.id
  tags          = merge(map("Name", "nat-subnet-c"), var.tags)
  depends_on    = [aws_eip.eip_c, aws_internet_gateway.igw, aws_subnet.vpc_subnet_c_public]
}


# private subnets

# private subnet a
resource "aws_subnet" "vpc_subnet_a_private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = var.availability_zone_a
  tags              = merge(map("Name", "vpc-subnet-a-private"), var.tags)
}

# private subnet b
resource "aws_subnet" "vpc_subnet_b_private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = var.availability_zone_b
  tags              = merge(map("Name", "vpc-subnet-b-private"), var.tags)
}

# private subnet c
resource "aws_subnet" "vpc_subnet_c_private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_c_cidr
  availability_zone = var.availability_zone_c
  tags              = merge(map("Name", "vpc-subnet-c-private"), var.tags)
}

# routing – defining the routes within a subnet and associating the subnet with the route table

# route table for public subnets
resource "aws_route_table" "route_public" {
  vpc_id = aws_vpc.vpc.id

  # default route through Internet Gateway
  # note: mapping the VPC's CIDR block to "local", is created implicitly
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(map("Name", format("%v-public-route-table", var.vpc_name)), var.tags)
}

resource "aws_route_table_association" "route_public_a" {
  subnet_id      = aws_subnet.vpc_subnet_a_public.id
  route_table_id = aws_route_table.route_public.id
}

resource "aws_route_table_association" "route_public_b" {
  subnet_id      = aws_subnet.vpc_subnet_b_public.id
  route_table_id = aws_route_table.route_public.id
}

resource "aws_route_table_association" "route_public_c" {
  subnet_id      = aws_subnet.vpc_subnet_c_public.id
  route_table_id = aws_route_table.route_public.id
}

# route table for private subnets
resource "aws_route_table" "private_route_a" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_subnet_a.id
  }
  tags = merge(map("Name", format("%v-private-route-a", var.vpc_name)), var.tags)
}

resource "aws_route_table" "private_route_b" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_subnet_b.id
  }
  tags = merge(map("Name", format("%v-private-route-b", var.vpc_name)), var.tags)
}

resource "aws_route_table" "private_route_c" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_subnet_c.id
  }
  tags = merge(map("Name", format("%v-private-route-c", var.vpc_name)), var.tags)
}

resource "aws_route_table_association" "private_route_a" {
  subnet_id      = aws_subnet.vpc_subnet_a_private.id
  route_table_id = aws_route_table.private_route_a.id
}

resource "aws_route_table_association" "private_route_b" {
  subnet_id      = aws_subnet.vpc_subnet_b_private.id
  route_table_id = aws_route_table.private_route_b.id
}

resource "aws_route_table_association" "private_route_c" {
  subnet_id      = aws_subnet.vpc_subnet_c_private.id
  route_table_id = aws_route_table.private_route_c.id
}
