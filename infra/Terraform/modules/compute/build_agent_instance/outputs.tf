# modules/resource_group/outputs.tf

output "private_ips" {
  value       = [for nic in azurerm_network_interface.build_agent_nic : nic.private_ip_address]
  description = "List of private IP addresses for build agents"
}

output "public_ips" {
  value       = [for pip in azurerm_public_ip.build_agent_pip : pip.ip_address]
  description = "List of public IP addresses for build agents"
}

output "vm_names" {
  value       = [for vm in azurerm_linux_virtual_machine.build_agent_vm : vm.name]
  description = "List of build agent VM names"
}