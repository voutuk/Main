variable "location" {
  type        = string
  description = "Регіон Azure (наприклад, East US, West Europe тощо)."
}

variable "resource_group_name" {
  type        = string
  description = "Назва Resource Group, у якій будуть створені ресурси."
}

variable "tags" {
  type        = map(string)
  description = "Набір тегів, які будуть застосовані до ресурсів."
  default     = {}
}

variable "vmss_name" {
  type        = string
  description = "Назва створюваного VM Scale Set."
}

variable "vm_sku" {
  type        = string
  description = "Тип SKU для віртуальних машин (наприклад, Standard_B2s)."
  default     = "Standard_B2s"
}

variable "instance_count" {
  type        = number
  description = "Кількість інстансів у Scale Set."
  default     = 2
}

variable "admin_username" {
  type        = string
  description = "Адміністративне ім'я користувача для віртуальних машин."
  default     = "ubuntu"
}

variable "ssh_public_key" {
  type        = string
  description = "Шлях до файлу публічного SSH-ключа."
  default     = "~/.ssh/id_rsa.pub"
}

variable "sku" {
  type        = string
  description = "SKU образу віртуальної машини."
  default     = "22_04-lts"
}

variable "network_security_group_name" {
  type        = string
  description = "ID Network Security Group, який буде призначений для віртуальних машин."
}

variable "nsg_id" {
  type        = string
  description = "ID Network Security Group, який буде призначений для віртуальних машин."
}

variable "cloudflare_zone_id" {
  type        = string
  description = "ID зони Cloudflare."
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_address_space" {
  type = list(string)
}