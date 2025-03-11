output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.main_vnet.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.main_vnet.name
}

output "ci_subnet_id" {
  description = "ID of the subnet for Container Instances"
  value       = azurerm_subnet.ci_subnet.id
}

output "vmss_subnet_id" {
  description = "ID of the subnet for VMSS"
  value       = azurerm_subnet.vmss_subnet.id
}

output "private_dns_zone_id" {
  description = "ID of the private DNS zone"
  value       = azurerm_private_dns_zone.internal_dns.id
}

output "private_dns_zone_name" {
  description = "Name of the private DNS zone"
  value       = azurerm_private_dns_zone.internal_dns.name
}