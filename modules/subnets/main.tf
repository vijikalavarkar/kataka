resource "aws_subnet" "kataka_subnet_1_1a" {

  vpc_id     = var.vpc_id
  cidr_block = var.subnet1_cidr

  tags = {
    Name = var.subnet1_tag
  }
}


resource "aws_subnet" "kataka_subnet_2_1a" {

  vpc_id     = var.vpc_id
  cidr_block = var.subnet2_cidr

  tags = {
    Name = var.subnet2_tag
  }
}



resource "aws_subnet" "kataka_subnet_3_1b" {

  vpc_id     = var.vpc_id
  cidr_block = var.subnet3_cidr

  tags = {
    Name = var.subnet3_tag
  }
}

