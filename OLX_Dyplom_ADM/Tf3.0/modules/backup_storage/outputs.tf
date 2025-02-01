# modules/backup_storage/outputs.tf

output "storage_account_id" {
  description = "ID створеного Storage Account."
  value       = azurerm_storage_account.backup_sa.id
}

output "storage_account_name" {
  description = "Назва створеного Storage Account."
  value       = azurerm_storage_account.backup_sa.name
}

output "backup_container_name" {
  description = "Назва контейнера для бекапів."
  value       = azurerm_storage_container.backup_container.name
}