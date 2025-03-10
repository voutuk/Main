# Public IP для NAT Gateway
resource "azurerm_public_ip" "nat_gw_pub_ip" {
  name                = "${var.vmss_name}-nat-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.tags
}

# NAT Gateway
resource "azurerm_nat_gateway" "nat_gw" {
  name                = "${var.vmss_name}-nat-gw"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gw_pub_ip.id
}

# Віртуальна мережа
resource "azurerm_virtual_network" "main_vnet" {
  name                = "${var.vmss_name}-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# Підмережа
resource "azurerm_subnet" "main_subnet" {
  name                 = "${var.vmss_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = var.subnet_address_space
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_association" {
  subnet_id      = azurerm_subnet.main_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}

# Load Balancer (для DNAT)
resource "azurerm_lb" "vmss_lb" {
  name                = "${var.vmss_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${var.vmss_name}-lb-fe"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.vmss_name}-lb-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

# Replace LB rules with NAT rules for SSH
resource "azurerm_lb_nat_rule" "nat_ssh" {
  count                          = var.instance_count
  name                           = "SSH-NAT-${count.index}"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.vmss_lb.id
  frontend_ip_configuration_name = "${var.vmss_name}-lb-fe"
  protocol                       = "Tcp"
  frontend_port                  = 50001 + count.index
  backend_port                   = 22
}

resource "azurerm_lb_backend_address_pool" "vmss_backend" {
  loadbalancer_id = azurerm_lb.vmss_lb.id
  name            = "vmss-backend-pool"
}

# NSG правило для дозволу NAT SSH
resource "azurerm_network_security_rule" "allow_ssh_nat" {
  name                        = "Allow-SSH-NAT"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = [for i in range(var.instance_count) : tostring(50001 + i)]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name
}

# VM Scale Set
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_sku
  instances           = var.instance_count
  admin_username      = var.admin_username
  tags                = var.tags

  network_interface {
    name                      = "${var.vmss_name}-nic"
    primary                   = true
    network_security_group_id = var.nsg_id

    ip_configuration {
      name                                   = "${var.vmss_name}-ipconf"
      primary                                = true
      subnet_id                              = azurerm_subnet.main_subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.vmss_backend.id]
      load_balancer_inbound_nat_rules_ids    = [for i in range(var.instance_count) : azurerm_lb_nat_rule.nat_ssh[i].id]
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.sku
    version   = "latest"
  }

  upgrade_mode = "Manual"

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }
}

resource "cloudflare_record" "nat_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "nat"
  type    = "A"
  value   = azurerm_public_ip.lb_pip.ip_address
  ttl     = 300
  proxied = false
}