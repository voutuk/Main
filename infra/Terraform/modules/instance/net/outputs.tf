output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "ci_subnet_id" {
  value = azurerm_subnet.ci_subnet.id
}