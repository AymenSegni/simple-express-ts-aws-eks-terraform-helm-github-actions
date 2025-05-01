terraform {
  backend "s3" {
    key    = "simple-prod-app-helm-tfstate"
    region = "eu-west-1"
  }
}