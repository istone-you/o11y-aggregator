variable "region" {
  default = "ap-northeast-1"
}

variable "role_arn" {
  type = string
}

variable "task_family_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "repository_name" {
  type = string
}

variable "container_port" {
  type = number
}

variable "healthcheck_port" {
  type = number
}

data "aws_caller_identity" "current" {}
