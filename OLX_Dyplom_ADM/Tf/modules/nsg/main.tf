# modules/nsg/main.tf

# INFO: NSG Variables
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_address_space" {
  type    = string
}

variable "nsg_name" {
  type    = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the NSG"
  default     = {}
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags

  # Basic SSH rule (Allow)
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

# INFO: NSG Outputs
output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "ID of the created NSG"
}

output "nsg_name" {
  value       = azurerm_network_security_group.nsg.name
  description = "Name of the created NSG"
}