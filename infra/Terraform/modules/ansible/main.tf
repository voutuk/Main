# modules/ansible_inventory/main.tf


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
