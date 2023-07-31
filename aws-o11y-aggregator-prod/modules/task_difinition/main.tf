resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.task_family_name
  execution_role_arn       = var.role_arn
  task_role_arn            = var.role_arn
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      "name" : var.container_name,
      "image" : "${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${var.repository_name}:latest",
      "portMappings" : [
        {
          "containerPort" : var.healthcheck_port,
          "hostPort" : var.healthcheck_port,
          "protocol" : "tcp"
        },
        {
          "containerPort" : var.container_port,
          "hostPort" : var.container_port,
          "protocol" : "tcp"
        }
      ],
      "memory" : 512,
      "cpu" : 0,
      "essential" : true,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-region" : "${var.region}",
          "awslogs-group" : "/ecs/${var.container_name}",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}
