data "aws_region" "environment_region" {}

data "aws_availability_zones" "environment_availability_zones" {
  state = "available"
}
