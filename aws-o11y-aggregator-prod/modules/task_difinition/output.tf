output "task_definition_arn" {
  value = aws_ecs_task_definition.task_definition.arn
}

output "container_name" {
  value = var.container_name
}

output "container_port" {
  value = var.container_port
}

output "healthcheck_port" {
  value = var.healthcheck_port
}
