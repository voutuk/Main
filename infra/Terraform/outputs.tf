# MAIN outputs.tf

output "AZURE_CONTAINER_NAME" {
  value       = module.storage_account.container_name
  description = "Name of the container for backups"
}

output "AZURE_CONTAINER_RESOURCE_GROUP" {
  value       = module.storage_rg.resource_group_name
  description = "Name of the container for backups"
}

output "AZURE_STORAGE_ACCOUNT" {
  value       = module.storage_account.storage_account_name
  description = "Name of the created Storage Account"
}