output "inventory_path" {
  value = local_file.ansible_inventory.filename
  description = "Path to the generated Ansible inventory file"
}