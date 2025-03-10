output "security_group_id" {
  description = "The ID of the security group"
  value       = module.sg.security_group_id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = module.sg.security_group_name
}

output "security_group_description" {
  description = "The description of the security group"
  value       = module.sg.security_group_description
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.sg.security_group_vpc_id
}

output "security_group_owner_id" {
  description = "The owner ID"
  value       = module.sg.security_group_owner_id
}