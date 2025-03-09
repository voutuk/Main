# modules/compute/main_instance/main.tf


# This delay is added to ensure the network is ready before continuing
resource "time_sleep" "wait_30_seconds" {
  depends_on      = [azurerm_virtual_network.vm_vnet]
  create_duration = "15s"
}

# Creating a Virtual Network
resource "azurerm_virtual_network" "vm_vnet" {
  name                = "${var.vm_name}-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  tags = var.tags
}

# Creating a Subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = var.subnet_address_space

  depends_on = [
    azurerm_virtual_network.vm_vnet,
    # time_sleep.wait_30_seconds
  ]
}

# Creating a Network Interface
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm_private_ip
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "vm_nic_nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = var.nsg_id
}

# Creating a Public IP
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.vm_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags                = var.tags
}

# Wait for the public IP to be assigned
resource "time_sleep" "wait_for_ip" {
  depends_on       = [azurerm_linux_virtual_machine.vm]
  create_duration  = "30s"
}

# Data lookup for the assigned public IP
data "azurerm_public_ip" "vm_public_ip_data" {
  name                = azurerm_public_ip.vm_public_ip.name
  resource_group_name = var.resource_group_name

  depends_on = [
    azurerm_linux_virtual_machine.vm,
    time_sleep.wait_for_ip
  ]
}

# Creating the Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  tags                = var.tags

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.vm_sku
    version   = "latest"
  }

  depends_on = [
    azurerm_public_ip.vm_public_ip,
    azurerm_network_interface.vm_nic
  ]

  computer_name                   = var.vm_name
  disable_password_authentication = true
}
