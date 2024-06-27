variable "policies_arns" {
  description = "List of policies that you want to add to the instance profile"
  type        = list(string)
  default     = []
}