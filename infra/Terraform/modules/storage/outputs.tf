# modules/storage/outputs.tf

output "account_id" {
  description = "ID of the created Storage Account."
  value       = azurerm_storage_account.sa.id
}

output "account_name" {
  description = "Name of the created Storage Account."
  value       = azurerm_storage_account.sa.name
}

output "container_name" {
  description = "Name of the container for backups."
  value       = azurerm_storage_container.backup_container.name
}

output "account_key" {
  description = "Primary access key for the Storage Account."
  value       = azurerm_storage_account.sa.primary_access_key
}