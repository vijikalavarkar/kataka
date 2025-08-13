resource "aws_route_table" "kataka_public_route_table" {

  vpc_id = var.vpc_id

  route {
    cidr_block = var.public_route_table_cidr
    gateway_id = var.igw_id

  }

  tags = {
    Name = var.kataka_rt_tag
  }
}