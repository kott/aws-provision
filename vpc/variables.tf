# AWS Regions / Zones
variable aws_region {
  type        = string
  description = "AWS region which should be used"
}

# AWS availability zones
variable availability_zone_a {
  type        = string
  description = "AWS AZ where subnet should be created"
}

variable availability_zone_b {
  type        = string
  description = "AWS AZ where subnet should be created"
}

variable availability_zone_c {
  type        = string
  description = "AWS AZ where subnet should be created"
}

# Resource naming
variable vpc_name {
  description = "Name of the VPC"
  type        = string
}

# Resource CIDR blocks
variable "vpc_cidr" {
  type        = string
  description = "CIDR block"
}

variable "public_subnet_a_cidr" {
  type        = string
  description = "CIDR block"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "CIDR block"
}

variable "public_subnet_c_cidr" {
  type        = string
  description = "CIDR block"
}

variable "private_subnet_a_cidr" {
  type        = string
  description = "CIDR block"
}

variable "private_subnet_b_cidr" {
  type        = string
  description = "CIDR block"
}

variable "private_subnet_c_cidr" {
  type        = string
  description = "CIDR block"
}

# Tags
variable tags {
  description = "Various tag values assigned to AWS resources"
  type        = map(string)
}
