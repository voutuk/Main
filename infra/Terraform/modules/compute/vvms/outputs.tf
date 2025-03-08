output "vnet_id" {
  description = "ID створеної віртуальної мережі."
  value       = azurerm_virtual_network.main_vnet.id
}

output "subnet_id" {
  description = "ID створеної підмережі."
  value       = azurerm_subnet.main_subnet.id
}

output "vmss_id" {
  description = "ID створеного VMSS."
  value       = azurerm_linux_virtual_machine_scale_set.vmss.id
}

output "vmss_name" {
  description = "Назва створеного VMSS."
  value       = azurerm_linux_virtual_machine_scale_set.vmss.name
}