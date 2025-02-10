# modules/nsg_rule/main.tf

# INFO: NSG Rule Variables
variable "resource_group_name" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "priority" {
  type        = number
  description = "Priority of the NSG rule"
  validation {
    condition     = var.priority >= 100 && var.priority <= 4096
    error_message = "Priority must be in the range of 100-4096."
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

# INFO: NSG Rule Outputs
output "rule_id" {
  value       = azurerm_network_security_rule.rule.id
  description = "ID of the created NSG rule"
}