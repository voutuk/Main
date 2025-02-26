resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    instances = var.instances
  })
  filename = var.inventory_path
}