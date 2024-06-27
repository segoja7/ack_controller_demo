include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/network/vpc"
  mock_outputs = {
    private_subnets = [
      "subnet-082b2836a05d3d363"
    ]
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "ec2_bastion_sg" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/network/security_groups/ec2_bastion"
  mock_outputs = {
    security_group_id = "sg-0e09103598863832a"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "kms_key" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/security/kms/infrastructure"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-east-1:216252549440:key/fd018b93-04ba-4917-9365-f6f6167150bc"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "instance_profile" {
  config_path = "${get_parent_terragrunt_dir("root")}/resources/security/iam/roles/instance_profile/ec2_bastion"
  mock_outputs = {
    profile_name = "ec2-bastion-instance-profile"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  private_subnets_ids = dependency.vpc.outputs.private_subnets
  vpc_security_group_ids = [
    dependency.ec2_bastion_sg.outputs.security_group_id
  ]
  kms_id = dependency.kms_key.outputs.key_arn
  instance_profile_name = dependency.instance_profile.outputs.profile_name
}