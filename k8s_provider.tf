provider "kubernetes" {
  host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, [""]), 0)
  cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, [""]), 0))
  token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, [""]), 0)
}


data "aws_eks_cluster" "cluster" {
  count = var.create_eks ? 1 : 0
  name = aws_eks_cluster.eks_cluster.id
}

data "aws_eks_cluster_auth" "cluster" {
  count = var.create_eks ? 1 : 0
  name = aws_eks_cluster.eks_cluster.id
}

data "template_file" "kubeconfig" {
  template = file("${path.module}/templates/kubeconfig.tpl")

  vars = {
    kubeconfig_name           = "eks_${aws_eks_cluster.eks_cluster.name}"
    clustername               = aws_eks_cluster.eks_cluster.name
    endpoint                  = aws_eks_cluster.eks_cluster.endpoint
    cluster_auth_base64       = data.aws_eks_cluster.cluster[0].certificate_authority[0].data
  }
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = pathexpand("~/.kube/config")
}