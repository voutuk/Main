# modules/backup_storage/main.tf

# INFO: Backup Storage Variables
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "backup_storage_prefix" {
  type = string
}
variable "container_name" {
  type        = string
  default     = "backups"
  description = "The name of the container in the Storage Account where backups will be stored."
}
variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the Storage Account and container."
  default     = {}
}

# Generate a random name for the storage account using a prefix
resource "random_pet" "as_storage_name" {
  prefix    = var.backup_storage_prefix
  separator = ""
}

locals {
  # Remove invalid characters and limit length to 24
  cleaned_name          = join("", regexall("[a-z0-9]", lower(random_pet.as_storage_name.id)))
  sanitized_storage_name = substr(local.cleaned_name, 0, 24)
}

# Create the Storage Account
resource "azurerm_storage_account" "backup_sa" {
  name                          = local.sanitized_storage_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  account_kind                  = "StorageV2"
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = true
  tags                          = var.tags
  # INFO: Вернути назад
  # lifecycle {
  #   prevent_destroy = true
  # }
}

# Create the container for backups
resource "azurerm_storage_container" "backup_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.backup_sa.name
  container_access_type = "private"
  # INFO: Вернути назад
  # lifecycle {
  #   prevent_destroy = true
  # }
}

# INFO: Backup Storage Outputs
output "storage_account_id" {
  description = "ID of the created Storage Account."
  value       = azurerm_storage_account.backup_sa.id
}

output "storage_account_name" {
  description = "Name of the created Storage Account."
  value       = azurerm_storage_account.backup_sa.name
}

output "backup_container_name" {
  description = "Name of the container for backups."
  value       = azurerm_storage_container.backup_container.name
}