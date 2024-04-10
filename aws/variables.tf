variable "project" {
  description = "Name of the Infrastructure Project"
  type        = string
}

# variable "dns_zone" {
#   type = string
# }

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "cidr_block_prefix" {
  description = "Prefix of the CIDR Block of the AWS VPC"
  type        = string
}

variable "stage" {
  description = "Stage of environment"
  type = string
}

variable "netmaker_domain" {
  description = "Domain for Netmaker Server"
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "hosted_zone_id" {
  type = string
}

variable "secret_name" {
  description = "Secret name of Token Netmaker value"
  type = string
}