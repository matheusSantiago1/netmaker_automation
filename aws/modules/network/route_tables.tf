resource "aws_route_table" "environment_private_route_table" {
  # count = local.counter_value

  vpc_id = aws_vpc.environment_vpc.id

  tags = {
    "Name"      = "${var.stage}-${var.project}-private-route-table-${data.aws_availability_zones.environment_availability_zones.names[0]}"
    "Project"   = var.project
    "Terraform" = "true"
  }
}

resource "aws_route_table" "environment_public_route_table" {
  vpc_id = aws_vpc.environment_vpc.id

  tags = {
    "Name" = "${var.stage}-${var.project}-public-route-table-general"
  }
}

#===============================================================================================

resource "aws_route_table_association" "environment_private_route_table_association" {
  # count = local.counter_value

  subnet_id      = aws_subnet.environment_private_subnet.id
  route_table_id = aws_route_table.environment_private_route_table.id
}

resource "aws_route_table_association" "environment_public_route_table_association" {
  # count = local.counter_value

  subnet_id      = aws_subnet.environment_public_subnet.id
  route_table_id = aws_route_table.environment_public_route_table.id
}

#===============================================================================================

resource "aws_route" "environment_private_route" {
  # count = local.counter_value

  route_table_id         = aws_route_table.environment_private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.environment_nat_gateway.id
}

resource "aws_route" "environment_public_route" {
  route_table_id         = aws_route_table.environment_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.environment_internet_gateway.id
}
