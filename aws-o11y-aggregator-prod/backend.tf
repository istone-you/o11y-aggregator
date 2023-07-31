terraform {
  cloud {
    organization = ""

    workspaces {
      name = "aws-o11y-aggregator-prod"
    }
  }
}
