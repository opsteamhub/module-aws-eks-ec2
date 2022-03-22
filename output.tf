output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "private_subnet_1a" {
  value = aws_subnet.eks_subnet_private_1a.id
}

output "private_subnet_1b" {
  value = aws_subnet.eks_subnet_private_1b.id
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster[0].id
}


output "launch_template_name" {
    value = aws_launch_template.node.name
}

output "launch_template_version" {
    value = aws_launch_template.node.latest_version
}

output "identity-oidc-issuer" {
  value = data.aws_eks_cluster.cluster[0].identity[0].oidc[0].issuer
}

output "kubeconfig-certificate-authority-data" {
  value = data.aws_eks_cluster.cluster[0].certificate_authority[0].data
}