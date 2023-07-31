variable "access_key" {}

variable "secret_key" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "fargate_subnet_id_1" {
  type = string
}

variable "fargate_subnet_id_2" {
  type = string
}

variable "nlb_subnet_id_1" {
  type = string
}

variable "nlb_subnet_id_2" {
  type = string
}

data "aws_caller_identity" "current" {}

data "aws_vpc" "flbase_prod_vpc" {
  id = var.vpc_id
}

