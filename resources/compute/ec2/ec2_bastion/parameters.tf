locals {
  env = {
    default = {
      create            = false
      name              = lower("${var.project}-${terraform.workspace}-bastion-ec2")
      source_dest_check = false
      instance_type     = "t3.micro"
      #      key_name                    = "exe1"
      subnet_id                   = element(var.private_subnets_ids, 0)
      vpc_security_group_ids      = var.vpc_security_group_ids
      associate_public_ip_address = false
      enable_volume_tags          = true
      monitoring                  = true
      ami                         = "ami-023c11a32b0207432"
      iam_instance_profile        = var.instance_profile_name
      user_data_base64            = filebase64("${path.module}/datafiles/cloud_init.yaml")
      user_data_replace_on_change = true
      metadata_options = {
        http_tokens = "required"
      }
      root_block_device = [
        {
          volume_type = "gp2"
          volume_size = 30
          encrypted   = true
          kms_key_id  = var.kms_id
        },
      ]


      tags = {
        Environment = terraform.workspace
        Protected   = "Shared"
        Layer       = "Compute"
      }
    }
    dev = {
      create           = true
      create_scheduler = true
      enable_rule_stop = true
    }
    prod = {

    }

  }
  environment_vars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace        = merge(local.env["default"], local.env[local.environment_vars])
}