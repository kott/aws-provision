
variable "service_name" {
  type        = string
  description = "Name of the service"
}

variable "tags" {
  description = "Various tag values assigned to AWS resources"
  type        = map(string)
}
