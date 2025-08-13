resource "aws_instance" "kataka_ec2" {
  ami           = "ami-0a7d80731ae1b2435"
  instance_type = "t2.micro"
  key_name = "TKey"
  subnet_id = aws_subnet.kataka_public_subnet_1_1a.id
  security_groups = [ aws_security_group.kataka_security_group.id ]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "kataka_ec2"
  }
}