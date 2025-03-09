# Public IP для NAT Gateway
resource "azurerm_public_ip" "nat_gw_pub_ip" {
  name                = "${var.vmss_name}-nat-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"  # Изменено с "Dynamic" на "Static"
}

# NAT Gateway для outbound доступу до інтернету
resource "azurerm_nat_gateway" "nat_gw" {
  name                = "${var.vmss_name}-nat-gw"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Standard"
  tags = var.tags
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
  address_space       = ["10.2.0.0/16"]
  tags                = var.tags
}

# Підмережа
resource "azurerm_subnet" "main_subnet" {
  name                 = "${var.vmss_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.2.1.0/24"]
  # nat_gateway_id удалено отсюда
}

# Ассоциация подсети с NAT Gateway
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_association" {
  subnet_id      = azurerm_subnet.main_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}

# Приклад VM Scale Set, який використовує підмережу з новоствореної мережі
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_sku
  instances           = var.instance_count
  admin_username      = var.admin_username
  tags                = var.tags
  
  network_interface {
    name    = "${var.vmss_name}-nic"
    primary = true
    network_security_group_id = var.nsg_id 

    ip_configuration {
      name      = "${var.vmss_name}-ipconf"
      primary   = true
      subnet_id = azurerm_subnet.main_subnet.id
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