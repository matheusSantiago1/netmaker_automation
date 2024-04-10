variable "stage" {
  type = string
}

variable "project" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
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
  type = string
}