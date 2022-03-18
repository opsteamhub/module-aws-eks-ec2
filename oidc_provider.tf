provider "external" {
}

resource "aws_iam_openid_connect_provider" "main" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.aws_eks_cluster.cluster_eks.certificate_authority[0].data]
  url             = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_openid_connect_provider" "main_arn" {
  arn = aws_iam_openid_connect_provider.main.arn
}

