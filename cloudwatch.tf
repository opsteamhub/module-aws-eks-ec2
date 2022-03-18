resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = "/aws/eks/${local.name}/cluster"
  retention_in_days = 1

  tags = {
    Name        = "${local.name}-eks-cloudwatch-log-group"
    Environment = var.environment
  }
}