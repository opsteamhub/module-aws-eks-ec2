
###### main.tf
```
variable "environment" {}

module "eks" {
  source = "github.com/opsteamhub/module-aws-eks-ec2"
  name         = var.name
  region       = var.region
  environment  = var.environment  
}
```