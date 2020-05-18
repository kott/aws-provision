
variable "vpc_name" {
  type        = string
  description = "Name of the vpc in which the service resides"
}

variable "tags" {
  description = "Various tag values assigned to AWS resources"
  type        = map(string)
}
