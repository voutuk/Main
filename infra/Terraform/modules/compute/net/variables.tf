variable "base_name" {
  description = "Base name for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "ci_subnet_address_space" {
  description = "Address space for Container Instances subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vmss_subnet_address_space" {
  description = "Address space for VMSS subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "private_dns_zone_name" {
  description = "Name of the private DNS zone"
  type        = string
  default     = "jenkins.internal"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}