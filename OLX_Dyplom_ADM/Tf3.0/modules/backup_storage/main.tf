
variable "resource_group_name" {
  type        = string
  description = "Назва (існуючої або новоствореної) ресурсної групи, де буде створено Storage Account"
}

variable "location" {
  type        = string
  description = "Azure-регіон для Storage Account."
}

variable "as_resource_group_prefix" {
  type        = string
  description = "Унікальний префікс для імені ресурсної групи при генерації random_pet (за потреби)."
}

variable "container_name" {
  type        = string
  default     = "backups"
  description = "Назва контейнера в Storage Account, де зберігатимуться бекапи."
}

resource "random_pet" "as_storage_name" {
  prefix    = var.as_resource_group_prefix
  # Use empty separator to avoid hyphens automatically
  separator = ""
}

locals {
  # Спочатку видаляємо всі неприпустимі символи
  cleaned_name = join("", regexall("[a-z0-9]", lower(random_pet.as_storage_name.id)))
  # Обмежуємо довжину до 24 символів
  sanitized_storage_name = substr(local.cleaned_name, 0, 24)
}

resource "azurerm_storage_account" "backup_sa" {
  name                          = local.sanitized_storage_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  account_kind                  = "StorageV2"
  min_tls_version              = "TLS1_2"
  public_network_access_enabled = true

  tags = {
    environment = "production"
    purpose     = "backups"
  }
}

resource "azurerm_storage_container" "backup_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.backup_sa.name
  container_access_type = "private"
}

