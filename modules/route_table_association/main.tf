resource "aws_route_table_association" "kataka_public_route_table_association_1" {
  subnet_id      = var.subnet1_id
  route_table_id = var.route_table_id
}

resource "aws_route_table_association" "kataka_public_route_table_association_2" {
  subnet_id      = var.subnet2_id
  route_table_id = var.route_table_id
}

resource "aws_route_table_association" "kataka_public_route_table_association_3" {
  subnet_id      = var.subnet3_id
  route_table_id = var.route_table_id
}


