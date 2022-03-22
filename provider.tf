provider "aws" {
  region = var.region
}

required_providers {
  kubernetes = {
    source  = "registry.terraform.io/hashicorp/kubernetes"
    version = "~> 1.0"
  }
}