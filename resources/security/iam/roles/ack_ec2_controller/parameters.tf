locals {
  env = {
    default = {
      create    = false
      role_name = lower("${var.project}-${terraform.workspace}-ack-controller")
      role_policy_arns = {
        policy = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
      }

      oidc_providers = {
        ex = {
          provider_arn               = var.oidc_provider_arn
          namespace_service_accounts = ["ack-system:ack-ec2-controller"]
        }
      }

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