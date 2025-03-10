output "vm_ids" {
  description = "IDs of the created VMs"
  value       = azurerm_linux_virtual_machine.vm[*].id
}

output "vm_names" {
  description = "Names of the created VMs"
  value       = azurerm_linux_virtual_machine.vm[*].name
}

output "vm_private_ips" {
  description = "Private IP addresses of the VMs"
  value       = [for nic in azurerm_network_interface.vm : nic.private_ip_address]
}