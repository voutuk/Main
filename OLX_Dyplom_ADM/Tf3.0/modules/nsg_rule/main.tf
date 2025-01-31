variable "resource_group_name" { type = string }
variable "nsg_name" { type = string }
variable "priority" {
  type        = number
  description = "Пріоритет правила"
  validation {
    condition     = var.priority >= 100 && var.priority <= 4096
    error_message = "Пріоритет повинен бути в діапазоні 100-4096."
  }
}

resource "azurerm_network_security_rule" "rule" {
  name                        = "DenySSHFromAll"
  priority                    = var.priority
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.nsg_name
}

output "rule_id" {
  value       = azurerm_network_security_rule.rule.id
  description = "ID створеного правила"
}