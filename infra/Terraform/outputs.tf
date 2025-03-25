# MAIN outputs.tf

output "AZURE_CONTAINER_NAME" {
  value       = module.sa.container_name
  description = "Name of the container for backups"
}

output "AZURE_CONTAINER_RESOURCE_GROUP" {
  value       = module.storage_rg.name
  description = "Name of the container for backups"
}

output "AZURE_STORAGE_ACCOUNT" {
  value       = module.sa.account_name
  description = "Name of the created Storage Account"
}
