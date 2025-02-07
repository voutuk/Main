variable "main_instance_ip" {
  type        = string
  description = "IP address of the main instance"
}

variable "build_agent_ips" {
  type        = list(string)
  description = "List of build agent IP addresses"
}

variable "admin_username" {
  type        = string
  description = "SSH username for the instances"
}

variable "inventory_path" {
  type        = string
  description = "Path where to save the Ansible inventory file"
  default     = "../../ansible"
}