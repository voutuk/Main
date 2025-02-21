variable "instances" {
  description = "List of instance details for inventory"
  type = list(object({
    name       = string
    public_ip  = string
    private_ip = string
    type       = string
  }))
}

variable "inventory_path" {
  description = "Path to save the inventory file"
  type        = string
  default     = "inventory.ini"
}