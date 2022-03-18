provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster_eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.main.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

provider "local" {
}

provider "template" {
}

data "template_file" "kubeconfig" {
  template = file("${path.module}/templates/kubeconfig.tpl")

  vars = {
    kubeconfig_name           = "eks_${aws_eks_cluster.main.name}"
    clustername               = aws_eks_cluster.eks_cluster.name
    endpoint                  = data.aws_eks_cluster.cluster.endpoint
    cluster_auth_base64       = data.aws_eks_cluster.cluster_eks.certificate_authority[0].data
  }
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = pathexpand("~/.kube/config")
}