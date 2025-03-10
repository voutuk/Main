# MAIN outputs.tf

output "AZURE_CONTAINER_NAME" {
  value       = module.sa.container_name
  description = "Name of the container for backups"
}

output "AZURE_CONTAINER_RESOURCE_GROUP" {
  value       = module.storage_rg.location
  description = "Name of the container for backups"
}

output "AZURE_STORAGE_ACCOUNT" {
  value       = module.sa.account_name
  description = "Name of the created Storage Account"
}

output "jenkins_ip" {
  description = "Private IP address of Jenkins"
  value       = module.ci.container_ip
}

output "vmss_agent_dns_names" {
  description = "DNS names of Jenkins agents"
  value       = module.vvms.agent_dns_names
}

output "nat_public_ip" {
  description = "Public IP address of NAT gateway"
  value       = module.vvms.nat_public_ip
}