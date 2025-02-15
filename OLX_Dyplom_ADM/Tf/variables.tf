# MAIN variables.tf

# Variables for the Doppler integration
variable "doppler_token" {
  type        = string
  description = "Doppler token"
  sensitive   = true
}

# Variables for Azure
variable "azure_subscription_id" {
  type        = string
  description = "The ID of your Azure subscription."
  default     = "3eba8433-8aaf-40ef-9be5-87b8edefec97"
}

variable "rg_prefix" {
  type        = string
  description = "Region group prefix."
  default     = "gosell"
}

# Variables for VMs
variable "main_instance_vm_size" {
  type        = string
  description = "The size (SKU) of the main virtual machine."
  default     = "Standard_B2ms"
}

variable "build_agent_vm_size" {
  type        = string
  description = "The size (SKU) of the Build-Agent virtual machine."
  default     = "Standard_B2s"
}

variable "vm_admin_username" {
  type        = string
  description = "The administrative login for the VM."
  default     = "ubuntu"
}

variable "vm_private_ip" {
  type        = string
  description = "The private IP address for the main VM."
  default     = "10.0.1.5"
}

variable "vm_sku" {
  type        = string
  description = "The SKU of the VM image."
  default     = "22_04-lts"
}

variable "instance_count" {
  type        = number
  description = "The number of Build-Agent instances."
  default     = 2
}

variable "main_vm_name" {
  type        = string
  description = "The name of the main VM."
  default     = "main-vm"
}

# Variables for AKS

variable "backup_storage_prefix" {
  type        = string
  description = "The prefix for the Azure backup storage name."
  default     = "gosellbackup"
}

variable "aks_vm_size" {
  type        = string
  description = "The size of the Virtual Machine used in the AKS node pool."
  default     = "Standard_B2s"
}

variable "node_count" {
  type        = number
  description = "The initial number of nodes for the node pool."
  default     = 2
}

variable "aks_admin_username" {
  type        = string
  description = "The admin username for the AKS cluster."
  default     = "ubuntu"
}