# modules/nsg_rule/variables.tf

variable "resource_group_name" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "priority" {
  type        = number
  description = "Priority of the NSG rule"
  validation {
    condition     = var.priority >= 100 && var.priority <= 4096
    error_message = "Priority must be in the range of 100-4096."
  }
}