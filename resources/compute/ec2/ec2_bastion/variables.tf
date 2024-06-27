variable "private_subnets_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "kms_id" {
  description = "ARN KMS key"
  type        = string
  default     = null
}

variable "instance_profile_name" {
  description = "The name attribute of the IAM instance profile to associate with launched instances"
  type        = string
  default     = null
}
