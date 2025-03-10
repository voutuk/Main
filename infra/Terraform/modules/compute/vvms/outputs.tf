output "vmss_id" {
  description = "ID of the VM Scale Set"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.id
}

output "nat_public_ip" {
  description = "Public IP address of NAT gateway"
  value       = azurerm_public_ip.lb_pip.ip_address
}

output "agent_dns_names" {
  description = "DNS names of the Jenkins agents"
  value = [
    for i in range(var.instance_count) : 
      "${var.vmss_name}-vm${i + 1}.${var.private_dns_zone_name}"
  ]
}