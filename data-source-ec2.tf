data "aws_subnet" "kataka_public_subnet_1_1a" {
  id = "subnet-0ff5e412be860eded"
}

data "aws_security_group" "kataka_security_group" {
  id = "sg-00773af3175e96b57"
}