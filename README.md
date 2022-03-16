
###### main.tf
```
variable "environment" {}
variable "vpc_id" {}
variable "private_subnet_id {}

module "eks" {
  source = "github.com/opsteamhub/module-aws-eks-ec2"
  
  name              = var.name
  region            = var.region
  environment       = var.environment  
  private_subnet_id = var.private_subnet_id
  vpc_id            = var.vpc_id
}
```