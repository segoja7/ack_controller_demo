locals {
  env = {
    default = {
      create          = false
      name            = lower("${var.project}-${terraform.workspace}-ec2-bastion-sg")
      description     = "Security Group for EC2 bastion"
      vpc_id          = var.vpc_id
      use_name_prefix = false
      ingress_with_cidr_blocks = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          description = "SSH Conncetion"
          cidr_blocks = "0.0.0.0/0"
        },
      ]
      egress_with_cidr_blocks = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = "0.0.0.0/0"
        }
      ]
      ingress_with_source_security_group_id = []
      egress_with_source_security_group_id  = []

      tags = {
        Environment = terraform.workspace
        Protected   = "Shared"
        Layer       = "Networking"
      }
    }
    dev = {
      create = true
    }
    prod = {

    }
  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}