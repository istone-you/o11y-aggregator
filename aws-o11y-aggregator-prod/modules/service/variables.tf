variable "fargate_subnet_id_1" {
  type = string
}

variable "fargate_subnet_id_2" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "nlb_arn" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "task_definition_arn" {
  type = string
}

variable "service_name" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}

variable "healthcheck_port" {
  type = number
}
