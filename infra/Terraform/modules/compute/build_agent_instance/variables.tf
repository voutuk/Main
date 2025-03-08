# modules/compute/build_agent_instance/variables.tf

variable "location" {
  type        = string
  description = "The Azure region where build agent resources will be created"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "instance_count" {
  type        = number
  description = "Number of build agent instances to create"
  default     = 1
}

variable "vm_name" {
  type        = string
  description = "Base name for the VM instances"
}

variable "vm_size" {
  type        = string
  description = "The size of the VM"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
}

variable "vm_sku" {
  type        = string
  description = "The SKU of the VM image"
}

variable "nsg_id" {
  type        = string
  description = "Network Security Group ID"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the build agent resources"
  default     = {}
}