output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "vm_subnet_id" {
  description = "ID of the VM subnet"
  value       = azurerm_subnet.vm.id
}

output "ci_subnet_id" {
  description = "ID of the Container Instance subnet"
  value       = azurerm_subnet.ci.id
}

output "vm_nsg_id" {
  description = "ID of the VM network security group"
  value       = azurerm_network_security_group.vm.id
}