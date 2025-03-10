output "container_id" {
  description = "ID of the container instance"
  value       = azurerm_container_group.jenkins.id
}

output "container_ip" {
  description = "IP of the container instance"
  value       = azurerm_container_group.jenkins.ip_address
}