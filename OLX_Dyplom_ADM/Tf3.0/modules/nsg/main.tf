variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "nsg_name" { type = string }
variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Базова SSH-правило (Allow)
  security_rule {
    name                       = "AllowSSHFromAll"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "ID створеного NSG"
}