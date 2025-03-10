variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "main-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "vm_subnet_name" {
  description = "Name of the subnet for VMs"
  type        = string
  default     = "vm-subnet"
}

variable "vm_subnet_address_prefix" {
  description = "Address prefix for the VM subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "ci_subnet_name" {
  description = "Name of the subnet for Container Instances"
  type        = string
  default     = "ci-subnet"
}

variable "ci_subnet_address_prefix" {
  description = "Address prefix for the Container Instance subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "tags" {
  description = "Tags to apply to all Azure resources"
  type        = map(string)
  default     = {}
}