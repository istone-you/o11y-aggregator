resource "aws_ecs_task_definition" "yace_exporter_task_definition" {
  family                   = "o11y-yace-exporter"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      "name" : "yace-exporter",
      "image" : "${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/o11y-yace-exporter:latest",
      "portMappings" : [
        {
          "containerPort" : 5000,
          "hostPort" : 5000,
          "protocol" : "tcp"
        }
      ],
      "essential" : true,
      "cpu" : 0,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-region" : "${var.region}",
          "awslogs-group" : "/ecs/yace-exporter",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    },
    {
      "name" : "otel-collector",
      "image" : "${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/o11y-otel-4-yace:latest",
      "essential" : true,
      "cpu" : 0,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-region" : "${var.region}",
          "awslogs-group" : "/ecs/yace-exporter",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "yace_exporter_service" {
  name            = "yace-exporter"
  cluster         = aws_ecs_cluster.o11y_aggregator.id
  task_definition = aws_ecs_task_definition.yace_exporter_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    security_groups = [var.security_group_id]
    subnets = [
      var.fargate_subnet_id_1,
      var.fargate_subnet_id_2
    ]
    assign_public_ip = true
  }
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
}
