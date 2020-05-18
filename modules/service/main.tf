
resource "aws_ecr_repository" "repo" {
  name = var.service_name
  tags = merge(map("Name", var.service_name), var.tags)
}
