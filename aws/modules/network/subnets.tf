resource "aws_subnet" "environment_private_subnet" {
  # count = local.counter_value

  vpc_id            = aws_vpc.environment_vpc.id
  cidr_block        = local.subnet_private_cidr_block
  availability_zone = data.aws_availability_zones.environment_availability_zones.names[0]

  tags = {
    "Name" = "${var.stage}-${var.project}-private-subnet-${data.aws_availability_zones.environment_availability_zones.names[0]}"
  }
}

resource "aws_subnet" "environment_public_subnet" {
  # count = local.counter_value

  vpc_id            = aws_vpc.environment_vpc.id
  cidr_block        = local.subnet_public_cidr_block
  availability_zone = data.aws_availability_zones.environment_availability_zones.names[0]

  tags = {
    "Name" = "${var.stage}-${var.project}-public-subnet-${data.aws_availability_zones.environment_availability_zones.names[0]}"
  }
}
