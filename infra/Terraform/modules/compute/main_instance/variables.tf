# modules/resource_group/main.tf

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_address_space" {
  type = list(string)
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "vm_private_ip" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "vm_sku" {
  type = string
}

variable "nsg_id" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the main instance"
  default     = {}
}