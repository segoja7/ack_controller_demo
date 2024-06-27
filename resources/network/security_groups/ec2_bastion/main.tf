module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  create = local.workspace["create"]
  name   = local.workspace["name"]
  vpc_id = local.workspace["vpc_id"]

  use_name_prefix = local.workspace["use_name_prefix"]
  description     = local.workspace["description"]

  ingress_with_cidr_blocks = local.workspace["ingress_with_cidr_blocks"]
  egress_with_cidr_blocks  = local.workspace["egress_with_cidr_blocks"]

  ingress_with_source_security_group_id = local.workspace["ingress_with_source_security_group_id"]
  egress_with_source_security_group_id  = local.workspace["egress_with_source_security_group_id"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}

