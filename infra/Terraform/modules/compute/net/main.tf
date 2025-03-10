# Віртуальна мережа для всіх ресурсів
resource "azurerm_virtual_network" "main_vnet" {
  name                = "${var.base_name}-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# Підмережа для Container Instances
resource "azurerm_subnet" "ci_subnet" {
  name                 = "${var.base_name}-ci-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = var.ci_subnet_address_space
  
  # Делегування для Container Instances
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Підмережа для VMSS
resource "azurerm_subnet" "vmss_subnet" {
  name                 = "${var.base_name}-vmss-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = var.vmss_subnet_address_space
}

# NAT Gateway для VMSS
resource "azurerm_public_ip" "nat_gw_pub_ip" {
  name                = "${var.base_name}-nat-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "nat_gw" {
  name                = "${var.base_name}-nat-gw"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gw_pub_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_association" {
  subnet_id      = azurerm_subnet.vmss_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}

# Private DNS зона для внутрішньої комунікації
resource "azurerm_private_dns_zone" "internal_dns" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_dns_link" {
  name                  = "${var.base_name}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.internal_dns.name
  virtual_network_id    = azurerm_virtual_network.main_vnet.id
  registration_enabled  = true
}


