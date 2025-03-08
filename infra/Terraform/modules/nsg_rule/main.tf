# modules/nsg_rule/main.tf


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
  network_security_group_name = var.nsg_name  # Changed back to name as per Azure provider requirements
}

