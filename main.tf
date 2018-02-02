provider "aws" {
  region = "eu-central-1"
  profile = "default"
}

provider "aws" {
  alias = "west"
  region = "us-east-1"
  profile = "default"
}

module "example" {
  source    = "./example"
  providers = {
    aws = "aws.usw2"
    aws.west = ""
  }
}