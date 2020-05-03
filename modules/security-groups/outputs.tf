
output "ssh_group" {
  value = aws_security_group.jumpbox.id
}

output "public_node_group" {
  value = aws_security_group.public_node.id
}

output "private_node_group" {
  value = aws_security_group.private_node.id
}

output "db_group" {
  value = aws_security_group.database.id
}
