# modules/backup_storage/outputs.tf

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