variable "vmss_name" {
  description = "Name of the VM Scale Set"
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

variable "vm_sku" {
  description = "VM SKU"
  type        = string
  default     = "Standard_B2s"
}

variable "instance_count" {
  description = "Number of VM instances"
  type        = number
  default     = 2
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "sku" {
  description = "Ubuntu SKU"
  type        = string
  default     = "22_04-lts"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "nsg_id" {
  description = "Network Security Group ID"
  type        = string
}

variable "network_security_group_name" {
  description = "Network Security Group Name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for VMSS"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
  default     = null
}

variable "private_dns_zone_name" {
  description = "Private DNS zone name"
  type        = string
  default     = "jenkins.internal"
}