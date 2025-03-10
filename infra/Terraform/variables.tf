# MAIN variables.tf

# Main variables for the project
variable "DOPPLER_AUTH_TOKEN" {
  description = "Токен для доступу до Doppler"
  type        = string
  sensitive   = true
}

variable "docker_hub_username" {
  description = "Ім'я користувача Docker Hub"
  type        = string
  default     = "voutuk"
}

variable "storage_prefix" {
  type        = string
  description = "The prefix for the Azure backup storage name."
  default     = "gosellbackup"
}

variable "rg_prefix" {
  type        = string
  description = "Region group prefix."
  default     = "gosell"
}

variable "dev_locate" {
  type        = string
  description = "The location for the development environment."
  default     = "westeurope"
}

variable "prod_locate" {
  type        = string
  description = "The location for the production environment."
  default     = "northeurope"
}

# Variables for VMs
variable "main_vnet_address_space" {
  type        = list(string)
  description = "The address space for the main virtual network."
  default     = ["10.1.0.0/20"]
}

variable "main_subnet_address_space" {
  type        = list(string)
  description = "The address space for the main subnet."
  default     = ["10.1.1.0/24"]
}

variable "vm_private_ip" {
  type        = string
  description = "The private IP address for the main VM."
  default     = "10.1.1.5"
}

variable "vvms_vnet_address_space" {
  type        = list(string)
  description = "The address space for the vvms virtual network."
  default     = ["10.2.0.0/20"]
}

variable "vvms_subnet_address_space" {
  type        = list(string)
  description = "The address space for the vvms subnet."
  default     = ["10.2.1.0/24"]
}

variable "main_instance_vm_size" {
  type        = string
  description = "The size (SKU) of the main virtual machine."
  default     = "Standard_B2ms"
}

variable "vm_admin_username" {
  type        = string
  description = "The administrative login for the VM."
  default     = "ubuntu"
}

variable "sku" {
  type        = string
  description = "The SKU of the VM image."
  default     = "22_04-lts"
}

variable "vvms_sku" {
  type        = string
  description = "The SKU of the VM image."
  default     = "Standard_B2s"
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

variable "vmss_name" {
  type        = string
  description = "The name of the VM Scale Set."
  default     = "vvms"
}

# Variables for AKS
variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "gosell-aks"
}

variable "aks_location" {
  description = "Location of the AKS cluster"
  type        = string
  default     = "northeurope"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "gosell"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "gosell-vnet"
}

variable "subnet_name" {
  description = "Name of the AKS subnet"
  type        = string
  default     = "gosell-aks-subnet"
}

variable "ask_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.3.0.0/20"]
}

variable "ask_subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = list(string)
  default     = ["10.3.1.0/24"] 
}


# Other variables
variable "tags" {
  description = "A mapping of tags to assign to resources"
  type        = map(string)
  default     = {}
}