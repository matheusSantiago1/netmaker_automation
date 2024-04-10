resource "aws_eip" "environment_eip" {
  depends_on = [
    aws_vpc.environment_vpc
  ]
  # count = local.counter_value

  domain = "vpc"

  tags = {
    "Name"      = "${var.stage}-${var.project}-eip-${data.aws_availability_zones.environment_availability_zones.names[0]}"
    "Project"   = var.project
    "Terraform" = "true"
  }
}
