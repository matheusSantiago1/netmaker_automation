resource "aws_internet_gateway" "environment_internet_gateway" {
  vpc_id = aws_vpc.environment_vpc.id

  tags = {
    "Name"      = "${var.stage}-${var.project}-internet-gateway"
    "Project"   = var.project
    "Terraform" = "true"
  }
}
