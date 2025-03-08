# modules/nsg_rule/outputs.tf

output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "ID of the created NSG"
}

output "nsg_name" {
  value       = azurerm_network_security_group.nsg.name
  description = "Name of the created NSG"
}