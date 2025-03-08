# MAIN outputs.tf

output "ansible_inventory_path" {
  value       = module.ansible_inventory.inventory_path
  description = "Path to the generated Ansible inventory file"
}

output "jenkins_master_ip" {
  value       = module.main_instance.public_ip
  description = "Private IP address of the Jenkins master"
}

output "jenkins_agent_ips" {
  value       = module.vvms_instance.public_ips
  description = "Private IP addresses of Jenkins agents"
}

output "AZURE_CONTAINER_NAME" {
  value       = module.backup_storage.backup_container_name
  description = "Name of the container for backups"
}

output "AZURE_CONTAINER_RESOURCE_GROUP" {
  value       = "${var.rg_prefix}-backup-storage"
  description = "Name of the container for backups"
}

output "AZURE_STORAGE_ACCOUNT" {
  value       = module.backup_storage.storage_account_name
  description = "Name of the created Storage Account"
}