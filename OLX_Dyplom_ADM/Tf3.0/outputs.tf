# outputs.tf

output "ansible_inventory_path" {
  value       = module.ansible_inventory.inventory_path
  description = "Path to the generated Ansible inventory file"
}

output "jenkins_master_ip" {
  value       = module.main_instance.public_ip
  description = "Private IP address of Jenkins master"
}

output "jenkins_agent_ips" {
  value       = module.build_agent_instance.public_ips
  description = "Private IP addresses of Jenkins agents"
}