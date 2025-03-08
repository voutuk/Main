# modules/nsg/variables.tf

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_address_space" {
  type    = string
}

variable "nsg_name" {
  type    = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the NSG"
  default     = {}
}