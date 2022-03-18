resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = local.log_name
  retention_in_days = 1

  tags = {
    Name        = local.log_name
    Environment = var.environment
  }
}