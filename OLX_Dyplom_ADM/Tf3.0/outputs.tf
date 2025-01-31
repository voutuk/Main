output "resource_group_name" {
  description = "Назва створеної ресурсної групи"
  value       = module.resource_group.resource_group_name
}

output "main_vm_private_ip" {
  description = "Приватна IP-адреса основної ВМ"
  value       = var.vm_private_ip
}