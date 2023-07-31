resource "aws_ecs_cluster" "o11y_aggregator" {
  name = "o11y-aggregator"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "O11yAggregatorTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

resource "aws_lb" "nlb" {
  name               = "o11y-aggregator"
  internal           = true
  load_balancer_type = "network"
  subnets = [
    var.nlb_subnet_id_1,
    var.nlb_subnet_id_2
  ]
}
