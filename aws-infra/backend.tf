terraform {
  backend "s3" {
    key    = "simple-prod-tfstate"
    region = "eu-west-1"
  }
}