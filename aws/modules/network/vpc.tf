resource "aws_vpc" "environment_vpc" {
  cidr_block = local.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name"      = "${var.stage}-${var.project}-vpc"
    "Project"   = var.project
    "Terraform" = "true"
  }
}
