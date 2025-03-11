# Мінімальна мережева конфігурація для CI контейнера
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.base_name}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "ci_subnet" {
  name                 = "${var.base_name}-ci-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.ci_subnet_address_space

  # Необхідна делегація для Container Instances
  delegation {
    name = "aci-delegation"
    
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "azplug_subnet" {
  name                 = "${var.base_name}-azplug-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.azplug_subnet_address_space
}


# Network Security Group to allow SSH traffic (port 22)
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.base_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Security rule to allow SSH (port 22)
resource "azurerm_network_security_rule" "ssh" {
  name                          = "allow-port"
  priority                      = 100
  direction                     = "Inbound"
  access                        = "Allow"
  protocol                      = "Tcp"
  source_port_range             = "*"
  destination_port_range        = "22"
  source_address_prefix         = "*"
  destination_address_prefix    = "*"
  resource_group_name           = var.resource_group_name
  network_security_group_name   = azurerm_network_security_group.nsg.name
}

# Security rule to allow HTTP (port 80)
resource "azurerm_network_security_rule" "http" {
  name                          = "allow-http"
  priority                      = 110
  direction                     = "Inbound"
  access                        = "Allow"
  protocol                      = "Tcp"
  source_port_range             = "*"
  destination_port_range        = "80"
  source_address_prefix         = "*"
  destination_address_prefix    = "*"
  resource_group_name           = var.resource_group_name
  network_security_group_name   = azurerm_network_security_group.nsg.name
}

# Security rule to allow port 3000
resource "azurerm_network_security_rule" "port_3000" {
  name                          = "allow-3000"
  priority                      = 120
  direction                     = "Inbound"
  access                        = "Allow"
  protocol                      = "Tcp"
  source_port_range             = "*"
  destination_port_range        = "3000"
  source_address_prefix         = "*"
  destination_address_prefix    = "*"
  resource_group_name           = var.resource_group_name
  network_security_group_name   = azurerm_network_security_group.nsg.name
}

# Associate NSG with subnets
resource "azurerm_subnet_network_security_group_association" "ci_subnet" {
  subnet_id                 = azurerm_subnet.ci_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "azplug_subnet" {
  subnet_id                 = azurerm_subnet.azplug_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}