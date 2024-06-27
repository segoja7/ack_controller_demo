
module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name          = local.workspace["name"]
  ami           = local.workspace["ami"]
  instance_type = local.workspace["instance_type"]
  subnet_id     = local.workspace["subnet_id"]
  #  key_name                    = local.workspace["key_name"]
  vpc_security_group_ids      = local.workspace["vpc_security_group_ids"]
  associate_public_ip_address = local.workspace["associate_public_ip_address"]
  iam_instance_profile        = local.workspace["iam_instance_profile"]
  user_data_base64            = local.workspace["user_data_base64"]
  user_data_replace_on_change = local.workspace["user_data_replace_on_change"]
  enable_volume_tags          = local.workspace["enable_volume_tags"]
  root_block_device           = local.workspace["root_block_device"]
  monitoring                  = local.workspace["monitoring"]
  metadata_options            = local.workspace["metadata_options"]
  source_dest_check           = local.workspace["source_dest_check"]

  tags = merge(
    var.required_tags,
    local.workspace["tags"]
  )
}


