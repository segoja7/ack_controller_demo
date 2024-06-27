include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/network/vpc"
  mock_outputs = {
    vpc_id = "vpc-05fb7f855f45f8001"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}