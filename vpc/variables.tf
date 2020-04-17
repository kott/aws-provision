# Tags

variable tags {
  description = "Different tag values which should be assigned to AWS resources created via Terraform)"
  type = map(string)
}

# AWS Regions / Zones

variable aws_region {
  type = string
  description = "AWS region which should be used"
}

variable aws_zones {
  type = list(string)
  description = "AWS AZs (Availability zones) where subnets should be created"
}

# Resource naming

variable vpc_name {
  description = "Name of the VPC"
  type = string
}
