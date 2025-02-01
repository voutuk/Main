variable "doppler_token" {
  type        = string
  description = "Doppler token"
  sensitive   = true
}

variable "azure_subscription_id" {
  type        = string
  description = "ID вашої Azure підписки."
  default     = "3eba8433-8aaf-40ef-9be5-87b8edefec97"
}

variable "azure_region" {
  type        = string
  description = "Регіон Azure для створення ресурсів."
  default     = "North Europe"
}

variable "resource_group_name" {
  type        = string
  description = "Назва ресурсної групи."
  default     = "gosell-dev-rg"
}

variable "main_instance_vm_size" {
  type        = string
  description = "Розмір (SKU) основної віртуальної машини."
  default     = "Standard_B2ms"
}

variable "build_agent_vm_size" {
  type        = string
  description = "Розмір (SKU) Build-Agent віртуальної машини."
  default     = "Standard_DS1_v2"
}

variable "vm_admin_username" {
  type        = string
  description = "Адміністративний логін для ВМ."
  default     = "ubuntu"
}

variable "vm_private_ip" {
  type        = string
  description = "Приватна IP-адреса для основної ВМ."
  default     = "10.0.1.5"
}

variable "vm_sku" {
  type        = string
  description = "SKU образу ВМ."
  default     = "22_04-lts"
}

variable "instance_count" {
  type        = number
  description = "Кількість Build-Agent інстансів."
  default     = 2
}

variable "main_vm_name" {
  type        = string
  description = "Назва основної ВМ."
  default     = "main-vm"
}

# AKS variables

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
  default     = "West Europe"
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  default     = "gosell-aks-rg"
}

variable "as_resource_group_prefix" {
  type        = string
  description = "Prefix of the azure storage backup name."
  default     = "gosellbackup"
}

variable "aks_vm_size" {
  type        = string
  description = "The size of the Virtual Machine."
  default     = "Standard_B2s"
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 2
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "ubuntu"
}

# Optional variable if using MSI authentication
variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set if running example with Managed Identity."
  default     = null
}

