locals {
  name        = "simple"
  region      = "eu-west-1"
  environment = "prod"
  tags = {
    team        = "app_team"
    environment = "prod"
    terraform   = "true"
  }
}
