locals {
  env = {
    default = {
      create = false
      # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
      allow_self_assume_role = false

      trusted_role_services = [
        "ec2.amazonaws.com"
      ]

      create_role             = true
      create_instance_profile = true

      role_name         = lower("${var.project}-${terraform.workspace}-bastion-role")
      role_requires_mfa = false

      attach_admin_policy = false

      custom_role_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
      tags = {
        Environment = terraform.workspace
        Protected   = "Private"
        Layer       = "Security"
      }
    }
    dev = {
      create = true
    }
    prod = {
      create = true
    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}