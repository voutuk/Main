# modules/ansible_inventory/main.tf

# INFO: Variables for the Ansible inventory
variable "main_instance_ip" {
  type = string
  description = "The private IP of the main instance"
}

variable "build_agent_ips" {
  type = list(string)
  description = "A list of private IPs for the build agents"
}

variable "admin_username" {
  type        = string
  description = "The administrative username for the VMs"
}

variable "inventory_path" {
  type        = string
  description = "Path where the Ansible inventory file will be saved"
  default     = "../../ansible"
}

locals {
  timestamp     = formatdate("YYYY-MM-DD HH:mm:ss", timestamp())
  user          = "voutuk"
  template_path = "${path.module}/ansible_inventory.tpl"
}

resource "local_file" "ansible_inventory" {
  content = templatefile(local.template_path, {
    timestamp      = local.timestamp
    user           = local.user
    main_ip        = var.main_instance_ip
    agent_ips      = var.build_agent_ips
    admin_username = var.admin_username
  })
  filename = var.inventory_path
}

# INFO: Outputs for Ansible inventory
output "inventory_path" {
  value       = local_file.ansible_inventory.filename
  description = "Path to the generated Ansible inventory file"
}