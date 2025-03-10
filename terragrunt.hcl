locals {
  common_vars = read_terragrunt_config("${get_parent_terragrunt_dir()}/common/common.hcl")
}

inputs = {
  COMMAND        = get_terraform_cli_args()
  COMMAND_GLOBAL = local.common_vars.locals
}

terraform {
  extra_arguments "init_arg" {
    commands = ["init"]
    arguments = [
      "-reconfigure"
    ]
    env_vars = {
      TERRAGRUNT_AUTO_INIT = true
    }
  }
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_parent_terragrunt_dir()}/common/common.tfvars"
    ]
  }
}

remote_state {
  backend = "s3"
  generate = {
    path      = "remotebackend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    profile              = local.common_vars.locals.backend_profile
    region               = local.common_vars.locals.backend_region
    bucket               = local.common_vars.locals.backend_bucket_name
    key                  = local.common_vars.locals.backend_key
    dynamodb_table       = local.common_vars.locals.backend-dynamodb-lock
    encrypt              = local.common_vars.locals.backend_encrypt
    workspace_key_prefix = "${local.common_vars.locals.project_folder}/${path_relative_to_include()}"
  }
}

generate = local.common_vars.generate