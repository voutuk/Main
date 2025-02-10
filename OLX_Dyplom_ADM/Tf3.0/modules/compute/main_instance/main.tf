# modules/compute/main_instance/main.tf

# INFO: Main Instance Variables
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "vm_name" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "vm_private_ip" {
  type = string
}
variable "ssh_public_key" {
  type = string
}
variable "vm_sku" {
  type = string
}
variable "nsg_id" {
  type = string
}

# This delay is added to ensure the network is ready before continuing
resource "time_sleep" "wait_30_seconds" {
  depends_on      = [azurerm_virtual_network.vm_vnet]
  create_duration = "30s"
}

# Creating a Virtual Network
resource "azurerm_virtual_network" "vm_vnet" {
  name                = "${var.vm_name}-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

# Creating a Subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [
    azurerm_virtual_network.vm_vnet,
    time_sleep.wait_30_seconds
  ]
}

# Creating a Network Interface
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

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
  allocation_method   = "Static"
  sku                 = "Basic"
}

# Wait for the public IP to be assigned
resource "time_sleep" "wait_for_ip" {
  depends_on       = [azurerm_linux_virtual_machine.vm]
  create_duration  = "60s"
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

# INFO: Main Instance Outputs
output "private_ip" {
  value       = azurerm_network_interface.vm_nic.private_ip_address
  description = "Private IP address of the main instance"
}

output "public_ip" {
  value       = data.azurerm_public_ip.vm_public_ip_data.ip_address
  description = "Public IP address of the main instance"
  depends_on  = [
    azurerm_linux_virtual_machine.vm
  ]
}

output "subnet_id" {
  value       = azurerm_subnet.vm_subnet.id
  description = "ID of the subnet created for the main instance"
}

output "vm_name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "Name of the main virtual machine"
}