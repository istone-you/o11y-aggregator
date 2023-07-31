module "metrics_aggregator_task_definition" {
  source = "./modules/task_difinition"

  region           = "ap-northeast-1"
  task_family_name = "o11y-metrics-aggregator"
  container_name   = "metrics-aggregator"
  repository_name  = "o11y-metrics-aggregator"
  container_port   = 4318
  healthcheck_port = 13133
  role_arn         = aws_iam_role.ecs_task_execution_role.arn
}

module "metrics_aggregator_service" {
  source = "./modules/service"

  service_name        = "metrics-aggregator"
  desired_count       = 2
  fargate_subnet_id_1 = var.fargate_subnet_id_1
  fargate_subnet_id_2 = var.fargate_subnet_id_2
  security_group_id   = var.security_group_id
  vpc_id              = data.aws_vpc.flbase_prod_vpc.id
  nlb_arn             = aws_lb.nlb.arn
  cluster_id          = aws_ecs_cluster.o11y_aggregator.id
  task_definition_arn = module.metrics_aggregator_task_definition.task_definition_arn
  container_name      = module.metrics_aggregator_task_definition.container_name
  container_port      = module.metrics_aggregator_task_definition.container_port
  healthcheck_port    = module.metrics_aggregator_task_definition.healthcheck_port
}
