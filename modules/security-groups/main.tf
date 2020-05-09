resource "aws_security_group" "jumpbox" {
  name        = "jumpbox-security-group"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(map("Name", format("%v-jumpbox-security-group", var.vpc_name)), var.tags)
}

resource "aws_security_group" "public_node" {
  name        = "public-node-security-group"
  description = "Allow inbound traffic to public nodes"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jumpbox.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(map("Name", format("%v-public-node-security-group", var.vpc_name)), var.tags)
}

resource "aws_security_group" "private_node" {
  name        = "private-node-security-group"
  description = "Allow inbound traffic to private nodes from public nodes"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow inbound from public group"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.public_node.id]
  }

  ingress {
    description     = "Allow SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jumpbox.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(map("Name", format("%v-public-node-security-group", var.vpc_name)), var.tags)
}

resource "aws_security_group" "database" {
  name        = "database-security-group"
  description = "Allow inbound traffic to database from within the VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow inbound from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(map("Name", format("%v-database-security-group", var.vpc_name), var.tags)
}
