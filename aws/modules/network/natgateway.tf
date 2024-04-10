resource "aws_nat_gateway" "environment_nat_gateway" {
  # count = local.counter_value

  allocation_id = aws_eip.environment_eip.id
  subnet_id     = aws_subnet.environment_public_subnet.id

  tags = {
    "Name"      = "${var.stage}-${var.project}-nat-gateway-${data.aws_availability_zones.environment_availability_zones.names[0]}"
    "Project"   = var.project
    "Terraform" = "true"
  }
}
