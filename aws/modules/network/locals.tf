locals {
  aws_region = data.aws_region.environment_region.id
  # counter_value             = lookup(var.counter_value, var.stage, 1)
  vpc_cidr_block            = "${var.cidr_block_prefix}.0.0/16"
  subnet_public_cidr_block  = "${var.cidr_block_prefix}.0.0/22"
  subnet_private_cidr_block = "${var.cidr_block_prefix}.12.0/22"
}
