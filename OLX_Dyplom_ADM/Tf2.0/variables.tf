# variables.tf

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
  description = "Назва ресурс-групи в Azure."
  default     = "gosell-dev-rg"
}

variable "main_instance_vm_size" {
  type        = string
  description = "Розмір (SKU) віртуальної машини для основного інстансу Jenkins."
  default     = "Standard_B2ms"
}

variable "build_agent_vm_size" {
  type        = string
  description = "Розмір (SKU) віртуальної машини для Build-Agent."
  default     = "Standard_DS1_v2"
}

variable "vm_admin_username" {
  type        = string
  description = "Адміністративний логін для віртуальної машини."
  default     = "ubuntu"
}

variable "vm_private_ip" {
  type        = string
  description = "Main vm private ip."
  default     = "10.0.1.5"
}

variable "vm_sku" {
  type        = string
  description = "VM SKU."
  default     = "22_04-lts"
}

variable "instance_count" {
  type        = number
  description = "Number of build agents."
  default     = 2
}

variable "main_vm_name" {
  type        = string
  description = "Main instance name."
  default     = "main-vm"
}