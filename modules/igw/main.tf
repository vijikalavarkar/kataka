resource "aws_internet_gateway" "kataka_igw" {
  vpc_id = var.vpc_id


  tags = {
    Name = var.igw_tag
  }
}