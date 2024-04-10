# variable "counter_value" {
#   type = map(string)
#   default = {
#     "dev" = 1
#   }
# }

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

variable "cidr_block_prefix" {
  type = string
}
