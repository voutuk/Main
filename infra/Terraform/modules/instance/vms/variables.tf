variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where VMs will be deployed"
  type        = string
}

variable "vm_name_prefix" {
  description = "Prefix for VM names"
  type        = string
  default     = "vm"
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_D2s_v3" # VM size that supports ephemeral OS disks
}

variable "admin_username" {
  description = "Username for the VM admin account"
  type        = string
  default     = "adminuser"
}

variable "admin_ssh_key_data" {
  description = "SSH public key for VM admin"
  type        = string
}

variable "source_image_reference" {
  description = "Image reference for the VM"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string
  default     = "Standard_LRS"
}

variable "tags" {
  description = "Tags to apply to all Azure resources"
  type        = map(string)
  default     = {}
}