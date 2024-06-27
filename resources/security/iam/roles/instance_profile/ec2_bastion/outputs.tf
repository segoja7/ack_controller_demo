output "profile_name" {
  description = "AWS ARN of created role"
  value       = module.iam_iam-assumable-role.iam_instance_profile_name
}

output "role_arn" {
  description = "AWS ARN of created role"
  value       = module.iam_iam-assumable-role.iam_role_arn
}