module "iam_iam-assumable-role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.39.1"

  allow_self_assume_role  = local.workspace["allow_self_assume_role"]
  trusted_role_services   = local.workspace["trusted_role_services"]
  create_role             = local.workspace["create_role"]
  create_instance_profile = local.workspace["create_instance_profile"]
  role_name               = local.workspace["role_name"]
  role_requires_mfa       = local.workspace["role_requires_mfa"]
  attach_admin_policy     = local.workspace["attach_admin_policy"]
  custom_role_policy_arns = local.workspace["custom_role_policy_arns"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}