resource "aws_instance" "Module-server-ec2" {

  ami           = var.ami
  instance_type = var.instance_type

  subnet_id     = var.subnet_id
  vpc_security_group_ids = [ var.security_group_id ]
  key_name      = "TKey"
  associate_public_ip_address = true

  tags = {
    Name = var.instance_tag
  }
}