
variable "vpc_id" {
  type        = string
  description = "ID of the created VPC"
}

# Tags
variable tags {
  description = "Various tag values assigned to AWS resources"
  type        = map(string)
}
