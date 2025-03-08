# modules/ansible/variables.tf

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