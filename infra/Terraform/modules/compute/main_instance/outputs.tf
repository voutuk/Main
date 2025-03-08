# modules/resource_group/main.tf

output "private_ip" {
  value       = azurerm_network_interface.vm_nic.private_ip_address
  description = "Private IP address of the main instance"
}

output "public_ip" {
  value       = data.azurerm_public_ip.vm_public_ip_data.ip_address
  description = "Public IP address of the main instance"
  depends_on  = [
    azurerm_linux_virtual_machine.vm
  ]
}

output "subnet_id" {
  value       = azurerm_subnet.vm_subnet.id
  description = "ID of the subnet created for the main instance"
}

output "vm_name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "Name of the main virtual machine"
}