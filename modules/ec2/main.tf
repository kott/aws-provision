


resource "aws_instance" "server_instance" {
  ami           = "ami-922914f7"
  instance_type = "t2.micro"
  key_name      = "test"
  tags          = merge(map("Name", format("%v-instance", var.vpc_name)), var.tags)
}
