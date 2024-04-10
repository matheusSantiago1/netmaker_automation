output "aws_region" {
  value = data.aws_region.environment_region.id
}

output "vpc_id" {
  value = aws_vpc.environment_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.environment_vpc.cidr_block
}

output "private_subnets_ids" {
  description = "List of IDs of the Private Subnets"
  value       = aws_subnet.environment_private_subnet.id
}

output "public_subnets_ids" {
  description = "List of IDs of the Public Subnets"
  value       = aws_subnet.environment_public_subnet.id
}
