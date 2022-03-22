provider "kubernetes" {
  #host                   = data.aws_eks_cluster.cluster_endpoint.endpoint
  host = "https://EE01BA6999346DD665B6E8B2B0E28457.sk1.sa-east-1.eks.amazonaws.com"
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

data "aws_eks_cluster" "cluster_endpoint" {
  name = aws_eks_cluster.eks_cluster.endpoint
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

data "template_file" "kubeconfig" {
  template = file("${path.module}/templates/kubeconfig.tpl")

  vars = {
    kubeconfig_name           = "eks_${aws_eks_cluster.eks_cluster.name}"
    clustername               = aws_eks_cluster.eks_cluster.name
    endpoint                  = aws_eks_cluster.eks_cluster.endpoint
    cluster_auth_base64       = data.aws_eks_cluster.cluster.certificate_authority[0].data
  }
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = pathexpand("~/.kube/config")
}