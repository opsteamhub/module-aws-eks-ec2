resource "aws_eks_cluster" "eks_cluster" {

  name     = local.name
  role_arn = aws_iam_role.eks_master_role.arn
  version  = var.kubernetes_version
  
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  encryption_config {
  provider     = "kms"
  resources    = "secrets"
  key_arn      = aws_kms_key.eks.key_arn
  }

  vpc_config {

      subnet_ids = [
        aws_subnet.eks_subnet_private_1a.id, 
        aws_subnet.eks_subnet_private_1b.id,
        aws_subnet.eks_subnet_private_1c.id
      ]
      
  }

  timeouts {
    delete = "30m"
  }

  depends_on = [
    aws_cloudwatch_log_group.eks_cluster,
    aws_iam_role_policy_attachment.eks_cluster_cluster,
    aws_iam_role_policy_attachment.eks_cluster_service
  ]

}