
  resource "aws_kms_key" "eks" {
  description             = join("-", ["kms", local.name])
  deletion_window_in_days = 7
  multi_region            = true

  tags = {
    Name          = join("-", ["kms", local.name])
    ProvisionedBy = local.provisioner
    Squad         = local.squad
    Service       = local.service
  }
}

resource "aws_kms_alias" "eks" {
  name          = "alias/${local.name}-kms-key"
  target_key_id = aws_kms_key.eks.key_id
}